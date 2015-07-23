From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Jul 2015 14:39:35 +0100
Subject: [PATCH 07/18] arm64: locks: patch in lse instructions when
 supported by the CPU
In-Reply-To: <20150721172918.GO31095@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-8-git-send-email-will.deacon@arm.com>
 <20150721165338.GE7250@e104818-lin.cambridge.arm.com>
 <20150721172918.GO31095@arm.com>
Message-ID: <20150723133935.GD445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 06:29:18PM +0100, Will Deacon wrote:
> On Tue, Jul 21, 2015 at 05:53:39PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 13, 2015 at 10:25:08AM +0100, Will Deacon wrote:
> > > @@ -125,11 +155,19 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
> > >  
> > >  	asm volatile(
> > >  	"	sevl\n"
> > > +	ARM64_LSE_ATOMIC_INSN(
> > > +	/* LL/SC */
> > >  	"1:	wfe\n"
> > >  	"2:	ldaxr	%w0, %1\n"
> > >  	"	cbnz	%w0, 1b\n"
> > >  	"	stxr	%w0, %w2, %1\n"
> > > -	"	cbnz	%w0, 2b\n"
> > > +	"	cbnz	%w0, 2b",
> > > +	/* LSE atomics */
> > > +	"1:	wfe\n"
> > > +	"	mov	%w0, wzr\n"
> > > +	"	casa	%w0, %w2, %1\n"
> > > +	"	nop\n"
> > > +	"	cbnz	%w0, 1b")
> > >  	: "=&r" (tmp), "+Q" (rw->lock)
> > >  	: "r" (0x80000000)
> > >  	: "memory");
> > 
> > With WFE in the LL/SC case, we rely on LDAXR to set the exclusive
> > monitor and an event would be generated every time it gets cleared. With
> > CAS, we no longer have this behaviour, so what guarantees a SEV?
> 
> My understanding was that failed CAS will set the exclusive monitor, but
> what I have for a spec doesn't actually comment on this behaviour. I'll
> go digging...

... and the winner is: not me! We do need an LDXR to set the exclusive
monitor and doing that without introducing races is slightly confusing.

Here's what I now have for write_lock (read_lock is actually pretty simple):

static inline void arch_write_lock(arch_rwlock_t *rw)
{
	unsigned int tmp;

	asm volatile(ARM64_LSE_ATOMIC_INSN(
	/* LL/SC */
	"	sevl\n"
	"1:	wfe\n"
	"2:	ldaxr	%w0, %1\n"
	"	cbnz	%w0, 1b\n"
	"	stxr	%w0, %w2, %1\n"
	"	cbnz	%w0, 2b\n"
	"	nop",
	/* LSE atomics */
	"1:	mov	%w0, wzr\n"
	"2:	casa	%w0, %w2, %1\n"
	"	cbz	%w0, 3f\n"
	"	ldxr	%w0, %1\n"
	"	cbz	%w0, 2b\n"
	"	wfe\n"
	"	b	1b\n"
	"3:")
	: "=&r" (tmp), "+Q" (rw->lock)
	: "r" (0x80000000)
	: "memory");
}

What do you reckon?

Will
