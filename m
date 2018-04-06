From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Apr 2018 11:54:17 +0100
Subject: [PATCH 03/10] locking/qspinlock: Kill cmpxchg loop when claiming
 lock from head of queue
In-Reply-To: <20180405171912.GE4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-4-git-send-email-will.deacon@arm.com>
 <20180405171912.GE4082@hirez.programming.kicks-ass.net>
Message-ID: <20180406105417.GA27619@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 07:19:12PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 05, 2018 at 05:59:00PM +0100, Will Deacon wrote:
> > +
> > +	/* In the PV case we might already have _Q_LOCKED_VAL set */
> > +	if ((val & _Q_TAIL_MASK) == tail) {
> >  		/*
> >  		 * The smp_cond_load_acquire() call above has provided the
> > +		 * necessary acquire semantics required for locking.
> >  		 */
> >  		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
> >  		if (old == val)
> > +			goto release; /* No contention */
> >  	}
> 
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -464,8 +464,7 @@ void queued_spin_lock_slowpath(struct qs
>  		 * The smp_cond_load_acquire() call above has provided the
>  		 * necessary acquire semantics required for locking.
>  		 */
> -		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
> -		if (old == val)
> +		if (atomic_try_cmpxchg_release(&lock->val, &val, _Q_LOCKED_VAL))
>  			goto release; /* No contention */
>  	}
> 
> Does that also work for you? It would generate slightly better code for
> x86 (not that it would matter much on this path).

Assuming you meant to use atomic_try_cmpxchg_relaxed, then that works for
me too.

Will
