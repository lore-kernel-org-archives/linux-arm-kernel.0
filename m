From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 19:27:57 +0100
Subject: [PATCH 1/2] mfd: Add support for MAX77686.
In-Reply-To: <1336580695-1184-2-git-send-email-yadi.brar@samsung.com>
References: <1336580695-1184-1-git-send-email-yadi.brar@samsung.com>
 <1336580695-1184-2-git-send-email-yadi.brar@samsung.com>
Message-ID: <20120509182757.GB32037@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 09:54:54PM +0530, Yadwinder Singh wrote:

> +int max77686_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(i2c, reg);
> +	if (ret < 0)

It would really be better if this used the regmap API - the regulator
API is starting to build out functionality on top of regmap which this
won't be able to take advantage of if it doesn't use regmap.

> +	if (of_get_property(dev->of_node, "max77686,wakeup", NULL))
> +		pd->wakeup = true;

You haven't included any binding documentatiojn for the device tree
bindings - you should do this.

> +	max77686 = kzalloc(sizeof(struct max77686_dev), GFP_KERNEL);
> +	if (max77686 == NULL) {
> +		dev_err(max77686->dev, "could not allocate memory\n");
> +		return -ENOMEM;
> +	}

devm_kzalloc().

> +	device_init_wakeup(max77686->dev, max77686->wakeup);

Why is this not just done unconditionally?  There's sysfs files to allow
userspace control.

> +	if (max77686_read_reg(i2c, MAX77686_REG_DEVICE_ID, &data) < 0) {
> +		ret = -EIO;
> +		dbg_info("%s : device not found on this channel\n", __func__);
> +		goto err_mfd;
> +	} else
> +		dev_info(max77686->dev, "device found\n");

You should verify that the device ID you read back is the expected one.

> +	dev_err(max77686->dev, "device probe failed : %d\n", ret);

Driver core should do this for you.
