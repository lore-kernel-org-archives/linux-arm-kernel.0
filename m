From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Nov 2018 09:45:39 -0800
Subject: [PATCH 3/3] regulator: mcp16502: add regulator driver for MCP16502
In-Reply-To: <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <20181113174539.GB2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 11:29:41AM +0000, Andrei.Stefanescu at microchip.com wrote:

> index 0000000..29c72d3
> --- /dev/null
> +++ b/drivers/regulator/mcp16502.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MCP16502 PMIC driver

Please make the entire comment a C++ comment so it looks more
intentional.

> +/*
> + * This macro is useful for iterating over all regulators and accessing their
> + * registers in a generic way or accessing a regulator device by its id.
> + */
> +#define BASE(i) (((i) + 1) << 4)

This macro name is likely to run into collisions@some point, a prefix
would be better.

> +static int mcp16502_update_regulator(struct regulator_dev *rdev,
> +				     bool hibernate,
> +				     unsigned int mask, unsigned int val)
> +{
> +	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
> +	unsigned int reg = BASE(rdev_get_id(rdev));
> +
> +	reg += (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;

Please write this as a normal if statement to improve legibility.

> +static int mcp16502_read(struct regulator_dev *rdev, bool hibernate,
> +			 unsigned int mask)
> +{
> +	struct mcp16502 *mcp = rdev_get_drvdata(rdev);
> +	unsigned int reg = BASE(rdev_get_id(rdev));
> +	int ret, val;
> +
> +	reg += (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
> +
> +	ret = regmap_read(mcp->rmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return val & mask;
> +}

I'm not convinced that these custom read/write functions are adding much
compared to just using the standard regmap helpers for things - they're
adding a bunch of code instead of data.  If you need extra helpers for
suspend mode just add those, I'm sure they'd be useful for other
drivers.

> +static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
> +{
> +	int val;
> +
> +	val = mcp16502_read(rdev, false, MCP16502_MODE_MASK);
> +	if (val < 0)
> +		return val;
> +
> +	if (val == MCP16502_MODE_FPWM)
> +		return REGULATOR_MODE_NORMAL;
> +	else if (val == MCP16502_MODE_AUTO_PFM)
> +		return REGULATOR_MODE_IDLE;
> +
> +	return REGULATOR_MODE_INVALID;
> +}

Please just write a switch statement to improve legibility.

> +/*
> + * mcp16502_is_enabled - regulator_ops is_enabled
> + */
> +static int mcp16502_is_enabled(struct regulator_dev *rdev)
> +{
> +	int val;
> +
> +	val = mcp16502_read(rdev, false, MCP16502_EN_MASK);
> +	if (val < 0)
> +		return val;
> +
> +	return !!val;
> +}

This can use regulator_is_enabled_regmap().  

> +	if (mode != REGULATOR_MODE_NORMAL && mode != REGULATOR_MODE_IDLE)
> +		return -EINVAL;
> +
> +	val = (mode == REGULATOR_MODE_NORMAL) ? MCP16502_MODE_FPWM :
> +						MCP16502_MODE_AUTO_PFM;
> +
> +	return mcp16502_update_regulator(rdev, hibernate, MCP16502_MODE_MASK,
> +					 val);

Again a switch statement would be clearer.

> +static int mcp16502_get_status(struct regulator_dev *rdev)
> +{
> +	int mode = mcp16502_get_mode(rdev);
> +
> +	if (!mcp16502_is_enabled(rdev))
> +		return REGULATOR_STATUS_OFF;
> +	else if (mode == REGULATOR_MODE_NORMAL)
> +		return REGULATOR_STATUS_NORMAL;
> +	else if (mode == REGULATOR_MODE_IDLE)
> +		return REGULATOR_STATUS_IDLE;
> +
> +	return REGULATOR_STATUS_UNDEFINED;
> +}

The _status() function should only be implemented if there's hardware
support for reading back the actual status from the device, we already
know what we set through software.

> +#ifdef CONFIG_PM_SLEEP
> +static int mcp16502_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mcp16502 *mcp = i2c_get_clientdata(client);
> +
> +	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_HIB);
> +
> +	return 0;
> +}

This will put the regulators into hibernate mode before the system has
finished suspending which is likely to cause breakage - hibernate mode
in the PMIC is expected to be triggered by the SoC as it shuts down.

> +static int __init mcp16502_init(void)
> +{
> +	return i2c_add_driver(&mcp16502_drv);
> +}

module_i2c_driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/fc30dea7/attachment.sig>
