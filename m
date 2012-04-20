From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Apr 2012 12:42:01 +0100
Subject: [PATCH 2/2] regulator: Add Freescale's MC34708 regulators
In-Reply-To: <1334853521-23792-2-git-send-email-paul.liu@linaro.org>
References: <1334853521-23792-1-git-send-email-paul.liu@linaro.org>
 <1334853521-23792-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120420114201.GA3259@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 12:38:41AM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +static const int mc34708_sw1A[] = {
> +	650000, 662500, 675000, 687500, 700000, 712500,

Replace these by direct calculations, using tables is both less
efficient and less clear.

> +	mc34708_lock(priv->mc34708);
> +	ret = mc34708_reg_rmw(priv->mc34708, mc34708_regulators[id].reg,
> +			      mc34708_regulators[id].enable_bit,
> +			      mc34708_regulators[id].enable_bit);
> +	mc34708_unlock(priv->mc34708);

Having to open code this locking in every single driver is a bit
painful; just have the default register I/O operations do the locking
and introduce additional unlocked versions if needed.

All this stuff could be factored out if you were using regmap.

> +EXPORT_SYMBOL_GPL(mc34708_regulator_list_voltage);

No, this stuff should only be accessed via the ops.  Why are you doing
this?

> +int
> +mc34708_get_best_voltage_index(struct regulator_dev *rdev,
> +			       int min_uV, int max_uV)
> +{

You're reimplementing core functionality here, or it'd be even better to
use calculations.

> +static int mc34708_regulator_get_voltage(struct regulator_dev *rdev)
> +{

Why is this not get_voltage_sel?

> +static struct regulator_ops mc34708_regulator_ops = {
> +	.enable = mc34708_regulator_enable,
> +	.disable = mc34708_regulator_disable,
> +	.is_enabled = mc34708_regulator_is_enabled,
> +	.list_voltage = mc34708_regulator_list_voltage,
> +	.set_voltage = mc34708_regulator_set_voltage,
> +	.get_voltage = mc34708_regulator_get_voltage,
> +};
> +EXPORT_SYMBOL_GPL(mc34708_regulator_ops);

No.  What are you doing this for?

> +int
> +mc34708_fixed_regulator_set_voltage(struct regulator_dev *rdev, int min_uV,
> +				    int max_uV, unsigned *selector)

This function makes no sense...

> +int mc34708_sw_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	return 1;
> +}

Why are you doing this - this function is redundant.

> +	ret = mc34708_reg_rmw(mc34708, MC34708_SW12OP,
> +			      MC34708_SW12OP_SW1AMODE_M |
> +			      MC34708_SW12OP_SW2MODE_M,
> +			      MC34708_SW12OP_SW1AMODE_VALUE |
> +			      MC34708_SW12OP_SW2MODE_VALUE);
> +	if (ret)
> +		goto err_free;
> +
> +	ret = mc34708_reg_rmw(mc34708, MC34708_SW345OP,
> +			      MC34708_SW345OP_SW3MODE_M |
> +			      MC34708_SW345OP_SW4AMODE_M |
> +			      MC34708_SW345OP_SW4BMODE_M |
> +			      MC34708_SW345OP_SW5MODE_M,
> +			      MC34708_SW345OP_SW3MODE_VALUE |
> +			      MC34708_SW345OP_SW4AMODE_VALUE |
> +			      MC34708_SW345OP_SW4BMODE_VALUE |
> +			      MC34708_SW345OP_SW5MODE_VALUE);
> +	if (ret)
> +		goto err_free;

If this needs to be done unconditionally shouldn't it be being donei in
the MFD core driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/5db8aecc/attachment-0001.sig>
