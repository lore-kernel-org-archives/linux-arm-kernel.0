From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Feb 2010 16:01:42 -0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203151449.GI4277@wear.picochip.com>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<20100203135914.GF4277@wear.picochip.com>
	<20100203144022.GG22275@n2100.arm.linux.org.uk>
	<20100203151449.GI4277@wear.picochip.com>
Message-ID: <008a01caa4ea$2dd72f20$89858d60$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

* Jamie Iles wrote:

> On Wed, Feb 03, 2010 at 02:40:22PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 03, 2010 at 01:59:14PM +0000, Jamie Iles wrote:
> > > Well it looks like the hardware breakpoint layer is on top of the perf_events
> > > subsystem and the breakpoint becomes a perf event. In this case the breakpoint
> > > should be scheduled in and out by perf on context switches if targetting a
> > > specific PID or could be left in the whole time if desired.

That's correct. The perf framework adds and removes the breakpoint when the
task to which it is pinned is scheduled in and out. Adding/removing a breakpoint
has the consequence of enabling/disabling it in hardware.

> > Unfortunately, we're drifting from the original topic...
> >
> > This starts worrying me more.  Is execution stopped (as in actually
> > stopped, not just switched away from leaving the thread runnable) in
> > the target thread when one of these 'perf' breakpoints is hit?  If
> > not, it's completely unsuitable for debuggers to use, and raises the
> > question of why it's being interfaced with the ptrace code.
> Will should be able to give a better anwer but my understanding is that at in
> the core hw_breakpoint and perf code, the event is simply logged and the pc
> recorded. The ptrace integration allows the processed to have SIGTRAP raised.

When a breakpoint is hit, a prefetch abort occurs. The hw-breakpoint code will
have installed a handler for the abort provided that the FSR shows that it is 
a debug exception. The handler checks whether a breakpoint or a watchpoint occurred
and signals the event to perf using perf_bp_event. This then calls the callback
function that was registered when register_user_hw_breakpoint was called. In the case
of ptrace, the callback is ptrace_hwbreak_triggered, which sends a SIGTRAP to the current
task.

Why are you concerned about the state of execution? Even if the child is rescheduled
before the debugger takes the trap [is this possible?], it will immediately trap again
when it attempts to re-execute the faulting instruction.

As for x86, it looks like it does send the signal, but it's hidden in the do_debug
routine which is called when the hardware signals the breakpoint. This then uses
notifiers to call back into the hw-breakpoint code which will finally call back to ptrace.

Cheers,

Will
