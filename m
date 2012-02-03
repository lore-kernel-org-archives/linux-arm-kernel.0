From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 03 Feb 2012 13:55:09 -0500
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120203060458.GF2380@linux.vnet.ibm.com>
References: <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
Message-ID: <1328295309.5882.178.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-02 at 22:04 -0800, Paul E. McKenney wrote:
> On Thu, Feb 02, 2012 at 09:45:31PM -0500, Steven Rostedt wrote:

> It is an atomic instruction or two, plus some memory barriers.  Entering
> idle is more heavyweight for RCU_FAST_NO_HZ.  But as you say, it is
> entering and exiting idle.
> 
> But should I make an empty definition of RCU_NONIDLE() for some #define
> or another?
> 
> 	#ifdef CONFIG_YOU_TELL_ME
> 	#define RCU_NONIDLE(a) \
> 		do { \
> 			rcu_idle_exit(); \
> 			do { a; } while (0); \
> 			rcu_idle_enter(); \
> 		} while (0)
> 	#else /* #ifdef CONFIG_YOU_TELL_ME */
> 	#define RCU_NONIDLE(a) do { } while (0);
> 	#endif /* #else #ifdef CONFIG_YOU_TELL_ME */
> 
> Or is event tracing unconditional these days?

I don't like it. As it binds the RCU_NONIDLE to tracepoints only without
any annotation that they are bound. Still doesn't help when tracepoints
are configured but not enabled.

I have no problem in making a special TRACE_EVENT_IDLE() that does this
inside the jump label. Basically what we have today is:


	if (static_branch(tracepoint_key)) {
		rcu_read_lock_sched_notrace();
		for (all attached tracepoints) {
			[...]
		}
		rcu_read_unlock_sched_notrace();
	}

Ideally we want the enter/exit idle inside that static_branch()
condition:

	if (static_branch(tracepoint_key)) {
		rcu_idle_exit();
		rcu_read_lock_sched_notrace();
		for (all attached tracepoints) {
			[...]
		}
		rcu_read_unlock_sched_notrace();
		rcu_idle_enter();
	}

The static_branch() is the jump label code when it's a nop when disabled
and a jump to the tracing code when enabled:

	nop; /* or jmp 2f */  <<--- jump label
1:	[ normal code ]
	ret;

2:	[trace code]
	jmp 1b


The jump label when disabled is just a nop that ignores the trace code
(although current gcc has a bug that it currently doesn't do it this
elegantly). When tracing is enabled the nop is converted to a jump to
the tracing code. This makes tracepoints very light weight in hot paths.

Ideally, we want the exit/enter rcu idle with in the [trace code], which
makes it not used when not needed.

-- Steve
