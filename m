From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 8 May 2017 10:38:19 -0700
Subject: FIO performance regression in 4.11 kernel vs. 4.10 kernel
 observed on ARM64
In-Reply-To: <49bb6a78-e57f-b4ad-a593-0dc9d24074f1@fb.com>
References: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
 <20170508110754.GI8526@arm.com>
 <CAK8P3a0aqH5X0yoi1EF1=vM_gaJhRkjC66NQJk8enZEES5aYRw@mail.gmail.com>
 <b0a33959-f3be-9b98-51a0-26e8ea145617@fb.com> <20170508152400.GB7131@arm.com>
 <49bb6a78-e57f-b4ad-a593-0dc9d24074f1@fb.com>
Message-ID: <872acc20-db5f-42c6-f735-6205b643b842@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens/Will,

More complex FIO test provided inline.  I think there are more than one 
changes in 4.11 that have degraded performance.

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
>>>>>
>>>>> I can confirm that I also see a ~20% drop in results from 4.10 to 4.11 on
>>>>> my AMD Seattle board w/ defconfig, but I can't see anything obvious in the
>>>>> log.
>>>>>
>>>>> Things you could try:
>>>>>
>>>>>   1. Try disabling CONFIG_NUMA in the 4.11 kernel (this was enabled in
>>>>>      defconfig between the releases).
>>>>>
>>>>>   2. Try to reproduce on an x86 box
>>>>>
>>>>>   3. Have a go at bisecting the issue, so we can revert the offender if
>>>>>      necessary.
>>>>
>>>> One more thing to try early: As 4.11 gained support for blk-mq I/O
>>>> schedulers compared to 4.10, null_blk will now also need some extra
>>>> cycles for each I/O request. Try loading the driver with "queue_mode=0"
>>>> or "queue_mode=1" instead of "queue_mode=2".
>>>
>>> Since you have 1 submit queues set, you are being loaded with deadline
>>> attached. To compare 4.10 and 4.11, with queue_mode=2 and submit_queues=1,
>>> after loading null_blk in 4.11, do:
>>>
>>> # echo none > /sys/block/nullb0/queue/scheduler
>>>
>>> and re-test.
>>
>> On my setup, doing this restored a bunch of the performance, but the numbers
>> are still ~5% worse than 4.10 (as opposed to ~20% worse with mq-deadline).
>> Disabling NUMA as well cuts this down to ~2%.
>
> So we're down to 2%. How stable are these numbers? With mq-deadline attached,
> I'm not surprised there's a drop for a null_blk type of test.
Could you try the following FIO test as well?  This is substantially 
worse on 4.11 vs. 4.10.  Echo none to scheduler has some benefit.  But 
by setting queue_mode=0 it is actually slightly better in 4.11 vs. 4.10. 
  So Arnd's comment about blk-mq also has a negative impact?

modprobe null_blk nr_devices=4;

fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=readtest 
--filename=/dev/nullb0:/dev/nullb1:/dev/nullb2:/dev/nullb3 --bs=4k 
--iodepth=128 --time_based --runtime=10 --readwrite=randread 
--iodepth_low=96 --iodepth_batch=16 --numjobs=8

>
> Maybe a perf profile comparison between the two kernels would help?
>
