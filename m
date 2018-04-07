From: boqun.feng@gmail.com (Boqun Feng)
Date: Sat, 7 Apr 2018 13:47:11 +0800
Subject: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
In-Reply-To: <1522947547-24081-11-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
Message-ID: <20180407054711.rldyfcmni2wtblyu@tardis>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> The qspinlock slowpath must ensure that the MCS node is fully initialised
> before it can be reached by another other CPU. This is currently enforced
> by using a RELEASE operation when updating the tail and also when linking
> the node into the waitqueue (since the control dependency off xchg_tail
> is insufficient to enforce sufficient ordering -- see 95bcade33a8a
> ("locking/qspinlock: Ensure node is initialised before updating prev->next")).
> 
> Back-to-back RELEASE operations may be expensive on some architectures,
> particularly those that implement them using fences under the hood. We
> can replace the two RELEASE operations with a single smp_wmb() fence and
> use RELAXED operations for the subsequent publishing of the node.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/locking/qspinlock.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 3ad8786a47e2..42c61f7b37c5 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -141,10 +141,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>  static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  {
>  	/*
> -	 * Use release semantics to make sure that the MCS node is properly
> -	 * initialized before changing the tail code.
> +	 * We can use relaxed semantics since the caller ensures that the
> +	 * MCS node is properly initialized before updating the tail.
>  	 */
> -	return (u32)xchg_release(&lock->tail,
> +	return (u32)xchg_relaxed(&lock->tail,
>  				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
>  }
>  
> @@ -178,10 +178,11 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>  	for (;;) {
>  		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
>  		/*
> -		 * Use release semantics to make sure that the MCS node is
> -		 * properly initialized before changing the tail code.
> +		 * We can use relaxed semantics since the caller ensures that
> +		 * the MCS node is properly initialized before updating the
> +		 * tail.
>  		 */
> -		old = atomic_cmpxchg_release(&lock->val, val, new);
> +		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
>  		if (old == val)
>  			break;
>  
> @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		goto release;
>  
>  	/*
> +	 * Ensure that the initialisation of @node is complete before we
> +	 * publish the updated tail and potentially link @node into the

I think it might be better if we mention exactly where we "publish the
updated tail" and "link @node", how about:

	* publish the update tail via xchg_tail() and potentially link
	* @node into the waitqueue via WRITE_ONCE(->next,..) below.

and also add comments below like:

> +	 * waitqueue.
> +	 */
> +	smp_wmb();
> +
> +	/*
>  	 * We have already touched the queueing cacheline; don't bother with
>  	 * pending stuff.
>  	 *
>  	 * p,*,* -> n,*,*
> -	 *
> -	 * RELEASE, such that the stores to @node must be complete.

	* publish the updated tail

>  	 */
>  	old = xchg_tail(lock, tail);
>  	next = NULL;
> @@ -356,15 +362,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 */
>  	if (old & _Q_TAIL_MASK) {
>  		prev = decode_tail(old);
> -
> -		/*
> -		 * We must ensure that the stores to @node are observed before
> -		 * the write to prev->next. The address dependency from
> -		 * xchg_tail is not sufficient to ensure this because the read
> -		 * component of xchg_tail is unordered with respect to the
> -		 * initialisation of @node.
> -		 */
> -		smp_store_release(&prev->next, node);

		/* Eventually link @node to the wait queue */
	
Thoughts?

Regards,
Boqun

> +		WRITE_ONCE(prev->next, node);
>  
>  		pv_wait_node(node, prev);
>  		arch_mcs_spin_lock_contended(&node->locked);
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180407/c08ab2ec/attachment.sig>
