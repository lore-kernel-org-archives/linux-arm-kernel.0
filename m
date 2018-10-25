From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 10:33:55 +0100
Subject: [PATCH v5 1/5] mfd: rk808: Add RK817 and RK809 support
In-Reply-To: <1540294467-25813-2-git-send-email-tony.xie@rock-chips.com>
References: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
 <1540294467-25813-2-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20181025093355.GN4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018, Tony Xie wrote:

>     The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>     and handheld devices. It contains the following components:
> 
>         - Regulators
>         - RTC
>         - Clocking
> 
>     Both RK809 and RK817 chips are using a similar register map,
>     so we can reuse the RTC and Clocking and regulators functionality.

What's with the odd tabbing at the start of every line?

> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/mfd/Kconfig       |   6 +-
>  drivers/mfd/rk808.c       | 225 +++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/rk808.h | 172 +++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h    |   6 ++
>  4 files changed, 392 insertions(+), 17 deletions(-)

[...]

> +static struct resource rk817_rtc_resources[] = {
> +	{
> +		.start  = RK817_IRQ_RTC_ALARM,
> +		.end    = RK817_IRQ_RTC_ALARM,
> +		.flags  = IORESOURCE_IRQ,
> +	}
> +};

There are MACROs for these.  Please consider converting to them.

You don't need to do that for *this* patch though.

[...]

>  static const struct regmap_irq_chip rk818_irq_chip = {
>  	.name = "rk818",
>  	.irqs = rk818_irqs,
> @@ -376,7 +489,7 @@ static void rk805_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk805, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

Nit: "cannot"

>  		return;
>  	}
>  
> @@ -394,7 +507,7 @@ static void rk808_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk808, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

As above (and below).

>  		return;
>  	}
>  
> @@ -412,7 +525,7 @@ static void rk818_device_shutdown(void)
>  
>  	if (!rk808) {
>  		dev_warn(&rk808_i2c_client->dev,
> -			 "have no rk818, so do nothing here\n");
> +			 "can not get the driver data of rk808!\n");

"RK808" in all prints and comments.

>  		return;
>  	}
>  
> @@ -423,9 +536,39 @@ static void rk818_device_shutdown(void)
>  		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>  }
>  
> +static void rk8xx_syscore_shutdown(void)
> +{
> +	int ret;
> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
> +
> +	if (!rk808) {
> +		dev_warn(&rk808_i2c_client->dev,
> +			 "can not get the driver data of rk808!\n");
> +		return;
> +	}
> +
> +	if (system_state == SYSTEM_POWER_OFF &&
> +	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
> +		ret = regmap_update_bits(rk808->regmap,
> +					 RK817_SYS_CFG(3),
> +					 RK817_SLPPIN_FUNC_MSK,
> +					 SLPPIN_DN_FUN);
> +		if (ret) {
> +			dev_warn(&rk808_i2c_client->dev,
> +				 "the retset pin can not switch to power down function\n");

Spellcheck.

[...]

> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4f38068..a468b81 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -1047,6 +1047,12 @@ struct regmap_irq {
>  #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
>  	[_irq] = { .reg_offset = (_off), .mask = (_mask) }
>  
> +#define REGMAP_IRQ_REG_LINE(_id, _reg_bits) \
> +	[_id] = {				\
> +		.mask = BIT((_id) % (_reg_bits)),	\
> +		.reg_offset = (_id) / (_reg_bits),	\
> +	}
> +
>  /**
>   * struct regmap_irq_chip - Description of a generic regmap irq_chip.
>   *

This needs to be a separate patch.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
