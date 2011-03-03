From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 11:53:52 +0100
Subject: [PATCH 1/2] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <20110303091558.GA22211@b20223-02.ap.freescale.net>
References: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
	<20110303085033.GN22310@pengutronix.de>
	<20110303091558.GA22211@b20223-02.ap.freescale.net>
Message-ID: <20110303105352.GA18351@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 05:15:59PM +0800, Richard Zhao wrote:
> Hi Uwe,
> 
> On Thu, Mar 03, 2011 at 09:50:33AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Mar 03, 2011 at 04:40:02PM +0800, Richard Zhao wrote:
> > > Move to SOC_SOC_IMX5X. Leave only places which prevent multi-soc
> > > using ARCH_MX5X.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Looks OK, probably you need to split off the changes that touch files in
> > drivers/ though.
> Yes. Will Sashca merge drivers part too, or someone else?

I think I can take them as they are.

Sascha

> > 
> > (Hmm, no diffstat?)
> ah, removing "-p".
> 
> Thanks
> Richard
> > 
> > Best regards
> > Uwe
> > 
> > > diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> > > index 03ec6e9..83ee088 100644
> > > --- a/arch/arm/mach-mx5/Kconfig
> > > +++ b/arch/arm/mach-mx5/Kconfig
> > > @@ -1,5 +1,6 @@
> > >  if ARCH_MX5
> > > -# ARCH_MX51 and ARCH_MX50 are left for compatibility
> > > +# ARCH_MX50/51/53 are left to mark places where prevent multi-soc in single
> > > +# image. So for most time, SOC_IMX50/51/53 should be used.
> > >  
> > >  config ARCH_MX50
> > >  	bool
> > > diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > > index 33530d2..be7df13 100644
> > > --- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > > +++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
> > > @@ -194,7 +194,7 @@ static int __init imxXX_add_imx_dma(void)
> > >  	} else
> > >  #endif
> > >  
> > > -#if defined(CONFIG_ARCH_MX51)
> > > +#if defined(CONFIG_SOC_IMX51)
> > >  	if (cpu_is_mx51()) {
> > >  		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51_to1;
> > >  		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
> > > diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
> > > index ba65c92..a3d930d 100644
> > > --- a/arch/arm/plat-mxc/include/mach/irqs.h
> > > +++ b/arch/arm/plat-mxc/include/mach/irqs.h
> > > @@ -23,17 +23,17 @@
> > >  #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
> > >  
> > >  /* these are ordered by size to support multi-SoC kernels */
> > > -#if defined CONFIG_ARCH_MX53
> > > +#if defined CONFIG_SOC_IMX53
> > >  #define MXC_GPIO_IRQS		(32 * 7)
> > >  #elif defined CONFIG_ARCH_MX2
> > >  #define MXC_GPIO_IRQS		(32 * 6)
> > > -#elif defined CONFIG_ARCH_MX50
> > > +#elif defined CONFIG_SOC_IMX50
> > >  #define MXC_GPIO_IRQS		(32 * 6)
> > >  #elif defined CONFIG_ARCH_MX1
> > >  #define MXC_GPIO_IRQS		(32 * 4)
> > >  #elif defined CONFIG_ARCH_MX25
> > >  #define MXC_GPIO_IRQS		(32 * 4)
> > > -#elif defined CONFIG_ARCH_MX51
> > > +#elif defined CONFIG_SOC_IMX51
> > >  #define MXC_GPIO_IRQS		(32 * 4)
> > >  #elif defined CONFIG_ARCH_MXC91231
> > >  #define MXC_GPIO_IRQS		(32 * 4)
> > > diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> > > index 04c7a26..3781f2f 100644
> > > --- a/arch/arm/plat-mxc/include/mach/mxc.h
> > > +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> > > @@ -127,7 +127,7 @@ extern unsigned int __mxc_cpu_type;
> > >  # define cpu_is_mx35()		(0)
> > >  #endif
> > >  
> > > -#ifdef CONFIG_ARCH_MX50
> > > +#ifdef CONFIG_SOC_IMX50
> > >  # ifdef mxc_cpu_type
> > >  #  undef mxc_cpu_type
> > >  #  define mxc_cpu_type __mxc_cpu_type
> > > @@ -139,7 +139,7 @@ extern unsigned int __mxc_cpu_type;
> > >  # define cpu_is_mx50()		(0)
> > >  #endif
> > >  
> > > -#ifdef CONFIG_ARCH_MX51
> > > +#ifdef CONFIG_SOC_IMX51
> > >  # ifdef mxc_cpu_type
> > >  #  undef mxc_cpu_type
> > >  #  define mxc_cpu_type __mxc_cpu_type
> > > @@ -151,7 +151,7 @@ extern unsigned int __mxc_cpu_type;
> > >  # define cpu_is_mx51()		(0)
> > >  #endif
> > >  
> > > -#ifdef CONFIG_ARCH_MX53
> > > +#ifdef CONFIG_SOC_IMX53
> > >  # ifdef mxc_cpu_type
> > >  #  undef mxc_cpu_type
> > >  #  define mxc_cpu_type __mxc_cpu_type
> > > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > > index c895922..450afc5 100644
> > > --- a/drivers/mtd/nand/Kconfig
> > > +++ b/drivers/mtd/nand/Kconfig
> > > @@ -476,7 +476,7 @@ config MTD_NAND_MPC5121_NFC
> > >  
> > >  config MTD_NAND_MXC
> > >  	tristate "MXC NAND support"
> > > -	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3 || ARCH_MX51
> > > +	depends on IMX_HAVE_PLATFORM_MXC_NAND
> > >  	help
> > >  	  This enables the driver for the NAND flash controller on the
> > >  	  MXC processors.
> > > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > > index bb233a9..9f9d3f7 100644
> > > --- a/drivers/spi/Kconfig
> > > +++ b/drivers/spi/Kconfig
> > > @@ -164,10 +164,10 @@ config SPI_IMX_VER_0_4
> > >  	def_bool y if ARCH_MX31
> > >  
> > >  config SPI_IMX_VER_0_7
> > > -	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
> > > +	def_bool y if ARCH_MX25 || ARCH_MX35 || SOC_IMX51 || SOC_IMX53
> > >  
> > >  config SPI_IMX_VER_2_3
> > > -	def_bool y if ARCH_MX51 || ARCH_MX53
> > > +	def_bool y if SOC_IMX51 || SOC_IMX53
> > >  
> > >  config SPI_IMX
> > >  	tristate "Freescale i.MX SPI controllers"
> > > -- 
> > > 1.7.1
> > > 
> > > 
> > > 
> > 
> > -- 
> > Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
