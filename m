From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 10 Jul 2015 16:31:54 +0200
Subject: [PATCH v2 2/6] soc: Mediatek: Add SCPSYS CPU power domain driver
In-Reply-To: <1436508249-49338-3-git-send-email-scott.shu@mediatek.com>
References: <1436508249-49338-3-git-send-email-scott.shu@mediatek.com>
Message-ID: <1480643.lE6oTr5Rlh@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 10, 2015 02:04:05 PM Scott Shu wrote:
> This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> MT6580.
> 
> Signed-off-by: Scott Shu <scott.shu@mediatek.com>
> ---
>  arch/arm/mach-mediatek/Makefile  |   2 +-
>  arch/arm/mach-mediatek/generic.h |  23 ++++
>  arch/arm/mach-mediatek/hotplug.c | 267
> +++++++++++++++++++++++++++++++++++++++ 3 files changed, 291 insertions(+),
> 1 deletion(-)
>  create mode 100644 arch/arm/mach-mediatek/generic.h
>  create mode 100644 arch/arm/mach-mediatek/hotplug.c
> 
> diff --git a/arch/arm/mach-mediatek/Makefile
> b/arch/arm/mach-mediatek/Makefile index 2116460..b2e4ef5 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -1,4 +1,4 @@
>  ifeq ($(CONFIG_SMP),y)
> -obj-$(CONFIG_ARCH_MEDIATEK) += platsmp.o
> +obj-$(CONFIG_ARCH_MEDIATEK) += platsmp.o hotplug.o
>  endif
>  obj-$(CONFIG_ARCH_MEDIATEK) += mediatek.o
> diff --git a/arch/arm/mach-mediatek/generic.h
> b/arch/arm/mach-mediatek/generic.h new file mode 100644
> index 0000000..376f183
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/generic.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2015 Mediatek Inc.
> + * Author: Scott Shu <scott.shu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef __MACH_GENERIC_H
> +#define __MACH_GENERIC_H
> +
> +#include <linux/kernel.h>
> +
> +int spm_cpu_mtcmos_init(void);
> +int spm_cpu_mtcmos_on(int cpu);
> +int spm_cpu_mtcmos_off(int cpu, bool wfi);
> +
> +#endif
> diff --git a/arch/arm/mach-mediatek/hotplug.c
> b/arch/arm/mach-mediatek/hotplug.c new file mode 100644
> index 0000000..bd97f2e
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/hotplug.c
> @@ -0,0 +1,267 @@
> +/*
> + * Copyright (c) 2015 Mediatek Inc.
> + * Author: Scott Shu <scott.shu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +
> +/* SCPSYS registers */
> +#define SPM_POWERON_CONFIG_SET		0x0000
> +
> +#define SPM_CA7_CPU0_PWR_CON		0x0200
> +#define SPM_CA7_CPU1_PWR_CON		0x0218
> +#define SPM_CA7_CPU2_PWR_CON		0x021c
> +#define SPM_CA7_CPU3_PWR_CON		0x0220
> +
> +#define SPM_CA7_CPU0_L1_PDN		0x025c
> +#define SPM_CA7_CPU1_L1_PDN		0x0264
> +#define SPM_CA7_CPU2_L1_PDN		0x026c
> +#define SPM_CA7_CPU3_L1_PDN		0x0274
> +
> +#define SPM_PWR_STATUS			0x060c
> +#define SPM_PWR_STATUS_2ND		0x0610
> +#define SPM_SLEEP_TIMER_STA		0x0720
> +
> +/* bit definition in SPM_CA7_CPUx_PWR_CON */
> +#define SRAM_ISOINT_B		BIT(6)
> +#define SRAM_CKISO		BIT(5)
> +#define PWR_CLK_DIS		BIT(4)
> +#define PWR_ON_2ND		BIT(3)
> +#define PWR_ON			BIT(2)
> +#define PWR_ISO			BIT(1)
> +#define PWR_RST_B		BIT(0)
> +
> +/* bit definition in SPM_CA7_CPUx_L1_PDN */
> +#define L1_PDN_ACK		BIT(8)
> +#define L1_PDN			BIT(0)
> +
> +#define MT6580_MAX_CPUS		4
> +
> +static DEFINE_SPINLOCK(spm_cpu_lock);
> +
> +void __iomem *spm_cpu_base;
> +
> +u32 spm_cpu_pwr_con[MT6580_MAX_CPUS] = {
> +	SPM_CA7_CPU0_PWR_CON,
> +	SPM_CA7_CPU1_PWR_CON,
> +	SPM_CA7_CPU2_PWR_CON,
> +	SPM_CA7_CPU3_PWR_CON,
> +};
> +
> +u32 spm_cpu_l1_pdn[MT6580_MAX_CPUS] = {
> +	SPM_CA7_CPU0_L1_PDN,
> +	SPM_CA7_CPU1_L1_PDN,
> +	SPM_CA7_CPU2_L1_PDN,
> +	SPM_CA7_CPU3_L1_PDN,
> +};
> +
> +#define SPM_REGWR_EN		BIT(0)
> +#define SPM_PROJECT_CODE	0x0B16
> +
> +int spm_cpu_mtcmos_on(int cpu)
> +{
> +	unsigned long flags;
> +	static u32 spmcpu_pwr_con, spmcpu_l1_pdn;
> +	unsigned int temp;
> +	int timeout = 10;
> +	int ret = -ENOSYS;
> +
> +	temp = (SPM_PROJECT_CODE << 16) | SPM_REGWR_EN;
> +	writel_relaxed(temp, spm_cpu_base + SPM_POWERON_CONFIG_SET);
> +
> +	spmcpu_pwr_con = spm_cpu_pwr_con[cpu];
> +	spmcpu_l1_pdn = spm_cpu_l1_pdn[cpu];
> +
> +	spin_lock_irqsave(&spm_cpu_lock, flags);
> +
> +	/* Set PWR_ON */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= PWR_ON;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Wait for charging core power */
> +	udelay(1);
> +
> +	/* Set PWR_ON_2ND */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= PWR_ON_2ND;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Wait for the power-ack */
> +	while (((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS) &
> +		(1U << (13 - cpu))) != (1U << (13 - cpu))) ||
> +		((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS_2ND) &
> +		(1U << (13 - cpu))) != (1U << (13 - cpu)))) {
> +		if (--timeout == 0)
> +			goto fail;
> +		udelay(1);
> +	}
> +
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~PWR_ISO;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* L1 power on */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_l1_pdn);
> +	temp &= ~L1_PDN;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_l1_pdn);
> +	timeout = 10;
> +	while ((readl_relaxed(spm_cpu_base + spmcpu_l1_pdn) &
> +		L1_PDN_ACK) != 0) {
> +		if (--timeout == 0)
> +			goto fail;
> +		udelay(1);
> +	}
> +
> +	/* Wait for memory power ready */
> +	udelay(1);
> +
> +	/* Set SRAM_ISOINT_B */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= SRAM_ISOINT_B;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Clear SRAM_CKISO */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~SRAM_CKISO;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Clear PWR_CLK_DIS */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~PWR_CLK_DIS;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Set PWR_RST_B to finish power on and reset sequences */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= PWR_RST_B;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	ret = 0;
> +fail:
> +	spin_unlock_irqrestore(&spm_cpu_lock, flags);
> +
> +	return ret;
> +}
> +
> +int spm_cpu_mtcmos_off(int cpu, bool wfi)
> +{
> +	unsigned long flags;
> +	static u32 spmcpu_pwr_con, spmcpu_l1_pdn;
> +	unsigned int temp;
> +	int timeout = 10;
> +	int ret = -ENOSYS;
> +
> +	temp = (SPM_PROJECT_CODE << 16) | SPM_REGWR_EN;
> +	writel_relaxed(temp, spm_cpu_base + SPM_POWERON_CONFIG_SET);
> +
> +	spmcpu_pwr_con = spm_cpu_pwr_con[cpu];
> +	spmcpu_l1_pdn = spm_cpu_l1_pdn[cpu];
> +
> +	if (wfi) {
> +		while ((readl_relaxed(spm_cpu_base + SPM_SLEEP_TIMER_STA) &
> +			(1U << (16 + cpu))) == 0) {
> +			if (--timeout == 0)
> +				return ret;
> +			udelay(1);
> +		}
> +	}
> +
> +	spin_lock_irqsave(&spm_cpu_lock, flags);
> +
> +	/* Set PWR_ISO */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= PWR_ISO;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Set SRAM_CKISO */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= SRAM_CKISO;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Clear SRAM_ISOINT_B */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~SRAM_ISOINT_B;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* L1 power off */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_l1_pdn);
> +	temp |= L1_PDN;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_l1_pdn);
> +	timeout = 10;
> +	while ((readl_relaxed(spm_cpu_base + spmcpu_l1_pdn) &
> +		L1_PDN_ACK) != L1_PDN_ACK) {
> +		if (--timeout == 0)
> +			goto fail;
> +		udelay(1);
> +	}
> +
> +	/* Clear PWR_RST_B */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~PWR_RST_B;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Set PWR_CLK_DIS */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp |= PWR_CLK_DIS;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Clear PWR_ON */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~PWR_ON;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	/* Clear PWR_ON_2ND */
> +	temp = readl_relaxed(spm_cpu_base + spmcpu_pwr_con);
> +	temp &= ~PWR_ON_2ND;
> +	writel_relaxed(temp, spm_cpu_base + spmcpu_pwr_con);
> +
> +	timeout = 10;
> +	while (((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS) &
> +		(1U << (13 - cpu))) != 0) ||
> +	       ((readl_relaxed(spm_cpu_base + SPM_PWR_STATUS_2ND) &
> +		(1U << (13 - cpu))) != 0)) {
> +		if (--timeout == 0)
> +			goto fail;
> +		udelay(1);
> +	}
> +
> +	ret = 0;
> +fail:
> +	spin_unlock_irqrestore(&spm_cpu_lock, flags);
> +
> +	return ret;
> +}
> +
> +int spm_cpu_mtcmos_init(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "mediatek,mt6580-scpsys");

This looks pretty much as if it should go in 
drivers/soc/mediatek/mtk-scpsys.c

AFAIR Sascha already mentioned that in v1.
Why do you want/need to implement this mach-mediatek?

Thanks,
Matthias
