From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 03 Apr 2014 13:56:57 +0200
Subject: [RFC PATCH 1/2] drivers: mfd: Add support of exynos-pmu driver
In-Reply-To: <1396427085-4696-2-git-send-email-pankaj.dubey@samsung.com>
References: <1396427085-4696-1-git-send-email-pankaj.dubey@samsung.com>
 <1396427085-4696-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <4187440.t3CeqIPlpy@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, April 02, 2014 05:24:44 PM Pankaj Dubey wrote:
> From: Younggun Jang <yg1004.jang@samsung.com>
> 
> This driver is mainly used for setting misc bits of register from PMU IP
> of Exynos SoC which will be required to configure before Suspend/Resume.
> Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
> moving ahead for ARM64 based SoC support, there is a need of DT based
> implementation of PMU driver.

PMU support for ARM32 EXYNOS SoCs is heavily SoC dependent and there
is very little code shared between diffirent SoCs.  Unless PMU setup
for Samsung ARM64 SoCs is similar to some existing ARM32 EXYNOS SoCs
it may be better to just add a separate PMU driver for Samsung ARM64
SoCs. IOW it would be best to show that this patch series is really
useful before merging it.

When it comes to the current patches it would be better to do changes
converting PMU support to be a platform driver first for the existing
arch/arm/mach-exynos/pmu.c file and then move+rename this file in
the separate patch.  Currently the code changes are done at the same
time as the code movement which makes them difficult to review/verify.

There are also some minor issues with the new code:

[...]

> diff --git a/drivers/mfd/exynos-pmu.c b/drivers/mfd/exynos-pmu.c
> new file mode 100644
> index 0000000..24abd9b
> --- /dev/null
> +++ b/drivers/mfd/exynos-pmu.c
> @@ -0,0 +1,534 @@
> +/*
> + * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/

2015?

[...]

> +static int __init exynos4210_pmu_init(void)
> +{
> +	exynos_pmu_config = exynos4210_pmu_config;
> +	pmu_data->pmu_id = PMU_EXYNOS4210;
> +	pr_info("EXYNOS4210 PMU Initialize\n");
> +
> +	return 0;
> +}
> +
> +static int __init exynos4212_pmu_init(void)
> +{
> +	exynos_pmu_config = exynos4x12_pmu_config;
> +	pmu_data->pmu_id = PMU_EXYNOS4212;
> +	pr_info("EXYNOS4x12 PMU Initialize\n");
> +
> +	return 0;
> +}
> +
> +static int __init exynos4412_pmu_init(void)
> +{
> +	exynos_pmu_config = exynos4x12_pmu_config;
> +	pmu_data->pmu_id = PMU_EXYNOS4412;
> +	pr_info("EXYNOS4412 PMU Initialize\n");
> +
> +	return 0;
> +}
> +
> +static int __init exynos5250_pmu_init(void)
> +{
> +	unsigned int value;
> +
> +	/*
> +	 * When SYS_WDTRESET is set, watchdog timer reset request
> +	 * is ignored by power management unit.
> +	 */
> +	value = __raw_readl(pmu_data->regs + EXYNOS5_AUTO_WDTRESET_DISABLE);
> +	value &= ~EXYNOS5_SYS_WDTRESET;
> +	__raw_writel(value, pmu_data->regs + EXYNOS5_AUTO_WDTRESET_DISABLE);
> +
> +	value = __raw_readl(pmu_data->regs + EXYNOS5_MASK_WDTRESET_REQUEST);
> +	value &= ~EXYNOS5_SYS_WDTRESET;
> +	__raw_writel(value, pmu_data->regs + EXYNOS5_MASK_WDTRESET_REQUEST);
> +
> +	exynos_pmu_config = exynos5250_pmu_config;
> +	pmu_data->pmu_id = PMU_EXYNOS5250;
> +	pr_info("EXYNOS5250 PMU Initialize\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * PMU platform driver and devicetree bindings.
> + */
> +static struct of_device_id exynos_pmu_of_device_ids[] = {
> +	{
> +		.compatible = "samsung,exynos4210-pmu",
> +		.data = (void *)exynos4210_pmu_init
> +	},
> +	{
> +		.compatible = "samsung,exynos4212-pmu",
> +		.data = (void *)exynos4212_pmu_init
> +	},
> +	{
> +		.compatible = "samsung,exynos4412-pmu",
> +		.data = (void *)exynos4412_pmu_init
> +	},
> +	{
> +		.compatible = "samsung,exynos5250-pmu",
> +		.data = (void *)exynos5250_pmu_init
> +	},
> +	{},
> +};
> +
> +static int exynos_pmu_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	exynos_pmu_init_t exynos_pmu_init;
> +	struct resource *res;
> +
> +	pmu_data = devm_kzalloc(&pdev->dev,
> +			sizeof(struct exynos_pmu_data), GFP_KERNEL);
> +	if (!pmu_data) {
> +		dev_err(&pdev->dev, "exynos_pmu driver probe failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	pmu_data->dev = &pdev->dev;
> +
> +	match = of_match_node(exynos_pmu_of_device_ids, pdev->dev.of_node);
> +	exynos_pmu_init = match->data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pmu_data->regs = devm_ioremap_resource(&pdev->dev, res);

devm_ioremap_resouce() return value should be checked for errors with

if (IS_ERR(pmu_data->regs))
	return PTR_ERR(pmu_data->regs);

> +
> +	exynos_pmu_init();

exynos*_pmu_init() methods should be void as they always return 0 and
the return value is ignored anyway.

Also they cannot be marked with __init as the driver probe function
itself is not marked with __init (it cannot be beacuse of possibility
of doing unbind/bind through sysfs).

> +
> +	return 0;
> +};
> +
> +static int exynos_pmu_remove(struct platform_device *pdev)
> +{
> +	exynos_pmu_config = NULL;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver exynos_pmu_driver = {
> +	.driver  = {
> +		.name   = "exynos-pmu",
> +		.of_match_table = exynos_pmu_of_device_ids,
> +	},
> +	.probe = exynos_pmu_probe,
> +	.remove = exynos_pmu_remove,
> +};
> +
> +static int __init exynos_pmu_driver_init(void)
> +{
> +	return platform_driver_register(&exynos_pmu_driver);
> +}
> +arch_initcall(exynos_pmu_driver_init);
> +
> +MODULE_AUTHOR("Younggun Jang <yg1004.jang@samsung.com");
> +MODULE_DESCRIPTION("Exynos PMU driver");
> +MODULE_LICENSE("GPL v2");

This driver can be build as module now but:
- exynos_sys_powerdown_conf() is not exported
- there is no exynos_pmu_driver_exit()

Also it is not clear what happens if exynos_sys_powerdown_conf() is called
while there are no platform devices binded to a driver but driver itself is
loaded.

[...]

> diff --git a/include/linux/mfd/samsung/exynos-regs-pmu.h b/include/linux/mfd/samsung/exynos-regs-pmu.h
> new file mode 100644
> index 0000000..ed8259d
> --- /dev/null
> +++ b/include/linux/mfd/samsung/exynos-regs-pmu.h
> @@ -0,0 +1,308 @@
> +/*
> + * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.

2015?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
