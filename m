From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 03 Feb 2012 14:36:27 -0500
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <87k4437oaq.fsf@ti.com>
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com> <87k4437oaq.fsf@ti.com>
Message-ID: <1328297787.5882.203.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-03 at 10:41 -0800, Kevin Hilman wrote:

> > How is it a step backwards if it is already broken. 
> 
> Well, I didn't know it was broken. ;) And, as Paul mentioned, this has
> been broken for a long time. Apparently it's been working well enough
> for nobody to notice until recently.
> 
> > Obviously you haven't actually used any tracing here because it
> > doesn't work right with things as is.
> 
> It's been working well enough for me to debug several idle path problems
> with tracing.  Admittedly, this has been primarily on UP systems, but
> I've recently started using the tracing on SMP as well.  (however, due
> to "coupled" low-power states on OMAP, large parts of the idle path are
> effectively UP since one CPU0 has to wait for CPU1 to hit a low-power
> state before it can.)

It's used by all users of powertop, and we haven't heard about a bug
yet. This doesn't mean that the bug doesn't exist. The race is extremely
hard to hit. It's one of those "good bugs". You know, the kind that you
don't really have to worry about because you are more likely to win the
lottery, become President of the United States, and find a cure for
cancer (all those together, not just one) than the chance of hitting
this bug. But it's a bug regardless and should, unfortunately, be fixed.

But here's the explanation of the bug:

As Paul has stated, when rcu_idle_enter() is in effect, the calls to
rcu_read_lock_* are ignored. Thus we can pretend they don't exist.

The code in question is the __DO_TRACE() in include/linux/tracepoint.h:

		rcu_read_lock_sched_notrace();				\
		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
		if (it_func_ptr) {					\
			do {						\
				it_func = (it_func_ptr)->func;		\
				__data = (it_func_ptr)->data;		\
				((void(*)(proto))(it_func))(args);	\
			} while ((++it_func_ptr)->func);		\
		}							\
		rcu_read_unlock_sched_notrace();	

As stated above, the rcu_read_(un)lock_sched_notrace() are worthless
when in rcu_idle_enter().

They protect the referencing of tp->funcs, which is an array of all
funcs that are attached to this tracepoint.

Now we need to look at kernel/tracepoint.c:

The protection is needed against a simultaneous insertion or deletion of
a tracepoint hook. This happens when a user enables or disables tracing.

Note, this race is even made harder to hit, because due to the static
branch that controls whether this gets called, will be off if no
tracepoints are attached. So the race can only happen after at least one
tracepoint is active.

But if two probes are are added to this tracepoint, then we can hit the
race. And it is possible to trigger with only one probe on removal.

When adding or removing a tracepoint, the array (the one that
it_func_ptr points to) is updated by allocating a new array, copying the
old array plus or minus the tracpoint being added or removed, setting
the tp->funcs to the new array, and then it calls call_rcu_sched() to
free it.

Now for the bug to hit, something had to be coming in or out of idle,
and jumping to this code. Between the time it got the it_func_ptr to the
time it accessed any of that pointer's data in the loop, the tp->func
had to be updated to the new array, and then all CPUs would have passed
a schedule point (except the rcu_idle CPUs).

On uniprocessor, this is not an issue, but on SMP, it is possible that
with two CPUs the first being in rcu_idle may be ignored, and the second
would have been adding the tracepoint and then going directly to freeing
the code. But as tracepoints are very low weight, it is most likely that
the tracepoints will finish before the first could even free the memory.

But the chance does exist. As the chance of me winning the lottery,
becoming President of the United States, and curing cancer also exists!

;-)

-- Steve
