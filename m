From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jul 2015 18:29:18 +0100
Subject: [PATCH 07/18] arm64: locks: patch in lse instructions when
 supported by the CPU
In-Reply-To: <20150721165338.GE7250@e104818-lin.cambridge.arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-8-git-send-email-will.deacon@arm.com>
 <20150721165338.GE7250@e104818-lin.cambridge.arm.com>
Message-ID: <20150721172918.GO31095@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Jul 21, 2015 at 05:53:39PM +0100, Catalin Marinas wrote:
> On Mon, Jul 13, 2015 at 10:25:08AM +0100, Will Deacon wrote:
> > @@ -67,15 +78,25 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
> >  	unsigned int tmp;
> >  	arch_spinlock_t lockval;
> >  
> > -	asm volatile(
> > -"	prfm	pstl1strm, %2\n"
> > -"1:	ldaxr	%w0, %2\n"
> > -"	eor	%w1, %w0, %w0, ror #16\n"
> > -"	cbnz	%w1, 2f\n"
> > -"	add	%w0, %w0, %3\n"
> > -"	stxr	%w1, %w0, %2\n"
> > -"	cbnz	%w1, 1b\n"
> > -"2:"
> > +	asm volatile(ARM64_LSE_ATOMIC_INSN(
> > +	/* LL/SC */
> > +	"	prfm	pstl1strm, %2\n"
> > +	"1:	ldaxr	%w0, %2\n"
> > +	"	eor	%w1, %w0, %w0, ror #16\n"
> > +	"	cbnz	%w1, 2f\n"
> > +	"	add	%w0, %w0, %3\n"
> > +	"	stxr	%w1, %w0, %2\n"
> > +	"	cbnz	%w1, 1b\n"
> > +	"2:",
> > +	/* LSE atomics */
> > +	"	ldar	%w0, %2\n"
> 
> Do we still need an acquire if we fail to take the lock?

Good point, I think we can drop that. Read-after-read ordering is sufficient
to order LDR -> CASA in a trylock loop.

> 
> > +	"	eor	%w1, %w0, %w0, ror #16\n"
> > +	"	cbnz	%w1, 1f\n"
> > +	"	add	%w1, %w0, %3\n"
> > +	"	casa	%w0, %w1, %2\n"
> > +	"	and	%w1, %w1, #0xffff\n"
> > +	"	eor	%w1, %w1, %w0, lsr #16\n"
> > +	"1:")
> >  	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
> >  	: "I" (1 << TICKET_SHIFT)
> >  	: "memory");
> 
> I wonder if this is any faster with LSE. CAS would have to re-load the
> lock but we already have the value loaded (though most likely the reload
> will be from cache and we save a cbnz that can be mispredicted). I guess
> we'll re-test when we get some real hardware.

Yeah, I'll definitely want to evaluate this on real hardware when it shows
up. For now, I'm basically trying to avoid explicit dirtying at L1, so
the CAS at least gives hardware the chance to go far in the face of
contention.

> Does prfm help in any way with the LDAR?

We'd need to prfm for write, which would end up forcing everything near
(which I'm avoiding for now).

> > @@ -85,10 +106,19 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
> >  
> >  static inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > -	asm volatile(
> > -"	stlrh	%w1, %0\n"
> > -	: "=Q" (lock->owner)
> > -	: "r" (lock->owner + 1)
> > +	unsigned long tmp;
> > +
> > +	asm volatile(ARM64_LSE_ATOMIC_INSN(
> > +	/* LL/SC */
> > +	"	ldr	%w1, %0\n"
> > +	"	add	%w1, %w1, #1\n"
> > +	"	stlrh	%w1, %0",
> > +	/* LSE atomics */
> > +	"	mov	%w1, #1\n"
> > +	"	nop\n"
> > +	"	staddlh	%w1, %0")
> > +	: "=Q" (lock->owner), "=&r" (tmp)
> > +	:
> >  	: "memory");
> >  }
> >  
> > @@ -125,11 +155,19 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
> >  
> >  	asm volatile(
> >  	"	sevl\n"
> > +	ARM64_LSE_ATOMIC_INSN(
> > +	/* LL/SC */
> >  	"1:	wfe\n"
> >  	"2:	ldaxr	%w0, %1\n"
> >  	"	cbnz	%w0, 1b\n"
> >  	"	stxr	%w0, %w2, %1\n"
> > -	"	cbnz	%w0, 2b\n"
> > +	"	cbnz	%w0, 2b",
> > +	/* LSE atomics */
> > +	"1:	wfe\n"
> > +	"	mov	%w0, wzr\n"
> > +	"	casa	%w0, %w2, %1\n"
> > +	"	nop\n"
> > +	"	cbnz	%w0, 1b")
> >  	: "=&r" (tmp), "+Q" (rw->lock)
> >  	: "r" (0x80000000)
> >  	: "memory");
> 
> With WFE in the LL/SC case, we rely on LDAXR to set the exclusive
> monitor and an event would be generated every time it gets cleared. With
> CAS, we no longer have this behaviour, so what guarantees a SEV?

My understanding was that failed CAS will set the exclusive monitor, but
what I have for a spec doesn't actually comment on this behaviour. I'll
go digging...

> > @@ -139,11 +177,16 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
> >  {
> >  	unsigned int tmp;
> >  
> > -	asm volatile(
> > +	asm volatile(ARM64_LSE_ATOMIC_INSN(
> > +	/* LL/SC */
> >  	"	ldaxr	%w0, %1\n"
> >  	"	cbnz	%w0, 1f\n"
> >  	"	stxr	%w0, %w2, %1\n"
> 
> Not a comment to your patch but to the original code: don't we need a
> branch back to ldaxr if stxr fails, like we do for arch_spin_trylock?
> The same comment for arch_read_trylock.

I don't think Linux specifies the behaviour here, to be honest. C11
distinguishes between "weak" and "strong" cmpxchg to try and address this
sort of thing. Since we're not sure, I suppose we should loop (like we
do for arch/arm/).

Bear in mind that I'm currently moving us over to the qrwlock once I've
got this out of the way and added generic support for relaxed atomics,
which will result in the deletion of all of this anyway.

> 
> > -	"1:\n"
> > +	"1:",
> > +	/* LSE atomics */
> > +	"	mov	%w0, wzr\n"
> > +	"	casa	%w0, %w2, %1\n"
> > +	"	nop")
> >  	: "=&r" (tmp), "+Q" (rw->lock)
> >  	: "r" (0x80000000)
> >  	: "memory");
> > @@ -153,9 +196,10 @@ static inline int arch_write_trylock(arch_rwlock_t *rw)
> >  
> >  static inline void arch_write_unlock(arch_rwlock_t *rw)
> >  {
> > -	asm volatile(
> > -	"	stlr	%w1, %0\n"
> > -	: "=Q" (rw->lock) : "r" (0) : "memory");
> > +	asm volatile(ARM64_LSE_ATOMIC_INSN(
> > +	"	stlr	wzr, %0",
> > +	"	swpl	wzr, wzr, %0")
> > +	: "=Q" (rw->lock) :: "memory");
> 
> Is this any better than just STLR? We don't need the memory read.

Again, I'm trying to avoid explicit dirtying at L1.

Will
