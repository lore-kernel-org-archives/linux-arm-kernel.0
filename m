From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 14 Oct 2015 13:07:17 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014102706.GR14956@sirena.org.uk>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014102706.GR14956@sirena.org.uk>
Message-ID: <20151014110717.GT17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:27:06AM +0100, Mark Brown wrote:
> On Wed, Oct 14, 2015 at 10:20:50AM +0200, Peter Zijlstra wrote:
> 
> > Uuh, I just looked at next and saw this regulator_lock_supply()
> > function. How is that limited? subclass must be <8 otherwise bad things
> > happen.
> 
> Can we please get some more discoverable documentation of the arbitrary
> limits in the lockdep code? 

include/linux/lockdep.h:#define MAX_LOCKDEP_SUBCLASSES          8UL

Also, it will give a runtime warn if you ever do hit that.

> I seem to keep seeing code that bumps into
> surprising limits like this and I'm not sure how I'm supposed to know
> about them except through finding out after the fact or trawling the
> code every time someone touches locking.

Not knowing what other limits you've hit, I'm not entirely sure how to
help out there.

> I would be very surprised to see a system that pushes over 8 locks,
> while there's nothing actually preventing it system design
> considerations mean that even four cascaded supplies are pretty
> unlikely so we should be fine.  Every time you add a new level of
> regulation you're both increasing the load on regulators up the chain
> (which means they need to be bigger and more expensive) and except in
> the case of a DCDC supplying an LDO (which only works to one level)
> you're going to be decreasing the efficiency of the system.  If we get
> to that point we can worry about what to do.

OK I suppose.
