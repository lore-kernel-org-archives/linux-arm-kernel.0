From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 3 Feb 2012 11:26:55 -0800
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <87ty37689a.fsf@ti.com>
References: <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <20120202230326.GJ2518@linux.vnet.ibm.com> <87ty37689a.fsf@ti.com>
Message-ID: <20120203192655.GJ2382@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 11:12:49AM -0800, Kevin Hilman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > On Thu, Feb 02, 2012 at 02:20:26PM -0800, Kevin Hilman wrote:
> >> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> >> 
> >> [...]
> >> 
> >> >> > The two options I see are:
> >> >> > 
> >> >> > 1.	Rip tracing out of the inner idle loops and everything that
> >> >> > 	they invoke.
> >> >> 
> >> >> What I suggested above.  But as I said I know sh*t about that tracing 
> >> >> implementation so that's an easy suggestion for me to make.
> >> >
> >> > Works for me as well.  ;-)
> >> 
> >> While I must admit not having a better suggestion, I for one would vote
> >> strongly against removing tracing from the idle path.
> >> 
> >> Being a PM developer and maintainer, much of the code I work on and
> >> maintain happens to be run in the bowels of the idle path.  Not having
> >> the ability to trace this code would be a major step backwards IMO.
> >
> > OK...
> >
> > What if the tracing code between the rcu_idle_enter() and the
> > rcu_idle_exit() had to be enclosed in a wrapper?  For example,
> > the tracing in cpuidle_idle_call() might appear as follows:
> >
> > 	RCU_NONIDLE(
> > 		trace_power_start(POWER_CSTATE, next_state, dev->cpu);
> > 		trace_cpu_idle(next_state, dev->cpu);
> > 	);
> >
> > 	entered_state = target_state->enter(dev, drv, next_state);
> >
> > 	RCU_NONIDLE(
> > 		trace_power_end(dev->cpu);
> > 		trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
> > 	);
> >
> > The RCU_NONIDLE() macro would do rcu_idle_exit(), execute its
> > argument, then do rcu_idle_enter().  (Credit to Steven Rostedt
> > for suggesting this.)  Given the possibility of code invoked both
> > from idle and not-idle, I have some changes to rcu to allow nesting
> > of rcu_idle_enter() and rcu_idle_exit().
> >
> > Would that work for you?
> 
> Yes, that should work.
> 
> And I defintely have examples of code paths that use tracepoints in both
> idle and non-idle context (power domains, clocks, etc.) so the changes
> to allow nesting will be needed.

OK, good to know that my paranoia is still functioning correctly.  ;-)

							Thanx, Paul
