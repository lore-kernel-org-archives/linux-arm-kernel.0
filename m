From: lee@kernel.org (Lee Jones)
Date: Tue, 27 Oct 2015 17:23:20 +0000
Subject: [PATCH] thermal: Add Raspberry Pi BCM2835 thermal driver
In-Reply-To: <1444592950-16533-1-git-send-email-lkundrak@v3.sk>
References: <1444592950-16533-1-git-send-email-lkundrak@v3.sk>
Message-ID: <20151027172320.GC5828@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Oct 2015, Lubomir Rintel wrote:

> BCM2835 thermal sensor accessible via Raspberry Pi VideoCore 4 firmware
> interface.
> 
> Based on work by Craig McGeachie, ported to the Raspberry Pi firmware
> interface (from the original mailbox client version).
> 
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> Needs the RPi firmware patchset from branch 'rpi-firmware' of 
> https://github.com/anholt/linux
> 
>  drivers/thermal/Kconfig           |   8 ++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/bcm2835-thermal.c | 161 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 drivers/thermal/bcm2835-thermal.c

Driver looks pretty simple, so not too much to go wrong.

Some small nits below though.

> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5aabc4b..5305a95 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -222,6 +222,14 @@ config DOVE_THERMAL
>  	  Support for the Dove thermal sensor driver in the Linux thermal
>  	  framework.
>  
> +config BCM2835_THERMAL
> +	tristate "BCM2835 Temperature sensor on Raspberry Pi"
> +	depends on RASPBERRYPI_FIRMWARE
> +	help
> +	  Support for the Broadcom BCM2835 thermal sensor driver on Raspberry Pi
> +	  devices in the Linux thermal framework. The BCM2835 has one sensor on
> +	  chip, with one trip point and no cooling devices.
> +
>  config DB8500_THERMAL
>  	bool "DB8500 thermal management"
>  	depends on ARCH_U8500
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 26f1608..e71182b 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -45,3 +45,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+= st/
>  obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_BCM2835_THERMAL)	+= bcm2835-thermal.o
> diff --git a/drivers/thermal/bcm2835-thermal.c b/drivers/thermal/bcm2835-thermal.c
> new file mode 100644
> index 0000000..7989c60
> --- /dev/null
> +++ b/drivers/thermal/bcm2835-thermal.c
> @@ -0,0 +1,161 @@
> +/*
> + *  Copyright (C) 2013 Craig McGeachie
> + *  Copyright (C) 2014,2015 Lubomir Rintel
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This device presents the BCM2835 SoC temperature sensor as a thermal
> + * device.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>

Nit: Alphabetical

> +#define VC_TAG_GET_TEMP 0x00030006
> +#define VC_TAG_GET_MAX_TEMP 0x0003000A
> +#define VC_SUCCESS 0x80000000

Tabs, not spaces.

> +struct prop {
> +	u32 id;
> +	u32 val;
> +} __packed;
> +
> +struct bcm2835_therm {
> +	struct device *dev;
> +	struct thermal_zone_device *thermal_dev;
> +	struct rpi_firmware *fw;
> +};

Consider adding a Kernel doc?

Tabs.

> +static int bcm2835_get_temp_common(struct thermal_zone_device *thermal_dev,
> +						int *temp, u32 temp_type)

What kind of tabbing is this?

Lining up to the '(' is my personal preference.

> +{
> +	struct bcm2835_therm *therm = thermal_dev->devdata;
> +	struct device *dev = therm->dev;
> +	struct prop msg = {
> +		.id = 0,
> +		.val = 0
> +	};
> +	int ret;
> +
> +	ret = rpi_firmware_property(therm->fw, temp_type, &msg, sizeof(msg));
> +	if (ret) {
> +		dev_err(dev, "VC temperature request failed\n");
> +		goto exit;

Don't do this.  Just return.

> +	}
> +
> +	*temp = msg.val;
> +
> +exit:
> +	return ret;
> +}
> +
> +static int bcm2835_get_temp(struct thermal_zone_device *thermal_dev, int *temp)
> +{
> +	return bcm2835_get_temp_common(thermal_dev, temp, VC_TAG_GET_TEMP);
> +}
> +
> +static int bcm2835_get_max_temp(struct thermal_zone_device *thermal_dev,
> +						int trip_num, int *temp)

Tabbing.

> +{
> +	return bcm2835_get_temp_common(thermal_dev, temp, VC_TAG_GET_MAX_TEMP);
> +}
> +
> +static int bcm2835_get_trip_type(struct thermal_zone_device *thermal_dev,
> +			int trip_num, enum thermal_trip_type *trip_type)

Tabbing, etc.

> +{
> +	*trip_type = THERMAL_TRIP_HOT;
> +
> +	return 0;
> +}
> +
> +static int bcm2835_get_mode(struct thermal_zone_device *thermal_dev,
> +		enum thermal_device_mode *dev_mode)
> +{
> +	*dev_mode = THERMAL_DEVICE_ENABLED;
> +
> +	return 0;
> +}

Not your fault, but these call-backs seem pretty pointless.

> +static struct thermal_zone_device_ops ops  = {
> +	.get_temp = bcm2835_get_temp,
> +	.get_trip_temp = bcm2835_get_max_temp,
> +	.get_trip_type = bcm2835_get_trip_type,
> +	.get_mode = bcm2835_get_mode,
> +};
> +
> +static int bcm2835_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm2835_therm *therm;
> +	struct device_node *fw;
> +
> +	therm = devm_kzalloc(dev, sizeof(*therm), GFP_KERNEL);
> +	if (!therm)
> +		return -ENOMEM;
> +
> +	therm->dev = dev;
> +	dev_set_drvdata(dev, therm);
> +
> +	fw = of_parse_phandle(pdev->dev.of_node, "firmware", 0);
> +	if (!fw) {
> +		dev_err(dev, "no firmware node");
> +		return -ENODEV;
> +	}

'\n' here.

> +	therm->fw = rpi_firmware_get(fw);
> +	if (!therm->fw)
> +		return -EPROBE_DEFER;
> +
> +	therm->thermal_dev = thermal_zone_device_register("bcm2835_thermal",
> +					1, 0, therm, &ops, NULL, 0, 0);
> +	if (IS_ERR(therm->thermal_dev)) {
> +		dev_err(dev, "Unable to register the thermal device");
> +		return PTR_ERR(therm->thermal_dev);
> +	}
> +
> +	dev_info(dev, "Broadcom BCM2835 thermal sensor\n");

It's best practice not to print static information.

> +	return 0;
> +}
> +
> +static int bcm2835_thermal_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_therm *therm = dev_get_drvdata(&pdev->dev);
> +
> +	thermal_zone_device_unregister(therm->thermal_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm2835_thermal_of_match[] = {
> +	{ .compatible = "raspberrypi,bcm2835-thermal", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_thermal_of_match);
> +
> +static struct platform_driver bcm2835_thermal_driver = {
> +	.driver = {
> +		.name = "bcm2835_thermal",
> +		.owner = THIS_MODULE,

Remove this.  It's handled else where.

> +		.of_match_table = bcm2835_thermal_of_match,
> +	},
> +	.probe = bcm2835_thermal_probe,
> +	.remove = bcm2835_thermal_remove,
> +};
> +
> +module_platform_driver(bcm2835_thermal_driver);
> +
> +MODULE_AUTHOR("Craig McGeachie");
> +MODULE_AUTHOR("Lubomir Rintel");

It's common practice to also place your email address in here.

> +MODULE_DESCRIPTION("Raspberry Pi BCM2835 thermal driver");
> +MODULE_LICENSE("GPL v2");
