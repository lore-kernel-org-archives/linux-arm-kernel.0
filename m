From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 09 May 2011 14:36:35 +0100
Subject: [PATCH v5 02/19] ARM: LPAE: add ISBs around MMU enabling code
In-Reply-To: <20110509120509.GR27807@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
	<20110508214101.GO27807@n2100.arm.linux.org.uk>
	<1304936539.7658.31.camel@e102109-lin.cambridge.arm.com>
	<20110509103242.GQ27807@n2100.arm.linux.org.uk>
	<1304938794.7658.56.camel@e102109-lin.cambridge.arm.com>
	<20110509120509.GR27807@n2100.arm.linux.org.uk>
Message-ID: <1304948195.7658.66.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-09 at 13:05 +0100, Russell King - ARM Linux wrote:
> On Mon, May 09, 2011 at 11:59:54AM +0100, Catalin Marinas wrote:
> > On Mon, 2011-05-09 at 11:32 +0100, Russell King - ARM Linux wrote:
> > > On Mon, May 09, 2011 at 11:22:19AM +0100, Catalin Marinas wrote:
> > > > Alternatively an exception return would do as well (like movs pc, lr)
> > > > but I think we still add some code for setting up the SPSR.
> > >
> > > That gives us a way out of both of these without introducing any CPU
> > > specific code.  We can setup the SPSR before this block of code, and
> > > call it with two movs pc, reg instructions which will provide the
> > > necessary synchronization.
> >
> > We still need an ISB before enabling the MMU to make sure that the TTBR
> > changing is visible. We may run with the MMU enabled (in the identity
> > mapping) before the exception return but with random data in TTBR.
> 
>   Changes to CP15 registers and the memory order model
>   All changes to CP15 registers that appear in program order after any
>   explicit memory operations are guaranteed not to affect those memory
>   operations.
> 
>   Any change to CP15 registers is guaranteed to be visible to subsequent
>   instructions only after one of:
>   ? the execution of an ISB instruction
>   ? the taking of an exception
>   ? the return from an exception.
...
> So, my reading of this suggests that ISB and returning from an exception
> (iow, movs pc, reg) have the same properties.  So:
> 
>         mcr     p15, 0, r5, c3, c0, 0           @ load domain access register
>         mcr     p15, 0, r4, c2, c0, 0           @ load page table pointer
> -       b       __turn_mmu_on
> +       mrs     r4, cpsr                        @ copy cpsr to spsr
> +       msr     spsr, r4
> +       adr     r4, BSYM(__turn_mmu_on)
> +       movs    pc, r4                          @ synchronizing
> 
>         .align  5
> __turn_mmu_on:
>         mov     r0, r0
>         mcr     p15, 0, r0, c1, c0, 0           @ write control reg
>         mrc     p15, 0, r3, c0, c0, 0           @ read id reg
>         mov     r3, r3
>         mov     r3, r13
> -       mov     pc, r3
> +       movs    pc, r3                          @ synchronizing
> 
> should be sufficient - and has the advantage that it should work on
> existing CPUs.

With two exception returns it should work. Only that we need to use LR
so that it compiles fine on Thumb-2 (found a bug in my TTBR1 patch as
well with using r13 as general purpose register, I'll fix it).

-- 
Catalin
