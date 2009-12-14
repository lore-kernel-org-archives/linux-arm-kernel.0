From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 12:15:13 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on SMP
	systems
In-Reply-To: <20091212122447.GA30537@n2100.arm.linux.org.uk>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
	<20091212122447.GA30537@n2100.arm.linux.org.uk>
Message-ID: <1260792913.17159.66.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-12-12 at 12:24 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2009 at 02:13:34PM +0000, Catalin Marinas wrote:
> > The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> > different from the current one, causing a race condition with both the
> > THREAD_NOTIFY_SWITCH path and vfp_support_entry().
> 
> The only call where thread->cpu may not be the current CPU is in the
> THREAD_NOFTIFY_RELEASE case.

Correct.

> When called in the THREAD_NOTIFY_SWITCH case, we are switching to the
> specified thread, and thread->cpu better be smp_processor_id() or else
> we're saving our CPUs VFP state into some other CPUs currently running
> thread.

Also correct.

> Not only that, but the thread we're switching away from will still be
> 'owned' by the CPU we're running on, and can't be scheduled onto another
> CPU without this function first completing, nor can it be flushed nor
> released.

Correct but see below.

> >  		/*
> > +		 * RCU locking is needed in case last_VFP_context[cpu] is
> > +		 * released on a different CPU.
> > +		 */
> > +		rcu_read_lock();
> 
> Given that we're modifying our CPUs last_VFP_context here, I don't see
> what the RCU locks give us - the thread we're switching to can _not_
> be being released at this time - we can't be switching to a dead task.
> Not only that, but this notifier is already called under the RCU lock,
> so this is a no-op.

With the current implementation, the last_CPU_context is set when the
CPU takes an undef for a VFP instruction and not during every context
switch, so last_VFP_context may *not* point to the task we are switching
away from. The RCU locking was added to prevent the task structure (and
thread_info) pointed to by last_VFP_context from being freed while
executing the switch between two tasks other than the one released.

If the region is RCU locked anyway, we can simply add a comment but
unless we change how last_CPU_context is set, we still need this check.

-- 
Catalin
