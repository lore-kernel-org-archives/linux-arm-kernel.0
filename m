From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 26 Jul 2011 18:16:42 +0100
Subject: [PATCH 1/2] ARM: alignment: Make SIGBUS sent to userspace
	POSIXly correct
In-Reply-To: <20110726162905.GA4969@shutemov.name>
References: <1311689686-7451-1-git-send-email-dave.martin@linaro.org>
	<20110726162905.GA4969@shutemov.name>
Message-ID: <20110726171642.GA7639@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 07:29:05PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 26, 2011 at 03:14:46PM +0100, Dave Martin wrote:
> > With the UM_SIGNAL alignment fault mode, no siginfo structure is
> > passed to userspace.
> > 
> > POSIX specifies how siginfo_t should be populated for alignment
> > faults, so this patch does just that:
> > 
> >   * si_signo = SIGBUS
> >   * si_code = BUS_ADRALN
> >   * si_addr = address of the faulted instruction
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> >  arch/arm/mm/alignment.c |   14 +++++++++++---
> >  1 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c

[...]

> > @@ -883,9 +884,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)

[...]

> > +	if (ai_usermode & UM_SIGNAL) {
> > +		siginfo_t si;
> > +
> > +		si.si_signo = SIGBUS;
> > +		si.si_errno = 0;
> > +		si.si_code = BUS_ADRALN;
> > +		si.si_addr = (void __user *)instruction_pointer(regs);
> 
> This is wrong. You need something like:
> 
> si.si_addr = (void __user *)instruction_pointer(regs) -
> 	(thumb_mode(regs) ? 2 : 4);

I don't think so.  The appropriate adjustment is already made on
vector entry by the vector_stub macro in entry-armv.S:

	.macro	vector_stub, name, mode, correction=0
	.align	5

vector_\name:
	.if \correction
	sub	lr, lr, #\correction
	.endif


I'm pretty sure that instruction_pointer(regs) must already point to the
faulted instruction when we enter do_alignment(), because the first thing
this function does is:

	instrptr = instruction_pointer(regs);
	if (thumb_mode(regs)) {
		fault = __get_user(tinstr, (u16 *)(instrptr & ~1));
		/* ... */
	} else
		fault = __get_user(instr, (u32 *)instrptr);


When I test the code, my observations bear this out: the address returned
in si_addr does match the address of the faulting instruction.

Does that satisfy your concerns, or have I missed something?


It might make sense to set bit 1 of si_addr to match the Thumb-ness of
the faulting instruction though.  Currently I don't do that.

Cheers
---Dave
