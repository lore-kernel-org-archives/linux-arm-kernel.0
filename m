From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 17 Jan 2017 04:46:01 +0100
Subject: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
Message-ID: <20170117034601.wevqblqiwrerpmal@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

Just a couple of small things in this patch.

On Mon, Jan 02, 2017 at 05:37:17PM +0100, Quentin Schulz wrote:
> [...]
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
> +				  &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
> +			chan = axp20x_batt->batt_chrg_i;
> +		else
> +			chan = axp20x_batt->batt_dischrg_i;
> +
> +		ret = iio_read_channel_processed(chan, &val->intval);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives ?V.
> +		 */

Nit: Volt -> Ampere

> +		val->intval *= 1000;
> +		break;
>
> [...]
>
> +static int axp20x_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +	struct axp20x_batt_ps *axp20x_batt;
> +	struct power_supply_config psy_cfg = {};
> +
> +	axp20x_batt = devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
> +				   GFP_KERNEL);
> +	if (!axp20x_batt)
> +		return -ENOMEM;
> +
> +	axp20x_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
> +	if (IS_ERR(axp20x_batt->batt_v)) {
> +		if (PTR_ERR(axp20x_batt->batt_v) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_v);
> +	}
> +
> +	axp20x_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
> +							"batt_chrg_i");
> +	if (IS_ERR(axp20x_batt->batt_chrg_i)) {
> +		if (PTR_ERR(axp20x_batt->batt_chrg_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_chrg_i);
> +	}
> +
> +	axp20x_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
> +							   "batt_dischrg_i");
> +	if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
> +		if (PTR_ERR(axp20x_batt->batt_dischrg_i) == -ENODEV)
> +			return -EPROBE_DEFER;
> +		return PTR_ERR(axp20x_batt->batt_dischrg_i);
> +	}
> +
> +	axp20x_batt->regmap = axp20x->regmap;
> +	platform_set_drvdata(pdev, axp20x_batt);

Please use drv_get_regmap(pdev->dev.parent, NULL) instead (and drop
axp20x).

> +	psy_cfg.drv_data = axp20x_batt;
> +	psy_cfg.of_node = pdev->dev.of_node;
> +
> +	axp20x_batt->axp_id = (int)of_device_get_match_data(&pdev->dev);

use (uintptr_t) to avoid compiler warnings on systems with sizeof
int != sizeof ptr.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/a8f71c66/attachment.sig>
