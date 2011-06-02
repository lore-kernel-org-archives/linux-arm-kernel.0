From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 02 Jun 2011 18:27:22 +0530
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <4DE77D9A.6090301@stericsson.com>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>	<20110602094622.GS3660@n2100.arm.linux.org.uk>	<4DE7637B.3060901@stericsson.com>	<20110602110137.GU3660@n2100.arm.linux.org.uk>
	<4DE77D9A.6090301@stericsson.com>
Message-ID: <4DE788B2.5060308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ John,

On 6/2/2011 5:40 PM, Mattias Wallin wrote:
> On 06/02/2011 01:01 PM, Russell King - ARM Linux wrote:
>> On Thu, Jun 02, 2011 at 12:18:35PM +0200, Mattias Wallin wrote:
>>> On 06/02/2011 11:46 AM, Russell King - ARM Linux wrote:
>>>> Why don't we just find a way of fixing sched_clock so that the value
>>>> doesn't reset over a suspend/resume cycle?
>>> Even if the value isn't reset during suspend/resume we want the
>>> clocksource to keep counting. Or is it ok to have the clocksource stop
>>> or freeze during suspend?
>>
>> kernel/time/timekeeping.c:timekeeping_suspend():
>>
>> timekeeping_forward_now();
>>
>> which does:
>> cycle_now = clock->read(clock);
>> cycle_delta = (cycle_now - clock->cycle_last)& clock->mask;
>> clock->cycle_last = cycle_now;
>>
>> So that updates the time with the current offset between cycle_last and
>> the current value.
>>
>> kernel/time/timekeeping.c:timekeeping_resume():
>> /* re-base the last cycle value */
>> timekeeper.clock->cycle_last = timekeeper.clock->read(timekeeper.clock);
>>
>> So this re-sets cycle_last to the current value of the clocksource. This
>> means that on resume, the clocksource can start counting from any
>> value it
>> likes.
>>
>> So, without any additional external inputs, time resumes incrementing at
>> the point where the suspend occurred without any jump backwards or
>> forwards.
>>
>> The code accounts for the sleep time by using read_persistent_clock()
>> read
>> a timer which continues running during sleep to calculate the delta
>> between
>> suspend and resume, and injects the delta between them to wind the time
>> forward.
>>
>>> Then we have cpuidle. Is it ok to stop/freeze the timer during cpuidle
>>> sleep states?
>>
>> During _idle_ (iow, no task running) sched_clock and the clocksource
>> should both continue to run - the scheduler needs to know how long the
>> system has been idle for, and the clocksource can't stop because we'll
>> lose track of time.
>>
>> Remember that the clockevent stuff is used as a trigger to the
>> timekeeping
>> code to read the clocksource, and update the current time. Time is moved
>> forward by the delta between a previous clocksource read and the current
>> clocksource read. So stopping or resetting the clocksource in unexpected
>> ways (other than over suspend/resume as mentioned above) will result in
>> time going weird.
>
> Hmm, I have missed the existence of the read_persistent_clock(). It
> sounds like I should keep the MTU as my clocksource / sched_clock and
> have the PRCMU Timer as a persistent_clock instead.
>
> Then one problem remains. The MTU will be powered during cstates:
> running, wfi, ApIdle (arm retenetion). The MTU will loose power during
> cstates ApSleep and ApDeepSleep. So I need to do a similar sync as
> suspend does against the persistent_clock but when leaving and enter the
> deeper cstates.
>
> Should I solve it in the clocksource framework with a flag telling which
> cstates the timer will stop/freeze and then inject time from the
> persistent_clock for those cstates? (I am thinking something like the
> CLOCK_EVT_FEAT_C3STOP flag)
>
> Am I on the wrong track here or how should I solve it?
>
IIUC, what you are trying here is to use high-precision clock-source
but since it doesn't work in low power modes, you want it to supplement
with always running low resolution timer.

Now just making the persistent_clock() read from low-resolution timer
is not going to help. Because there is no reference available for
the kernel on whatever counting is done by the low-resolution timer.
In other words, it has to be a registered clock-source first.

Earlier this year at ELC SFO, I had a discussion with
John and Thomas on how to have a high-resolution clock-source
and a low-resolution clock-source working together to cover
the low power scenario and still manage to get the highest
timer resolution.
The idea was to do dynamic switching of clock-source
which initially looked simple. Here the idea was to
have this working for suspend and as well as cupidle.

John mentioned that because of frequent clock-source
switching, will affect the NTP correction badly to an
extent that NTP correction may not work.

Here is what John suggested to do but I got busy with
other stuff and this one got pushed out from my todo.

--------------------
John wrote ...
A different approach would be to create a meta-clocksource, that
utilizes the two underlying clocks to create a what looks like a unified
counter.

Basically you use the slow-always running counter as your long-term freq
adjusted clock, but supplement its low granularity with the highres
halting clock.

This works best if both counters are driven by the same crystal, so
there won't be much drift between them.
----------------------

This approach should solve most of the issues and get
the functionality what you are looking for.

If you like, you can work on this scheme.

Regards
Santosh
