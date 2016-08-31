From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:56:23 +0200
Subject: [PATCH v8 07/11] power: act8945a_charger: Add capacity level
 property
In-Reply-To: <1472109599-21915-8-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-8-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831145622.a5pmhddb5fqpzy5z@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:19:55PM +0800, Wenyou Yang wrote:
> Add the power supply capacity level property, it corresponds to
> POWER_SUPPLY_CAPACITY_LEVEL_*.
> 
> It also utilizes the precision voltage detector function module
> to catch the low battery voltage.

[...]

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..a983de2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -77,7 +77,7 @@ config BATTERY_88PM860X
>  
>  config BATTERY_ACT8945A
>  	tristate "Active-semi ACT8945A charger driver"
> -	depends on MFD_ACT8945A || COMPILE_TEST
> +	depends on MFD_ACT8945A || GPIOLIB || COMPILE_TEST

This looks wrong. You probably wanted (MFD_ACT8945A && GPIOLIB).
But since the gpio consumer headers defines stubs for the !GPIOLIB
case just drop the dependency.

>  	help
>  	  Say Y here to enable support for power supply provided by
>  	  Active-semi ActivePath ACT8945A charger.

[...]

> +	charger->lbo_gpio = devm_gpiod_get(dev, "active-semi,lbo", GPIOD_IN);
> +	if (PTR_ERR(charger->lbo_gpio) == -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"lbo\"\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(charger->lbo_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"lbo\"\n");
> +		charger->lbo_gpio = NULL;
> +	}

Please use devm_gpiod_get_optional():

charger->lbo_gpio = devm_gpiod_get_optional(dev, "active-semi,lbo", GPIOD_IN);
if (IS_ERR(charger->lbo_gpio)) {
    err = PTR_ERR(charger->lbo_gpio)
    dev_err(dev, "unable to claim gpio \"lbo\": %ld\n", err);
    return err;
}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/c9e51b66/attachment.sig>
