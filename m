From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 00:44:27 +0900
Subject: [PATCH v3] ARM: EXYNOS4: Add platform device for dwmci driver.
In-Reply-To: <1311124933-8133-1-git-send-email-tgih.jun@samsung.com>
References: <1311124933-8133-1-git-send-email-tgih.jun@samsung.com>
Message-ID: <06c101cc46f3$eb5a4260$c20ec720$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwon Jeon wrote:
> 
> This patch adds platform device for Synopsys DesignWare Multimedia Card
> Interface driver.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig              |    5 ++
>  arch/arm/mach-exynos4/Makefile             |    1 +
>  arch/arm/mach-exynos4/dev-dwmci.c          |   82
> ++++++++++++++++++++++++++++
>  arch/arm/mach-exynos4/include/mach/dwmci.h |   20 +++++++
>  arch/arm/mach-exynos4/include/mach/irqs.h  |    1 +
>  arch/arm/mach-exynos4/include/mach/map.h   |    1 +
>  arch/arm/plat-samsung/include/plat/devs.h  |    1 +
>  7 files changed, 111 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/dev-dwmci.c
>  create mode 100644 arch/arm/mach-exynos4/include/mach/dwmci.h
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index a4fb109..31f798c 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -36,6 +36,11 @@ config EXYNOS4_DEV_SYSMMU
>  	help
>  	  Common setup code for SYSTEM MMU in EXYNOS4
> 
> +config EXYNOS4_DEV_DWMCI
> +	bool
> +	help
> +	  Compile in platform device definitions for DWMCI
> +
>  config EXYNOS4_SETUP_I2C1
>  	bool
>  	help
> diff --git a/arch/arm/mach-exynos4/Makefile
b/arch/arm/mach-exynos4/Makefile
> index c3c70ab..4c4ea6b 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -38,6 +38,7 @@ obj-y					+= dev-
> audio.o
>  obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
>  obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
>  obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
> +obj-$(CONFIG_EXYNOS4_DEV_DWMCI)	+= dev-dwmci.o
> 
>  obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
>  obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
> diff --git a/arch/arm/mach-exynos4/dev-dwmci.c
b/arch/arm/mach-exynos4/dev-
> dwmci.c
> new file mode 100644
> index 0000000..b025db4
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/dev-dwmci.c
> @@ -0,0 +1,82 @@
> +/*
> + * linux/arch/arm/mach-exynos4/dev-dwmci.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Platform device for Synopsys DesignWare Mobile Storage IP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mmc/dw_mmc.h>
> +
> +#include <plat/devs.h>
> +
> +#include <mach/map.h>
> +
> +static int exynos4_dwmci_get_bus_wd(u32 slot_id)
> +{
> +	return 4;
> +}
> +
> +static int exynos4_dwmci_init(u32 slot_id, irq_handler_t handler, void
*data)
> +{
> +	return 0;
> +}
> +
> +static struct resource exynos4_dwmci_resource[] = {
> +	[0] = {
> +		.start	= EXYNOS4_PA_DWMCI,
> +		.end	= EXYNOS4_PA_DWMCI + SZ_4K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= IRQ_DWMCI,
> +		.end	= IRQ_DWMCI,
> +		.flags	= IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct dw_mci_board exynos4_dwci_pdata = {
> +	.num_slots			= 1,
> +	.quirks				=
> DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> +	.bus_hz				= 80 * 1000 * 1000,
> +	.detect_delay_ms	= 200,
> +	.init				= exynos4_dwmci_init,
> +	.get_bus_wd			= exynos4_dwmci_get_bus_wd,
> +};
> +
> +static u64 exynos4_dwmci_dmamask = DMA_BIT_MASK(32);
> +
> +struct platform_device exynos4_device_dwmci = {
> +	.name		= "dw_mmc",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(exynos4_dwmci_resource),
> +	.resource	= exynos4_dwmci_resource,
> +	.dev		= {
> +		.dma_mask		= &exynos4_dwmci_dmamask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data	= &exynos4_dwci_pdata,
> +	},
> +};
> +
> +void __init exynos4_dwmci_set_platdata(struct dw_mci_board *pd)
> +{
> +	struct dw_mci_board *npd;
> +
> +	npd = s3c_set_platdata(pd, sizeof(struct dw_mci_board),
> +			&exynos4_device_dwmci);
> +
> +	if (!npd->init)
> +		npd->init = exynos4_dwmci_init;
> +	if (!npd->get_bus_wd)
> +		npd->get_bus_wd = exynos4_dwmci_get_bus_wd;
> +}
> diff --git a/arch/arm/mach-exynos4/include/mach/dwmci.h b/arch/arm/mach-
> exynos4/include/mach/dwmci.h
> new file mode 100644
> index 0000000..7ce6574
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/include/mach/dwmci.h
> @@ -0,0 +1,20 @@
> +/* linux/arch/arm/mach-exynos4/include/mach/dwmci.h
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Synopsys DesignWare Mobile Storage for EXYNOS4210
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_ARCH_DWMCI_H
> +#define __ASM_ARM_ARCH_DWMCI_H __FILE__
> +
> +#include <linux/mmc/dw_mmc.h>
> +
> +extern void exynos4_dwmci_set_platdata(struct dw_mci_board *pd);
> +
> +#endif /* __ASM_ARM_ARCH_DWMCI_H */
> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-
> exynos4/include/mach/irqs.h
> index 250427f..47ff87f 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -78,6 +78,7 @@
>  #define IRQ_HSMMC1		IRQ_SPI(74)
>  #define IRQ_HSMMC2		IRQ_SPI(75)
>  #define IRQ_HSMMC3		IRQ_SPI(76)
> +#define IRQ_DWMCI		IRQ_SPI(77)
> 
>  #define IRQ_MIPICSI0		IRQ_SPI(78)
> 
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-
> exynos4/include/mach/map.h
> index 3677356..49356d2 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -96,6 +96,7 @@
>  #define EXYNOS4_PA_MIPI_CSIS1		0x11890000
> 
>  #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
> +#define EXYNOS4_PA_DWMCI		0x12550000
> 
>  #define EXYNOS4_PA_SATA			0x12560000
>  #define EXYNOS4_PA_SATAPHY		0x125D0000
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index e3b31c2..29fa1cf 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -112,6 +112,7 @@ extern struct platform_device exynos4_device_i2s2;
>  extern struct platform_device exynos4_device_spdif;
>  extern struct platform_device exynos4_device_pd[];
>  extern struct platform_device exynos4_device_ahci;
> +extern struct platform_device exynos4_device_dwmci;
> 
>  extern struct platform_device s5p6440_device_pcm;
>  extern struct platform_device s5p6440_device_iis;
> --
> 1.7.2.3

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
