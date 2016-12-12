From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Dec 2016 10:42:43 +0000
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock
 counter
In-Reply-To: <584E2F40.10904@codeaurora.org>
References: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
 <20161202110845.GC8266@arm.com> <5843D587.5010407@codeaurora.org>
 <20161206121346.GF2498@arm.com> <584E2F40.10904@codeaurora.org>
Message-ID: <20161212104243.GA21248@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 10:31:52AM +0530, Srinivas Ramana wrote:
> On 12/06/2016 05:43 PM, Will Deacon wrote:
> >On Sun, Dec 04, 2016 at 02:06:23PM +0530, Srinivas Ramana wrote:
> >>On 12/02/2016 04:38 PM, Will Deacon wrote:
> >>>On Fri, Dec 02, 2016 at 01:44:55PM +0530, Srinivas Ramana wrote:
> >>>>Extend the trace_clock to support the arch timer cycle
> >>>>counter so that we can get the monotonic cycle count
> >>>>in the traces. This will help in correlating the traces with the
> >>>>timestamps/events in other subsystems in the soc which share
> >>>>this common counter for driving their timers.
> >>>
> >>>I'm not sure I follow this reasoning. What's wrong with nanoseconds? In
> >>>particular, the "perf" trace_clock hangs off sched_clock, which should
> >>>be backed by the architected counter anyway. What does the cycle counter in
> >>>isolation tell you, given that the frequency isn't architected?
> >>>
> >>>I think I'm missing something here.
> >>>
> >>
> >>Having cycle counter would help in the cases where we want to correlate the
> >>time with other subsystems which are outside cpu subsystem.
> >
> >Do you have an example of these subsystems? Can they be used to generate
> >trace data with mainline?
> 
> Some of the subsystems i can list are Modem(on a mobilephone), GPU or video
> subsystem, or a DSP among others.

Oh, you're talking about hardware subsystems. That makes this slightly more
compelling, but I don't think you want the virtual counter here, since
I assume those other subsystems don't take into account CNTVOFF (and I
don't really see how they could, it being a per-cpu thing). So, if you
want to expose the *physical* counter as a trace clock, I think that's
justifiable.

> >>local_clock or even the perf track_clock uses sched_clock which gets
> >>suspended during system suspend. Yes, they are backed up by the
> >>architected counter but they ignore the cycles spent in suspend.i
> >
> >Does mono_raw solve this (also hangs off the architected counter and is
> >supported in the vdso)?
> 
> Doesn't seem like. Any of the existing clock sources are designed not show
> the jump, when there is a suspend and resume. Even though they run out of
> architected counter they just cane give exact correlation with the counter.
> Furthermore, during the initial kernel boot, these just run out of jiffies
> clock source. They also not account for the time spent in boot loaders.

Hmm, there's a thing called CLOCK_BOOTTIME, but I don't think that helps
you when CNTVOFF comes into play.

> >>so, when comparing with monotonically increasing cycle counter, other
> >>clocks doesn't help. It seems X86 uses the TSC counter to help such cases.
> >
> >Does this mean we need a way to expose the frequency to userspace, too?
> 
> Not really. The CNTFRQ_EL0 of timer subsystem holds the clock frequency of
> system timer and is available to EL0.

Experience shows that CNTFRQ_EL0 is often unreliable, and the frequency
can be overridden by the device-tree. There are also systems where the
counter stops ticking across suspend. Whilst both of these can be considered
"broken", I suspect we want runtime buy-in from the arch-timer driver
before registering this trace_clock.

Will
