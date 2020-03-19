#! /bin/bash
#$ -cwd #start from current directory
#$ -l h_rt=48:00:00 -l data
#$ -V #export all the environmental variables into the context of the job
#$ -j yes #merge the stderr with the stdout
#$ -o logs/ #stdout, job log
#$ -m eas # send email beginning, end, and suspension
#$ -M svetlana.lebedeva@mdc-berlin.de
#$ -N 'RiboPipe'


#source ~/.bashrc
eval "$(/home/lebedeva/miniconda3/bin/conda shell.bash hook)"
conda activate ribopipe #ribopipebase
mkdir -p logs
mkdir -p sge_log
snakemake -j 10 -k -p --restart-times 1 --max-jobs-per-second 5 -s Snakefile --cluster-config ../src/config_pipeline.json  --rerun-incomplete --use-conda --cluster="qsub -cwd -V -l m_mem_free={cluster.m_mem_free} -l h_rt={cluster.h_rt} -pe {cluster.pe} -j yes -o sge_log -l data" "all"
exit 0
