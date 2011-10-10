From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Oct 2011 18:33:25 +0900
Subject: [PATCH V2 1/2] ARM: EXYNOS4: Add SPI support
In-Reply-To: <1318234084-19960-2-git-send-email-padma.v@samsung.com>
References: <1318234084-19960-1-git-send-email-padma.v@samsung.com>
	<1318234084-19960-2-git-send-email-padma.v@samsung.com>
Message-ID: <038e01cc872f$a95a93c0$fc0fbb40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> Define SPI platform devices.
> Register SPI bus clock with clkdev using generic
> connection id.
> 

I can't see your second patch 'SPI: EXYNOS4: Enable the SPI driver for
EXYNOS4'. Probably you think it should be handled by spi side, Grant. Yes
right. But when you submit patch set is related to each subsystem such as
arch/arm/ and drivers/, please adding regarding maintainers on your patch
set. So they can know whether necessity of talking to each other is required
or not if there are dependencies. In this case, I need to know the progress
of driver/spi side.

> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig                    |    1 +
>  arch/arm/mach-exynos4/Makefile                   |    1 +
>  arch/arm/mach-exynos4/clock.c                    |   82 +++++---
>  arch/arm/mach-exynos4/dev-spi.c                  |  225
> ++++++++++++++++++++++
>  arch/arm/mach-exynos4/include/mach/irqs.h        |    3 +
>  arch/arm/mach-exynos4/include/mach/map.h         |    3 +
>  arch/arm/mach-exynos4/include/mach/spi-clocks.h  |   16 ++
>  arch/arm/plat-samsung/include/plat/devs.h        |    3 +
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 +
>  9 files changed, 305 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/dev-spi.c
>  create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index d0491c2..96b2511 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -154,6 +154,7 @@ config MACH_SMDKV310
>  	select EXYNOS4_SETUP_KEYPAD
>  	select EXYNOS4_SETUP_SDHCI
>  	select EXYNOS4_SETUP_USB_PHY
> +	select S3C64XX_DEV_SPI

Hmm...if possible, please keep the alphabetical ordering here and I wonder
S3C64XX_DEV_SPI is proper name......

>  	help
>  	  Machine support for Samsung SMDKV310
> 
> diff --git a/arch/arm/mach-exynos4/Makefile
b/arch/arm/mach-exynos4/Makefile
> index e19cd12..7376869 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-
> ahci.o
>  obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
>  obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
>  obj-$(CONFIG_EXYNOS4_DEV_DWMCI)	+= dev-dwmci.o
> +obj-$(CONFIG_S3C64XX_DEV_SPI)		+= dev-spi.o
> 
>  obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
>  obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index a25c818..2497176 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -1152,36 +1152,6 @@ static struct clksrc_clk clksrcs[] = {
>  		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4
},
>  	}, {
>  		.clk		= {
> -			.name		= "sclk_spi",
> -			.devname	= "s3c64xx-spi.0",
> -			.enable		= exynos4_clksrc_mask_peril1_ctrl,
> -			.ctrlbit	= (1 << 16),
> -		},
> -		.sources = &clkset_group,
> -		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size =
4 },
> -		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4
},
> -	}, {
> -		.clk		= {
> -			.name		= "sclk_spi",
> -			.devname	= "s3c64xx-spi.1",
> -			.enable		= exynos4_clksrc_mask_peril1_ctrl,
> -			.ctrlbit	= (1 << 20),
> -		},
> -		.sources = &clkset_group,
> -		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size =
4 },
> -		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size =
4 },
> -	}, {
> -		.clk		= {
> -			.name		= "sclk_spi",
> -			.devname	= "s3c64xx-spi.2",
> -			.enable		= exynos4_clksrc_mask_peril1_ctrl,
> -			.ctrlbit	= (1 << 24),
> -		},
> -		.sources = &clkset_group,
> -		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size =
4 },
> -		.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4
},
> -	}, {
> -		.clk		= {
>  			.name		= "sclk_fimg2d",
>  		},
>  		.sources = &clkset_mout_g2d,
> @@ -1242,6 +1212,53 @@ static struct clksrc_clk clksrcs[] = {
>  	}
>  };
> 
> +static struct clksrc_clk sclk_spi0 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.0",
> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit	= (1 << 16),
> +	},
> +	.sources = &clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
> +};
> +
> +static struct clksrc_clk sclk_spi1 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.1",
> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit	= (1 << 20),
> +	},
> +	.sources = &clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
> +};
> +static struct clksrc_clk sclk_spi2 = {
> +	.clk		= {
> +		.name		= "sclk_spi",
> +		.devname	= "s3c64xx-spi.2",
> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit	= (1 << 24),
> +	},
> +	.sources = &clkset_group,
> +	.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
> +	.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
> +};
> +
> +static struct clk_lookup clk_lookup_table[] = {
> +	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &sclk_spi0.clk),
> +	CLKDEV_INIT("s3c64xx-spi.1", "spi_busclk0", &sclk_spi1.clk),
> +	CLKDEV_INIT("s3c64xx-spi.2", "spi_busclk0", &sclk_spi2.clk),

Yes, as you said, firstly your CLKDEV_INIT patch is needed before this. So I
need to think this can be sent to upstream in this time or next time even
though this patch is good.

> +};
> +
> +static struct clksrc_clk *clksrc_cdev[] = {
> +	&sclk_spi0,
> +	&sclk_spi1,
> +	&sclk_spi2,
> +};
> +
>  /* Clock initialization code */
>  static struct clksrc_clk *sysclks[] = {
>  	&clk_mout_apll,
> @@ -1480,6 +1497,9 @@ void __init exynos4_register_clocks(void)
>  	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
>  		s3c_register_clksrc(sysclks[ptr], 1);
> 
> +	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
> +		s3c_register_clksrc(clksrc_cdev[ptr], 1);
> +
>  	for (ptr = 0; ptr < ARRAY_SIZE(sclk_tv); ptr++)
>  		s3c_register_clksrc(sclk_tv[ptr], 1);
> 
> @@ -1493,4 +1513,6 @@ void __init exynos4_register_clocks(void)
>  	s3c24xx_register_clock(&dummy_apb_pclk);
> 
>  	s3c_pwmclk_init();
> +
> +	clkdev_add_table(clk_lookup_table, ARRAY_SIZE(clk_lookup_table));
>  }
> diff --git a/arch/arm/mach-exynos4/dev-spi.c
b/arch/arm/mach-exynos4/dev-spi.c
> new file mode 100644
> index 0000000..0c9704d
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/dev-spi.c
> @@ -0,0 +1,225 @@
> +/* linux/arch/arm/mach-exynos4/dev-spi.c
> + *
> + * Copyright (C) 2011 Samsung Electronics Co. Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
> +
> +#include <mach/dma.h>
> +#include <mach/map.h>
> +#include <mach/irqs.h>
> +#include <mach/spi-clocks.h>
> +
> +#include <plat/s3c64xx-spi.h>
> +#include <plat/gpio-cfg.h>
> +
> +/* SPI Controller platform_devices */
> +
> +/* Since we emulate multi-cs capability, we do not touch the CS.

According to coding style(multi-line comments) ......

/*
 * foo
 * foo
 */

So,

+/*
+ * Since we emulate multi-cs capability, we do not touch the CS.


> + * The emulated CS is toggled by board specific mechanism, as it can
> + * be either some immediate GPIO or some signal out of some other
> + * chip in between ... or some yet another way.
> + * We simply do not assume anything about CS.
> + */
> +static int exynos4_spi_cfg_gpio(struct platform_device *pdev)
> +{
> +	switch (pdev->id) {
> +	case 0:
> +		s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
> +				      S3C_GPIO_SFN(2),
> S3C_GPIO_PULL_UP);
> +		break;
> +
> +	case 1:
> +		s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
> +				      S3C_GPIO_SFN(2),
> S3C_GPIO_PULL_UP);
> +		break;
> +
> +	case 2:
> +		s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
> +		s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
> +				      S3C_GPIO_SFN(5),
> S3C_GPIO_PULL_UP);
> +		break;
> +
> +	default:
> +		dev_err(&pdev->dev, "Invalid SPI Controller number!");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct resource exynos4_spi0_resource[] = {
> +	[0] = {
> +		.start	= EXYNOS4_PA_SPI0,
> +		.end	= EXYNOS4_PA_SPI0 + 0x100 - 1,

Please use SZ_256 instead of 0x100.

> +		.flags	= IORESOURCE_MEM,
> +	},

DEFINE_RES_MEM(...)

> +	[1] = {
> +		.start	= DMACH_SPI0_TX,
> +		.end	= DMACH_SPI0_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},

DEFINE_RES_DMA(...)

> +	[2] = {
> +		.start	= DMACH_SPI0_RX,
> +		.end	= DMACH_SPI0_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},

Same as above.

> +	[3] = {
> +		.start	= IRQ_SPI0,
> +		.end	= IRQ_SPI0,
> +		.flags	= IORESOURCE_IRQ,
> +	},

DEFINE_RES_IRQ(...)

> +};
> +
> +static struct s3c64xx_spi_info exynos4_spi0_pdata = {
> +	.cfg_gpio	= exynos4_spi_cfg_gpio,
> +	.fifo_lvl_mask	= 0x1ff,
> +	.rx_lvl_offset	= 15,
> +	.high_speed	= 1,
> +	.clk_from_cmu	= true,
> +	.tx_st_done	= 25,

I don't think we need all exynos4_spi0_pdata, exynos4_spi1_pdata and
exynos4_spi2_pdata because only its fifo_lvl_mask is different with each
other. As you know it can be added when it is initialized.

> +};
> +
> +static u64 spi_dmamask = DMA_BIT_MASK(32);
> +
> +struct platform_device exynos4_device_spi0 = {
> +	.name		= "s3c64xx-spi",
> +	.id		= 0,
> +	.num_resources	= ARRAY_SIZE(exynos4_spi0_resource),
> +	.resource	= exynos4_spi0_resource,
> +	.dev = {
> +		.dma_mask		= &spi_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data		= &exynos4_spi0_pdata,
> +	},
> +};
> +
> +static struct resource exynos4_spi1_resource[] = {
> +	[0] = {
> +		.start	= EXYNOS4_PA_SPI1,
> +		.end	= EXYNOS4_PA_SPI1 + 0x100 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= DMACH_SPI1_TX,
> +		.end	= DMACH_SPI1_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[2] = {
> +		.start	= DMACH_SPI1_RX,
> +		.end	= DMACH_SPI1_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[3] = {
> +		.start	= IRQ_SPI1,
> +		.end	= IRQ_SPI1,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct s3c64xx_spi_info exynos4_spi1_pdata = {
> +	.cfg_gpio	= exynos4_spi_cfg_gpio,
> +	.fifo_lvl_mask	= 0x7f,
> +	.rx_lvl_offset	= 15,
> +	.high_speed	= 1,
> +	.clk_from_cmu	= true,
> +	.tx_st_done	= 25,
> +};
> +
> +struct platform_device exynos4_device_spi1 = {
> +	.name		= "s3c64xx-spi",
> +	.id		= 1,
> +	.num_resources	= ARRAY_SIZE(exynos4_spi1_resource),
> +	.resource	= exynos4_spi1_resource,
> +	.dev = {
> +		.dma_mask		= &spi_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data		= &exynos4_spi1_pdata,
> +	},
> +};
> +
> +static struct resource exynos4_spi2_resource[] = {
> +	[0] = {
> +		.start	= EXYNOS4_PA_SPI2,
> +		.end	= EXYNOS4_PA_SPI2 + 0x100 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= DMACH_SPI2_TX,
> +		.end	= DMACH_SPI2_TX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[2] = {
> +		.start	= DMACH_SPI2_RX,
> +		.end	= DMACH_SPI2_RX,
> +		.flags	= IORESOURCE_DMA,
> +	},
> +	[3] = {
> +		.start	= IRQ_SPI2,
> +		.end	= IRQ_SPI2,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct s3c64xx_spi_info exynos4_spi2_pdata = {
> +	.cfg_gpio	= exynos4_spi_cfg_gpio,
> +	.fifo_lvl_mask	= 0x7f,
> +	.rx_lvl_offset	= 15,
> +	.high_speed	= 1,
> +	.clk_from_cmu	= true,
> +	.tx_st_done	= 25,
> +};
> +
> +struct platform_device exynos4_device_spi2 = {
> +	.name		= "s3c64xx-spi",
> +	.id		= 2,
> +	.num_resources	= ARRAY_SIZE(exynos4_spi2_resource),
> +	.resource	= exynos4_spi2_resource,
> +	.dev = {
> +		.dma_mask		= &spi_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data		= &exynos4_spi2_pdata,
> +	},
> +};
> +
> +void __init exynos4_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
> +{
> +	struct s3c64xx_spi_info *pd;
> +
> +	/* Reject invalid configuration */
> +	if (!num_cs || src_clk_nr < 0
> +			|| src_clk_nr > EXYNOS4_SPI_SRCCLK_SCLK) {
> +		printk(KERN_ERR "%s: Invalid SPI configuration\n",
__func__);
> +		return;
> +	}
> +
> +	switch (cntrlr) {
> +	case 0:
> +		pd = &exynos4_spi0_pdata;
> +		break;
> +	case 1:
> +		pd = &exynos4_spi1_pdata;
> +		break;
> +	case 2:
> +		pd = &exynos4_spi2_pdata;
> +		break;
> +	default:
> +		printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
> +							__func__, cntrlr);
> +		return;
> +	}
> +
> +	pd->num_cs = num_cs;
> +	pd->src_clk_nr = src_clk_nr;
> +}

I think you can consolidate dev-spi.c in mach-s3c64xx directory. How about
to move them into plat-samsung/devs.c?

Please refer to next/topic-plat-samsung-devs branch in my tree.

> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
> exynos4/include/mach/irqs.h
> index 62093b9..a9f0341 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -70,6 +70,9 @@
>  #define IRQ_IIC5		IRQ_SPI(63)
>  #define IRQ_IIC6		IRQ_SPI(64)
>  #define IRQ_IIC7		IRQ_SPI(65)
> +#define IRQ_SPI0		IRQ_SPI(66)
> +#define IRQ_SPI1		IRQ_SPI(67)
> +#define IRQ_SPI2		IRQ_SPI(68)
> 
>  #define IRQ_USB_HOST		IRQ_SPI(70)
>  #define IRQ_USB_HSOTG		IRQ_SPI(71)
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-
> exynos4/include/mach/map.h
> index 1bea7d1..8dd509e 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -88,6 +88,9 @@
>  #define EXYNOS4_PA_SYSMMU_TV		0x12E20000
>  #define EXYNOS4_PA_SYSMMU_MFC_L		0x13620000
>  #define EXYNOS4_PA_SYSMMU_MFC_R		0x13630000
> +#define EXYNOS4_PA_SPI0			0x13920000
> +#define EXYNOS4_PA_SPI1			0x13930000
> +#define EXYNOS4_PA_SPI2			0x13940000
> 
>  #define EXYNOS4_PA_GPIO1		0x11400000
>  #define EXYNOS4_PA_GPIO2		0x11000000
> diff --git a/arch/arm/mach-exynos4/include/mach/spi-clocks.h
b/arch/arm/mach-
> exynos4/include/mach/spi-clocks.h
> new file mode 100644
> index 0000000..576efdf
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/include/mach/spi-clocks.h
> @@ -0,0 +1,16 @@
> +/* linux/arch/arm/mach-exynos4/include/mach/spi-clocks.h
> + *
> + * Copyright (C) 2011 Samsung Electronics Co. Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARCH_SPI_CLKS_H
> +#define __ASM_ARCH_SPI_CLKS_H __FILE__
> +
> +/* Must source from SCLK_SPI */
> +#define EXYNOS4_SPI_SRCCLK_SCLK		0
> +
> +#endif /* __ASM_ARCH_SPI_CLKS_H */
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index ee5014a..7949131 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -84,6 +84,9 @@ extern struct platform_device s5pv210_device_spi0;
>  extern struct platform_device s5pv210_device_spi1;
>  extern struct platform_device s5p64x0_device_spi0;
>  extern struct platform_device s5p64x0_device_spi1;
> +extern struct platform_device exynos4_device_spi0;
> +extern struct platform_device exynos4_device_spi1;
> +extern struct platform_device exynos4_device_spi2;
> 
>  extern struct platform_device s3c_device_hwmon;
> 
> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
b/arch/arm/plat-
> samsung/include/plat/s3c64xx-spi.h
> index c3d82a5..1ec1ea3 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> @@ -69,5 +69,6 @@ extern void s3c64xx_spi_set_info(int cntrlr, int
src_clk_nr, int
> num_cs);
>  extern void s5pc100_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
>  extern void s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
>  extern void s5p64x0_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
> +extern void exynos4_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
> 
>  #endif /* __S3C64XX_PLAT_SPI_H */
> --
> 1.7.4.4



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
