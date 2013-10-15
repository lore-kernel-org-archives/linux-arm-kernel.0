From: john.stultz@linaro.org (John Stultz)
Date: Tue, 15 Oct 2013 09:46:19 -0700
Subject: [PATCH] arch_timer: Do not register arch_sys_counter twice
In-Reply-To: <20131015150314.GA10535@ulmo.nvidia.com>
References: <1381843911-31962-1-git-send-email-treding@nvidia.com>
 <20131015142313.GC850@mudshark.cambridge.arm.com>
 <20131015150314.GA10535@ulmo.nvidia.com>
Message-ID: <525D715B.5090203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:03 AM, Thierry Reding wrote:
> On Tue, Oct 15, 2013 at 03:23:14PM +0100, Will Deacon wrote:
>> On Tue, Oct 15, 2013 at 02:31:51PM +0100, Thierry Reding wrote:
>>> Commit 65cd4f6 (arch_timer: Move to generic sched_clock framework) added
>>> code to register the arch_sys_counter in arch_timer_register() but it is
>>> already registered in arch_counter_register(). This results in the timer
>>> being added to the clocksource list twice, therefore causing an infinite
>>> loop in the list.
>>>
>>> Remove the duplicate registration and register the scheduler clock after
>>> the original registration instead.
>>>
>>> This fixes a hang during boot on Tegra114 (Cortex-A15).
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>> While I've only tested this on Tegra114, I suspect the same hang during
>>> boot happens for all processors that use this clock source.
>>>
>>>  drivers/clocksource/arm_arch_timer.c | 12 +++---------
>>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c
b/drivers/clocksource/arm_arch_timer.c
>>> index f655036..95fb944 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -436,6 +436,9 @@ static void __init
arch_counter_register(unsigned type)
>>>      cyclecounter.mult = clocksource_counter.mult;
>>>      cyclecounter.shift = clocksource_counter.shift;
>>>      timecounter_init(&timecounter, &cyclecounter, start_count);
>>> +
>>> +    /* 56 bits minimum, so we assume worst case rollover */
>>> +    sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
>>>  }
>>> 
>>>  static void arch_timer_stop(struct clock_event_device *clk)
>>> @@ -515,15 +518,6 @@ static int __init arch_timer_register(void)
>>>          goto out;
>>>      }
>>> 
>>> -    clocksource_register_hz(&clocksource_counter, arch_timer_rate);
>>> -    cyclecounter.mult = clocksource_counter.mult;
>>> -    cyclecounter.shift = clocksource_counter.shift;
>>> -    timecounter_init(&timecounter, &cyclecounter,
>>> -             arch_counter_get_cntvct());
>>> -
>>> -    /* 56 bits minimum, so we assume worst case rollover */
>>> -    sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
>>> -
>>>      if (arch_timer_use_virtual) {
>>>          ppi = arch_timer_ppi[VIRT_PPI];
>>>          err = request_percpu_irq(ppi, arch_timer_handler_virt,
>>
>> Excuse my ignorance, but I'm failing to apply either this patch or
the one
>> that Stephen Boyd proposed:
>>
>>  
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204665.html
>
> Hehe, that patch is exactly the same as this one. =)
>
>> The second hunk (deletions) doesn't apply at all, and if I just apply the
>> first hunk then things won't compile. Which tree is this against?

The problem is from my merge to -tip.

>
> This is on top of today's linux-next[0] and will probably apply to
> yesterday's linux-next too. I think that perhaps the patch or the one
> that Stephen proposed himself should be squashed with the original
> because that caused the breakage in the first place. From what I gather
> from the mailing thread you linked to above it seems like John took an
> earlier patch from Stephen and rebased it on top of something more
> recent and that didn't work out as expected.

Yes, again my apologies. When I applied Stephen's original patch to the
recent tree, I mis-resolved the conflict.


> Ingo, any chance you could take this patch and squash it into the patch
> mentioned above? Applying it as a separate fix will break bisectability
> inbetween both patches.

I suspect Ingo won't squish down the fix onto the misresolved patch,
since -tip usually preserves history. But hopefully we can get this
merged quickly.

Again, sorry for the trouble!
-john
