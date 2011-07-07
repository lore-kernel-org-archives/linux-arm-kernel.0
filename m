From: toddpoynor@google.com (Todd Poynor)
Date: Thu, 7 Jul 2011 13:17:48 -0700
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <87ei22dnsp.fsf@ti.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<87ei22dnsp.fsf@ti.com>
Message-ID: <20110707201748.GB32199@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 10:05:10AM -0700, Kevin Hilman wrote:
> Todd Poynor <toddpoynor@google.com> writes:
> 
> > Add notifiers for idle entry and exit, called with IDLE_START when a
> > CPU goes idle and IDLE_END when it goes out of idle, based on the
> > existing idle notifiers for the x86_64 arch.
> >
> > Convert x86_64 to use these notifiers, and call the notifiers on ARM.
> >
> > Convert the ARM LEDs events for idle start/end to these notifiers.
> 
> Is this intended to replace the more general CPU PM notifiers proposed
> by Colin:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052827.html

This is intended to coexist with the CPU PM notifiers.  The idle
notifiers proposed here are notifying of a change in kernel scheduler
state: the scheduler has no task to run and is entering its "idle
loop", or now has something to run and is exiting idle state.
Things that can use this include power management hints such as the
existing drivers/idle/i7300_idle.c usage, the ARM LEDs idle triggers,
and there's probably other existing potential uses in other arch'es that
I should go track down.

The CPU PM notifiers notify of changes in hardware power state that
affect the CPU and closely associated IP blocks (such as an OMAP
power state transition that causes one or more CPU power domains to
hit OFF).  These changes may be due to cpuidle power state management
when the system is idle, or may be due to suspending or resuming the
system (such as a suspend-to-RAM), or may be due to a CPU hotplug event.
In the case of an idle loop entry, if cpuidle decides it is not
appropriate to change CPU power state (as when insufficient time
remains until next timer expiry to enter such a power state due to
entry and exit latency), there may be no CPU PM notification
generated.  The callbacks for CPU PM notifiers on ARM do things such
as save/restore GIC interrupt controller state and VFP floating-point
coprocessor state.

That's the intent, anyhow, but ideas are welcome, thanks,


Todd
