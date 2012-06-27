From: pavel@denx.de (Pavel Machek)
Date: Wed, 27 Jun 2012 23:06:00 +0200
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <20120627162548.01adc769@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-3-git-send-email-dinguyen@altera.com>
 <20120627162548.01adc769@skate>
Message-ID: <20120627210600.GB26023@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +CONFIG_CMDLINE="console=ttyS0,57600 mem=256M at 0x0"
> 
> Why do you need to specify the memory map here, since it's already
> passed in the device tree?

Probably old leftover, will check. 

> > +#define SOCFPGA_GIC_CPU_BASE	(SOCFPGA_MPUSCU_BASE + 0x100)
> > +#define SOCFPGA_TWD_BASE		(SOCFPGA_MPUSCU_BASE + 0x600)
> > +#define SOCFPGA_GIC_DIST_BASE	(SOCFPGA_MPUSCU_BASE + 0x1000)
> > +
> > +/* System Manager */
> > +#define SOCFPGA_SMP_FLAG		(SOCFPGA_SYSMGR_BASE + 0x10)
> > +#define SOCFPGA_SYSMGR_SDMMCGRP_CTR	(SOCFPGA_SYSMGR_BASE + 0x108)
> > +
> > +/* Clock Manager */
> > +#define SOCFPGA_CLKMGR_PERPLLGRP_EN	(SOCFPGA_CLKMGR_BASE + 0xA0)
> 
> Just like the IRQ numbers, those defines for I/O registers are no
> longer needed with the device tree.

Yep. It shows we have more DT-ization to do.

arch/arm/mach-socfpga/include/mach/uncompress.h needs UART0
base... but device tree is not easily accessible at that point, right?


> > +	}, {
> > +		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
> > +		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
> > +		.length		= SZ_4K,
> > +		.type		= MT_DEVICE,
> > +	},
> > +};
> 
> Most of those static mappings should instead be turned into dynamic
> mappings created with ioremap(), at least for the timers.

Dynamic mappings so that we can use device tree -- not constants?

> > +static const char *altera_dt_match[] = {
> > +	"altr,socfpga-cyclone5",
> > +	NULL
> > +};
> > +
> > +MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
> > +	.atag_offset    = 0x100,
> > +	.fixup		= socfpga_fixup,
> > +	.map_io		= cyclone5_map_io,
> > +	.init_early	= socfpga_init_early,
> > +	.init_irq	= gic_init_irq,
> > +	.handle_irq     = gic_handle_irq,
> > +	.timer		= &socfpga_cyclone5_timer,
> > +	.init_machine	= socfpga_cyclone5_init,
> > +	.restart	= socfpga_cyclone5_restart,
> > +	.dt_compat	= altera_dt_match,
> > +MACHINE_END
> 
> You should use DT_MACHINE_START and not MACHINE_START, since new SoC
> should only use the Device Tree now. So the .atag_offset and .fixup
> should no longer be necessary.

Ok.


> > diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> > index 2997e56..c6ed4b1 100644
> > --- a/arch/arm/tools/mach-types
> > +++ b/arch/arm/tools/mach-types
> > @@ -1206,3 +1206,4 @@ baileys			MACH_BAILEYS		BAILEYS			4169
> >  familybox		MACH_FAMILYBOX		FAMILYBOX		4170
> >  ensemble_mx35		MACH_ENSEMBLE_MX35	ENSEMBLE_MX35		4171
> >  sc_sps_1		MACH_SC_SPS_1		SC_SPS_1		4172
> > +socfpga_cyclone5	MACH_SOCFPGA_CYCLONE5	SOCFPGA_CYCLONE5	4251
> 
> A machine ID is no longer needed with the Device Tree.


Thanks for great review,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
