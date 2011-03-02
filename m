From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 3 Mar 2011 00:06:05 +0800
Subject: [RFC PATCH 1/1] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <20110302112559.GC22310@pengutronix.de>
References: <1299036526-15674-1-git-send-email-richard.zhao@freescale.com>
	<20110302112559.GC22310@pengutronix.de>
Message-ID: <20110302160605.GA2994@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for your detailed explanation!
On Wed, Mar 02, 2011 at 12:25:59PM +0100, Uwe Kleine-K?nig wrote:
> Hello Richard,
> 
> On Wed, Mar 02, 2011 at 11:28:46AM +0800, Richard Zhao wrote:
> > Remove legacy support of ARCH_MX5X. Move to SOC_SOC_IMX5X.
> > 
> > My understanding is ARCH_MX5 selects Kconfig in arch/arm/mach-mx5,
> > and every board can be selected/unselected, and SOC_XXX be selected
> > by the board config. MACH_XXXX/SOC_XXXX then select those HAVE_XXXX.
> My intended goal with these ARCH_MX.., MACH_MX.. and SOC_IMX.. symbols is:
> 
>  - ARCH_MX.. should be only a helper to group all machines together that
>    can be built in a single image. In the far future it hopefully dies
>    because we can compile everything together. These IMHO should not be
>    used in Makefiles or source files at all as the grouping can change
>    over time. I'm not sure the name ARCH_MX.. is that good. Didn't think
>    about a better naming scheme, so if you have suggestions don't
>    hesitate to tell them.
Would it make sense to go straight forward? 
ARCH_MX.. for SoC series. eg. ARCH_MX1/2/3/5. It groups SoCs.
SOC_IMX.. for single SoC. eg. SOC_IMX31/35/50/51/53. It groups Machines.
MACH_.. for single machine. eg. MACH_MX51_BABBAGE.

They can be used in Makefiles to help include source files, but idealy not be
used in source files. For multi-soc in single image, it's more easy to select
build targets. It can also help transit to single image step by step.

>  - MACH_MX.. actually are misnomers becauce they clash with the name
>    space of the machine db. So they should be substituted by SOC_IMX...
>    (maybe a few by ARCH_MX..)  (affected: MACH_MX21 and MACH_MX27)
>  - SOC_IMX.. are used to differentiate between SoCs.
> 
> So a goal is to review all ARCH_MX.. and MACH_MX.. used in .c and .h
> files and try to use the SOC_IMX variables instead.
> Here I consider important that SOC_IMX... is really only used with
> having multi-SoC-kernels in mind. So you can consider ARCH_MX and
> MACH_MX as todo-markers for that (and this is the main difference IMHO).
> E.g. the Makefile.boots are such a place that are not multi-soc capable
> yet as is the selection of PHYS_OFFSET. I'd like to keep them marked
> somehow.
The ToDO markers might label itself as markers, Or it cause many people
confused.
And are you sure we won't need ARCH_MX.. in the final single image solution?
IMHO, single image needs to select what targetis it builds for too. The ARCH_MX..
works as categories and help reduce image size. 
> 
> I don't know if it's sensible to coordinate this effort, it mainly
> depends on how many people are willing to help. I'll start with ARCH_MX2
> and MACH_MX2[17] next.
> 
> A bit orthogonal to this issue is to clean up mach-mx3 and mach-mx5 to
> allow them to be merged into mach-imx. I didn't look at all on mxc91231,
> yet.
> 
> Comments and patches are welcome. If you want to help and don't know
> where to start, here are a few hints:
> 
>  - git grep -E 'M?AR?CH_MX' drivers
>  - convert arch/arm/mach-mx[35]/devices.c to dynamically allocation
> 
> Richard, having said that, some of your changes look OK, while I'm not
> completely happy with the others.
It seems only PHYS_OFFSET are not ok? Maybe the p2v patch can help?
> 
> > diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> > index f065a0d..518a39e 100644
> > --- a/arch/arm/mach-mx5/Kconfig
> > +++ b/arch/arm/mach-mx5/Kconfig
> > @@ -1,14 +1,4 @@
> >  if ARCH_MX5
> > -# ARCH_MX51 and ARCH_MX50 are left for compatibility
> > -
> > -config ARCH_MX50
> > -	bool
> > -
> > -config ARCH_MX51
> > -	bool
> > -
> > -config ARCH_MX53
> > -	bool
> these are still needed, see below (or you should suggest an alternative marking).
> 
> >  config SOC_IMX50
> >  	bool
> > @@ -16,7 +6,6 @@ config SOC_IMX50
> >  	select ARCH_MXC_IOMUX_V3
> >  	select ARCH_MXC_AUDMUX_V2
> >  	select ARCH_HAS_CPUFREQ
> > -	select ARCH_MX50
> >  
> >  config	SOC_IMX51
> >  	bool
> > @@ -24,13 +13,11 @@ config	SOC_IMX51
> >  	select ARCH_MXC_IOMUX_V3
> >  	select ARCH_MXC_AUDMUX_V2
> >  	select ARCH_HAS_CPUFREQ
> > -	select ARCH_MX51
> >  
> >  config	SOC_IMX53
> >  	bool
> >  	select MXC_TZIC
> >  	select ARCH_MXC_IOMUX_V3
> > -	select ARCH_MX53
> >  
> >  comment "MX5 platforms:"
> >  
> > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > index e928be1..cdc70b3 100644
> > --- a/arch/arm/mach-mx5/Makefile.boot
> > +++ b/arch/arm/mach-mx5/Makefile.boot
> > @@ -1,9 +1,9 @@
> > -   zreladdr-$(CONFIG_ARCH_MX50)	:= 0x70008000
> > -params_phys-$(CONFIG_ARCH_MX50)	:= 0x70000100
> > -initrd_phys-$(CONFIG_ARCH_MX50)	:= 0x70800000
> > -   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
> > -params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
> > -initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
> > -   zreladdr-$(CONFIG_ARCH_MX53)	:= 0x70008000
> > -params_phys-$(CONFIG_ARCH_MX53)	:= 0x70000100
> > -initrd_phys-$(CONFIG_ARCH_MX53)	:= 0x70800000
> > +   zreladdr-$(CONFIG_SOC_MX50)	:= 0x70008000
> > +params_phys-$(CONFIG_SOC_MX50)	:= 0x70000100
> > +initrd_phys-$(CONFIG_SOC_MX50)	:= 0x70800000
> > +   zreladdr-$(CONFIG_SOC_MX51)	:= 0x90008000
> > +params_phys-$(CONFIG_SOC_MX51)	:= 0x90000100
> > +initrd_phys-$(CONFIG_SOC_MX51)	:= 0x90800000
> > +   zreladdr-$(CONFIG_SOC_MX53)	:= 0x70008000
> > +params_phys-$(CONFIG_SOC_MX53)	:= 0x70000100
> > +initrd_phys-$(CONFIG_SOC_MX53)	:= 0x70800000
> > diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > index 33530d2..be7df13 100644
> > --- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > +++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > @@ -194,7 +194,7 @@ static int __init imxXX_add_imx_dma(void)
> >  	} else
> >  #endif
> >  
> > -#if defined(CONFIG_ARCH_MX51)
> > +#if defined(CONFIG_SOC_IMX51)
> >  	if (cpu_is_mx51()) {
> >  		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51_to1;
> >  		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
> looks OK.
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > index ba65c92..a3d930d 100644
> > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > @@ -23,17 +23,17 @@
> >  #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
> >  
> >  /* these are ordered by size to support multi-SoC kernels */
> > -#if defined CONFIG_ARCH_MX53
> > +#if defined CONFIG_SOC_IMX53
> >  #define MXC_GPIO_IRQS		(32 * 7)
> >  #elif defined CONFIG_ARCH_MX2
> >  #define MXC_GPIO_IRQS		(32 * 6)
> > -#elif defined CONFIG_ARCH_MX50
> > +#elif defined CONFIG_SOC_IMX50
> >  #define MXC_GPIO_IRQS		(32 * 6)
> >  #elif defined CONFIG_ARCH_MX1
> >  #define MXC_GPIO_IRQS		(32 * 4)
> >  #elif defined CONFIG_ARCH_MX25
> >  #define MXC_GPIO_IRQS		(32 * 4)
> > -#elif defined CONFIG_ARCH_MX51
> > +#elif defined CONFIG_SOC_IMX51
> >  #define MXC_GPIO_IRQS		(32 * 4)
> >  #elif defined CONFIG_ARCH_MXC91231
> >  #define MXC_GPIO_IRQS		(32 * 4)
> OK
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
> > index 8386140..f1e9c0a 100644
> > --- a/arch/arm/plat-mxc/include/mach/memory.h
> > +++ b/arch/arm/plat-mxc/include/mach/memory.h
> > @@ -34,11 +34,11 @@
> >  #  define PHYS_OFFSET		MX3x_PHYS_OFFSET
> >  # elif defined CONFIG_ARCH_MXC91231
> >  #  define PHYS_OFFSET		MXC91231_PHYS_OFFSET
> > -# elif defined CONFIG_ARCH_MX50
> > +# elif defined CONFIG_SOC_IMX50
> >  #  define PHYS_OFFSET		MX50_PHYS_OFFSET
> > -# elif defined CONFIG_ARCH_MX51
> > +# elif defined CONFIG_SOC_IMX51
> >  #  define PHYS_OFFSET		MX51_PHYS_OFFSET
> > -# elif defined CONFIG_ARCH_MX53
> > +# elif defined CONFIG_SOC_IMX53
> >  #  define PHYS_OFFSET		MX53_PHYS_OFFSET
> >  # endif
> >  #endif
> not ok
> 
> > diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> > index 04c7a26..3781f2f 100644
> > --- a/arch/arm/plat-mxc/include/mach/mxc.h
> > +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> > @@ -127,7 +127,7 @@ extern unsigned int __mxc_cpu_type;
> >  # define cpu_is_mx35()		(0)
> >  #endif
> >  
> > -#ifdef CONFIG_ARCH_MX50
> > +#ifdef CONFIG_SOC_IMX50
> >  # ifdef mxc_cpu_type
> >  #  undef mxc_cpu_type
> >  #  define mxc_cpu_type __mxc_cpu_type
> > @@ -139,7 +139,7 @@ extern unsigned int __mxc_cpu_type;
> >  # define cpu_is_mx50()		(0)
> >  #endif
> >  
> > -#ifdef CONFIG_ARCH_MX51
> > +#ifdef CONFIG_SOC_IMX51
> >  # ifdef mxc_cpu_type
> >  #  undef mxc_cpu_type
> >  #  define mxc_cpu_type __mxc_cpu_type
> > @@ -151,7 +151,7 @@ extern unsigned int __mxc_cpu_type;
> >  # define cpu_is_mx51()		(0)
> >  #endif
> >  
> > -#ifdef CONFIG_ARCH_MX53
> > +#ifdef CONFIG_SOC_IMX53
> >  # ifdef mxc_cpu_type
> >  #  undef mxc_cpu_type
> >  #  define mxc_cpu_type __mxc_cpu_type
> These are OK, too, I think
> 
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > index c895922..daeafc2 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -476,7 +476,7 @@ config MTD_NAND_MPC5121_NFC
> >  
> >  config MTD_NAND_MXC
> >  	tristate "MXC NAND support"
> > -	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3 || ARCH_MX51
> > +	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3 || SOC_IMX51
> OK, though I'd prefer having
> 
> 	depends on HAVE_MTD_NAND_MXC
> 
> and let the SOC_IMXYZ symbols select this one.
Yes. Thanks.
> 
> >  	help
> >  	  This enables the driver for the NAND flash controller on the
> >  	  MXC processors.
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index bb233a9..9f9d3f7 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -164,10 +164,10 @@ config SPI_IMX_VER_0_4
> >  	def_bool y if ARCH_MX31
> >  
> >  config SPI_IMX_VER_0_7
> > -	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
> > +	def_bool y if ARCH_MX25 || ARCH_MX35 || SOC_IMX51 || SOC_IMX53
> >  
> >  config SPI_IMX_VER_2_3
> > -	def_bool y if ARCH_MX51 || ARCH_MX53
> > +	def_bool y if SOC_IMX51 || SOC_IMX53
> >  
> >  config SPI_IMX
> >  	tristate "Freescale i.MX SPI controllers"
> ok
> 
Thanks
Richard
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
