From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 5 May 2017 18:54:18 -0700
Subject: FIO performance regression in 4.11 kernel vs. 4.10 kernel
 observed on ARM64
In-Reply-To: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
References: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
Message-ID: <ea652b6c-cf0d-67f9-53a3-a14ce6623ca3@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please note the 4.11 and 4.10 log results in my email were
reversed - see correction below.

Performance regression is observed - FIO performance in 4.11 is
much less than 4.10 on ARM64 based platform.

On 17-05-05 06:37 PM, Scott Branden wrote:
> I have updated the kernel to 4.11 and see significant performance
> drops using fio-2.9.
>
> Using FIO the performanced drops from 281 KIOPS to 207 KIOPS using
> single core and task.
> Percent performance drop becomes even worse if multi-cores and multi-
> threads are used.
>
> Platform is ARM64 based A72.  Can somebody reproduce the results or
> know what may have changed to make such a dramatic change?
>
> FIO command and resulting log output below using null_blk to remove
> as many hardware specific driver dependencies as possible.
>
> modprobe null_blk queue_mode=2 irqmode=0 completion_nsec=0
> submit_queues=1 bs=4096
>
> taskset 0x1 fio --randrepeat=1 --ioengine=libaio --direct=1 --numjobs=1
> --gtod_reduce=1 --name=readtest --filename=/dev/nullb0 --bs=4k
> --iodepth=128 --time_based --runtime=15 --readwrite=read
>
> **** 281 KIOPS RESULT on 4.11 Kernel ****
CORRECTION:
**** 281 KIOPS RESULT on 4.10 Kernel ****

> readtest: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio,
> iodepth=128
> fio-2.9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)] [100.0% done] [1098MB/0KB/0KB /s] [281K/0/0 iops]
> [eta 00m:00s]
> readtest: (groupid=0, jobs=1): err= 0: pid=2868: Mon Apr  3 20:24:25 2017
>   read : io=16456MB, bw=1096.1MB/s, iops=280825, runt= 15001msec
>   cpu          : usr=28.35%, sys=71.55%, ctx=1560, majf=0, minf=146
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%,
>>=64=100.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>=64=0.1%
>      issued    : total=r=4212670/w=0/d=0, short=r=0/w=0/d=0,
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=128
>
> Run status group 0 (all jobs):
>    READ: io=16456MB, aggrb=1096.1MB/s, minb=1096.1MB/s, maxb=1096.1MB/s,
> mint=15001msec, maxt=15001msec
>
> Disk stats (read/write):
>   nullb0: ios=4185627/0, merge=0/0, ticks=3664/0, in_queue=3308,
> util=22.05%
>
>
> **** 207 KIOPS RESULT on 4.10 Kernel ****
CORRECTION:
**** 281 KIOPS RESULT on 4.11 Kernel ****

> taskset 0x1 fio --randrepeat=1 --ioengine=libaio --direct=1 --numjobs=1
> --gtod_reduce=1 --name=readtest --filename=/dev/nullb0 --bs=4k
> --iodepth=128 --time_based --runtime=15 --readwrite=read
> readtest: (g=0): rw=read, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio,
> iodepth=128
> fio-2.9
> Starting 1 process
> Jobs: 1 (f=1): [R(1)] [100.0% done] [807.6MB/0KB/0KB /s] [207K/0/0 iops]
> [eta 00m:00s]
> readtest: (groupid=0, jobs=1): err= 0: pid=2832: Mon Apr  3 20:09:31 2017
>   read : io=12109MB, bw=826620KB/s, iops=206654, runt= 15001msec
>   cpu          : usr=24.62%, sys=75.28%, ctx=1571, majf=0, minf=146
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%,
>>=64=100.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>=64=0.1%
>      issued    : total=r=3100030/w=0/d=0, short=r=0/w=0/d=0,
> drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=128
>
> Run status group 0 (all jobs):
>    READ: io=12109MB, aggrb=826619KB/s, minb=826619KB/s, maxb=826619KB/s,
> mint=15001msec, maxt=15001msec
>
> Disk stats (read/write):
>   nullb0: ios=3080149/0, merge=0/0, ticks=3952/0, in_queue=3560,
> util=23.73%
>
>
>
> Regards,
>  Scott
