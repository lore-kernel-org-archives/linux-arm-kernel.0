From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jun 2012 14:00:34 +0000
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
In-Reply-To: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
References: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
Message-ID: <201206191400.35410.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 June 2012, Josh Coombs wrote:

> +static struct mv643xx_eth_platform_data goflexnet_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +static struct mv_sata_platform_data goflexnet_sata_data = {
> +	.n_ports	= 2,
> +};
>

It should not be too hard to let these ones be probed through DT,
so if nobody has done this yet, maybe you can provide the patches
to let mv_sata be probed based on a compatible property and
read the number of ports from a new DT property, as well as 
use of_phy_connect() to find the right PHY from the "phy-handle"
property.

> +static struct gpio_led goflexnet_led_pins[] = {
> +	{
> +		.name			= "status:green:health",
> +		.default_trigger	= "default-on",
> +		.gpio			= 46, // 0x4000
> +		.active_low		= 1,
> +	},
> +	{
> +		.name			= "status:orange:fault",
> +		.default_trigger	= "none",
> +		.gpio			= 47, // 0x8000
> +		.active_low		= 1,
> +	},
...
> +};
> +
> +static struct gpio_led_platform_data goflexnet_led_data = {
> +	.leds		= goflexnet_led_pins,
> +	.num_leds	= ARRAY_SIZE(goflexnet_led_pins),
> +};
> +
> +static struct platform_device goflexnet_leds = {
> +	.name	= "leds-gpio",
> +	.id	= -1,
> +	.dev	= {
> +		.platform_data	= &goflexnet_led_data,
> +	}
> +};

I believe we have gpio DT support in kirkwood now, so these
can both go away and get replaced with DT descriptions.

	Arnd
