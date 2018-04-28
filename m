From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 28 Apr 2018 14:45:37 +0200
Subject: [PATCH v3 05/14] locking/qspinlock: Remove unbounded cmpxchg
 loop from locking slowpath
In-Reply-To: <20180426165518.GC898@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
 <1524738868-31318-6-git-send-email-will.deacon@arm.com>
 <20180426155335.GL4064@hirez.programming.kicks-ass.net>
 <20180426165518.GC898@arm.com>
Message-ID: <20180428124537.GD4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 05:55:19PM +0100, Will Deacon wrote:
> Hi Peter,
> 
> On Thu, Apr 26, 2018 at 05:53:35PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 26, 2018 at 11:34:19AM +0100, Will Deacon wrote:
> > > @@ -290,58 +312,50 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > >  	}
> > >  
> > >  	/*
> > > +	 * If we observe any contention; queue.
> > > +	 */
> > > +	if (val & ~_Q_LOCKED_MASK)
> > > +		goto queue;
> > > +
> > > +	/*
> > >  	 * trylock || pending
> > >  	 *
> > >  	 * 0,0,0 -> 0,0,1 ; trylock
> > >  	 * 0,0,1 -> 0,1,1 ; pending
> > >  	 */
> > > +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> > > +	if (!(val & ~_Q_LOCKED_MASK)) {
> > >  		/*
> > > +		 * we're pending, wait for the owner to go away.
> > > +		 *
> > > +		 * *,1,1 -> *,1,0
> > 
> > Tail must be 0 here, right?
> 
> Not necessarily. If we're concurrently setting pending with another slowpath
> locker, they could queue in the tail behind us, so we can't mess with those
> upper bits.

Could be my brain just entirely stopped working; but I read that as:

	!(val & ~0xFF) := !(val & 0xFFFFFF00)

which then pretty much mandates the top bits are empty, no?
