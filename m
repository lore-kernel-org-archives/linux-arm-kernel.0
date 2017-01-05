From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:02:24 +0100
Subject: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
Message-ID: <20170105170224.wq45m3pg6sjnuhyh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 05:37:17PM +0100, Quentin Schulz wrote:
> +		/*
> +		 * IIO framework gives mV but Power Supply framework gives ?V.
> +		 */
> +		val->intval *= 1000;

s/gives/wants/ ?

> +static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +					  int val)
> +{
> +	switch (val) {
> +	case 4100000:
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_1V);
> +	case 4150000:
> +		if (axp20x_batt->axp_id == AXP221_ID)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_15V);
> +	case 4200000:
> +		return regmap_update_bits(axp20x_batt->regmap,
> +					  AXP20X_CHRG_CTRL1,
> +					  AXP20X_CHRG_CTRL1_TGT_VOLT,
> +					  AXP20X_CHRG_CTRL1_TGT_4_2V);
> +	default:
> +		/*
> +		 * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
> +		 * can be set to 4.22V and 4.24V, but these voltages are too
> +		 * high for Lithium based batteries (AXP PMICs are supposed to
> +		 * be used with these kinds of battery).
> +		 */
> +		return -EINVAL;
> +	}

Since all your calls to regmap are the same, something like:

case 4100000:
	val = AXP20X_CHRG_CTRL1_TGT_4_1V;
	break;

case 4150000:
	val = AXP20X_CHRG_CTRL1_TGT_4_15V;
	break;

regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
		   AXP20X_CHRG_CTRL1_TGT_VOLT, val);


It would also get rid of your warnings in checkpatch.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/e854f1cc/attachment.sig>
