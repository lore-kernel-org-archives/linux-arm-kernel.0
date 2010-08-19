From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Aug 2010 11:46:54 +0100
Subject: [PATCH] MAX8952 PMIC Driver Initial Release
In-Reply-To: <1282201515-11385-1-git-send-email-myungjoo.ham@samsung.com>
References: <1282201515-11385-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100819104654.GA23404@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 19, 2010 at 04:05:15PM +0900, MyungJoo Ham wrote:

> If MAX8952's EN is not going to be changed by this driver, the user
> should set gpio_en_writable as false. In S5PC210/UNIVERSL board,
> controlling EN pin at MAX8952 driver can be dangerous because this gpio
> pin is shared with another PMIC.

If you're including this sort of board specific comment in the driver
for a generic chip like a regulator it should be a bit of a warning sign
- 

> +static int max8952_i2c_read(struct i2c_client *client, u8 reg, u8 *dest)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret < 0)
> +		return -EIO;

If you've got an error code back you should return it directly rather
than replacing it with -EIO.

> +static int max8952_read_reg(struct max8952_data *max8952, u8 reg)
> +{
> +	u8 value = 0;
> +	int ret;
> +
> +	mutex_lock(&max8952->mutex);
> +	ret = max8952_i2c_read(max8952->client, reg, &value);
> +	mutex_unlock(&max8952->mutex);
> +	if (!ret)
> +		ret = value & 0xff;

I don't see any need for the lock here - you're doing simple SMBus
transactions which should already be atomic.  Locks are needed when
you're doing multiple transactions in your driver but that's not the
case at this level.

> +static int max8952_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
> +
> +	if (gpio_is_valid(max8952->pdata->gpio_en))
> +		return gpio_get_value(max8952->pdata->gpio_en);

You're not allowed to read the status of output GPIOs by the gpiolib
API, you need to remember what you set it to.

> +
> +	return -ENXIO;
> +}

If there's no GPIO I'd expect the driver to report that the regulator is
always enabled since the most likely configuration is that the enable is
latched high.  Otherwise users will get confused.

> +static int max8952_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
> +	u8 vid = 0;
> +
> +	if (gpio_is_valid(max8952->pdata->gpio_vid0) &&
> +			gpio_is_valid(max8952->pdata->gpio_vid1)) {
> +		if (gpio_get_value(max8952->pdata->gpio_vid0))
> +			vid += 1;
> +		if (gpio_get_value(max8952->pdata->gpio_vid1))
> +			vid += 2;

Again, you can't read GPIOs that you're using for output.

> +static int max8952_set_voltage(struct regulator_dev *rdev,
> +				int min_uV, int max_uV)
> +{
> +	struct max8952_data *max8952 = rdev_get_drvdata(rdev);
> +	u8 vid = -1, i;
> +
> +	for (i = 0; i < MAX8952_NUM_DVS_MODE; i++) {
> +		int volt = max8952_voltage(max8952, i);
> +
> +		/* Set the voltage as low as possible within the range */
> +		if ((volt <= max_uV) && (volt >= min_uV))
> +			if ((vid == -1) ||
> +					(max8952_voltage(max8952, vid) > volt))
> +				vid = i;

The indentation here is badly confused - the second branch of the or is
massively indented.

> +static int max8952_do_nothing(struct regulator_dev *rdev)
> +{
> +	return 0;
> +}

Why have you done this?

> +	.set_suspend_enable	= max8952_do_nothing,
> +	.set_suspend_disable	= max8952_disable,

If the chip has no explicit suspend mode control then remove these.

> +	pr_info("MAX8952 Probing...\n");

Remove this.

> +	if (pdata->gpio_en_writable == false) {
> +		max8952_ops.enable = NULL;
> +		max8952_ops.disable = NULL;
> +		max8952_ops.set_suspend_disable = max8952_do_nothing;
> +	}

This is going to break if you have more than one of these regulators in
the system.

> +	ret = IS_ERR(max8952->rdev);
> +	if (ret)
> +		dev_err(max8952->dev, "regulator init failed\n");

Print the error code too.

> +	} else {
> +		pr_err("MAX8952 Initilization Failed: Wrong GPIO setting.\n");
> +		return -EINVAL;

dev_err().

> +	max8952_write_reg(max8952, MAX8952_REG_SYNC,
> +			(max8952_read_reg(max8952, MAX8952_REG_SYNC) & 0x3F) |
> +			((pdata->sync_freq & 0x3) << 6));
> +	max8952_write_reg(max8952, MAX8952_REG_RAMP,
> +			(max8952_read_reg(max8952, MAX8952_REG_RAMP) & 0x1F) |
> +			((pdata->ramp_speed & 0x7) << 5));

This looks like it should be platform data.

> +	i2c_set_clientdata(client, NULL);

Not needed.

> +#ifdef CONFIG_REGULATOR_RESUME
> +/* becasue alway_power_on, add this feature,
> + * To do this at bootloader is better */
> +beforeresume_initcall(max8952_pmic_init);
> +#else
> +subsys_initcall(max8952_pmic_init);
> +#endif

There's no CONFIG_REGULATOR_RESUME in mainline.

> +struct max8952_platform_data {
> +	int gpio_vid0;
> +	int gpio_vid1;
> +	int gpio_en;
> +
> +	/*
> +	 * In C210 Universal Board, EN is connected to PWR_EN, which can also
> +	 * turn off the whole system. In such a case, disable en_writable.
> +	 */
> +	bool gpio_en_writable;

This should not be in the driver - any regulator could be used in a
fashion that's critical to system operation and the regulator API
always_on constraint will do this for you.
