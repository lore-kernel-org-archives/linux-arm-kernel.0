From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 May 2017 12:07:55 +0100
Subject: FIO performance regression in 4.11 kernel vs. 4.10 kernel
 observed on ARM64
In-Reply-To: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
References: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
Message-ID: <20170508110754.GI8526@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

Thanks for the report.

On Fri, May 05, 2017 at 06:37:55PM -0700, Scott Branden wrote:
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

I can confirm that I also see a ~20% drop in results from 4.10 to 4.11 on
my AMD Seattle board w/ defconfig, but I can't see anything obvious in the
log.

Things you could try:

  1. Try disabling CONFIG_NUMA in the 4.11 kernel (this was enabled in
     defconfig between the releases).

  2. Try to reproduce on an x86 box

  3. Have a go at bisecting the issue, so we can revert the offender if
     necessary.

Cheers,

Will
