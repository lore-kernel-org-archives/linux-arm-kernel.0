From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Feb 2016 16:12:16 +0000
Subject: [PATCH v9 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <1453887530-22490-2-git-send-email-wenyou.yang@atmel.com>
References: <1453887530-22490-1-git-send-email-wenyou.yang@atmel.com>
 <1453887530-22490-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160210161216.GG26950@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016, Wenyou Yang wrote:

> This patch adds support for the Active-semi ACT8945A PMIC.
> It is a Multi Function Device with the following subdevices:
>  - Regulator
>  - Charger
> 
> It is interfaced to the host controller using I2C interface,
> ACT8945A is a child device of the I2C.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Peter Korsgaard <peter@korsgaard.com>
> ---
> 
> Changes in v9:
>  - remove unneeded struct act8945a_dev structure.
>  - collect Acked from Lee.
>  - collect Acked from Peter.
> 
> Changes in v8:
>  - change the subdevice's name "act8945a-pmic" to "act8945a-regulator".
> 
> Changes in v7:
>  - remove struct act8945a_dev to .c file.
>  - remove unused .h file.
> 
> Changes in v6:
>  - change MFD_ACT8945A type from bool to tristate.
>  - revert depends on to 'I2C'.
> 
> Changes in v5:
>  - change depends on to 'I2C=y'.
> 
> Changes in v4:
>  - add a space before .compatible.
>  - collect Reviewed-by from Krzysztof Kozlowski.
> 
> Changes in v3: None
> Changes in v2:
>  - add more help information in Kconfig.
>  - update the file header with short version license and author line.
>  - remove unused structure members (dev, i2c_client) of stuct act8945a_dev.
>  - use define "PLATFORM_DEVID_NONE" for mfd_add_devices(), instead of '-1'.
>  - use more explicit info to indicate the failure to add sub devices.
>  - remove the unnecessary print out.
>  - substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").
> 
>  drivers/mfd/Kconfig    |   11 +++++
>  drivers/mfd/Makefile   |    1 +
>  drivers/mfd/act8945a.c |  104 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 drivers/mfd/act8945a.c

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6c4ebd9..38994bb 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -18,6 +18,17 @@ config MFD_CS5535
>  	  This is the core driver for CS5535/CS5536 MFD functions.  This is
>            necessary for using the board's GPIO and MFGPT functionality.
>  
> +config MFD_ACT8945A
> +	tristate "Active-semi ACT8945A"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C && OF
> +	help
> +	  Support for the ACT8945A PMIC from Active-semi. This device
> +	  features three step-down DC/DC converters and four low-dropout
> +	  linear regulators, along with a complete ActivePath battery
> +	  charger.
> +
>  config MFD_AS3711
>  	bool "AMS AS3711"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0f230a6..2f1ca82 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
>  obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
> +obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
>  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
> diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
> new file mode 100644
> index 0000000..f59eb99
> --- /dev/null
> +++ b/drivers/mfd/act8945a.c
> @@ -0,0 +1,104 @@
> +/*
> + * MFD driver for Active-semi ACT8945a PMIC
> + *
> + * Copyright (C) 2015 Atmel Corporation.
> + *
> + * Author: Wenyou Yang <wenyou.yang@atmel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under  the terms of the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +static const struct mfd_cell act8945a_devs[] = {
> +	{
> +		.name = "act8945a-regulator",
> +		.of_compatible = "active-semi,act8945a-regulator",
> +	},
> +	{
> +		.name = "act8945a-charger",
> +		.of_compatible = "active-semi,act8945a-charger",
> +	},
> +};
> +
> +static const struct regmap_config act8945a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int act8945a_i2c_probe(struct i2c_client *i2c,
> +			      const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &act8945a_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(i2c, regmap);
> +
> +	ret = mfd_add_devices(&i2c->dev, PLATFORM_DEVID_NONE, act8945a_devs,
> +			      ARRAY_SIZE(act8945a_devs), NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to add sub devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int act8945a_i2c_remove(struct i2c_client *i2c)
> +{
> +	mfd_remove_devices(&i2c->dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id act8945a_i2c_id[] = {
> +	{ "act8945a", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, act8945a_i2c_id);
> +
> +static const struct of_device_id act8945a_of_match[] = {
> +	{ .compatible = "active-semi,act8945a", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, act8945a_of_match);
> +
> +static struct i2c_driver act8945a_i2c_driver = {
> +	.driver = {
> +		   .name = "act8945a",
> +		   .of_match_table = of_match_ptr(act8945a_of_match),
> +	},
> +	.probe = act8945a_i2c_probe,
> +	.remove = act8945a_i2c_remove,
> +	.id_table = act8945a_i2c_id,
> +};
> +
> +static int __init act8945a_i2c_init(void)
> +{
> +	return i2c_add_driver(&act8945a_i2c_driver);
> +}
> +subsys_initcall(act8945a_i2c_init);
> +
> +static void __exit act8945a_i2c_exit(void)
> +{
> +	i2c_del_driver(&act8945a_i2c_driver);
> +}
> +module_exit(act8945a_i2c_exit);
> +
> +MODULE_DESCRIPTION("ACT8945A PMIC multi-function driver");
> +MODULE_AUTHOR("Wenyou Yang <wenyou.yang@atmel.com>");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
