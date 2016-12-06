From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 12:13:47 +0000
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock
 counter
In-Reply-To: <5843D587.5010407@codeaurora.org>
References: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
 <20161202110845.GC8266@arm.com> <5843D587.5010407@codeaurora.org>
Message-ID: <20161206121346.GF2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2016 at 02:06:23PM +0530, Srinivas Ramana wrote:
> On 12/02/2016 04:38 PM, Will Deacon wrote:
> >On Fri, Dec 02, 2016 at 01:44:55PM +0530, Srinivas Ramana wrote:
> >>Extend the trace_clock to support the arch timer cycle
> >>counter so that we can get the monotonic cycle count
> >>in the traces. This will help in correlating the traces with the
> >>timestamps/events in other subsystems in the soc which share
> >>this common counter for driving their timers.
> >
> >I'm not sure I follow this reasoning. What's wrong with nanoseconds? In
> >particular, the "perf" trace_clock hangs off sched_clock, which should
> >be backed by the architected counter anyway. What does the cycle counter in
> >isolation tell you, given that the frequency isn't architected?
> >
> >I think I'm missing something here.
> >
> 
> Having cycle counter would help in the cases where we want to correlate the
> time with other subsystems which are outside cpu subsystem.

Do you have an example of these subsystems? Can they be used to generate
trace data with mainline?

> local_clock or even the perf track_clock uses sched_clock which gets
> suspended during system suspend. Yes, they are backed up by the
> architected counter but they ignore the cycles spent in suspend.i

Does mono_raw solve this (also hangs off the architected counter and is
supported in the vdso)?

> so, when comparing with monotonically increasing cycle counter, other
> clocks doesn't help. It seems X86 uses the TSC counter to help such cases.

Does this mean we need a way to expose the frequency to userspace, too?

Will
