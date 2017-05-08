From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 8 May 2017 09:32:16 -0700
Subject: FIO performance regression in 4.11 kernel vs. 4.10 kernel
 observed on ARM64
In-Reply-To: <20170508152400.GB7131@arm.com>
References: <50f528e8-8d8d-b168-784d-607a602ba808@broadcom.com>
 <20170508110754.GI8526@arm.com>
 <CAK8P3a0aqH5X0yoi1EF1=vM_gaJhRkjC66NQJk8enZEES5aYRw@mail.gmail.com>
 <b0a33959-f3be-9b98-51a0-26e8ea145617@fb.com> <20170508152400.GB7131@arm.com>
Message-ID: <1ab84e58-3e97-c792-ab8c-969e86c62d31@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Jens,

Thanks for reproducing.  Comment inline

On 17-05-08 08:24 AM, Will Deacon wrote:
> On Mon, May 08, 2017 at 08:08:55AM -0600, Jens Axboe wrote:
>> On 05/08/2017 05:19 AM, Arnd Bergmann wrote:
>>> On Mon, May 8, 2017 at 1:07 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>> On Fri, May 05, 2017 at 06:37:55PM -0700, Scott Branden wrote:
>>>>> I have updated the kernel to 4.11 and see significant performance
>>>>> drops using fio-2.9.
>>>>>
>>>>> Using FIO the performanced drops from 281 KIOPS to 207 KIOPS using
>>>>> single core and task.
>>>>> Percent performance drop becomes even worse if multi-cores and multi-
>>>>> threads are used.
>>>>>
>>>>> Platform is ARM64 based A72.  Can somebody reproduce the results or
>>>>> know what may have changed to make such a dramatic change?
>>>>>
>>>>> FIO command and resulting log output below using null_blk to remove
>>>>> as many hardware specific driver dependencies as possible.
>>>>>
>>>>> modprobe null_blk queue_mode=2 irqmode=0 completion_nsec=0
>>>>> submit_queues=1 bs=4096
>>>>>
>>>>> taskset 0x1 fio --randrepeat=1 --ioengine=libaio --direct=1 --numjobs=1
>>>>> --gtod_reduce=1 --name=readtest --filename=/dev/nullb0 --bs=4k
>>>>> --iodepth=128 --time_based --runtime=15 --readwrite=read
>>>>
>>>> I can confirm that I also see a ~20% drop in results from 4.10 to 4.11 on
>>>> my AMD Seattle board w/ defconfig, but I can't see anything obvious in the
>>>> log.
>>>>
>>>> Things you could try:
>>>>
>>>>   1. Try disabling CONFIG_NUMA in the 4.11 kernel (this was enabled in
>>>>      defconfig between the releases).
>>>>
>>>>   2. Try to reproduce on an x86 box
>>>>
>>>>   3. Have a go at bisecting the issue, so we can revert the offender if
>>>>      necessary.
>>>
>>> One more thing to try early: As 4.11 gained support for blk-mq I/O
>>> schedulers compared to 4.10, null_blk will now also need some extra
>>> cycles for each I/O request. Try loading the driver with "queue_mode=0"
>>> or "queue_mode=1" instead of "queue_mode=2".
>>
>> Since you have 1 submit queues set, you are being loaded with deadline
>> attached. To compare 4.10 and 4.11, with queue_mode=2 and submit_queues=1,
>> after loading null_blk in 4.11, do:
>>
>> # echo none > /sys/block/nullb0/queue/scheduler
>>
>> and re-test.
>
> On my setup, doing this restored a bunch of the performance, but the numbers
> are still ~5% worse than 4.10 (as opposed to ~20% worse with mq-deadline).
> Disabling NUMA as well cuts this down to ~2%.
>
> Scott -- do you see the same sort of thing?
NUMA was already disabled in my defconfig.

Using the echo to the scheduler restored half of my performance loss vs 
4.10.
echo none > /sys/block/nullb0/queue/scheduler

I will spend some time comparing and building defconfigs.
>
> Will
>
