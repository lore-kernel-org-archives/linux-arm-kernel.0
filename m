From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Oct 2015 14:46:23 +0800
Subject: [linux-sunxi] Re: [PATCH 3/6] mfd: axp20x: Add support for RSB
 based AXP223 PMIC
In-Reply-To: <20151016064159.GG2711@lukather>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-4-git-send-email-wens@csie.org>
 <20151016064159.GG2711@lukather>
Message-ID: <CAGb2v66B8EbTZkVrt3QT85fKCwOjL8OBWfQvcLHrLAe6NfavNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 2:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Oct 15, 2015 at 12:32:19AM +0800, Chen-Yu Tsai wrote:
>> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
>> It is functionally identical to AXP221; only the regulator default
>> voltage/status and the external host interface are different.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/mfd/Kconfig        | 12 ++++++
>>  drivers/mfd/Makefile       |  1 +
>>  drivers/mfd/axp20x-core.c  |  2 +
>>  drivers/mfd/axp20x-rsb.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/axp20x.h |  1 +
>>  5 files changed, 109 insertions(+)
>>  create mode 100644 drivers/mfd/axp20x-rsb.c
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 9ba3feb3f2fc..6e5edb61d42e 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -84,6 +84,7 @@ config MFD_BCM590XX
>>  config MFD_AXP20X
>>       bool "X-Powers AXP series PMICs"
>>       select MFD_AXP20X_I2C
>> +     select MFD_AXP20X_RSB
>>
>>  config MFD_AXP20X_CORE
>>       bool
>> @@ -102,6 +103,17 @@ config MFD_AXP20X_I2C
>>         components like regulators or the PEK (Power Enable Key) under the
>>         corresponding menus.
>>
>> +config MFD_AXP20X_RSB
>> +     bool "X-Powers AXP series RSB PMICs"
>> +     select MFD_AXP20X_CORE
>> +     depends on SUNXI_RSB=y
>
> Do we need that? Even if the bus is compiled as a module, the driver
> will not be probed before that, will it?

There's a compile/link dependency on the __devm_regmap_init_sunxi_rsb().

And both drivers are bool, i.e. can't be compiled as a module. What we
don't want is enabling MFD_AXP20X_RSB without SUNXI_RSB.

AFAIK the same goes for the I2C version.

>> +     help
>> +       If you say Y here you get support for the X-Powers AXP series RSB
>> +       based power management ICs (PMICs).
>> +       This driver include only the core APIs. You have to select individual
>> +       components like regulators or the PEK (Power Enable Key) under the
>> +       corresponding menus.
>> +
>>  config MFD_CROS_EC
>>       tristate "ChromeOS Embedded Controller"
>>       select MFD_CORE
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index ce3ad5fd4e2f..1eb278619dd6 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -108,6 +108,7 @@ obj-$(CONFIG_MFD_DA9052_SPI)      += da9052-spi.o
>>  obj-$(CONFIG_MFD_DA9052_I2C) += da9052-i2c.o
>>  obj-$(CONFIG_MFD_AXP20X_CORE)        += axp20x-core.o
>>  obj-$(CONFIG_MFD_AXP20X_I2C) += axp20x-i2c.o
>> +obj-$(CONFIG_MFD_AXP20X_RSB) += axp20x-rsb.o
>>
>>  obj-$(CONFIG_MFD_LP3943)     += lp3943.o
>>  obj-$(CONFIG_MFD_LP8788)     += lp8788.o lp8788-irq.o
>> diff --git a/drivers/mfd/axp20x-core.c b/drivers/mfd/axp20x-core.c
>> index dd33548d93c4..baecccb6d400 100644
>> --- a/drivers/mfd/axp20x-core.c
>> +++ b/drivers/mfd/axp20x-core.c
>> @@ -32,6 +32,7 @@ static const char * const axp20x_model_names[] = {
>>       "AXP202",
>>       "AXP209",
>>       "AXP221",
>> +     "AXP223",
>>       "AXP288",
>>  };
>>
>> @@ -575,6 +576,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x, struct device *dev)
>>               axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
>>               break;
>>       case AXP221_ID:
>> +     case AXP223_ID:
>>               axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
>>               axp20x->cells = axp22x_cells;
>>               axp20x->regmap_cfg = &axp22x_regmap_config;
>> diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
>> new file mode 100644
>> index 000000000000..5d053d177717
>> --- /dev/null
>> +++ b/drivers/mfd/axp20x-rsb.c
>> @@ -0,0 +1,93 @@
>> +/*
>> + * axp20x-rsb.c - RSB driver for the X-Powers' Power Management ICs
>> + *
>> + * AXP20x typically comprises an adaptive USB-Compatible PWM charger, BUCK DC-DC
>> + * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
>> + * as well as configurable GPIOs.
>> + *
>> + * This driver supports the RSB variants.
>> + *
>> + * Author: Chen-Yu Tsai <wens@csie.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/axp20x.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/sunxi/sunxi_rsb.h>
>> +
>> +static const struct of_device_id axp20x_sunxi_rsb_of_match[] = {
>> +     { .compatible = "x-powers,axp223", .data = (void *) AXP223_ID },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, axp20x_sunxi_rsb_of_match);
>> +
>> +static int axp20x_sunxi_rsb_match_device(struct axp20x_dev *axp20x,
>> +                                      struct device *dev)
>> +{
>> +     const struct of_device_id *of_id;
>> +
>> +     of_id = of_match_device(axp20x_sunxi_rsb_of_match, dev);
>> +     if (!of_id) {
>> +             dev_err(dev, "Unable to match OF ID\n");
>> +             return -ENODEV;
>> +     }
>> +     axp20x->variant = (long) of_id->data;
>> +
>> +     return axp20x_match_device(axp20x, dev);
>> +}
>> +
>> +static int axp20x_sunxi_rsb_probe(struct sunxi_rsb_device *rdev)
>> +{
>> +     struct axp20x_dev *axp20x;
>> +     int ret;
>> +
>> +     axp20x = devm_kzalloc(&rdev->dev, sizeof(*axp20x), GFP_KERNEL);
>> +     if (!axp20x)
>> +             return -ENOMEM;
>> +
>> +     ret = axp20x_sunxi_rsb_match_device(axp20x, &rdev->dev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     axp20x->dev = &rdev->dev;
>> +     axp20x->irq = rdev->irq;
>> +     sunxi_rsb_device_set_drvdata(rdev, axp20x);
>> +
>> +     axp20x->regmap = devm_regmap_init_sunxi_rsb(rdev, axp20x->regmap_cfg);
>> +     if (IS_ERR(axp20x->regmap)) {
>> +             ret = PTR_ERR(axp20x->regmap);
>> +             dev_err(&rdev->dev, "regmap init failed: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return axp20x_device_probe(axp20x);
>> +}
>> +
>> +static int axp20x_sunxi_rsb_remove(struct sunxi_rsb_device *rdev)
>> +{
>> +     struct axp20x_dev *axp20x = sunxi_rsb_device_get_drvdata(rdev);
>> +
>> +     return axp20x_device_remove(axp20x);
>> +}
>> +
>> +static struct sunxi_rsb_driver axp20x_sunxi_rsb_driver = {
>> +     .driver = {
>> +             .name   = "axp20x-sunxi-rsb",
>
> Do we need to be that verbose in the name of the driver?
>
> axp20x-rsb should be enough, especially since it's also the name of
> your file.

Sure.

> Looks good otherwise, thanks!

Thanks!

ChenYu
