From: geoff@infradead.org (Geoff Levand)
Date: Mon, 30 Nov 2015 12:03:30 -0800
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <56586679.8060403@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
Message-ID: <1448913810.31214.61.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, 2015-11-27 at 14:19 +0000, Marc Zyngier wrote:
> On 24/11/15 22:25, Geoff Levand wrote:
> > +#define SCTLR_ELx_I> > 	> > (1 << 12)
> > +#define SCTLR_ELx_SA> > 	> > (1 << 3)
> > +#define SCTLR_ELx_C> > 	> > (1 << 2)
> > +#define SCTLR_ELx_A> > 	> > (1 << 1)
> > +#define SCTLR_ELx_M> > 	> > 1
> 
> kvm_arm.h already has some of these defined, and sysreg.h has another
> bunch. Can you please consolidate this into a single place (probably
> sysreg.h)?

OK, I'll look into it.

> > +#define SCTLR_ELx_FLAGS> > 	> > (SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C |> > 	> > \
> > +> > 	> > 	> > 	> >  SCTLR_ELx_SA | SCTLR_ELx_I)
> > +
> > +.text
> > +.pushsection    .idmap.text, "ax"
> > +
> > +.align 5
> 
> Why is this .align directive required?

In the original proc.S file, this was to align the cpu_reset
routine.  It has been there since the initial commit of the
proc.S.  I don't think this alignment is needed, but maybe
there is some reason it is there that I am not aware of?

> > +
> > +/*
> > + * cpu_soft_restart(cpu_reset, el2_switch, entry, arg0, arg1) - Perform a cpu
> > + * soft reset.
> > + *
> > + * @cpu_reset: Physical address of the cpu_reset routine.
> > + * @el2_switch: Flag to indicate a swich to EL2 is needed, passed to cpu_reset.
> > + * @entry: Location to jump to for soft reset, passed to cpu_reset.
> > + * arg0: First argument passed to @entry.
> > + * arg1: Second argument passed to @entry.
> > + */
> > +
> > +ENTRY(cpu_soft_restart)
> > +> > 	> > mov> > 	> > x18, x0> > 	> > 	> > 	> > 	> > // cpu_reset
> > +> > 	> > mov> > 	> > x0, x1> > 	> > 	> > 	> > 	> > // el2_switch
> > +> > 	> > mov> > 	> > x1, x2> > 	> > 	> > 	> > 	> > // entry
> > +> > 	> > mov> > 	> > x2, x3> > 	> > 	> > 	> > 	> > // arg0
> > +> > 	> > mov> > 	> > x3, x4> > 	> > 	> > 	> > 	> > // arg1
> > +> > 	> > ret> > 	> > x18
> > +ENDPROC(cpu_soft_restart)
> 
> Grepping through the tree, I can only find a single use of
> cpu_soft_restart, with cpu_reset as its first parameter.
> 
> Why do we need this indirection? Having
> 
> void cpu_soft_restart(el2_switch, entry, arg0, arg1);
> 
> should be enough...

> > +/*
> > + * cpu_reset(el2_switch, entry, arg0, arg1) - Helper for cpu_soft_restart.
> > + *
> > + * @el2_switch: Flag to indicate a swich to EL2 is needed.
> > + * @entry: Location to jump to for soft reset.
> > + * arg0: First argument passed to @entry.
> > + * arg1: Second argument passed to @entry.
> > + *
> > + * Put the CPU into the same state as it would be if it had been reset, and
> > + * branch to what would be the reset vector. It must be executed with the
> > + * flat identity mapping.
> > + */
> > +
> > +ENTRY(cpu_reset)
> > +> > 	> > /* Clear sctlr_el1 flags. */
> > +> > 	> > mrs> > 	> > x12, sctlr_el1
> > +> > 	> > ldr> > 	> > x13, =SCTLR_ELx_FLAGS
> > +> > 	> > bic> > 	> > x12, x12, x13
> > +> > 	> > msr> > 	> > sctlr_el1, x12
> > +> > 	> > isb
> > +
> > +> > 	> > cbz> > 	> > x0, 1f> > 	> > 	> > 	> > 	> > // el2_switch?
> > +
> > +> > 	> > mov> > 	> > x0, x1> > 	> > 	> > 	> > 	> > // entry
> > +> > 	> > mov> > 	> > x1, x2> > 	> > 	> > 	> > 	> > // arg0
> > +> > 	> > mov> > 	> > x2, x3> > 	> > 	> > 	> > 	> > // arg1
> > +> > 	> > hvc> > 	> > #HVC_CALL_FUNC> > 	> > 	> > 	> > // no return
> > +
> > +1:> > 	> > mov> > 	> > x18, x1> > 	> > 	> > 	> > 	> > // entry
> > +> > 	> > mov> > 	> > x0, x2> > 	> > 	> > 	> > 	> > // arg0
> > +> > 	> > mov> > 	> > x1, x3> > 	> > 	> > 	> > 	> > // arg1
> > +> > 	> > ret> > 	> > x18
> > +ENDPROC(cpu_reset)
> 
> And this can be an actual part of cpu_soft_reset.

Sure, I'll look at your proposal from your reply to Pratyush.

> > +
> > +.popsection
> > diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> > new file mode 100644
> > index 0000000..79816b6
> > --- /dev/null
> > +++ b/arch/arm64/kernel/cpu-reset.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * cpu reset routines
> > + *
> > + * Copyright (C) 2015 Huawei Futurewei Technologies.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#if !defined(_ARM64_CPU_RESET_H)
> 
> The usual idiom is "#ifndef __BLAH_H".

Sure, I can change that.  Grepping the arm64 sources shows one other
use of this style, in a kvm header...

> > +#define _ARM64_CPU_RESET_H
> > +
> > +#include 
> > +
> > +void __attribute__((noreturn)) cpu_reset(unsigned long el2_switch,
> > +> > 	> > unsigned long entry, unsigned long arg0, unsigned long arg1);
> > +void __attribute__((noreturn)) cpu_soft_restart(phys_addr_t cpu_reset,
> > +> > 	> > unsigned long el2_switch, unsigned long entry, unsigned long arg0,
> > +> > 	> > unsigned long arg1);
> > +
> > +#endif
> > 
> 
> There is a __noreturn attribute already defined.

I'll switch these over.

Thanks for the review.

-Geoff
