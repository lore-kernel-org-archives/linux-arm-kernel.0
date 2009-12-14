From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 14 Dec 2009 16:22:42 +0530
Subject: [PATCH 3/4] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
In-Reply-To: <1260787034.17159.24.camel@pc1117.cambridge.arm.com>
References: <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
	<1260787034.17159.24.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC142138@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for comments Catalin !!
> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Monday, December 14, 2009 4:07 PM
> To: Shilimkar, Santosh
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux at arm.linux.org.uk; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/4] ARM: L2 : Errata 588369: Clean & Invalidate do notinvalidate clean lines
> 
> On Wed, 2009-12-09 at 18:43 +0000, Santosh Shilimkar wrote:
> > This patch implements the work-around for the errata 588369. The secure API
> > is used to alter L2 debug regsiter because of trust-zone.
> [...]
> > +config PL310_ERRATA_588369
> > +       bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
> > +       depends on CACHE_L2X0
> > +       default n
> > +       help
> > +          The PL310 L2 cache controller implements three types of Clean &
> > +          Invalidate maintenance operations: by Physical Address
> > +          (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
> > +          They are architecturally defined to behave as the execution of a
> > +          clean operation followed immediately by an invalidate operation,
> > +          both performing to the same memory location. This functionality
> > +          is not correctly implemented in PL310 as clean lines are not
> > +          invalidated as a result of these operations
> >  endmenu
> 
> Could you actually add a comment and a dependence on OMAP4 since this
> requires the secure monitor that only TI has.
OK

> > +#ifdef CONFIG_PL310_ERRATA_588369
> > +       /*
> > +        * Disable Write-Back and Cache Linefill (set bits [1:0] of the Debug
> > +        * Control Register)
> > +        */
> > +       __asm__ __volatile__(
> > +       "stmfd r13!, {r0-r12, r14}\n"
> > +       "mov r0, #3\n"
> > +       "ldr r12, =0x100\n"
> > +       "dsb\n"
> > +       "smc\n"
> > +       "ldmfd r13!, {r0-r12, r14}");
> 
> Could you actually add a function that gets called with a parameter
> rather than having to similar inline asm blocks? You also don't need to
> save/restore the registers if you declare them properly or use local
> variables for that, the compiler does the work for you.
A function call would be better as you suggested. We will look into this.
> Is a DSB needed before SMC (I'm not sure)?
That was a recommendation though not having it, I didn't observer any problems. 
> --
> Catalin
