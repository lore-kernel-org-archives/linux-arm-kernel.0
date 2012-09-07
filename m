From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 7 Sep 2012 23:23:31 +0200
Subject: [PATCH 2/2] ARM: kirkwood: Use devicetree to define DNS-32[05] fan
In-Reply-To: <1347035675-23907-3-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347035675-23907-3-git-send-email-jm@lentin.co.uk>
Message-ID: <20120907212331.GF21036@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
> index 4ab3506..e202a07 100644
> --- a/arch/arm/mach-kirkwood/board-dnskw.c
> +++ b/arch/arm/mach-kirkwood/board-dnskw.c
> @@ -67,29 +67,6 @@ static unsigned int dnskw_mpp_config[] __initdata = {
>  	0
>  };
>  
> -/* Fan: ADDA AD045HB-G73 40mm 6000rpm at 5v */
> -static struct gpio_fan_speed dnskw_fan_speed[] = {
> -	{    0,  0 },
> -	{ 3000,	 1 },
> -	{ 6000,	 2 },
> -};
> -static unsigned dnskw_fan_pins[] = {46, 45};
> -
> -static struct gpio_fan_platform_data dnskw_fan_data = {
> -	.num_ctrl	= ARRAY_SIZE(dnskw_fan_pins),
> -	.ctrl		= dnskw_fan_pins,
> -	.num_speed	= ARRAY_SIZE(dnskw_fan_speed),
> -	.speed		= dnskw_fan_speed,
> -};
> -
> -static struct platform_device dnskw_fan_device = {
> -	.name	= "gpio-fan",
> -	.id	= -1,
> -	.dev	= {
> -		.platform_data	= &dnskw_fan_data,
> -	},
> -};
> -
>  static void dnskw_power_off(void)
>  {
>  	gpio_set_value(36, 1);
> @@ -114,8 +91,6 @@ void __init dnskw_init(void)
>  	kirkwood_ehci_init();
>  	kirkwood_ge00_init(&dnskw_ge00_data);
>  
> -	platform_device_register(&dnskw_fan_device);
> -
>  	/* Register power-off GPIO. */
>  	if (gpio_request(36, "dnskw:power:off") == 0
>  	    && gpio_direction_output(36, 0) == 0)
> -- 
> 1.7.10.4
> 

Hi Jamie

Minor point. I expect you can remove the header file gpio-fan.h.

There are also a few other headers files which can be removed, but i
suggest you do this in a separate cleanup patch. I think
ata_platform.h, input.h, leds.h, map.h, bridge-regs.h and maybe also
kirkwood.h are no longer needed.

  Andrew
