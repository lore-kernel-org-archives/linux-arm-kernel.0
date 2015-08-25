From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 10:24:34 +0100
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <55DC3452.3070205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/08/15 20:04, Shenwei Wang wrote:
> IMX7D contains a new version of GPC IP block (GPCv2). It has two
> major functions: power management and wakeup source management.
> This patch adds a new irqchip driver to manage the interrupt wakeup
> sources on IMX7D.

Interesting, you mention that this IP block has mainly power management
and it itself requires save/restore. Is it not in always on domain ?

> When the system is in WFI (wait for interrupt) mode, this GPC block
> will be the first block on the platform to be activated and signaled.
> Under normal wait mode during cpu idle, the system can be woke up
> by any enabled interrupts. Under standby or suspend mode, the system
> can only be woke up by the pre-defined wakeup sources.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> Change log:
> 	Renamed the enabled_irqs to saved_irq_mask in struct gpcv2_irqchip_data
> 	Removed "BUG_ON()" in imx_gpcv2_irqchip_init to unify the error handling codes.
>
>   drivers/irqchip/Kconfig         |   7 +
>   drivers/irqchip/Makefile        |   1 +
>   drivers/irqchip/irq-imx-gpcv2.c | 275 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 283 insertions(+)
>   create mode 100644 drivers/irqchip/irq-imx-gpcv2.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 120d815..3fc0fac 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -177,3 +177,10 @@ config RENESAS_H8300H_INTC
>   config RENESAS_H8S_INTC
>           bool
>   	select IRQ_DOMAIN
> +
> +config IMX_GPCV2
> +	bool
> +	select IRQ_DOMAIN
> +	help
> +	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
> +
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b8d4e96..8eb5f60 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -52,3 +52,4 @@ obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
>   obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
>   obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
>   obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
> +obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
> new file mode 100644
> index 0000000..4a97afa
> --- /dev/null
> +++ b/drivers/irqchip/irq-imx-gpcv2.c
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +#include <linux/irqchip.h>
> +#include <linux/syscore_ops.h>
> +
> +#define IMR_NUM			4
> +#define GPC_MAX_IRQS            (IMR_NUM * 32)
> +
> +#define GPC_IMR1_CORE0		0x30
> +#define GPC_IMR1_CORE1		0x40
> +
> +struct gpcv2_irqchip_data {
> +	struct raw_spinlock    rlock;
> +	void __iomem       *gpc_base;
> +	u32 wakeup_sources[IMR_NUM];
> +	u32 saved_irq_mask[IMR_NUM];
> +	u32 cpu2wakeup;
> +};
> +
> +static struct gpcv2_irqchip_data *imx_gpcv2_instance;
> +
> +u32 imx_gpcv2_get_wakeup_source(u32 **sources)
> +{
> +	if (!imx_gpcv2_instance)
> +		return 0;
> +
> +	if (sources)
> +		*sources = imx_gpcv2_instance->wakeup_sources;
> +
> +	return IMR_NUM;
> +}
> +
> +static int gpcv2_wakeup_source_save(void)
> +{
> +	struct gpcv2_irqchip_data *cd;
> +	void __iomem *reg;
> +	int i;
> +
> +	cd = imx_gpcv2_instance;
> +	if (!cd)
> +		return 0;
> +
> +	for (i = 0; i < IMR_NUM; i++) {
> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> +		cd->saved_irq_mask[i] = readl_relaxed(reg);
> +		writel_relaxed(cd->wakeup_sources[i], reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static void gpcv2_wakeup_source_restore(void)
> +{
> +	struct gpcv2_irqchip_data *cd;
> +	void __iomem *reg;
> +	int i;
> +
> +	cd = imx_gpcv2_instance;
> +	if (!cd)
> +		return;
> +
> +	for (i = 0; i < IMR_NUM; i++) {
> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> +		writel_relaxed(cd->saved_irq_mask[i], reg);

Instead of saving all the non-wakeup sources, can't you use raw
save/restore of these registers and mask all the non-wakeup sources
by setting MASK_ON_SUSPEND ?

Also your interrupt controller seems like has no special way to
configure wakeups, you are just leaving them enabled. i.e. I see
cpu2wakeup used for both {un,}masking and wakeup enable. So you can just
use IRQCHIP_SKIP_SET_WAKE. Correct me if my understanding is wrong.

Regards,
Sudeep
