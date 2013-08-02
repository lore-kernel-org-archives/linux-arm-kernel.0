From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Aug 2013 12:10:32 +0100
Subject: [PATCH 08/10] ARM: clps711x: Add CLPS711X cpuidle driver
In-Reply-To: <1374172501-26796-9-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-9-git-send-email-shc_work@mail.ru>
Message-ID: <20130802111031.GG2884@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 07:34:59PM +0100, Alexander Shiyan wrote:
> This adds the cpuidle driver for Cirrus Logic CLPS711X series SoCs.
> Designed primarily for migration CLPS711X subarch for multiplatform & DT.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/cpuidle/Kconfig            |  6 +++
>  drivers/cpuidle/Makefile           |  1 +
>  drivers/cpuidle/cpuidle-clps711x.c | 80 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 0e2cd5c..c68a0cf 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -36,6 +36,12 @@ config CPU_IDLE_CALXEDA
>  	help
>  	  Select this to enable cpuidle on Calxeda processors.
>  
> +config CPU_IDLE_CLPS711X
> +	bool "CPU Idle Driver for CLPS711X processors"
> +	depends on ARCH_CLPS711X
> +	help
> +	  Select this to enable cpuidle on Cirrus Logic CLPS711X processors.
> +
>  config CPU_IDLE_ZYNQ
>  	bool "CPU Idle Driver for Xilinx Zynq processors"
>  	depends on ARCH_ZYNQ
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 8767a7b..d07d2cb 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -6,5 +6,6 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
>  obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  
>  obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
> +obj-$(CONFIG_CPU_IDLE_CLPS711X)	+= cpuidle-clps711x.o
>  obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
>  obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
> diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
> new file mode 100644
> index 0000000..9f0129f
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-clps711x.c
> @@ -0,0 +1,80 @@
> +/*
> + *  CLPS711X CPU idle driver
> + *
> + *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static void __iomem *clps711x_halt;
> +
> +static int clps711x_cpuidle_halt(struct cpuidle_device *dev,
> +				 struct cpuidle_driver *drv, int index)
> +{
> +	writel(1, clps711x_halt);
> +	asm volatile ("mov r0, r0");
> +	asm volatile ("mov r0, r0");

Huh?

> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver clps711x_idle_driver = {
> +	.name			= "clps711x_idle",
> +	.owner			= THIS_MODULE,
> +	.state_count		= 1,
> +	.states[0]	= {
> +		.name		= "HALT",
> +		.desc		= "CLPS711X WFI",
> +		.enter		= clps711x_cpuidle_halt,
> +		.exit_latency	= 1,
> +	},
> +};
> +
> +static int __init clps711x_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	clps711x_halt = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(clps711x_halt))
> +		return PTR_ERR(clps711x_halt);
> +
> +	return cpuidle_register(&clps711x_idle_driver, NULL);
> +}
> +
> +static int clps711x_cpuidle_remove(struct platform_device *pdev)
> +{
> +	cpuidle_unregister(&clps711x_idle_driver);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id clps711x_cpuidle_dt_ids[] = {
> +	{ .compatible = "cirrus,clps711x-cpuidle", },
> +	{ }
> +};

I don't like this -- cpuidle is a Linux abstraction, not a real device.
Additionally you haven't provided a binding.

What is the device being poked actually called? Is it a register in a
larger power management unit?

Thanks,
Mark.

> +MODULE_DEVICE_TABLE(of, clps711x_cpuidle_dt_ids);
> +
> +static struct platform_driver clps711x_cpuidle_driver = {
> +	.driver	= {
> +		.name		= "clps711x-cpuidle",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= clps711x_cpuidle_dt_ids,
> +	},
> +	.remove	= clps711x_cpuidle_remove,
> +};
> +module_platform_driver_probe(clps711x_cpuidle_driver, clps711x_cpuidle_probe);
> +
> +MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
> +MODULE_DESCRIPTION("CLPS711X CPU idle driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.8.1.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
