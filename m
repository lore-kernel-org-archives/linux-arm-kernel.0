From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Feb 2014 13:29:51 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <1391516352-32359-4-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
Message-ID: <20140204132951.GE13529@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add a driver for the BCM59056 PMU multi-function device. The driver
> initially supports regmap initialization and instantiation of the
> voltage regulator device function of the PMU.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> ---
>  drivers/mfd/Kconfig          |   8 +++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/bcm59056.c       | 119 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/bcm59056.h |  35 +++++++++++++
>  4 files changed, 163 insertions(+)
>  create mode 100644 drivers/mfd/bcm59056.c
>  create mode 100644 include/linux/mfd/bcm59056.h

<snip>

> +static struct mfd_cell bcm59056s[] = {
> +	{
> +		.name = "bcm59056-pmu",

If you plan to use *->of_node in the PMU driver, which it looks like
you do, you should set the compatible string here.

> +	},
> +};
> +
> +static const struct regmap_config bcm59056_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= BCM59056_MAX_REGISTER - 1,

If you've just set this manually i.e. it's not part of an enum table,
can't you set it a value you don't need to do math on? It's not used
anywhere else is it?

> +	.cache_type	= REGCACHE_RBTREE,
> +};
> +
> +static int bcm59056_i2c_probe(struct i2c_client *i2c,
> +			      const struct i2c_device_id *id)
> +{
> +	struct bcm59056 *bcm59056;
> +	int chip_id = id->driver_data;

I thought this was a DT only driver? If so, you probably want to use
of_match_device() instead.

> +	int ret = 0;
> +
> +	bcm59056 = devm_kzalloc(&i2c->dev, sizeof(*bcm59056), GFP_KERNEL);
> +	if (!bcm59056)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, bcm59056);
> +	bcm59056->dev = &i2c->dev;
> +	bcm59056->i2c_client = i2c;
> +	bcm59056->id = chip_id;
> +
> +	bcm59056->regmap = devm_regmap_init_i2c(i2c, &bcm59056_regmap_config);
> +	if (IS_ERR(bcm59056->regmap)) {
> +		ret = PTR_ERR(bcm59056->regmap);
> +		dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mfd_add_devices(bcm59056->dev, -1,
> +			      bcm59056s, ARRAY_SIZE(bcm59056s),
> +			      NULL, 0, NULL);

Are you sure you need all of your #includes?

I notice that irqdomain is there, but you don't actually have one?

> +	if (ret < 0)
> +		dev_err(&i2c->dev, "mfd_add_devices failed: %d\n", ret);

What if we change the name of the function? Probably better to say
something like "device registration failed" or thelike.

> +	return ret;
> +}
> +
> +static int bcm59056_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct bcm59056 *bcm59056 = i2c_get_clientdata(i2c);
> +
> +	mfd_remove_devices(bcm59056->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcm59056_of_match[] = {
> +	{ .compatible = "brcm,bcm59056", .data = (void *)BCM59056 },

You've gone to the trouble of setting a device version here, but you
don't seem to use it?

> +	{ }
> +};
> +
> +static const struct i2c_device_id bcm59056_i2c_id[] = {
> +	{ "bcm59056", BCM59056 },
> +	{ }
> +};

Ah, I guess this is where id->driver comes from.

It's pretty silly that the I2C subsystem demands the presence of this
table, despite not using it if an of_device_id table is present.

> +MODULE_DEVICE_TABLE(i2c, bcm59056_i2c_id);
> +
> +static struct i2c_driver bcm59056_i2c_driver = {
> +	.driver = {
> +		   .name = "bcm59056",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = of_match_ptr(bcm59056_of_match),

No need to use of_match_ptr() here.

> +	},
> +	.probe = bcm59056_i2c_probe,
> +	.remove = bcm59056_i2c_remove,
> +	.id_table = bcm59056_i2c_id,

*grumble*

> +};
> +
> +static int __init bcm59056_init(void)
> +{
> +	return i2c_add_driver(&bcm59056_i2c_driver);
> +}
> +subsys_initcall(bcm59056_init);

Really? :(

Maybe you'll want to comment this, in case people do not know the back
ground and attempts to clean it up.

> +static void __exit bcm59056_exit(void)
> +{
> +	i2c_del_driver(&bcm59056_i2c_driver);
> +}
> +module_exit(bcm59056_exit);

<snip>

> +/* chip id */
> +#define BCM59056		0

Lonely, oh so lonely!

> +/* max register address */
> +#define BCM59056_MAX_REGISTER	0xe8

Don't you have a table of registers which you care about?

> +/* bcm59056 chip access */

Superfluous comment? Don't we all know what these containers do?

> +struct bcm59056 {
> +	struct device *dev;
> +	struct i2c_client *i2c_client;
> +	struct regmap *regmap;
> +	unsigned int id;
> +};
> +
> +#endif /*  __LINUX_MFD_BCM59056_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
