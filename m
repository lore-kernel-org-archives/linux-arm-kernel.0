From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 27 Jan 2016 09:05:26 +0100
Subject: [PATCH v8 1/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD
 driver
In-Reply-To: <1453861685-30924-2-git-send-email-wenyou.yang@atmel.com> (Wenyou
 Yang's message of "Wed, 27 Jan 2016 10:28:04 +0800")
References: <1453861685-30924-1-git-send-email-wenyou.yang@atmel.com>
 <1453861685-30924-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <87pownphvd.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Wenyou" == Wenyou Yang <wenyou.yang@atmel.com> writes:

 > This patch adds support for the Active-semi ACT8945A PMIC.
 > It is a Multi Function Device with the following subdevices:
 >  - Regulator
 >  - Charger

 > It is interfaced to the host controller using I2C interface,
 > ACT8945A is a child device of the I2C.

 > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
 > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks, looks good - One more thing though:

 > +
 > +struct act8945a_dev {
 > +	struct regmap *regmap;
 > +};

You don't need this structure as you used devm. With that removed (and
the logic to devm_kzalloc it) you can add my:

Acked-by: Peter Korsgaard <peter@korsgaard.com>


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
 > +	struct act8945a_dev *act8945a;
 > +	int ret;
 > +
 > +	act8945a = devm_kzalloc(&i2c->dev, sizeof(*act8945a), GFP_KERNEL);
 > +	if (!act8945a)
 > +		return -ENOMEM;
 > +
 > +	i2c_set_clientdata(i2c, act8945a);
 > +
 > +	act8945a->regmap = devm_regmap_init_i2c(i2c, &act8945a_regmap_config);
 > +	if (IS_ERR(act8945a->regmap)) {
 > +		ret = PTR_ERR(act8945a->regmap);
 > +		dev_err(&i2c->dev, "regmap init failed: %d\n", ret);
 > +		return ret;
 > +	}
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
 > -- 
 > 1.7.9.5



-- 
Bye, Peter Korsgaard
