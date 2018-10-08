From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 8 Oct 2018 09:44:09 +0200
Subject: [PATCH v2 6/6] power: supply: add AC power supply driver for
 AXP813
In-Reply-To: <20181006211836.28253-7-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-7-oskari@lemmela.net>
Message-ID: <20181008074409.5g73zrfm6nbn6vpp@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:36AM +0300, Oskari Lemmela wrote:
> AXP813 and AXP803 PMICs can control input current and
> minimum voltage.
> 
> Both of these values are configurable.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 92 ++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> index 0771f951b11f..92a92354f6f0 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,16 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
>  
> +#define AXP813_VHOLD_MASK		GENMASK(5, 3)
> +#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
> +#define AXP813_VHOLD_REG_TO_UV(x)	\
> +	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
> +
> +#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
> +#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
> +#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
> +	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
> +
>  #define DRVNAME "axp20x-ac-power-supply"
>  
>  struct axp20x_ac_power {
> @@ -102,6 +112,55 @@ static int axp20x_ac_power_get_property(struct power_supply *psy,
>  
>  		return 0;
>  
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = AXP813_VHOLD_REG_TO_UV(reg);
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval = AXP813_CURR_LIMIT_REG_TO_UA(reg);
> +
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axp20x_ac_power_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{

Argh, missed this one in the first version. Since you're introducing it
with the AXP813 and it isn't used with the AXP20X, I'd name it
axp813_ac_power_set_property. I'll let Maxime or Chen-Yu confirm though.

With the modification in the header from the previous patch in this
patch,

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/7bf32116/attachment.sig>
