From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Nov 2015 10:17:45 -0700
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CANLsYkzBjDTCr1NPkPAQXnR5LCQ0MFFGb8EXXO2oVaxuZ0DH_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2015 at 08:29, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some boards, in order to power devices that have a quite high power
> consumption, wire multiple regulators in parallel.
>
> In such a case, the regulators need to be kept in sync, all of them being
> enabled or disabled in parallel.
>
> This also requires to expose only the voltages that are common to all the
> regulators.
>
> Eventually support for changing the voltage in parallel should be added
> too, possibly with delays between each other to avoid having a too brutal
> peak consumption.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/regulator/Kconfig                     |   7 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/coupled-voltage-regulator.c | 241 ++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 drivers/regulator/coupled-voltage-regulator.c
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 8df0b0e62976..6ba7bc8fda13 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -35,6 +35,13 @@ config REGULATOR_FIXED_VOLTAGE
>           useful for systems which use a combination of software
>           managed regulators and simple non-configurable regulators.
>
> +config REGULATOR_COUPLED_VOLTAGE
> +       tristate "Coupled voltage regulator support"
> +       help
> +         This driver provides support for regulators that are an
> +         aggregate of other regulators in the system, and need to
> +         keep them all in sync.
> +
>  config REGULATOR_VIRTUAL_CONSUMER
>         tristate "Virtual regulator consumer support"
>         help
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 0f8174913c17..c05839257386 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
>  obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
>  obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
>  obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
> +obj-$(CONFIG_REGULATOR_COUPLED_VOLTAGE) += coupled-voltage-regulator.o
>  obj-$(CONFIG_REGULATOR_DA903X) += da903x.o
>  obj-$(CONFIG_REGULATOR_DA9052) += da9052-regulator.o
>  obj-$(CONFIG_REGULATOR_DA9055) += da9055-regulator.o
> diff --git a/drivers/regulator/coupled-voltage-regulator.c b/drivers/regulator/coupled-voltage-regulator.c
> new file mode 100644
> index 000000000000..dc7aa2aca7e6
> --- /dev/null
> +++ b/drivers/regulator/coupled-voltage-regulator.c
> @@ -0,0 +1,241 @@
> +/*
> + * Copyright 2015 Free Electrons
> + * Copyright 2015 NextThing Co.
> + *
> + * Author: Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#define COUPLED_REGULATOR_MAX_SUPPLIES 16
> +
> +struct coupled_regulator {
> +       struct regulator        **regulators;
> +       int                     n_regulators;
> +

Extra line.

> +       int                     *voltages;
> +       int                     n_voltages;
> +};

This new structure needs documentation.

> +
> +static int coupled_regulator_disable(struct regulator_dev *rdev)
> +{
> +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> +       int ret, i;
> +
> +       for (i = 0; i < creg->n_regulators; i++) {
> +               ret = regulator_disable(creg->regulators[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}

What happens to the other regulators when an element of the chain
fails to disable?  Should they be powered on again?

> +
> +static int coupled_regulator_enable(struct regulator_dev *rdev)
> +{
> +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> +       int ret, i;
> +
> +       for (i = 0; i < creg->n_regulators; i++) {
> +               ret = regulator_enable(creg->regulators[i]);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}

Same thing here - shouldn't the previously enabled regulators be
switched off when one fails to come on?  It might be worth documenting
the behaviour being enacted.

> +
> +static int coupled_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> +       int ret = 0, i;
> +
> +       for (i = 0; i < creg->n_regulators; i++) {
> +               ret &= regulator_is_enabled(creg->regulators[i]);

Why is the '&=' here?  Since it is set to '0' from the start, won't it
always clear all the bits in a potential error return code?  Apologies
if I'm missing something.

> +               if (ret < 0)
> +                       break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int coupled_regulator_list_voltage(struct regulator_dev *rdev,
> +                                         unsigned int selector)
> +{
> +       struct coupled_regulator *creg = rdev_get_drvdata(rdev);
> +
> +       if (selector >= creg->n_voltages)
> +               return -EINVAL;
> +
> +       return creg->voltages[selector];
> +}
> +
> +static struct regulator_ops coupled_regulator_ops = {
> +       .enable                 = coupled_regulator_enable,
> +       .disable                = coupled_regulator_disable,
> +       .is_enabled             = coupled_regulator_is_enabled,
> +       .list_voltage           = coupled_regulator_list_voltage,
> +};
> +
> +static struct regulator_desc coupled_regulator_desc = {
> +       .name           = "coupled-voltage-regulator",
> +       .type           = REGULATOR_VOLTAGE,
> +       .ops            = &coupled_regulator_ops,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int coupled_regulator_probe(struct platform_device *pdev)
> +{
> +       const struct regulator_init_data *init_data;
> +       struct coupled_regulator *creg;
> +       struct regulator_config config = { };
> +       struct regulator_dev *regulator;
> +       struct regulator_desc *desc;
> +       struct device_node *np = pdev->dev.of_node;
> +       int max_voltages, i;
> +
> +       if (!np) {
> +               dev_err(&pdev->dev, "Device Tree node missing\n");
> +               return -EINVAL;
> +       }
> +
> +       creg = devm_kzalloc(&pdev->dev, sizeof(*creg), GFP_KERNEL);
> +       if (!creg)
> +               return -ENOMEM;
> +
> +       init_data = of_get_regulator_init_data(&pdev->dev, np,
> +                                              &coupled_regulator_desc);
> +       if (!init_data)
> +               return -ENOMEM;
> +
> +       config.of_node = np;
> +       config.dev = &pdev->dev;
> +       config.driver_data = creg;
> +       config.init_data = init_data;
> +
> +       for (i = 0; i < COUPLED_REGULATOR_MAX_SUPPLIES; i++) {
> +               char *propname = kasprintf(GFP_KERNEL, "vin%d-supply", i);
> +               const void *prop = of_get_property(np, propname, NULL);
> +               kfree(propname);
> +
> +               if (!prop) {
> +                       creg->n_regulators = i;
> +                       break;
> +               }
> +       }
> +
> +       dev_dbg(&pdev->dev, "Found %d parent regulators\n",
> +               creg->n_regulators);
> +
> +       if (!creg->n_regulators) {
> +               dev_err(&pdev->dev, "No parent regulators listed\n");
> +               return -EINVAL;
> +       }
> +
> +       creg->regulators = devm_kcalloc(&pdev->dev, creg->n_regulators,
> +                                       sizeof(*creg->regulators), GFP_KERNEL);
> +       if (!creg->regulators)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < creg->n_regulators; i++) {
> +               char *propname = kasprintf(GFP_KERNEL, "vin%d", i);
> +
> +               dev_dbg(&pdev->dev, "Trying to get supply %s\n", propname);
> +
> +               creg->regulators[i] = devm_regulator_get(&pdev->dev, propname);
> +               kfree(propname);
> +
> +               if (IS_ERR(creg->regulators[i])) {
> +                       dev_err(&pdev->dev, "Couldn't get regulator vin%d\n",
> +                               i);
> +                       return PTR_ERR(creg->regulators[i]);
> +               }
> +       }
> +
> +       /*
> +        * Since we want only to expose voltages that can be set on
> +        * all the regulators, we won't have more voltages supported
> +        * than the number of voltages supported by the first
> +        * regulator in our list
> +        */
> +       max_voltages = regulator_count_voltages(creg->regulators[0]);
> +
> +       creg->voltages = devm_kcalloc(&pdev->dev, max_voltages, sizeof(int),
> +                                     GFP_KERNEL);
> +
> +       /* Build up list of supported voltages */
> +       for (i = 0; i < max_voltages; i++) {
> +               int voltage = regulator_list_voltage(creg->regulators[0], i);
> +               bool usable = true;
> +               int j;
> +
> +               if (voltage <= 0)
> +                       continue;
> +
> +               dev_dbg(&pdev->dev, "Checking voltage %d...\n", voltage);
> +
> +               for (j = 1; j < creg->n_regulators; j++) {
> +                       if (!regulator_is_supported_voltage(creg->regulators[j],
> +                                                           voltage, voltage)) {
> +                               usable = false;
> +                               break;
> +                       }
> +               }
> +
> +               if (usable) {
> +                       creg->voltages[creg->n_voltages++] = voltage;
> +                       dev_dbg(&pdev->dev,
> +                                "Adding voltage %d to the list of supported voltages\n",
> +                                voltage);
> +               }
> +       }
> +
> +       dev_dbg(&pdev->dev, "Supporting %d voltages\n", creg->n_voltages);
> +
> +       desc = devm_kmemdup(&pdev->dev, &coupled_regulator_desc,
> +                           sizeof(coupled_regulator_desc), GFP_KERNEL);
> +       if (!desc)
> +               return -ENOMEM;
> +       desc->n_voltages = creg->n_voltages;
> +
> +       regulator = devm_regulator_register(&pdev->dev, desc, &config);
> +       if (IS_ERR(regulator)) {
> +               dev_err(&pdev->dev, "Failed to register regulator %s\n",
> +                       coupled_regulator_desc.name);
> +               return PTR_ERR(regulator);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct of_device_id coupled_regulator_of_match[] = {
> +       { .compatible = "coupled-voltage-regulator" },
> +       { /* Sentinel */ },
> +};
> +
> +static struct platform_driver coupled_regulator_driver = {
> +       .probe  = coupled_regulator_probe,
> +
> +       .driver = {
> +               .name           = "coupled-voltage-regulator",
> +               .of_match_table = coupled_regulator_of_match,
> +       },
> +};
> +module_platform_driver(coupled_regulator_driver);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
> +MODULE_DESCRIPTION("Coupled Regulator Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
