From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 25 Nov 2016 10:48:18 +0100
Subject: [PATCH 02/10] power: supply: axp20x_usb_power: set min voltage
 and max current from sysfs
In-Reply-To: <20161125090921.23138-3-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-3-quentin.schulz@free-electrons.com>
Message-ID: <20161125104818.597c0718@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quentin,

On Fri, 25 Nov 2016 10:09:13 +0100, Quentin Schulz wrote:

> +static int axp20x_usb_power_set_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +	int ret, val1;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		switch (val->intval) {

This nested switch construct doesn't look very pretty. What about
instead:

	switch(psp) {
	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
		return axp20x_usb_power_set_prop_voltage_min(...);
	case POWER_SUPPLY_PROP_CURRENT_MAX:
		return axp20x_usb_power_set_prop_current_max(...);
	default:
		return -EINVAL;
	}

> +		case 4000000:
> +		case 4100000:
> +		case 4200000:
> +		case 4300000:
> +		case 4400000:
> +		case 4500000:
> +		case 4600000:
> +		case 4700000:
> +			val1 = (val->intval - 4000000) / 100000;
> +			ret = regmap_update_bits(power->regmap,
> +						 AXP20X_VBUS_IPSOUT_MGMT,
> +						 AXP20X_VBUS_VHOLD_MASK,
> +						 val1 << 3);
> +			if (ret)
> +				return ret;
> +
> +			return 0;

Just do:

			return regmap_update_bits(...);

The dance to test ret is useless, since you anyway return ret when
non-zero, or return zero when ret was zero.

While you're at it, maybe make val1 a u32, since I guess it's written
to a 32-bit register (unless u32 is not commonly used in this driver
already, of course).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
