From: sramana@codeaurora.org (Srinivas Ramana)
Date: Thu, 15 Dec 2016 18:46:09 +0530
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock
 counter
In-Reply-To: <20161212104243.GA21248@arm.com>
References: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
 <20161202110845.GC8266@arm.com> <5843D587.5010407@codeaurora.org>
 <20161206121346.GF2498@arm.com> <584E2F40.10904@codeaurora.org>
 <20161212104243.GA21248@arm.com>
Message-ID: <58529799.9060206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 04:12 PM, Will Deacon wrote:
> On Mon, Dec 12, 2016 at 10:31:52AM +0530, Srinivas Ramana wrote:
>> On 12/06/2016 05:43 PM, Will Deacon wrote:
>>> On Sun, Dec 04, 2016 at 02:06:23PM +0530, Srinivas Ramana wrote:
>>>> On 12/02/2016 04:38 PM, Will Deacon wrote:
>>>>> On Fri, Dec 02, 2016 at 01:44:55PM +0530, Srinivas Ramana wrote:
>>>>>> Extend the trace_clock to support the arch timer cycle
>>>>>> counter so that we can get the monotonic cycle count
>>>>>> in the traces. This will help in correlating the traces with the
>>>>>> timestamps/events in other subsystems in the soc which share
>>>>>> this common counter for driving their timers.
>>>>>
>>>>> I'm not sure I follow this reasoning. What's wrong with nanoseconds? In
>>>>> particular, the "perf" trace_clock hangs off sched_clock, which should
>>>>> be backed by the architected counter anyway. What does the cycle counter in
>>>>> isolation tell you, given that the frequency isn't architected?
>>>>>
>>>>> I think I'm missing something here.
>>>>>
>>>>
>>>> Having cycle counter would help in the cases where we want to correlate the
>>>> time with other subsystems which are outside cpu subsystem.
>>>
>>> Do you have an example of these subsystems? Can they be used to generate
>>> trace data with mainline?
>>
>> Some of the subsystems i can list are Modem(on a mobilephone), GPU or video
>> subsystem, or a DSP among others.
>
> Oh, you're talking about hardware subsystems. That makes this slightly more
> compelling, but I don't think you want the virtual counter here, since
> I assume those other subsystems don't take into account CNTVOFF (and I
> don't really see how they could, it being a per-cpu thing). So, if you
> want to expose the *physical* counter as a trace clock, I think that's
> justifiable.
>
Yes, I meant HW subsystems. Sorry if I was not clear.
In ARM64, it seems the access to physical counter is removed with commit 
"clocksource: arch_timer: Fix code to use physical timers when 
requested". Only ARM (32) is allowed to used physical counter in the 
current timer API. It seems only EL2 is supposed to access this. But 
yes, if there is an offset, it seems it would be difficult to get the 
exact value at EL0. However for systems where CNTVOFF is '0', this will 
work seamless. This clock would not be the default anyways and is 
optional. Local clock would continue to be the default for traces.

>>>> local_clock or even the perf track_clock uses sched_clock which gets
>>>> suspended during system suspend. Yes, they are backed up by the
>>>> architected counter but they ignore the cycles spent in suspend.i
>>>
>>> Does mono_raw solve this (also hangs off the architected counter and is
>>> supported in the vdso)?
>>
>> Doesn't seem like. Any of the existing clock sources are designed not show
>> the jump, when there is a suspend and resume. Even though they run out of
>> architected counter they just cane give exact correlation with the counter.
>> Furthermore, during the initial kernel boot, these just run out of jiffies
>> clock source. They also not account for the time spent in boot loaders.
>
> Hmm, there's a thing called CLOCK_BOOTTIME, but I don't think that helps
> you when CNTVOFF comes into play.
>
CLOCK_BOOTTIME includes the time spent in suspend. But this also doesn't 
give exact counter value since power ON. So for the purpose of comparing 
with global counter, this would not help.

>>>> so, when comparing with monotonically increasing cycle counter, other
>>>> clocks doesn't help. It seems X86 uses the TSC counter to help such cases.
>>>
>>> Does this mean we need a way to expose the frequency to userspace, too?
>>
>> Not really. The CNTFRQ_EL0 of timer subsystem holds the clock frequency of
>> system timer and is available to EL0.
>
> Experience shows that CNTFRQ_EL0 is often unreliable, and the frequency
> can be overridden by the device-tree. There are also systems where the
> counter stops ticking across suspend. Whilst both of these can be considered
> "broken", I suspect we want runtime buy-in from the arch-timer driver
> before registering this trace_clock.

Agree. It doesnt seem like architecture mandates initializing this.
For those systems where tick would stop, if not arch counter, i assume 
there is some counter which falls in 'always ON' domain without which 
they cant keep track of time.

Adding Mark Rutland and Marc Zyngier for help with this.

Thanks,
-- Srinivas R


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative 
Project.
