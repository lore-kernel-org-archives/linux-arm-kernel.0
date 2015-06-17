From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jun 2015 12:35:18 +0100
Subject: [PATCH 09/10] arm64/BUG: Use BRK instruction for generic BUG traps
In-Reply-To: <20150616144810.GE30522@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <1434036566-9848-10-git-send-email-Dave.Martin@arm.com>
 <20150616144810.GE30522@arm.com>
Message-ID: <20150617113518.GE3651@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 03:48:10PM +0100, Will Deacon wrote:
> Hi Dave,
> 
> Just a few comments, inline.
> 
> On Thu, Jun 11, 2015 at 04:29:23PM +0100, Dave P Martin wrote:
> > Currently, the minimal default BUG() implementation from asm-
> > generic is used for arm64.
> > 
> > This patch uses the BRK software breakpoint instruction to generate
> > a trap instead, similarly to most other arches, with the generic
> > BUG code generating the dmesg boilerplate.
> > 
> > This allows bug metadata to be moved to a separate table and
> > reduces the amount of inline code at BUG and WARN sites.  This also
> > avoids clobbering any registers before they can be dumped.
> > 
> > To mitigate the size of the bug table further, this patch makes
> > use of the existing infrastructure for encoding addresses within
> > the bug table as 32-bit offsets instead of absolute pointers.
> > (Note that this limits the kernel size to 2GB.)
> > 
> > Traps are registered at arch_initcall time for aarch64, but BUG
> > has minimal real dependencies and it is desirable to be able to
> > generate bug splats as early as possible.  This patch redirects
> > all debug exceptions caused by BRK directly to bug_handler() until
> > the full debug exception support has been initialised.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/Kconfig           |    8 ++++++
> >  arch/arm64/include/asm/brk.h |    1 +
> >  arch/arm64/include/asm/bug.h |   64 ++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/traps.c    |   57 ++++++++++++++++++++++++++++++++++++-
> >  arch/arm64/mm/fault.c        |   12 ++++++--
> >  5 files changed, 139 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/bug.h

[...]

> > diff --git a/arch/arm64/include/asm/brk.h b/arch/arm64/include/asm/brk.h
> > index 99b8dfb..f4d5894 100644
> > --- a/arch/arm64/include/asm/brk.h
> > +++ b/arch/arm64/include/asm/brk.h
> > @@ -27,5 +27,6 @@
> >  #define FAULT_BRK_IMM			0x100
> >  #define KGDB_DYN_DBG_BRK_IMM		0x400
> >  #define KGDB_COMPILED_DBG_BRK_IMM	0x401
> > +#define BUG_BRK_IMM			0x7ff
> 
> Just curious, but how did you come up with this number?

There's a comment in debug-monitors.h that the "allowed values for
kgbd" (sic) are 0x400..0x7ff.

So 0x7ff seemed unlikely to clash with any other use, and well
out of the way of the values that kgbd currently uses.

It's debatable that the BUG value shouldn't be in the range at all.
However, BUG_BRK_IMM is a contract between the kernel and itself for
EL1 only, so it can be changed at any time in the future with minimal
impact.

What's your view?

[...]

> > diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
> > new file mode 100644
> > index 0000000..0429c7b
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/bug.h
> > @@ -0,0 +1,64 @@

[...]

> > +#ifndef _ARCH_ARM64_ASM_BUG_H
> > +#define _ARCH_ARM64_ASM_BUG_H
> 
> Please follow the standard header guard pattern we use for arm64 (__ASM_).

Hmmm, I would say I picked a bad example to copy from, but I can't see
another header matching what I have.

__ASM_ is certainly the most common.
There are also a few _ASM_ (mostly ACPI/EFI) and a few _ASM_ARM64.

I'll follow the crowd and change to __ASM_.

[...]

> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 1ef2940..5fdf776 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c

[...]

> > @@ -460,7 +464,58 @@ void __pgd_error(const char *file, int line, unsigned long val)
> >  	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
> >  }
> >  
> > +/* GENERIC_BUG traps */
> > +
> > +int is_valid_bugaddr(unsigned long addr)
> > +{
> > +	/*
> > +	 * bug_handler() only called for BUG #BUG_BRK_IMM.
> 
> s/BUG/BRK/ ?

Hmmm, yes.

> 
> > +	 * So the answer is trivial -- any spurious instances with no
> > +	 * bug table entry will be rejected by report_bug() and passed
> > +	 * back to the debug-monitors code and handled as a fatal
> > +	 * unexpected debug exception.
> > +	 */
> > +	return 1;
> > +}
> 
> Could we define is_valid_bugaddr as a macro in the header file and avoid
> the potential out-of-line call?

We could, but it would require a change to <linux/bug.h>.  Since
this is slowpath anyway, I wasn't sure it was worth it.

Happy to add that and try to push it as part of this series if
you like -- let me know.

> 
> > +
> > +static int bug_handler(struct pt_regs *regs, unsigned int esr)
> > +{
> > +	if (user_mode(regs))
> > +		return DBG_HOOK_ERROR;
> > +
> > +	switch (report_bug(regs->pc, regs)) {
> > +	case BUG_TRAP_TYPE_BUG:
> > +		die("Oops - BUG", regs, 0);
> > +		/* die() does not return */
> 
> Are you sure about that? A quick glance at the code didn't convince me...

Ouch.  That explains why attempting to continue a BUGged thread using
kgdb wasn't working too well...

I'll fix that the re-test this behaviour.

Thanks for the review.

Cheers
---Dave
