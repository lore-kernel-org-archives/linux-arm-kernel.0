From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 15 May 2017 13:10:25 -0700
Subject: FIO performance regression in 4.11 kernel vs. 4.10 kernel
 observed on ARM64
In-Reply-To: <49bb6a78-e57f-b4ad-a593-0dc9d24074f1@fb.com>
References: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
 <20170508110754.GI8526@arm.com>
 <CAK8P3a0aqH5X0yoi1EF1=vM_gaJhRkjC66NQJk8enZEES5aYRw@mail.gmail.com>
 <b0a33959-f3be-9b98-51a0-26e8ea145617@fb.com> <20170508152400.GB7131@arm.com>
 <49bb6a78-e57f-b4ad-a593-0dc9d24074f1@fb.com>
Message-ID: <79c28cd2-35a5-3846-6c0e-fe4ef2854e4c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

Details on bisecting inline.


On 17-05-08 08:28 AM, Jens Axboe wrote:
> On 05/08/2017 09:24 AM, Will Deacon wrote:
>> On Mon, May 08, 2017 at 08:08:55AM -0600, Jens Axboe wrote:
>>> On 05/08/2017 05:19 AM, Arnd Bergmann wrote:
>>>> On Mon, May 8, 2017 at 1:07 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>>> On Fri, May 05, 2017 at 06:37:55PM -0700, Scott Branden wrote:
>>>>>> I have updated the kernel to 4.11 and see significant performance
>>>>>> drops using fio-2.9.
>>>>>>
>>>>>> Using FIO the performanced drops from 281 KIOPS to 207 KIOPS using
>>>>>> single core and task.
>>>>>> Percent performance drop becomes even worse if multi-cores and multi-
>>>>>> threads are used.
>>>>>>
>>>>>> Platform is ARM64 based A72.  Can somebody reproduce the results or
>>>>>> know what may have changed to make such a dramatic change?
>>>>>>
>>>>>> FIO command and resulting log output below using null_blk to remove
>>>>>> as many hardware specific driver dependencies as possible.
>>>>>>
>>>>>> modprobe null_blk queue_mode=2 irqmode=0 completion_nsec=0
>>>>>> submit_queues=1 bs=4096
>>>>>>
>>>>>> taskset 0x1 fio --randrepeat=1 --ioengine=libaio --direct=1 --numjobs=1
>>>>>> --gtod_reduce=1 --name=readtest --filename=/dev/nullb0 --bs=4k
>>>>>> --iodepth=128 --time_based --runtime=15 --readwrite=read
>>>>> I can confirm that I also see a ~20% drop in results from 4.10 to 4.11 on
>>>>> my AMD Seattle board w/ defconfig, but I can't see anything obvious in the
>>>>> log.
>>>>>
>>>>> Things you could try:
>>>>>
>>>>>    1. Try disabling CONFIG_NUMA in the 4.11 kernel (this was enabled in
>>>>>       defconfig between the releases).
>>>>>
>>>>>    2. Try to reproduce on an x86 box
>>>>>
>>>>>    3. Have a go at bisecting the issue, so we can revert the offender if
>>>>>       necessary.
The 4.11 kernel has numerous performance regressions.  I only bisected 
up to 4.11-rc1 as merge conflicts and complexities arise after that.

First Performance regression is:
b86dd815ff74  "block: get rid of blk-mq default scheduler choice Kconfig 
entries"

Using "echo none > /sys/block/nullb0/queue/schedule" does not restore 
all performance loss at this point.  I needed to revert this change to 
restore all loss.

Second Performance regression is:
113285b47382 "blk-mq: ensure that bd->last is always set correctly"

Third Performance regression is:
a528d35e8bfc "statx: Add a system call to make enhanced file info available"

Unfortunately due to reverting a528d35e8bfc there are merge conflicts in 
later 4.11-rcX versions.

I have only reported the simplest test case we have but there are other 
scenarios that are even worse in 4.11 that the single queue case.

Here is one:
modprobe null_blk nr_devices=4;
fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=readtest 
--filename=/dev/nullb0:/dev/nullb1:/dev/nullb2:/dev/nullb3 --bs=4k 
--iodepth=128 --time_based --runtime=10 --readwrite=randread 
--iodepth_low=96 --iodepth_batch=16 --numjobs=8

What is next step to fix these regressions?  It is not a simple single 
commit causing the performance problems.

Is anyone running any performance tests on the kernel to catch such issues?
>>>> One more thing to try early: As 4.11 gained support for blk-mq I/O
>>>> schedulers compared to 4.10, null_blk will now also need some extra
>>>> cycles for each I/O request. Try loading the driver with "queue_mode=0"
>>>> or "queue_mode=1" instead of "queue_mode=2".
>>> Since you have 1 submit queues set, you are being loaded with deadline
>>> attached. To compare 4.10 and 4.11, with queue_mode=2 and submit_queues=1,
>>> after loading null_blk in 4.11, do:
>>>
>>> # echo none > /sys/block/nullb0/queue/scheduler
>>>
>>> and re-test.
>> On my setup, doing this restored a bunch of the performance, but the numbers
>> are still ~5% worse than 4.10 (as opposed to ~20% worse with mq-deadline).
>> Disabling NUMA as well cuts this down to ~2%.
> So we're down to 2%. How stable are these numbers? With mq-deadline attached,
> I'm not surprised there's a drop for a null_blk type of test.
>
> Maybe a perf profile comparison between the two kernels would help?
>
Regards,
Scott
