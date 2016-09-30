From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 30 Sep 2016 19:43:12 +0100
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
Message-ID: <61567858-7224-c7af-5207-3872671b58ad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brent,

On 30/09/16 18:40, Brent DeGraaf wrote:
> Prior spinlock code solely used load-acquire and store-release
> semantics to ensure ordering of the spinlock lock and the area it
> protects. However, store-release semantics and ordinary stores do
> not protect against accesses to the protected area being observed
> prior to the access that locks the lock itself.
> 
> While the load-acquire and store-release ordering is sufficient
> when the spinlock routines themselves are strictly used, other
> kernel code that references the lock values directly (e.g. lockrefs)
> could observe changes to the area protected by the spinlock prior
> to observance of the lock itself being in a locked state, despite
> the fact that the spinlock logic itself is correct.
> 
> Barriers were added to all the locking routines wherever necessary
> to ensure that outside observers which read the lock values directly
> will not observe changes to the protected data before the lock itself
> is observed.
> 
> Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
> ---
>  arch/arm64/include/asm/spinlock.h | 59 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
> index 89206b5..4dd0977 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -106,7 +106,20 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  
>  	/* Did we get the lock? */
>  "	eor	%w1, %w0, %w0, ror #16\n"
> -"	cbz	%w1, 3f\n"
> +"	cbnz	%w1, 4f\n"
> +	/*
> +	 * Yes: The store done on this cpu was the one that locked the lock.
> +	 * Store-release one-way barrier on LL/SC means that accesses coming
> +	 * after this could be reordered into the critical section of the
> +	 * load-acquire/store-release, where we did not own the lock. On LSE,
> +	 * even the one-way barrier of the store-release semantics is missing,
> +	 * so LSE needs an explicit barrier here as well.  Without this, the
> +	 * changed contents of the area protected by the spinlock could be
> +	 * observed prior to the lock.

What is that last sentence supposed to mean? If the lock is free, then
surely any previous writes to the data it's protecting would have
already been observed by the release semantics of the previous unlock?
If the lock is currently held, what do we care about the state of the
data while we're still spinning on the lock itself? And if someone's
touching the data without having acquired *or* released the lock, why is
there a lock in the first place?

This seems like a very expensive way of papering over broken callers :/

Robin.

> +	 */
> +"	dmb	ish\n"
> +"	b	3f\n"
> +"4:\n"
>  	/*
>  	 * No: spin on the owner. Send a local event to avoid missing an
>  	 * unlock before the exclusive load.
> @@ -116,7 +129,15 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>  "	ldaxrh	%w2, %4\n"
>  "	eor	%w1, %w2, %w0, lsr #16\n"
>  "	cbnz	%w1, 2b\n"
> -	/* We got the lock. Critical section starts here. */
> +	/*
> +	 * We got the lock and have observed the prior owner's store-release.
> +	 * In this case, the one-way barrier of the prior owner that we
> +	 * observed combined with the one-way barrier of our load-acquire is
> +	 * enough to ensure accesses to the protected area coming after this
> +	 * are not accessed until we own the lock.  In this case, other
> +	 * observers will not see our changes prior to observing the lock
> +	 * itself.  Critical locked section starts here.
> +	 */
>  "3:"
>  	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
>  	: "Q" (lock->owner), "I" (1 << TICKET_SHIFT)
> @@ -137,6 +158,13 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
>  	"	add	%w0, %w0, %3\n"
>  	"	stxr	%w1, %w0, %2\n"
>  	"	cbnz	%w1, 1b\n"
> +	/*
> +	 * We got the lock with a successful store-release: Store-release
> +	 * one-way barrier means accesses coming after this could be observed
> +	 * before the lock is observed as locked.
> +	 */
> +	"	dmb	ish\n"
> +	"	nop\n"
>  	"2:",
>  	/* LSE atomics */
>  	"	ldr	%w0, %2\n"
> @@ -146,6 +174,13 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
>  	"	casa	%w0, %w1, %2\n"
>  	"	and	%w1, %w1, #0xffff\n"
>  	"	eor	%w1, %w1, %w0, lsr #16\n"
> +	"	cbnz	%w1, 1f\n"
> +	/*
> +	 * We got the lock with the LSE casa store.
> +	 * A barrier is required to ensure accesses coming from the
> +	 * critical section of the lock are not observed before our lock.
> +	 */
> +	"	dmb	ish\n"
>  	"1:")
>  	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
>  	: "I" (1 << TICKET_SHIFT)
> @@ -212,6 +247,12 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
>  	"	cbnz	%w0, 1b\n"
>  	"	stxr	%w0, %w2, %1\n"
>  	"	cbnz	%w0, 2b\n"
> +	/*
> +	 * Lock is not ours until the store, which has no implicit barrier.
> +	 * Barrier is needed so our writes to the protected area are not
> +	 * observed before our lock ownership is observed.
> +	 */
> +	"	dmb	ish\n"
>  	"	nop",
>  	/* LSE atomics */
>  	"1:	mov	%w0, wzr\n"
> @@ -221,7 +262,12 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
>  	"	cbz	%w0, 2b\n"
>  	"	wfe\n"
>  	"	b	1b\n"
> -	"3:")
> +	/*
> +	 * Casa doesn't use store-release semantics. Even if it did,
> +	 * it would not protect us from our writes being observed before
> +	 * our ownership is observed. Barrier is required.
> +	 */
> +	"3:	dmb	ish")
>  	: "=&r" (tmp), "+Q" (rw->lock)
>  	: "r" (0x80000000)
>  	: "memory");
> @@ -299,7 +345,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
>  	"	tbnz	%w1, #31, 1b\n"
>  	"	casa	%w0, %w1, %2\n"
>  	"	sbc	%w0, %w1, %w0\n"
> -	"	cbnz	%w0, 2b")
> +	"	cbnz	%w0, 2b\n"
> +	/*
> +	 * Need to ensure that our reads of the area protected by the lock
> +	 * are not observed before our lock ownership is observed.
> +	 */
> +	"	dmb	ish\n")
>  	: "=&r" (tmp), "=&r" (tmp2), "+Q" (rw->lock)
>  	:
>  	: "cc", "memory");
> 
