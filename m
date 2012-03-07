From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Mar 2012 15:42:55 -0700
Subject: [PATCH 4/4] ARM: u300: configure some pins as an example
In-Reply-To: <1331071547-25109-1-git-send-email-linus.walleij@stericsson.com>
References: <1331071547-25109-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F57E46F.6050505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 03:05 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> To show how the pin configuration is used on the U300, let's
> include some configs for two GPIO pins.

> -/* Pinmux settings */
> +static unsigned long g0d_conf[] = {
> +	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
> +};
> +
> +static unsigned long g1d_conf[] = {
> +	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
> +};
> +
> +static unsigned long g0i_conf[] = {
> +	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
> +};
> +
> +static unsigned long g1i_conf[] = {
> +	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
> +};

Those are all the same, so you could just point all the mapping tables
at the same config param array.

> +
> +/* Pin control settings */
>  static struct pinctrl_map __initdata u300_pinmux_map[] = {
>  	/* anonymous maps for chip power and EMIFs */
>  	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-u300", NULL, "power"),
> @@ -1615,6 +1632,11 @@ static struct pinctrl_map __initdata u300_pinmux_map[] = {
>  	PIN_MAP_MUX_GROUP_DEFAULT("mmci",  "pinctrl-u300", NULL, "mmc0"),
>  	PIN_MAP_MUX_GROUP_DEFAULT("pl022", "pinctrl-u300", NULL, "spi0"),
>  	PIN_MAP_MUX_GROUP_DEFAULT("uart0", "pinctrl-u300", NULL, "uart0"),
> +	/* some pin configurations */
> +	PIN_MAP_CONFIGS_PIN_DEFAULT("mmci", "pinctrl-u300", "GPIO0", g0d_conf),
> +	PIN_MAP_CONFIGS_PIN_DEFAULT("mmci", "pinctrl-u300", "GPIO1", g1d_conf),
> +	PIN_MAP_CONFIGS_PIN("mmci", "idle", "pinctrl-u300", "GPIO0", g0i_conf),
> +	PIN_MAP_CONFIGS_PIN("mmci", "idle", "pinctrl-u300", "GPIO1", g1i_conf),
>  };

I'd assume though that the default and idle state should have different
pin configurations?

(and if this was stacked on top of your other patch, you could use
PINCTRL_STATE_IDLE instead of "idle" for the last two entries)
