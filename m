From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 20 Apr 2016 17:52:05 +0100
Subject: [PATCH] drivers/perf: arm-pmu: fix RCU usage on resume from idle
 states
In-Reply-To: <20160420162354.GB3539@linux.vnet.ibm.com>
References: <1461085689-2893-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160419172320.GD4509@arm.com> <7hr3e1b77r.fsf@baylibre.com>
 <20160420134116.GA8537@red-moon>
 <20160420162354.GB3539@linux.vnet.ibm.com>
Message-ID: <20160420165205.GA17840@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 09:23:54AM -0700, Paul E. McKenney wrote:

[...]

> > > Maybe RCU_NONIDLE() will help here?
> > 
> > Thanks for chiming in.
> > 
> > CPU_PM notifiers are called from process context (which is not necessarily
> > the idle thread) with IRQs disabled from:
> > 
> > - CPUidle drivers state enter calls
> > - syscore callbacks (ie suspend2RAM - suspend thread)
> > - bL switcher
> > - MCPM loopback
> > 
> > The questions I have are:
> > 
> > - Is it safe to wrap a call (in this case armpmu_start()) with RCU_NONIDLE
> >   if the core is not actually executing the idle thread ? The function
> >   requiring rcu locks/dereferences is perf_event_update_userpage().
> 
> Yes it is.
> 
> > - What are RCU_NONIDLE side-effects (ie what can be actually called from
> >   within an RCU_NONIDLE wrapper ?)
> 
> There are a few restrictions:
> 
> 1.	Code within RCU_NONIDLE() cannot block.  Then again, neither
> 	can the idle task.  ;-)
> 
> 2.	RCU_NONIDLE() can be nested, but not indefinitely.  Then again,
> 	given that the limit even on a 32-bit system is something like
> 	a million, I bet you hit compiler or stack-size limits long
> 	before you overflow RCU_NONIDLE()'s counter.
> 
> 3.	You can neither branch into the middle of RCU_NONIDLE()'s code
> 	nor branch out from the middle of RCU_NONIDLE()'s code.
> 	Calling functions is just fine, but things like this are not:
> 
> 		RCU_NONIDLE({
> 			do_something();
> 			goto bad_idea;	/* BUG!!! */
> 			do_something_else();});
> 		do_yet_a_third_thing();
> 	bad_idea:
> 
> 	Branching -within- the RCU_NONIDLE() code is just fine.
> 
> Yes, and I am adding this information to RCU_NONIDLE()'s header
> comment, apologies for its not being there to begin with!
> (See below for patches.)

Thank you for the explanation, that's now clear. For my own understanding:
RCU_NONIDLE() is a way to inform the RCU subsystem that the CPU in question
should be temporarily *watched* (ie it is not idle from an RCU standpoint),
correct ?

> > It would be nice if we can use it instead of merging this patch, I need
> > more insights into RCU_NONIDLE usage though before proceeding.
> 
> Please let me know if any of the above restrictions cause you a problem.

I can't think of any, perf_event_update_userpage(), that I will call
indirectly through:

RCU_NONIDLE(armpmu_start());

is not allowed to block anyway, so I think we have a much better
solution than this one, new patch coming, Catalin please drop this one.

Thank you all !
Lorenzo
