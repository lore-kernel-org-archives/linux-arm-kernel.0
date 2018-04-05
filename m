From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Apr 2018 19:13:08 +0200
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180405171308.GD4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 05:58:59PM +0100, Will Deacon wrote:
> @@ -306,58 +306,48 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		return;
>  
>  	/*
> +	 * If we observe any contention; queue.
> +	 */
> +	if (val & ~_Q_LOCKED_MASK)
> +		goto queue;
> +
> +	/*
>  	 * trylock || pending
>  	 *
>  	 * 0,0,0 -> 0,0,1 ; trylock
>  	 * 0,0,1 -> 0,1,1 ; pending
>  	 */
> +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +	if (!(val & ~_Q_LOCKED_MASK)) {
>  		/*
> +		 * we're pending, wait for the owner to go away.
> +		 *
> +		 * *,1,1 -> *,1,0
> +		 *
> +		 * this wait loop must be a load-acquire such that we match the
> +		 * store-release that clears the locked bit and create lock
> +		 * sequentiality; this is because not all
> +		 * clear_pending_set_locked() implementations imply full
> +		 * barriers.
>  		 */
> +		if (val & _Q_LOCKED_MASK)
> +			smp_cond_load_acquire(&lock->val.counter,
> +					      !(VAL & _Q_LOCKED_MASK));

I much prefer { } for multi-line statements like this.

>  		/*
> +		 * take ownership and clear the pending bit.
> +		 *
> +		 * *,1,0 -> *,0,1
>  		 */
> +		clear_pending_set_locked(lock);
>  		return;
> +	}
