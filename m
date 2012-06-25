From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Jun 2012 10:36:48 +0100
Subject: [PATCH 1/2] ARM: spinlock: use ticket algorithm for ARMv6+
 locking implementation
In-Reply-To: <alpine.LFD.2.02.1206221443100.10229@xanadu.home>
References: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
 <1340378146-17560-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1206221443100.10229@xanadu.home>
Message-ID: <20120625093648.GC22128@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Thanks for looking at this.

On Fri, Jun 22, 2012 at 09:08:47PM +0100, Nicolas Pitre wrote:
> On Fri, 22 Jun 2012, Will Deacon wrote:
> 
> > Ticket spinlocks ensure locking fairness by reducing the thundering herd
> > effect when acquiring a lock.
> 
> The conventional thundering herd effect is still there as all waiting 
> CPUs are still woken up from WFE upon a spin_unlock with a SEV.  Maybe 
> the fact that the actual spinning is no longer banging on the exclusion 
> monitor does count as reduction of the thundering herd effect at that 
> level though, and if that is what you meant then this could be precised 
> here.

Sure, I can clarify that. The thundering herd effect is reduced because (a)
the cacheline can remain shared and (b) the memory access time doesn't
determine the winner.

> > This is especially important on systems
> > where memory-access times are not necessarily uniform when accessing
> > the lock structure (for example, on a multi-cluster platform where the
> > lock is allocated into L1 when a CPU releases it).
> 
> In which case it is more about fairness.  This algorithm brings fairness 
> due to its FIFO nature, despite possible memory access speed 
> differences.  And that is even more important than the thundering herd 
> effect.  Solving both at once is of course all good.

Precisely.

> > This patch implements the ticket spinlock algorithm for ARM, replacing
> > the simpler implementation for ARMv6+ processors.
> > 
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> A minor remarks below.  Otherwise...
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks Nicolas.

> >  static inline int arch_spin_trylock(arch_spinlock_t *lock)
> >  {
> >  	unsigned long tmp;
> > +	u32 slock;
> >  
> >  	__asm__ __volatile__(
> > -"	ldrex	%0, [%1]\n"
> > -"	teq	%0, #0\n"
> > -"	strexeq	%0, %2, [%1]"
> > -	: "=&r" (tmp)
> > -	: "r" (&lock->lock), "r" (1)
> > +"	ldrex	%0, [%2]\n"
> > +"	cmp	%0, %0, ror #16\n"
> > +"	movne	%1, #1\n"
> 
> You could replace the above 2 insns with:
> 
> 	subs	%1, %0, %0, ror #16

Wahey, that is extremely concise!

Cheers,

Will
