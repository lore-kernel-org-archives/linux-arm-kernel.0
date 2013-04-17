From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Apr 2013 11:22:34 -0700
Subject: [GIT PULL] Timer clean-ups for 3.10, Part 2
In-Reply-To: <516EA638.1060800@gmail.com>
References: <516720B4.3000703@gmail.com> <516DEC68.8030101@codeaurora.org>
 <516EA638.1060800@gmail.com>
Message-ID: <516EE86A.9070003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/13 06:40, Rob Herring wrote:
> On 04/16/2013 07:27 PM, Stephen Boyd wrote:
>> On 04/11/13 13:44, Rob Herring wrote:
>>> Rob Herring (13):
>>>       ARM: sched_clock: allow changing to higher frequency counter
>>>       ARM: make sched_clock just call a function pointer
>>>       ARM: arch_timer: use full 64-bit counter for sched_clock
>> If I leave my system in the bootloader for a while this seems to cause
>> my sched_clock timestamps to jump once the sched_clock is setup. It also
>> sets up a sched_clock twice because read_sched_clock ==
>> jiffy_sched_clock_read.
>>
>> [    0.000000] Switching to timer-based delay loop
>> [    0.000000] sched_clock: ARM arch timer >56 bits at 19200kHz,
>> resolution 52ns
>> [    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
>> wraps every 4294967286ms
>> [    0.000000] Console: colour dummy device 80x30
>> [16645.193054] Calibrating delay loop (skipped), value calculated using
>> timer frequency.. 38.40 BogoMIPS (lpj=192000)
>>
>> I suspect it's because we don't do any cyc_to_sched_clock() stuff in the
>> arm architected timer case. Instead we just return the value from the
>> counter when we really should do some sort of subtraction from the first
>> value we read.
>>
>> I'm also curious how this is going to work for suspend/resume because it
>> doesn't look like we're going to stop sched_clock on arm architected
>> timer systems. See 6a4dae5e138a3 (ARM: 7565/1: sched: stop sched_clock()
>> during suspend, 2012-10-23) for why we need to do this.
>
> Well, I think arm64 is broken in both ways too. So we should fix this
> for both.
>
> I think this can be handled in a much more simple way than the 32-bit
> code since we don't need to deal with wrapping.
>
> Maintain a cycle offset that starts as the cycle count at init time.
> This offset can be subtracted from the current count. On suspend and
> resume, we need to calculate the cycle count delta while in suspend and
> then add this to the cycle offset.

Agreed. It looks like we're missing out on the irq time accounting stuff
because enable_sched_clock_irqtime() is never called too.

>
>> Finally, looks like this is unused now...
> Yes, but that's unrelated to anything I did.

Yes,  I didn't mean to say it was anything you did.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
