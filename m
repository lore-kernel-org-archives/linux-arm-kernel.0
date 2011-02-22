From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 20:39:41 +0800
Subject: [PATCH v3 3/6] ARM: mxs: dynamically allocate mmc device
In-Reply-To: <20110222083113.GU22310@pengutronix.de>
References: <1298284979-14853-1-git-send-email-shawn.guo@freescale.com>
	<1298284979-14853-4-git-send-email-shawn.guo@freescale.com>
	<20110222083113.GU22310@pengutronix.de>
Message-ID: <20110222123940.GF19871@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 09:31:13AM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Feb 21, 2011 at 06:42:56PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/clock-mx23.c                  |   16 +++++
> >  arch/arm/mach-mxs/clock-mx28.c                  |   18 +++++
> >  arch/arm/mach-mxs/devices-mx23.h                |    4 +
> >  arch/arm/mach-mxs/devices-mx28.h                |    4 +
> >  arch/arm/mach-mxs/devices/Kconfig               |    3 +
> >  arch/arm/mach-mxs/devices/Makefile              |    1 +
> >  arch/arm/mach-mxs/devices/platform-mmc.c        |   77 +++++++++++++++++++++++
> >  arch/arm/mach-mxs/include/mach/devices-common.h |   13 ++++
> >  8 files changed, 136 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/devices/platform-mmc.c
> > 
> > diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> > index c19b69a..a1ed5f4 100644
> > --- a/arch/arm/mach-mxs/clock-mx23.c
> > +++ b/arch/arm/mach-mxs/clock-mx23.c
> > @@ -445,6 +445,7 @@ static struct clk_lookup lookups[] = {
> >  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
> >  	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> >  	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
> > +	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
> >  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
> >  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
> >  	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> > @@ -515,6 +516,15 @@ static int clk_misc_init(void)
> >  	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
> >  			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU_SET);
> >  
> > +	/*
> > +	 * 480 MHz seems too high to be ssp clock source directly,
> > +	 * so set frac to get a 288 MHz ref_io.
> > +	 */
> > +	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
> > +	reg &= ~BM_CLKCTRL_FRAC_IOFRAC;
> > +	reg |= 30 << BP_CLKCTRL_FRAC_IOFRAC;
> > +	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -522,6 +532,12 @@ int __init mx23_clocks_init(void)
> >  {
> >  	clk_misc_init();
> >  
> > +	/*
> > +	 * source ssp clock from ref_io than ref_xtal,
> > +	 * as ref_xtal only provides 24 MHz as maximum.
> > +	 */
> > +	clk_set_parent(&ssp_clk, &ref_io_clk);
> > +
> >  	clk_enable(&cpu_clk);
> >  	clk_enable(&hbus_clk);
> >  	clk_enable(&xbus_clk);
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index 9f4ee36..aeb7b2c 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -619,6 +619,8 @@ static struct clk_lookup lookups[] = {
> >  	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
> >  	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> >  	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
> > +	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
> > +	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
> >  	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
> >  	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
> >  	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
> > @@ -730,6 +732,15 @@ static int clk_misc_init(void)
> >  	reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
> >  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
> >  
> > +	/*
> > +	 * 480 MHz seems too high to be ssp clock source directly,
> > +	 * so set frac0 to get a 288 MHz ref_io0.
> > +	 */
> > +	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
> > +	reg &= ~BM_CLKCTRL_FRAC0_IO0FRAC;
> > +	reg |= 30 << BP_CLKCTRL_FRAC0_IO0FRAC;
> > +	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -737,6 +748,13 @@ int __init mx28_clocks_init(void)
> >  {
> >  	clk_misc_init();
> >  
> > +	/*
> > +	 * source ssp clock from ref_io0 than ref_xtal,
> > +	 * as ref_xtal only provides 24 MHz as maximum.
> > +	 */
> > +	clk_set_parent(&ssp0_clk, &ref_io0_clk);
> > +	clk_set_parent(&ssp1_clk, &ref_io0_clk);
> > +
> >  	clk_enable(&cpu_clk);
> >  	clk_enable(&hbus_clk);
> >  	clk_enable(&xbus_clk);
> > diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> > index 1256788..4419390 100644
> > --- a/arch/arm/mach-mxs/devices-mx23.h
> > +++ b/arch/arm/mach-mxs/devices-mx23.h
> > @@ -14,3 +14,7 @@
> >  extern const struct amba_device mx23_duart_device __initconst;
> >  #define mx23_add_duart() \
> >  	mxs_add_duart(&mx23_duart_device)
> > +
> > +extern const struct mxs_mmc_data mx23_mmc_data[] __initconst;
> > +#define mx23_add_mmc(id, pdata) \
> > +	mxs_add_mmc(&mx23_mmc_data[id], pdata)
> mxs_mmc please (not sure about mxs_mxs_mmc_data, but it would be
> consistent).  At least mx23_add_mxs_mmc and mxs_add_mxs_mmc.
> 
> > diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> > index 3b18304..540639d 100644
> > --- a/arch/arm/mach-mxs/devices-mx28.h
> > +++ b/arch/arm/mach-mxs/devices-mx28.h
> > @@ -32,3 +32,7 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
> >  	mxs_add_flexcan(&mx28_flexcan_data[id], pdata)
> >  #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
> >  #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
> > +
> > +extern const struct mxs_mmc_data mx28_mmc_data[] __initconst;
> > +#define mx28_add_mmc(id, pdata) \
> > +	mxs_add_mmc(&mx28_mmc_data[id], pdata)
> This conflicts with my series, but it's trivial enough to let Sascha
> handle that.
> 
> > diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> > index 6c65b67..49307f8 100644
> > --- a/arch/arm/mach-mxs/devices/Kconfig
> > +++ b/arch/arm/mach-mxs/devices/Kconfig
> > @@ -11,3 +11,6 @@ config MXS_HAVE_PLATFORM_FEC
> >  config MXS_HAVE_PLATFORM_FLEXCAN
> >  	select HAVE_CAN_FLEXCAN if CAN
> >  	bool
> > +
> > +config MXS_HAVE_PLATFORM_MMC
> > +	bool
> ditto MXS_HAVE_PLATFORM_MXS_MMC
> 
> > diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> > index ca7acc4..c0dacfd 100644
> > --- a/arch/arm/mach-mxs/devices/Makefile
> > +++ b/arch/arm/mach-mxs/devices/Makefile
> > @@ -3,3 +3,4 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
> >  obj-y += platform-dma.o
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
> >  obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> > +obj-$(CONFIG_MXS_HAVE_PLATFORM_MMC) += platform-mmc.o
> > diff --git a/arch/arm/mach-mxs/devices/platform-mmc.c b/arch/arm/mach-mxs/devices/platform-mmc.c
> > new file mode 100644
> > index 0000000..868def1
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/devices/platform-mmc.c
> > @@ -0,0 +1,77 @@
> > +/*
> > + * Copyright (C) 2010 Pengutronix
> > + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> > + *
> > + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it under
> > + * the terms of the GNU General Public License version 2 as published by the
> > + * Free Software Foundation.
> > + */
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +
> > +#include <mach/mx23.h>
> > +#include <mach/mx28.h>
> > +#include <mach/devices-common.h>
> > +
> > +#define mxs_mmc_data_entry_single(soc, _id, hwid)			\
> > +	{								\
> > +		.id = _id,						\
> > +		.iobase = soc ## _SSP ## hwid ## _BASE_ADDR,		\
> > +		.dma = soc ## _DMA_SSP ## hwid,				\
> > +		.irq_err = soc ## _INT_SSP ## hwid ## _ERROR,		\
> > +		.irq_dma = soc ## _INT_SSP ## hwid ## _DMA,		\
> > +	}
> > +
> > +#define mxs_mmc_data_entry(soc, _id, hwid)				\
> > +	[_id] = mxs_mmc_data_entry_single(soc, _id, hwid)
> > +
> > +
> > +#ifdef CONFIG_SOC_IMX23
> > +const struct mxs_mmc_data mx23_mmc_data[] __initconst = {
> > +#define mx23_mmc_data_entry(_id, hwid)					\
> > +	mxs_mmc_data_entry(MX23, _id, hwid)
> > +	mx23_mmc_data_entry(0, 1),
> > +	mx23_mmc_data_entry(1, 2),
> > +};
> hmm, maybe let mxs-mmc.1 use MX23_SSP1_BASE_ADDR?
> BTW, Sascha pointed out that
> 
> 	mxs_mmc_data_entry(MX23, 0, 1),
> 	mxs_mmc_data_entry(MX23, 1, 2),
> 
> is easier than
> 
> 	#define mx23_mmc_data_entry(_id, hwid)					\
> 		mxs_mmc_data_entry(MX23, _id, hwid)
> 		mx23_mmc_data_entry(0, 1),
> 		mx23_mmc_data_entry(1, 2),
> 
This approach was used in mx23 auart device code which Sascha has
merged.

> though it has to repeat MX23.
> 
> > +#endif
> > +
> > +#ifdef CONFIG_SOC_IMX28
> > +const struct mxs_mmc_data mx28_mmc_data[] __initconst = {
> > +#define mx28_mmc_data_entry(_id)					\
> > +	mxs_mmc_data_entry(MX28, _id, _id)
> > +	mx28_mmc_data_entry(0),
> > +	mx28_mmc_data_entry(1),
> > +};
> > +#endif
> hmm, so i.MX28 starts at 0, i.MX23 at 1.  Well, that's how it is.
> 

-- 
Regards,
Shawn
