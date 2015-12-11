From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 11 Dec 2015 13:13:19 +0100
Subject: FW: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <20151211120419.GD18828@arm.com>
References: <5669D5F2.5050004@caviumnetworks.com>
 <SN1PR07MB21577C72379C8440A208D6BC9EEA0@SN1PR07MB2157.namprd07.prod.outlook.com>
 <CA+=Sn1miWYhH5ddMmLGYWknzcw3d1k4S6QyK9O_ofdJKJDQxmg@mail.gmail.com>
 <CA+=Sn1n6e9pLDRVWT1EzDEn2XWwoK-Ep__-R6VVPzhbMvCEdNg@mail.gmail.com>
 <20151211084133.GE6356@twins.programming.kicks-ass.net>
 <20151211120419.GD18828@arm.com>
Message-ID: <20151211121319.GK6356@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 12:04:19PM +0000, Will Deacon wrote:
> I think Andrew meant the atomic_xchg_acquire at the start of osq_lock,
> as opposed to "compare and swap". In which case, it does look like
> there's a bug here because there is nothing to order the initialisation
> of the node fields with publishing of the node, whether that's
> indirectly as a result of setting the tail to the current CPU or
> directly as a result of the WRITE_ONCE.

Agreed, this does indeed look like a bug. If confirmed please write a
shiny changelog and I'll queue asap.

> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d092a0c9c2d4..05a37857ab55 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -93,10 +93,12 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>  	node->cpu = curr;
>  
>  	/*
> -	 * ACQUIRE semantics, pairs with corresponding RELEASE
> -	 * in unlock() uncontended, or fastpath.
> +	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> +	 * unlock() uncontended, or fastpath) and RELEASE (to publish
> +	 * the node fields we just initialised) semantics when updating
> +	 * the lock tail.
>  	 */
> -	old = atomic_xchg_acquire(&lock->tail, curr);
> +	old = atomic_xchg(&lock->tail, curr);
>  	if (old == OSQ_UNLOCKED_VAL)
>  		return true;
>  
