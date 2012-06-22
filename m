From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 22 Jun 2012 16:08:47 -0400 (EDT)
Subject: [PATCH 1/2] ARM: spinlock: use ticket algorithm for ARMv6+ locking
 implementation
In-Reply-To: <1340378146-17560-2-git-send-email-will.deacon@arm.com>
References: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
 <1340378146-17560-2-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1206221443100.10229@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, Will Deacon wrote:

> Ticket spinlocks ensure locking fairness by reducing the thundering herd
> effect when acquiring a lock.

The conventional thundering herd effect is still there as all waiting 
CPUs are still woken up from WFE upon a spin_unlock with a SEV.  Maybe 
the fact that the actual spinning is no longer banging on the exclusion 
monitor does count as reduction of the thundering herd effect at that 
level though, and if that is what you meant then this could be precised 
here.

> This is especially important on systems
> where memory-access times are not necessarily uniform when accessing
> the lock structure (for example, on a multi-cluster platform where the
> lock is allocated into L1 when a CPU releases it).

In which case it is more about fairness.  This algorithm brings fairness 
due to its FIFO nature, despite possible memory access speed 
differences.  And that is even more important than the thundering herd 
effect.  Solving both at once is of course all good.

> This patch implements the ticket spinlock algorithm for ARM, replacing
> the simpler implementation for ARMv6+ processors.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

A minor remarks below.  Otherwise...

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/spinlock.h       |   73 ++++++++++++++++++++++-----------
>  arch/arm/include/asm/spinlock_types.h |   17 +++++++-
>  2 files changed, 64 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index 65fa3c8..dcca638 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -79,31 +74,40 @@ static inline void dsb_sev(void)
>  static inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
>  	unsigned long tmp;
> +	u32 newval;
> +	arch_spinlock_t lockval;
>  
>  	__asm__ __volatile__(
> -"1:	ldrex	%0, [%1]\n"
> -"	teq	%0, #0\n"
> -	WFE("ne")
> -"	strexeq	%0, %2, [%1]\n"
> -"	teqeq	%0, #0\n"
> +"1:	ldrex	%0, [%3]\n"
> +"	add	%1, %0, %4\n"
> +"	strex	%2, %1, [%3]\n"
> +"	teq	%2, #0\n"
>  "	bne	1b"
> -	: "=&r" (tmp)
> -	: "r" (&lock->lock), "r" (1)
> +	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp)
> +	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
>  	: "cc");
>  
> +	while (lockval.tickets.next != lockval.tickets.owner) {
> +		wfe();
> +		lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
> +	}
> +
>  	smp_mb();
>  }
>  
>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
>  {
>  	unsigned long tmp;
> +	u32 slock;
>  
>  	__asm__ __volatile__(
> -"	ldrex	%0, [%1]\n"
> -"	teq	%0, #0\n"
> -"	strexeq	%0, %2, [%1]"
> -	: "=&r" (tmp)
> -	: "r" (&lock->lock), "r" (1)
> +"	ldrex	%0, [%2]\n"
> +"	cmp	%0, %0, ror #16\n"
> +"	movne	%1, #1\n"

You could replace the above 2 insns with:

	subs	%1, %0, %0, ror #16

> +"	addeq	%0, %0, %3\n"
> +"	strexeq	%1, %0, [%2]"
> +	: "=&r" (slock), "=&r" (tmp)
> +	: "r" (&lock->slock), "I" (1 << TICKET_SHIFT)
>  	: "cc");
>  
>  	if (tmp == 0) {


Nicolas
