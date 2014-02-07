From: john.stultz@linaro.org (John Stultz)
Date: Fri, 07 Feb 2014 10:23:31 -0800
Subject: Weird sched_clock behaviour during boot with -rc1
In-Reply-To: <20140204220045.GC20528@codeaurora.org>
References: <20140204183641.GA25127@mudshark.cambridge.arm.com>
 <52F1518B.9010109@linaro.org> <20140204220045.GC20528@codeaurora.org>
Message-ID: <52F524A3.3070400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 02:00 PM, Stephen Boyd wrote:
> On 02/04, John Stultz wrote:
>> On 02/04/2014 10:36 AM, Will Deacon wrote:
>>> Hi guys,
>>>
>>> Booting -rc1 on my TC2 gives the following strange entries in the dmesg:
>>>
>>>
>>>   Uncompressing Linux... done, booting the kernel.
>>>   [    0.000000] Booting Linux on physical CPU 0x0
>>>
>>>   [...]
>>>
>>>   [    0.000000]   HighMem zone: 329728 pages, LIFO batch:31
>>>   [    7.789662] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956969942ns
>>>   [    0.000129] PERCPU: Embedded 9 pages/cpu @ee7bd000 s12800 r8192 d15872 u36864
>>>
>>>   [...]
>>>
>>>   [    0.868297] NR_IRQS:16 nr_irqs:16 16
>>>   [    0.886350] Architected cp15 timer(s) running at 24.00MHz (phys).
>>>   [ 2915.164998] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
>>>   [    0.000002] Switching to timer-based delay loop
>>>   [    0.014249] Console: colour dummy device 80x30
>>>
>>>
>>> so it looks like something whacky goes on during sched_clock registration.
>>> Sure enough, we're doing a pr_info in-between updating cs.* and calling
>>> update_sched_clock(), so moving the print sorts things out (diff below).
>> Yea... we have to be particularly careful with sched_clock to avoid
>> locks since we don't want to deadlock, but in this case
>> sched_clock_register is a little too relaxed here.
>>
>> Stephen: Would it make sense to set cd.suspended = true at the top of
>> the registration? That should block any sched_clock calls from getting
>> half-updated data, but still allow the sched_clock_update function to work.
>>
> That would work, but why can't we just hold the write seqlock
> during the registration? We would need to make a lockeless
> version of update_sched_clock() but that doesn't look too hard.
> It might actually turn out nicer because we call
> update_sched_clock() here just to set the epoch_cyc but we have
> to reset the epoch_ns back to 0 to start the count off right.
>
> How about this? The only concern is calling read_sched_clock()
> inside the seqlock, but I don't think that's a concern and if it
> is we can call it outside the lock at the beginning of this
> function.

Hey Stephen,

So whats the story here? Are we waiting on an ack from Will or would you
rather go with Josh's approach?

thanks
-john
