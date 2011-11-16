From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 16:28:17 +0000
Subject: [PATCH 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111116154230.GD2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-5-git-send-email-pawel.moll@arm.com>
 <20111116154230.GD2073@localhost.localdomain>
Message-ID: <1321460897.3137.364.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 15:42 +0000, Dave Martin wrote:
> > +config ARCH_VEXPRESS_LEGACY
> Brief comment explaining what this is?
> > +config ARCH_VEXPRESS_RS1
> Ditto

Ok.

> > +	bool
> > +
> >  config ARCH_VEXPRESS_CA9X4
> >  	bool "Versatile Express Cortex-A9x4 tile"
> >  	select CPU_V7
> > @@ -8,6 +16,7 @@ config ARCH_VEXPRESS_CA9X4
> >  	select ARM_ERRATA_720789
> >  	select ARM_ERRATA_751472
> >  	select ARM_ERRATA_753970
> > +	select ARCH_VEXPRESS_LEGACY
> 
> We should add a brief note to the help text explaining the existence
> of the new combined A9x4/A5x2 DT based support, if were planning to
> keep both variants.  (Probably wise for now, since people may be
> temporarily stuck old bootloaders etc.)
> 
> If there is no help text yet, we should add some, but it should be
> kept brief.

No probs. All suggestions and "templates" welcomed :-)

> 
> [...]
> 
> > diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > index fd9e6c7..adc94ce 100644
> > --- a/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-vexpress/include/mach/debug-macro.S
> > @@ -10,12 +10,41 @@
> >   * published by the Free Software Foundation.
> >   */
> >  
> > -#define DEBUG_LL_UART_OFFSET	0x00009000
> > +#define VEXPRESS_PHYS_BASE_LEGACY	0x10000000
> > +#define VEXPRESS_UART_OFFSET_LEGACY	0x00009000
> > +
> > +#define VEXPRESS_PHYS_BASE_RS1		0x1c000000
> > +#define VEXPRESS_UART_OFFSET_RS1	0x00090000
> > +
> > +#define VEXPRESS_VIRT_BASE		0xf8000000
> >  
> >  		.macro	addruart,rp,rv,tmp
> > -		mov	\rp, #DEBUG_LL_UART_OFFSET
> > -		orr	\rv, \rp, #0xf8000000	@ virtual base
> > -		orr	\rp, \rp, #0x10000000	@ physical base
> > +
> > +		@ Check the MMU state
> > +#if defined(CONFIG_MMU)
> > +		mrc	p15, 0, \tmp, c1, c0	@ SCTRL
> > +		tst	\tmp, #1		@ MMU enabled?
> > +		moveq	\tmp, #VEXPRESS_PHYS_BASE_LEGACY
> > +		movne	\tmp, #VEXPRESS_VIRT_BASE
> > +#else
> > +		mov	\tmp, #VEXPRESS_PHYS_BASE_LEGACY
> > +#endif
> > +
> > +		@ PL011 present in "legacy place"?
> > +		orr	\tmp, \tmp, #VEXPRESS_UART_OFFSET_LEGACY
> > +		ldr	\tmp, [\tmp, #0xfe0]	@ PeriphID0
> > +		teq	\tmp, #0x11		@ PL011
> > +
> > +		@ Legacy memory map
> > +		moveq	\rp, #VEXPRESS_UART_OFFSET_LEGACY
> > +		orreq	\rv, \rp, #VEXPRESS_VIRT_BASE
> > +		orreq	\rp, \rp, #VEXPRESS_PHYS_BASE_LEGACY
> > +
> > +		@ RS1 memory map
> > +		movne	\rp, #VEXPRESS_UART_OFFSET_RS1
> > +		orrne	\rv, \rp, #VEXPRESS_VIRT_BASE
> > +		orrne	\rp, \rp, #VEXPRESS_PHYS_BASE_RS1
> 
> I will assume that this works :)

It does, tested :-) The probing order "legacy-then-RS1" is carefully
selected - it doesn't work the other way round.

> Without grokking the detail, it looks fairly reasonable.

I was considering something similar to
"arch/arm/mach-omap2/include/mach/debug-macro.S", but it made the code
even more obscure.

> [...]
> 
> > diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> 
> [...]
> 
> >  void __init v2m_dt_init_early(void)
> > @@ -601,6 +643,10 @@ static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> >  	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> >  			&v2m_flash_data),
> >  	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> > +	/* RS1 memory map */
> > +	OF_DEV_AUXDATA("arm,vexpress-flash", 0x08000000, "physmap-flash",
> > +			&v2m_flash_data),
> > +	OF_DEV_AUXDATA("arm,primecell", 0x1c050000, "mb:mmci", &v2m_mmci_data),
> 
> Can we have macros instead of the magic numbers here?

I don't see any point:
1. These value are used only and only here, so #defining them would just
add extra lines of traffic.
2. They correspond to numbers (as in: numbers) in DTS.
3. They will disappear once I'm done with MMCI and sysreg bindings. So
probably long before this series is actually merged...

Cheers!

Pawe?
