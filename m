From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Mar 2014 15:59:19 +0000
Subject: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <1394898225-28452-2-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
Message-ID: <20140318155919.GS25478@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
> 
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/mfd/Kconfig        |  12 +++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/axp20x.c       | 247 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 179 ++++++++++++++++++++++++++++++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 drivers/mfd/axp20x.c
>  create mode 100644 include/linux/mfd/axp20x.h

[...]

> +/*
> + * axp20x.c - mfd core driver for the X-Powers AXP202 and AXP209

MFD

[...]

> +static struct resource axp20x_pek_resources[] = {
> +	{
> +		.name	= "PEK_DBR",
> +		.start	= AXP20X_IRQ_PEK_RIS_EDGE,
> +		.end	= AXP20X_IRQ_PEK_RIS_EDGE,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.name	= "PEK_DBF",
> +		.start	= AXP20X_IRQ_PEK_FAL_EDGE,
> +		.end	= AXP20X_IRQ_PEK_FAL_EDGE,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};

[...] 

> +static struct mfd_cell axp20x_cells[] = {
> +	{
> +		.name		= "axp20x-pek",
> +		.num_resources	= ARRAY_SIZE(axp20x_pek_resources),
> +		.resources	= axp20x_pek_resources,
> +	}, {
> +		.name		= "axp20x-regulator",
> +	},
> +};

nit: The format of these two structs are inconsistent.

[...]

> +static int axp20x_i2c_probe(struct i2c_client *i2c,
> +			 const struct i2c_device_id *id)
> +{
> +	struct axp20x_dev *axp20x;
> +	const struct of_device_id *of_id;
> +	int ret;
> +
> +	axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
> +	if (!axp20x)
> +		return -ENOMEM;
> +
> +	of_id = of_match_device(axp20x_of_match, &i2c->dev);
> +	if (!of_id) {
> +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> +		return -ENODEV;
> +	}
> +	axp20x->variant = (int) of_id->data;

No need to cast from void *.

> +	axp20x->i2c_client = i2c;
> +	axp20x->dev = &i2c->dev;
> +	dev_set_drvdata(axp20x->dev, axp20x);
> +
> +	axp20x->regmap = devm_regmap_init_i2c(i2c, &axp20x_regmap_config);
> +	if (IS_ERR(axp20x->regmap)) {
> +		ret = PTR_ERR(axp20x->regmap);
> +		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	axp20x->irq = i2c->irq;

Do you _really_ need this if you have 'axp20x->i2c_client->irq'?

> +	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> +				  IRQF_ONESHOT | IRQF_SHARED, -1,
> +				  &axp20x_regmap_irq_chip,
> +				  &axp20x->regmap_irqc);
> +	if (ret) {
> +		dev_err(&i2c->dev, "failed to add irq chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mfd_add_devices(axp20x->dev, -1, axp20x_cells,
> +			      ARRAY_SIZE(axp20x_cells), NULL, 0, NULL);
> +
> +	if (ret) {
> +		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
> +		goto mfd_err;
> +	}
> +
> +	if (!pm_power_off) {
> +		axp20x_pm_power_off = axp20x;
> +		pm_power_off = axp20x_power_off;
> +	}
> +
> +	dev_info(&i2c->dev, "AXP20X driver loaded\n");
> +
> +	return 0;
> +
> +mfd_err:
> +	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
> +
> +	return ret;

I'd say the goto is pointless if you're only using it once.

Instead move regmap_del_irq_chip() into mfd_add_devices()'s error
handler and return straight from there.

[...]

> +static const struct i2c_device_id axp20x_i2c_id[] = {
> +	{ "axp202", AXP202_ID },
> +	{ "axp209", AXP209_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);

Isn't this redundant now that you're using of_id?

[...]

> +#ifndef __LINUX_MFD_AXP20X_H
> +#define __LINUX_MFD_AXP20X_H
> +
> +#define AXP202_ID			0
> +#define AXP209_ID			1

enum?

[...] 

> +struct axp20x_dev {
> +	struct device			*dev;
> +	struct i2c_client		*i2c_client;
> +	struct regmap			*regmap;
> +	struct regmap_irq_chip_data	*regmap_irqc;
> +	int				variant;
> +	int				irq;

i2c_client->irq?

> +};
> +
> +#endif /* __LINUX_MFD_AXP20X_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
