From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jun 2011 16:54:47 +0100
Subject: [PATCH 1/3] ARM: pmu: add OF probing support
In-Reply-To: <1307456541-11026-2-git-send-email-robherring2@gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-2-git-send-email-robherring2@gmail.com>
Message-ID: <000001cc25f4$64c2d5c0$2e488140$@rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>  static int __devinit pmu_device_probe(struct platform_device *pdev)
>  {
> +	enum arm_pmu_type type = pdev->id;
> 
> -	if (pdev->id < 0 || pdev->id >= ARM_NUM_PMU_DEVICES) {
> +	if (pdev->dev.of_node)
> +		type = ARM_PMU_DEVICE_CPU;
> +
> +	if (type < 0 || type >= ARM_NUM_PMU_DEVICES) {
>  		pr_warning("received registration request for unknown "
>  				"device %d\n", pdev->id);
>  		return -EINVAL;
>  	}
> 
> -	if (pmu_devices[pdev->id])
> +	if (pmu_devices[type])
>  		pr_warning("registering new PMU device type %d overwrites "
> -				"previous registration!\n", pdev->id);
> +				"previous registration!\n", type);
>  	else
>  		pr_info("registered new PMU device of type %d\n",
> -				pdev->id);
> +				type);
> 
> -	pmu_devices[pdev->id] = pdev;
> +	pmu_devices[type] = pdev;
>  	return 0;
>  }

I don't think this is the best way to handle the type when we've got an FDT
description:

* release_pmu hasn't been updated to match the type logic here, so it might do
  anything when handed a platform_device initialised by FDT code.

* the warning message for an invalid registration still uses pdev->id rather
  than type. This can't currently be reached when the PMU was handed to us via
  FDT, but it may confuse refactoring later on.

* If we want to add a new PMU type, we'll have to add more logic to
  pmu_device_probe. Given that work is going on to add support for system PMUs,
  this doesn't seem particularly brilliant.

> +static struct of_device_id pmu_device_ids[] = {
> +	{ .compatible = "arm,cortex-a9-pmu" },
> +	{ .compatible = "arm,cortex-a8-pmu" },
> +	{ .compatible = "arm,arm1136-pmu" },
> +	{ .compatible = "arm,arm1176-pmu" },
> +	{},
> +};
> +
>  static struct platform_driver pmu_driver = {
>  	.driver		= {
>  		.name	= "arm-pmu",
> +		.of_match_table = pmu_device_ids,
>  	},
>  	.probe		= pmu_device_probe,
>  };

This all seems fine for handling CPU PMUs.

I think that a better strategy would be to separate the type logic from the
registration. I have a patch for this:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052455.html

With it, you won't need to change pmu_device_probe, and adding FDT support
should just be a matter of adding the of_match_table.

Mark
