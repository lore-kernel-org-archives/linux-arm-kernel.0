From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Aug 2013 15:14:21 +0100
Subject: [PATCHv2 2/5] arm64: factor out spin-table boot method
In-Reply-To: <51EE9E79.6080005@ti.com>
References: <1374507454-4573-1-git-send-email-mark.rutland@arm.com>
 <1374507454-4573-3-git-send-email-mark.rutland@arm.com>
 <51EE9E79.6080005@ti.com>
Message-ID: <20130802141421.GQ2884@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 04:17:13PM +0100, Santosh Shilimkar wrote:
> On Monday 22 July 2013 11:37 AM, Mark Rutland wrote:
> > The arm64 kernel has an internal holding pen, which is necessary for
> > some systems where we can't bring CPUs online individually and must hold
> > multiple CPUs in a safe area until the kernel is able to handle them.
> > The current SMP infrastructure for arm64 is closely coupled to this
> > holding pen, and alternative boot methods must launch CPUs into the pen,
> > from whence they are launched into the kernel proper.
> >
> s/whence/where

Will fix up.

>  
> > With PSCI (and possibly other future boot methods), we can bring CPUs
> > online individually, and need not perform the secondary_holding_pen
> > dance. Instead, this patch factors the holding pen management code out
> > to the spin-table boot method code, as it is the only boot method
> > requiring the pen.
> > 
> > A new entry point for secondaries, secondary_entry is added for other
> > boot methods to use, which bypasses the holding pen and its associated
> > overhead when bringing CPUs online. The smp.pen.text section is also
> > removed, as the pen can live in head.text without problem.
> > 
> > The smp_operations structure is extended with two new functions,
> > cpu_boot and cpu_postboot, for bringing a cpu into the kernel and
> > performing any post-boot cleanup required by a bootmethod (e.g.
> > resetting the secondary_holding_pen_release to INVALID_HWID).
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/include/asm/smp.h       | 17 ++++++++-
> >  arch/arm64/kernel/head.S           | 12 +++++-
> >  arch/arm64/kernel/smp.c            | 67 +++-------------------------------
> >  arch/arm64/kernel/smp_psci.c       | 16 ++++----
> >  arch/arm64/kernel/smp_spin_table.c | 75 ++++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/vmlinux.lds.S    |  1 -
> >  6 files changed, 115 insertions(+), 73 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> > index 90626b6..af39644 100644
> > --- a/arch/arm64/include/asm/smp.h
> > +++ b/arch/arm64/include/asm/smp.h
> > @@ -60,8 +60,7 @@ struct secondary_data {
> >  	void *stack;
> >  };
> >  extern struct secondary_data secondary_data;
> > -extern void secondary_holding_pen(void);
> > -extern volatile unsigned long secondary_holding_pen_release;
> > +extern void secondary_entry(void);
> >  
> >  extern void arch_send_call_function_single_ipi(int cpu);
> >  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
> > @@ -70,8 +69,22 @@ struct device_node;
> >  
> >  struct smp_operations {
> >  	const char	*name;
> > +	/*
> > +	 * Check devicetree data for cpu
> > +	 */
> All these comments can go above the struct as mentioned
> in kerneldoc.

Ok, I'll take a look at the kerneldoc documentation.

> 
> >  	int		(*cpu_init)(struct device_node *, unsigned int);
> > +	/*
> > +	 * Test if cpu is present and bootable
> > +	 */
> >  	int		(*cpu_prepare)(unsigned int);
> > +	/*
> > +	 * Boot cpu into the kernel
> > +	 */
> > +	int		(*cpu_boot)(unsigned int);
> > +	/*
> > +	 * Performs post-boot cleanup
> > +	 */
> > +	void		(*cpu_postboot)(void);
> >  };
> >  
> >  extern const struct smp_operations smp_spin_table_ops;
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 53dcae4..3532ca6 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -217,7 +217,6 @@ ENTRY(__boot_cpu_mode)
> >  	.quad	PAGE_OFFSET
> >  
> >  #ifdef CONFIG_SMP
> > -	.pushsection    .smp.pen.text, "ax"
> >  	.align	3
> >  1:	.quad	.
> >  	.quad	secondary_holding_pen_release
> > @@ -242,7 +241,16 @@ pen:	ldr	x4, [x3]
> >  	wfe
> >  	b	pen
> >  ENDPROC(secondary_holding_pen)
> > -	.popsection
> > +
> > +	/*
> > +	 * Secondary entry point that jumps straight into the kernel. Only to
> > +	 * be used where CPUs are brought online dynamically by the kernel.
> > +	 */
> > +ENTRY(secondary_entry)
> > +	bl	__calc_phys_offset		// x2=phys offset
> > +	bl	el2_setup			// Drop to EL1
> > +	b	secondary_startup
> > +ENDPROC(secondary_entry)
> >  
> >  ENTRY(secondary_startup)
> >  	/*
> Other than that, rest of the patch looks fine too me.

Great!

Thanks,
Mark.
