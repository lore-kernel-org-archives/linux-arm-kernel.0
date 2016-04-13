From: oss@buserror.net (Scott Wood)
Date: Wed, 13 Apr 2016 00:41:47 -0500
Subject: [RFC PATCH 1/2] ARM/ARM64: arch_timer: Work around QorIQ
 Erratum A-008585
In-Reply-To: <570CBAC5.8070406@arm.com>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-2-git-send-email-oss@buserror.net>
 <570B73CF.6070502@arm.com> <1460440128.32510.106.camel@buserror.net>
 <570CBAC5.8070406@arm.com>
Message-ID: <1460526107.32510.138.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-12 at 10:07 +0100, Marc Zyngier wrote:
> On 12/04/16 06:48, Scott Wood wrote:
> > On Mon, 2016-04-11 at 10:52 +0100, Marc Zyngier wrote:
> > > Hi Scott,
> > > 
> > > On 11/04/16 03:22, Scott Wood wrote:
> > > > +static __always_inline
> > > > +u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
> > > > +{
> > > > +	if (arm_arch_timer_reread && reg == ARCH_TIMER_REG_TVAL)
> > > > +		return arch_timer_reg_tval_reread(access, reg);
> > > 
> > > I'm really not keen on this. Please implement this workaround as a
> > > static_key, and branch to the workaround in the slow path.
> > 
> > OK, I'll look into that.
> > 
> > > > -static inline u64 arch_counter_get_cntpct(void)
> > > > +static __always_inline u64 arch_counter_get_cnt(int opcode, bool
> > > > reread)
> > > 
> > > Why the __always_inline? The compiler should already do the right thing.
> > 
> > The "i" asm constraint requires that it be inline.  Maybe GCC is likely to
> > inline it anyway, but it's better to be explicit when it's required for
> > correctness.
> 
> Probably. But the underlying issue is that you are reinventing your own
> accessors instead of using the existing ones to implement your
> workaround. What is wrong with looping around the existing accessors?

The existing accessors don't guarantee that multiple accesses are done with
back-to-back instructions.  I don't know how far apart they can get without
risking a loop that doesn't finish, nor do I know what weirdness GCC might do,
now or in the future, to place nearby asm statements farther from each other
than expected.

> 
> > 
> > > > -	u64 cval;
> > > > +	u64 val, val_new;
> > > > +	int timeout = 200;
> > > >  
> > > >  	isb();
> > > > -	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
> > > > -	return cval;
> > > > +
> > > > +	if (reread) {
> > > > +		do {
> > > > +			asm volatile("mrrc p15, %2, %Q0, %R0, c14;"
> > > > +				     "mrrc p15, %2, %Q1, %R1, c14"
> > > > +				     : "=r" (val), "=r" (val_new)
> > > > +				     : "i" (opcode));
> > > > +			timeout--;
> > > > +		} while (val != val_new && timeout);
> > > > +
> > > > +		BUG_ON(!timeout);
> > > 
> > > BUG_ON()? Really? Is there any condition where you wouldn't be able to
> > > converge to a single value?
> > 
> > This function is used from the vdso, and thus WARN causes a link error.
> 
> And surely BUG_ON() is suitable for userspace. /me rolls eyes...

It's not ideal, but it will raise a signal which seems no worse than a hang,
and again, if there is a problem I expect you'd see it first in the kernel.

I'll have the erratum disable vdso on arm32 as well, and then this can be
WARN_ON_ONCE like the others.

> > > > +	/*
> > > > +	 * Erratum A-008585 requires back-to-back reads to be
> > > > identical
> > > > +	 * in order to avoid glitches.
> > > > +	 */
> > > > +	cmp	w17, #0
> > > > +	b.eq	2f
> > > > +1:	mrs	x15, cntvct_el0
> > > > +	mrs	x16, cntvct_el0
> > > > +	cmp	x16, x15
> > > > +	b.ne	1b
> > > > +2:
> > > 
> > > Could userspace lock-up here? If it can, you need to be able to bail
> > > out. If not, then your BUG_ON() sprinkling is bogus.
> > 
> > It *shouldn't* be possible for these loops to time out -- it would not be
> > a
> > viable workaround if it's not guaranteed to resolve quickly -- but if
> > there
> > are situations where the workaround fails (e.g. unusual clock speeds) it
> > would
> > be useful to get that diagnostic rather than have to hunt down a hang.  I
> > can
> > remove them if you want, though.
> 
> Warning once + tainting the kernel should be enough.

That's what the patches do, in codepaths that are capable of it.

> > > The elephant in the room is KVM. I'm pretty sure it suffers from the
> > > same erratum, yet you did not handle it at all. I'd expect to see
> > > something in an upcoming version of the patch.
> > 
> > cval isn't listed in the erratum description as being affected.  I looked
> > around a bit and couldn't find the KVM code directly accessing tval or
> > count. 
> >  Am I missing something?
> 
> You are missing the fact that CVAL and TVAL are the two sides of the
> same coin. From the ARMv8 ARM:
> 
> <quote>
> This view of a timer depends on the following behavior of accesses to
> TimerValue registers:
> 
> Reads: TimerValue = (CompareValue ? (Counter - Offset))[31:0]
> Writes: CompareValue = ((Counter - Offset)[63:0] +
> SignExtend(TimerValue))[63:0]
> </quote>

If the underlying representation is CompareValue, as the above suggests, then
it makes sense that only tval would be affected, since the underlying problem
is the counter.  The counter needs to be read in order to read or write tval. 
 cval accesses the underlying representation directly, and the bad SoC clock
logic doesn't have a chance to interfere.

> So I'd be really surprised if TVAL was buggy and CVAL was not (why would
> loop around programming TVAL if you could hit CVAL and be correct?).

Switching to cval would be great, if everyone's OK with it.  We'd still need
the loop on the counter.

-Scott
