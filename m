From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Dec 2009 14:30:16 +0000
Subject: [PATCH 4/4] regulator: add max8925 support
In-Reply-To: <771cded00912230139g23ea8554l866d55e16ae3ed58@mail.gmail.com>
References: <771cded00912210447jf040fd8s8da0e68db0c39c1a@mail.gmail.com>
	<1261418546.6971.343.camel@odin>
	<771cded00912230139g23ea8554l866d55e16ae3ed58@mail.gmail.com>
Message-ID: <20091223143016.GD14455@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 04:39:59AM -0500, Haojian Zhuang wrote:

> +#define MAX8925_REGULATOR_DRIVER(_name)				\
> +{								\
> +	.driver		= {					\
> +		.name	= "max8925-" #_name,			\
> +		.owner	= THIS_MODULE,				\
> +	},							\
> +	.probe		= max8925_regulator_probe,		\
> +	.remove		= __devexit_p(max8925_regulator_remove),\
> +}
> +
> +static struct platform_driver max8925_regulator_driver[] = {
> +	MAX8925_REGULATOR_DRIVER(sd1),
> +	MAX8925_REGULATOR_DRIVER(sd2),
> +	MAX8925_REGULATOR_DRIVER(sd3),
> +	MAX8925_REGULATOR_DRIVER(ldo1),
> +	MAX8925_REGULATOR_DRIVER(ldo2),

Since these driver structures differ only in name there seems to be no
need to define more than one for the bucks and one for the LDOs - the
code in the driver doesn't actually seem to need it.  The .id field of
the driver structure can be set to give the device numbers.

> +}
> +module_init(max8925_regulator_init);

subsys_initcall()

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
> +MODULE_DESCRIPTION("Regulator Driver for Maxim 8925 PMIC");
> +MODULE_ALIAS("platform:max8925-regulator");

This MODULE_ALIAS won't actually work - the name doesn't match up with
the names of the drivers or the devices.
