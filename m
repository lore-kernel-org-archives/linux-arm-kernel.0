From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 13 Jul 2011 17:20:17 +0900
Subject: [PATCH] ARM: EXYNOS4: Add platform device for dwmci driver.
In-Reply-To: <1310541479-32252-1-git-send-email-tgih.jun@samsung.com>
References: <1310541479-32252-1-git-send-email-tgih.jun@samsung.com>
Message-ID: <CAH9JG2VpLBACx2Ym3G65=oAPqUtJO3CXbXsuQGJTmKaqML8ANw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 4:17 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This patch add platform devices for Synopsys DesignWare Multimedia Card
> Interface driver.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Kconfig ? ? ? ? ? ? | ? ?5 ++
> ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-exynos4/dev-dwmci.c ? ? ? ? | ? 86 +++++++++++++++++++++++++++++
> ?arch/arm/mach-exynos4/include/mach/irqs.h | ? ?1 +
> ?arch/arm/mach-exynos4/include/mach/map.h ?| ? ?1 +
> ?arch/arm/plat-samsung/include/plat/devs.h | ? ?1 +
> ?6 files changed, 95 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-exynos4/dev-dwmci.c
>
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index 5115b90..c82674a 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -35,6 +35,11 @@ config EXYNOS4_DEV_SYSMMU
> ? ? ? ?help
> ? ? ? ? ?Common setup code for SYSTEM MMU in EXYNOS4
>
> +config EXYNOS4_DEV_DWMCI
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? Compile in platform device definitions for DWMCI
> +
> ?config EXYNOS4_SETUP_I2C1
> ? ? ? ?bool
> ? ? ? ?help
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
> index 60fe5ec..eeeaada 100644
> --- a/arch/arm/mach-exynos4/Makefile
> +++ b/arch/arm/mach-exynos4/Makefile
> @@ -43,6 +43,7 @@ obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? += dev-audio.o
> ?obj-$(CONFIG_EXYNOS4_DEV_AHCI) ? ? ? ? += dev-ahci.o
> ?obj-$(CONFIG_EXYNOS4_DEV_PD) ? ? ? ? ? += dev-pd.o
> ?obj-$(CONFIG_EXYNOS4_DEV_SYSMMU) ? ? ? += dev-sysmmu.o
> +obj-$(CONFIG_EXYNOS4_DEV_DWMCI) ? ? ? ?+= dev-dwmci.o
>
> ?obj-$(CONFIG_EXYNOS4_SETUP_FIMC) ? ? ? += setup-fimc.o
> ?obj-$(CONFIG_EXYNOS4_SETUP_I2C1) ? ? ? += setup-i2c1.o
> diff --git a/arch/arm/mach-exynos4/dev-dwmci.c b/arch/arm/mach-exynos4/dev-dwmci.c
> new file mode 100644
> index 0000000..6b69707
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/dev-dwmci.c
> @@ -0,0 +1,86 @@
> +/*
> + * linuxarch/arm/mach-exynos4/dev-dwmci.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
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
> +#include <linux/mmc/host.h>
> +#include <linux/io.h>
> +
> +#include <mach/map.h>
> +#include <mach/gpio.h>
> +
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +#include <plat/gpio-cfg.h>
> +
> +static int exynos4_dwmci_init(u32 slot_id, irq_handler_t handler, void *data);
> +static int exynos4_dwmci_get_ocr(u32 slot_id);
> +static int exynos4_dwmci_get_bus_wd(u32 slot_id);
No need to declare it at here.
Just put the exynos4_dwci_pdata at last.
> +
> +static struct resource exynos4_dwmci_resource[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start = EXYNOS4_PA_DWMCI,
> + ? ? ? ? ? ? ? .end ? = EXYNOS4_PA_DWMCI + SZ_4K - 1,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start = IRQ_DWMCI,
> + ? ? ? ? ? ? ? .end ? = IRQ_DWMCI,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> + ? ? ? }
> +};
> +
> +static struct dw_mci_board exynos4_dwci_pdata = {
> + ? ? ? .num_slots ? ? ? ? ? ? ? ? ? ? ?= 1,
> + ? ? ? .quirks ? ? ? ? ? ? ? ? ? ? ? ? = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> + ? ? ? .bus_hz ? ? ? ? ? ? ? ? ? ? ? ? = 80*1000*1000,
Does it correct value?
> + ? ? ? .detect_delay_ms ? ? ? ?= 200,
> + ? ? ? .init ? ? ? ? ? ? ? ? ? ? ? ? ? = exynos4_dwmci_init,
> + ? ? ? .get_ocr ? ? ? ? ? ? ? ? ? ? ? ?= exynos4_dwmci_get_ocr,
> + ? ? ? .get_bus_wd ? ? ? ? ? ? ? ? ? ? = exynos4_dwmci_get_bus_wd,
> + ? ? ? .select_slot ? ? ? ? ? ?= NULL,
> +};
> +
> +static u64 exynos4_dwmci_dmamask = DMA_BIT_MASK(32);
> +
> +struct platform_device exynos4_device_dwmci = {
> + ? ? ? .name ? ? ? ? ? = "dw_mmc",
> + ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? .num_resources ?= ARRAY_SIZE(exynos4_dwmci_resource),
> + ? ? ? .resource ? ? ? = exynos4_dwmci_resource,
> + ? ? ? .dev ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .dma_mask ? ? ? ? ? ? ? = &exynos4_dwmci_dmamask,
> + ? ? ? ? ? ? ? .coherent_dma_mask ? ? ?= DMA_BIT_MASK(32),
> + ? ? ? ? ? ? ? .platform_data ?= &exynos4_dwci_pdata,
> + ? ? ? },
> +};
> +
> +static int exynos4_dwmci_get_ocr(u32 slot_id)
> +{
> + ? ? ? return MMC_VDD_32_33 | MMC_VDD_33_34;
> +}
> +
> +static int exynos4_dwmci_get_bus_wd(u32 slot_id)
> +{
> + ? ? ? return 4;
It's platform dependent value. Please give also platform helper
function to setup at each platform.
> +}
> +
> +static int exynos4_dwmci_init(u32 slot_id, irq_handler_t handler, void *data)
> +{
> + ? ? ? return 0;
> +}
> +
> diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
> index 5d03730..b720246 100644
> --- a/arch/arm/mach-exynos4/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos4/include/mach/irqs.h
> @@ -107,6 +107,7 @@
> ?#define IRQ_HSMMC1 ? ? ? ? ? ? COMBINER_IRQ(29, 1)
> ?#define IRQ_HSMMC2 ? ? ? ? ? ? COMBINER_IRQ(29, 2)
> ?#define IRQ_HSMMC3 ? ? ? ? ? ? COMBINER_IRQ(29, 3)
> +#define IRQ_DWMCI ? ? ? ? ? ? ?COMBINER_IRQ(29, 4)
>
> ?#define IRQ_MIPI_CSIS0 ? ? ? ? COMBINER_IRQ(30, 0)
> ?#define IRQ_MIPI_CSIS1 ? ? ? ? COMBINER_IRQ(30, 1)
> diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
> index 0009e77..352e500 100644
> --- a/arch/arm/mach-exynos4/include/mach/map.h
> +++ b/arch/arm/mach-exynos4/include/mach/map.h
> @@ -94,6 +94,7 @@
> ?#define EXYNOS4_PA_MIPI_CSIS1 ? ? ? ? ?0x11890000
>
> ?#define EXYNOS4_PA_HSMMC(x) ? ? ? ? ? ?(0x12510000 + ((x) * 0x10000))
> +#define EXYNOS4_PA_DWMCI ? ? ? ? ? ? ? 0x12550000
>
> ?#define EXYNOS4_PA_SATA ? ? ? ? ? ? ? ? ? ? ? ?0x12560000
> ?#define EXYNOS4_PA_SATAPHY ? ? ? ? ? ? 0x125D0000
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
> index e3b31c2..29fa1cf 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -112,6 +112,7 @@ extern struct platform_device exynos4_device_i2s2;
> ?extern struct platform_device exynos4_device_spdif;
> ?extern struct platform_device exynos4_device_pd[];
> ?extern struct platform_device exynos4_device_ahci;
> +extern struct platform_device exynos4_device_dwmci;
>
> ?extern struct platform_device s5p6440_device_pcm;
> ?extern struct platform_device s5p6440_device_iis;
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
