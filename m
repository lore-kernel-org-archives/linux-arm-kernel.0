From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 3 Oct 2012 17:43:10 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for Network Space v2 and
 parents
In-Reply-To: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
References: <1349277270-24962-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20121003154310.GI11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 05:14:30PM +0200, Simon Guinot wrote:
> This patch adds DT board setup for LaCie Network Space v2 and parents,
> based the Marvell Kirkwood 6281 SoC. This includes Network Space (Max)
> v2 and Internet Space v2.

Hi Simon

At a first look, this looks good. Also nice to see you use the new
gpio-fan binding.

> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -96,6 +96,11 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("keymile,km_kirkwood"))
>  		km_kirkwood_init();
>  
> +	if (of_machine_is_compatible("lacie,inetspace_v2") ||
> +	    of_machine_is_compatible("lacie,netspace_v2") ||
> +	    of_machine_is_compatible("lacie,netspace_max_v2"))
> +		ns2_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table,
>  			     kirkwood_auxdata_lookup, NULL);

I'm not a DT policy expert. Could this be one compatibility string for
all the boards? Maybe ask on the DT mainline list?

> +#define NETSPACE_V2_GPIO_BLUE_LED_SLOW	29
> +#define NETSPACE_V2_GPIO_BLUE_LED_CMD	30
> +
> +static struct ns2_led ns2_led_pins[] = {
> +	{
> +		.name	= "ns_v2:blue:sata",
> +		.cmd	= NETSPACE_V2_GPIO_BLUE_LED_CMD,
> +		.slow	= NETSPACE_V2_GPIO_BLUE_LED_SLOW,
> +	},
> +};
> +
> +static struct ns2_led_platform_data ns2_leds_data = {
> +	.num_leds	= ARRAY_SIZE(ns2_led_pins),
> +	.leds		= ns2_led_pins,
> +};
> +
> +static struct platform_device ns2_leds = {
> +	.name		= "leds-ns2",
> +	.id		= -1,
> +	.dev		= {
> +		.platform_data	= &ns2_leds_data,
> +	},
> +};

Have you thought about adding a DT binding for this driver?

It would be nice if you could respin the patches for -rc1, when it
comes out. There are changes to Makefile.boot at least required.

Thanks
	Andrew
