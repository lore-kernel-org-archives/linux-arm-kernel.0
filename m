From: longman@redhat.com (Waiman Long)
Date: Thu, 5 Apr 2018 17:16:16 -0400
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <1522947547-24081-3-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
Message-ID: <a4649773-9dac-c496-2796-713981ead426@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2018 12:58 PM, Will Deacon wrote:
> The qspinlock locking slowpath utilises a "pending" bit as a simple form
> of an embedded test-and-set lock that can avoid the overhead of explicit
> queuing in cases where the lock is held but uncontended. This bit is
> managed using a cmpxchg loop which tries to transition the uncontended
> lock word from (0,0,0) -> (0,0,1) or (0,0,1) -> (0,1,1).
>
> Unfortunately, the cmpxchg loop is unbounded and lockers can be starved
> indefinitely if the lock word is seen to oscillate between unlocked
> (0,0,0) and locked (0,0,1). This could happen if concurrent lockers are
> able to take the lock in the cmpxchg loop without queuing and pass it
> around amongst themselves.
>
> This patch fixes the problem by unconditionally setting _Q_PENDING_VAL
> using atomic_fetch_or, and then inspecting the old value to see whether
> we need to spin on the current lock owner, or whether we now effectively
> hold the lock. The tricky scenario is when concurrent lockers end up
> queuing on the lock and the lock becomes available, causing us to see
> a lockword of (n,0,0). With pending now set, simply queuing could lead
> to deadlock as the head of the queue may not have observed the pending
> flag being cleared. Conversely, if the head of the queue did observe
> pending being cleared, then it could transition the lock from (n,0,0) ->
> (0,0,1) meaning that any attempt to "undo" our setting of the pending
> bit could race with a concurrent locker trying to set it.
>
> We handle this race by preserving the pending bit when taking the lock
> after reaching the head of the queue and leaving the tail entry intact
> if we saw pending set, because we know that the tail is going to be
> updated shortly.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/locking/qspinlock.c | 80 ++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index a192af2fe378..b75361d23ea5 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -294,7 +294,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>  void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  {
>  	struct mcs_spinlock *prev, *next, *node;
> -	u32 new, old, tail;
> +	u32 old, tail;
>  	int idx;
>  
>  	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
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
> -	for (;;) {
> +	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
> +	if (!(val & ~_Q_LOCKED_MASK)) {
>  		/*
> -		 * If we observe any contention; queue.
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
> -		if (val & ~_Q_LOCKED_MASK)
> -			goto queue;
> -
> -		new = _Q_LOCKED_VAL;
> -		if (val == new)
> -			new |= _Q_PENDING_VAL;
> -
> +		if (val & _Q_LOCKED_MASK)
> +			smp_cond_load_acquire(&lock->val.counter,
> +					      !(VAL & _Q_LOCKED_MASK));
>  		/*
> -		 * Acquire semantic is required here as the function may
> -		 * return immediately if the lock was free.
> +		 * take ownership and clear the pending bit.
> +		 *
> +		 * *,1,0 -> *,0,1
>  		 */
> -		old = atomic_cmpxchg_acquire(&lock->val, val, new);
> -		if (old == val)
> -			break;
> -
> -		val = old;
> -	}
> -
> -	/*
> -	 * we won the trylock
> -	 */
> -	if (new == _Q_LOCKED_VAL)
> +		clear_pending_set_locked(lock);
>  		return;
> +	}
>  
>  	/*
> -	 * we're pending, wait for the owner to go away.
> -	 *
> -	 * *,1,1 -> *,1,0
> -	 *
> -	 * this wait loop must be a load-acquire such that we match the
> -	 * store-release that clears the locked bit and create lock
> -	 * sequentiality; this is because not all clear_pending_set_locked()
> -	 * implementations imply full barriers.
> -	 */
> -	smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
> -
> -	/*
> -	 * take ownership and clear the pending bit.
> -	 *
> -	 * *,1,0 -> *,0,1
> +	 * If pending was clear but there are waiters in the queue, then
> +	 * we need to undo our setting of pending before we queue ourselves.
>  	 */
> -	clear_pending_set_locked(lock);
> -	return;
> +	if (!(val & _Q_PENDING_MASK))
> +		atomic_andnot(_Q_PENDING_VAL, &lock->val);
Can we add a clear_pending() helper that will just clear the byte if
_Q_PENDING_BITS == 8? That will eliminate one atomic instruction from
the failure path.

-Longman
