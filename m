From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Nov 2012 17:01:50 -0700
Subject: struct sys_timer .suspend/.resume ignored for
 ARCH_SA1100/ARCH_PXA?
In-Reply-To: <20121107232341.GY28327@n2100.arm.linux.org.uk>
References: <509AE964.8070009@wwwdotorg.org>
 <20121107232341.GY28327@n2100.arm.linux.org.uk>
Message-ID: <509AF66E.8020308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2012 04:23 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 07, 2012 at 04:06:12PM -0700, Stephen Warren wrote:
>> Russell, Kevin,
>>
>> In commit 9e4559d "[ARM] 4258/2: Support for dynticks in idle loop" in
>> 2007, Kevin applied the following change:
>>
>>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>>
>>> -#ifdef CONFIG_PM
>>> +#if defined(CONFIG_PM) && !defined(CONFIG_GENERIC_CLOCKEVENTS)
>>>  static int timer_suspend(struct sys_device *dev, pm_message_t state)
>>
>> This means that for any architecture that enables GENERIC_CLOCKEVENTS,
>> the .suspend/.resume fields of struct sys_timer will be ignored, since
>> timer_suspend()/timer_resume() won't be filled into
>> arch/arm/kernel/time.c's struct syscore_ops timer_syscore_ops.
> 
> Correct.
> 
>> Later, in commit 3e238be "[ARM] sa1100: add clock event support" in
>> 2008, Russell modified ARCH_SA1100 to select GENERIC_CLOCKEVENTS. I
>> believe this means that sa1100_timer_suspend()/resume() haven't been
>> used since.
> 
> Also correct.
> 
>> A similar issue exists for ARCH_PXA.
>>
>> Should sa1100_timer_suspend(), sa1100_timer_resume(),
>> pxa_timer_suspend(), pxa_timer_suspend() simply be deleted since they
>> are dead code, or should they be revived somehow; is the ifdef from
>> Kevin's change incorrect?
> 
> Hmm, that's probably not good for either of those two platforms; it means
> that the OSCR and match registers get lost over a suspend/resume.  That's
> not a real big problem for the clocksource code, but if its being used
> for something else (eg, rtc) then it probably means we have a failure
> there.

OK, so it sounds like the correct approach here is to re-enable those
functions. The local patches I have right now do this, and hook them
into e.g. ckevt_sa1100_osmr0's suspend/resume rather than sys_timer's. I
assume that will work fine?

>> As background, I'm working on a patch series that will remove all fields
>> from struct sys_timer except for .init, and will then replace the ARM
>> machine descriptor's .timer struct pointer with a .init_timer function
>> pointer. This will allow machines, on an opt-in basis, to call into a
>> central function in drivers/clocksource to initialize the required
>> timer, as determined by searching device tree for a known device type,
>> in much the same way as has been proposed to use a single implementation
>> for for the machine descriptor's .init_irq. As part of this, I've been
>> looking at moving any use of struct sys_timer .suspend/.resume into e.g.
>> struct clock_event_device .suspend/.resume, and found this issue.
> 
> Don't forget we still have a number of platforms not converted to
> the generic event/clocksource stuff (because they lack the necessary
> counters/timers for this 'new' infrastructure.)

I believe the only user of struct sys_timer .suspend/.resume that does
use struct clock_event_device is s3c2410. I'd missed that before since
I'd only searched for .suspend and not .resume alone. Perhaps this one
should just register its own syscore_ops instead of having the ARM core
do that on its behalf.
