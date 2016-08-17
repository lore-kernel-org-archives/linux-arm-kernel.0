From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 17 Aug 2016 13:31:41 +0200
Subject: [PATCH v5 1/7] power: act8945a_charger: Remove
 "battery_temperature"
In-Reply-To: <1471337998-6467-2-git-send-email-wenyou.yang@atmel.com>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
 <1471337998-6467-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160817113141.cshwjvpuwcj2hk5k@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 16, 2016 at 04:59:52PM +0800, Wenyou Yang wrote:
> [...]
>
> -static int act8945a_get_battery_health(struct act8945a_charger *charger,
> -				       struct regmap *regmap, int *val)
> +static int act8945a_get_battery_health(struct regmap *regmap, int *val)
>  {
>  	int ret;
>  	unsigned int status;
> @@ -148,7 +146,7 @@ static int act8945a_get_battery_health(struct act8945a_charger *charger,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (charger->battery_temperature && !(status & APCH_STATUS_TEMPDAT))
> +	if (status & APCH_STATUS_TEMPDAT)

This incorrectly inverts the logic.

>  		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
>  	else if (!(status & APCH_STATUS_INDAT))
>  		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> @@ -188,8 +186,7 @@ static int act8945a_charger_get_property(struct power_supply *psy,
>  		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		ret = act8945a_get_battery_health(charger,
> -						  regmap, &val->intval);
> +		ret = act8945a_get_battery_health(regmap, &val->intval);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval = act8945a_charger_model;
> @@ -235,9 +232,6 @@ static int act8945a_charger_config(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	charger->battery_temperature = of_property_read_bool(np,
> -				"active-semi,check-battery-temperature");
> -
>  	chglev_pin = of_get_named_gpio_flags(np,
>  				"active-semi,chglev-gpios", 0, &flags);

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160817/948749d5/attachment.sig>
