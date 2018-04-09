From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 9 Apr 2018 17:54:20 +0200
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <20180409145409.GA9661@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180409105835.GC23134@arm.com> <20180409145409.GA9661@arm.com>
Message-ID: <20180409155420.GB4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:54:09PM +0100, Will Deacon wrote:

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 19261af9f61e..71eb5e3a3d91 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -139,6 +139,20 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
>  }
>  
> +/**
> + * set_pending_fetch_acquire - set the pending bit and return the old lock
> + *                             value with acquire semantics.
> + * @lock: Pointer to queued spinlock structure
> + *
> + * *,*,* -> *,1,*
> + */
> +static __always_inline u32 set_pending_fetch_acquire(struct qspinlock *lock)
> +{
> +	u32 val = xchg_relaxed(&lock->pending, 1) << _Q_PENDING_OFFSET;
> +	val |= (atomic_read_acquire(&lock->val) & ~_Q_PENDING_MASK);
> +	return val;
> +}

> @@ -289,18 +315,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		return;
>  
>  	/*
> -	 * If we observe any contention; queue.
> +	 * If we observe queueing, then queue ourselves.
>  	 */
> -	if (val & ~_Q_LOCKED_MASK)
> +	if (val & _Q_TAIL_MASK)
>  		goto queue;
>  
>  	/*
> +	 * We didn't see any queueing, so have one more try at snatching
> +	 * the lock in case it became available whilst we were taking the
> +	 * slow path.
> +	 */
> +	if (queued_spin_trylock(lock))
> +		return;
> +
> +	/*
>  	 * trylock || pending
>  	 *
>  	 * 0,0,0 -> 0,0,1 ; trylock
>  	 * 0,0,1 -> 0,1,1 ; pending
>  	 */
> +	val = set_pending_fetch_acquire(lock);
>  	if (!(val & ~_Q_LOCKED_MASK)) {

So, if I remember that partial paper correctly, the atomc_read_acquire()
can see 'arbitrary' old values for everything except the pending byte,
which it just wrote and will fwd into our load, right?

But I think coherence requires the read to not be older than the one
observed by the trylock before (since it uses c-cas its acquire can be
elided).

I think this means we can miss a concurrent unlock vs the fetch_or. And
I think that's fine, if we still see the lock set we'll needlessly 'wait'
for it go become unlocked.
