From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 23 Sep 2015 08:13:33 -0700
Subject: [PATCH v2] arm/ls1021a: Add Sleep feature for ls1021
In-Reply-To: <1442308030-21231-1-git-send-email-dongsheng.wang@freescale.com>
References: <1442308030-21231-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <20150923151333.GJ3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 05:07:10PM +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add system STANDBY implement for ls1021 platform.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v2*:
> - Remove PSCI code. Just implement STANDBY in platform code.

Why stepping back?  We are encouraged to move to PSCI, aren't we?

> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index fb689d8..d7a2d1d 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -90,6 +90,7 @@ ifeq ($(CONFIG_SUSPEND),y)
>  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_SOC_IMX6) += suspend-imx6.o
>  obj-$(CONFIG_SOC_IMX53) += suspend-imx53.o
> +obj-$(CONFIG_SOC_LS1021A) += pm-ls1.o
>  endif
>  obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
>  
> diff --git a/arch/arm/mach-imx/pm-ls1.c b/arch/arm/mach-imx/pm-ls1.c
> new file mode 100644
> index 0000000..90775cf
> --- /dev/null
> +++ b/arch/arm/mach-imx/pm-ls1.c
> @@ -0,0 +1,225 @@
> +/*
> + * Support Power Management Control for LS1
> + *
> + * Copyright 2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute	it and/or modify it
> + * under  the terms of	the GNU General	 Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/suspend.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/suspend.h>
> +
> +#define FSL_SLEEP			0x1
> +#define FSL_DEEP_SLEEP			0x2

Unused defines.

> +
> +#define CCSR_SCFG_CLUSTERPMCR		0x904
> +#define CCSR_SCFG_CLUSTERPMCR_WFIL2EN	0x80000000
> +#define CCSR_SCFG_CLUSTERPM_ENABLE	1
> +#define CCSR_SCFG_CLUSTERPM_DISABLE	0
> +
> +#define CCSR_RCPM_POWMGTCSR		0x130
> +#define CCSR_RCPM_POWMGTCSR_LPM20_REQ	0x00100000
> +#define CCSR_RCPM_IPPDEXPCR0		0x140
> +#define CCSR_RCPM_IPPDEXPCR1		0x144
> +#define CCSR_RCPM_IPPDEXPCR1_OCRAM1	0x10000000
> +
> +#define SLEEP_ARRAY_SIZE		3

The name of the macro doesn't appealing.
> +
> +static u32 ippdexpcr0, ippdexpcr1;

It makes more sense to have a structure holds all these variables and
the following base addresses.

> +
> +struct ls1_pm_baseaddr {
> +	void __iomem *rcpm;
> +	void __iomem *scfg;
> +};
> +
> +static struct ls1_pm_baseaddr ls1_pm_base;
> +
> +static inline void ls1_clrsetbits_be32(void __iomem *addr, u32 clear, u32 set)
> +{
> +	u32 val;
> +
> +	val = ioread32be(addr);
> +	val = (val & ~clear) | set;
> +	iowrite32be(val, addr);
> +}
> +
> +static int ls1_pm_iomap(suspend_state_t state)

How is argument 'state' used?

> +{
> +	struct device_node *np;
> +	void *base;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-scfg");
> +	if (!np) {
> +		pr_err("Missing SCFG node in the device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	base = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!base) {
> +		pr_err("Couldn't map SCFG registers\n");
> +		return -EINVAL;
> +	}
> +
> +	ls1_pm_base.scfg = base;
> +
> +	return 0;
> +}
> +
> +static void ls1_pm_uniomap(suspend_state_t state)
> +{
> +	iounmap(ls1_pm_base.scfg);
> +}
> +
> +/* set IP powerdown exception, make them work during sleep/deep sleep */
> +static void ls1_set_powerdown(void)
> +{
> +	iowrite32be(ippdexpcr0, ls1_pm_base.rcpm + CCSR_RCPM_IPPDEXPCR0);
> +	iowrite32be(ippdexpcr1,	ls1_pm_base.rcpm + CCSR_RCPM_IPPDEXPCR1);
> +}
> +
> +static void ls1_set_power_except(struct device *dev, int on)

How argument 'on' is used?

> +{
> +	int ret;
> +	u32 value[SLEEP_ARRAY_SIZE];
> +
> +	/*
> +	 * Get the values in the "rcpm-wakeup" property. There are three values.
> +	 * The first points to the RCPM node, the second is the value of
> +	 * the ippdexpcr0 register, and the third is the value of
> +	 * the ippdexpcr1 register.
> +	 */
> +	ret = of_property_read_u32_array(dev->of_node, "rcpm-wakeup",
> +					 value, SLEEP_ARRAY_SIZE);

The property should be documented in device tree bindings.  And you need
a good reason for why these register values should be defined by device
tree.

> +	if (ret) {
> +		dev_err(dev, "%s: Can not find the \"sleep\" property.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	ippdexpcr0 |= value[1];
> +	ippdexpcr1 |= value[2];
> +
> +	pr_debug("%s: set %s as a wakeup source", __func__,

When you have device pointer, you should use dev_dbg() instead of
pr_debug().

> +		 dev->of_node->full_name);
> +}
> +
> +static void ls1_set_wakeup_device(struct device *dev, void *enable)
> +{
> +	/* set each device which can act as wakeup source */
> +	if (device_may_wakeup(dev))
> +		ls1_set_power_except(dev, *((int *)enable));
> +}
> +
> +/* enable cluster to enter the PCL10 state */
> +static void ls1_set_clusterpm(int enable)
> +{
> +	u32 val = 0;
> +
> +	if (enable)
> +		val = CCSR_SCFG_CLUSTERPMCR_WFIL2EN;
> +
> +	iowrite32be(val, ls1_pm_base.scfg + CCSR_SCFG_CLUSTERPMCR);
> +}
> +
> +static int ls1_suspend_enter(suspend_state_t state)
> +{
> +	int ret = 0;
> +
> +	ls1_set_powerdown();
> +	ls1_set_clusterpm(CCSR_SCFG_CLUSTERPM_ENABLE);
> +
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		flush_cache_louis();
> +		ls1_clrsetbits_be32(ls1_pm_base.rcpm + CCSR_RCPM_POWMGTCSR,
> +				    CCSR_RCPM_POWMGTCSR_LPM20_REQ,
> +				    CCSR_RCPM_POWMGTCSR_LPM20_REQ);
> +		cpu_do_idle();
> +		break;
> +	case PM_SUSPEND_MEM:
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	ls1_set_clusterpm(CCSR_SCFG_CLUSTERPM_DISABLE);
> +
> +	return ret;
> +}
> +
> +static int ls1_suspend_valid(suspend_state_t state)
> +{
> +	if (state == PM_SUSPEND_STANDBY)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int ls1_suspend_begin(suspend_state_t state)
> +{
> +	int res = -EINVAL;

The convention of return variable is 'ret' than 'res'.

> +
> +	ippdexpcr0 = 0;
> +	ippdexpcr1 = 0;
> +
> +	if (state == PM_SUSPEND_STANDBY)
> +		res = ls1_pm_iomap(state);
> +
> +	if (!res)
> +		dpm_for_each_dev(NULL, ls1_set_wakeup_device);
> +
> +	return res;
> +}
> +
> +static void ls1_suspend_end(void)
> +{
> +	ls1_pm_uniomap(PM_SUSPEND_STANDBY);
> +}

The .begin() and .end() hooks will be called each time that system
enters/exits suspend, right?  Are you sure the setup you're doing in
ls1_suspend_begin() and ls1_suspend_end() is needed each time?  Or they
only need to be done in ls1_pm_init() for once?

> +
> +static const struct platform_suspend_ops ls1_suspend_ops = {
> +	.valid = ls1_suspend_valid,
> +	.enter = ls1_suspend_enter,
> +	.begin = ls1_suspend_begin,
> +	.end = ls1_suspend_end,
> +};
> +
> +static const struct of_device_id rcpm_matches[] = {
> +	{
> +		.compatible = "fsl,ls1021a-rcpm",

Undocumented compatible.

> +	},
> +	{}
> +};
> +
> +static int __init ls1_pm_init(void)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *np;
> +
> +	np = of_find_matching_node_and_match(NULL, rcpm_matches, &match);

You are simply trying to find "fsl,ls1021a-rcpm" node, so why not just
use of_find_compatible_node() like you try to find "fsl,ls1021a-scfg"
in ls1_pm_iomap().

> +	if (!np) {
> +		pr_err("%s: can't find the rcpm node.\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ls1_pm_base.rcpm = of_iomap(np, 0);
> +	of_node_put(np);
> +	if (!ls1_pm_base.rcpm)
> +		return -ENOMEM;

Right.  Why cannot iomap of scfg be done here just like rcpm?

> +
> +	suspend_set_ops(&ls1_suspend_ops);
> +
> +	pr_info("Freescale Power Management Control Registered\n");
> +
> +	return 0;
> +}
> +arch_initcall(ls1_pm_init);

Bear it in mind that we're now in multi-platform world, where a single
kernel image will run multiple targets, LS1021A, IMX, Vybrid, and even
non-FSL SoCs.  You cannot use such initcall here, which will get the
function called on non-LS1021A platform.

Shawn
