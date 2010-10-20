From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 20 Oct 2010 14:15:58 +0300
Subject: [patch 5/9] efikamx: add leds support
In-Reply-To: <20101019205257.052613428@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205257.052613428@rtp-net.org>
Message-ID: <20101020111558.GJ2562@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 19, Arnaud Patard wrote:
> The efika mx a 3 leds (1 blue, 1 red, 1 green) connected on GPIOS 3 13/14/15.
> Also, some special care is done for default trigger of blue led for mmc as
> the mmc host used is different between hw revisions
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org> 
> Index: linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-15 23:11:42.000000000 +0200
> +++ linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-15 23:11:51.000000000 +0200
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> +#include <linux/leds.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/fsl_devices.h>
> @@ -43,6 +44,10 @@
>  #define EFIKAMX_PCBID1		(2*32+17)
>  #define EFIKAMX_PCBID2		(2*32+11)
>  
> +#define EFIKAMX_BLUE_LED	(2*32+13)
> +#define EFIKAMX_GREEN_LED	(2*32+14)
> +#define EFIKAMX_RED_LED		(2*32+15)
> +
>  /* the pci ids pin have pull up. they're driven low according to board id */
>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> @@ -81,6 +86,11 @@
>  	MX51_PAD_GPIO_1_1__ESDHC1_WP,
>  	MX51_PAD_GPIO_1_7__ESDHC2_WP,
>  	MX51_PAD_GPIO_1_8__ESDHC2_CD,
> +
> +	/* leds */
> +	MX51_PAD_CSI1_D9__GPIO_3_13,
> +	MX51_PAD_CSI1_VSYNC__GPIO_3_14,
> +	MX51_PAD_CSI1_HSYNC__GPIO_3_15,
>  };
>  
>  /* Serial ports */
> @@ -179,6 +189,37 @@
>  	}
>  }
>  
> +static struct gpio_led mx51_efikamx_leds[] = {
> +	{
> +		.name = "efikamx:green",
> +		.default_trigger = "default-on",
> +		.gpio = EFIKAMX_GREEN_LED,
> +	},
> +	{
> +		.name = "efikamx:red",
> +		.default_trigger = "ide-disk",
> +		.gpio = EFIKAMX_RED_LED,
> +	},
> +	{
> +		.name = "efikamx:blue",
> +		.default_trigger = "mmc1",
> +		.gpio = EFIKAMX_BLUE_LED,

Make the default mmc0 ....

> +	},
> +};
> +
> +static struct gpio_led_platform_data mx51_efikamx_leds_data = {
> +	.leds = mx51_efikamx_leds,
> +	.num_leds = ARRAY_SIZE(mx51_efikamx_leds),
> +};
> +
> +static struct platform_device mx51_efikamx_leds_device = {
> +	.name = "leds-gpio",
> +	.id = -1,
> +	.dev = {
> +		.platform_data = &mx51_efikamx_leds_data,
> +	},
> +};
> +
>  static void __init mxc_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
> @@ -191,6 +232,10 @@
>  	/* on < 1.2 boards the 2 SD controller are used */
>  	if (system_rev < 0x12)
>  		imx51_add_esdhc(1, NULL);
.. and change to mmc1 if system_rev < 0x12. That gets rid of this else
clause below.
>
> +	else
> +		mx51_efikamx_leds[2].default_trigger = "mmc0";
> +	platform_device_register(&mx51_efikamx_leds_device);
>  }
>  
>  static void __init mx51_efikamx_timer_init(void)
> 
> 
