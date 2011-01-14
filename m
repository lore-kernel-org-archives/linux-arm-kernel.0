From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 14 Jan 2011 00:22:28 +0000
Subject: [PATCH] Introduce VPR200 board.
In-Reply-To: <1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
References: <1294962532-15790-1-git-send-email-marc@cpdesign.com.au>
	<1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
Message-ID: <20110114002228.GF2822@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

A couple of nitpicks inline, but otherwise looks good to me (I'm not 
familiar with mxc or most of the hardware though, so I'm not sure how 
useful my comments are!).

Jamie

On Fri, Jan 14, 2011 at 10:48:52AM +1100, Marc Reilly wrote:
> diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-mx3/mach-vpr200.c
> new file mode 100644
> index 0000000..a4f0514
> --- /dev/null
> +++ b/arch/arm/mach-mx3/mach-vpr200.c
> @@ -0,0 +1,404 @@
> +/*
> + * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2009 Marc Kleine-Budde, Pengutronix
> + * Copyright 2010 Creative Product Design
> + *
> + * Derived from mx35 3stack.
> + * Original author: Fabio Estevam <fabio.estevam@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +#include <linux/memory.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <asm/mach/map.h>

I don't think you need asm/mach/map.h as you aren't setting up any IO 
mappings.

> +
> +#include <mach/hardware.h>
> +#include <mach/common.h>
> +#include <mach/iomux-mx35.h>
> +#include <mach/irqs.h>
> +#include <mach/ipu.h>
> +#include <mach/mx3fb.h>
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/regulator/machine.h>

I don't think you need linux/regulator/machine.h either.

> +#include <linux/mfd/mc13xxx.h>
> +#include <video/platform_lcd.h>
> +
> +#include "devices-imx35.h"
> +#include "devices.h"
> +
> +#define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
> +#define GPIO_PMIC_INT	IMX_GPIO_NR(2, 0)
> +
> +#define GPIO_BUTTON1	IMX_GPIO_NR(1, 4)
> +#define GPIO_BUTTON2	IMX_GPIO_NR(1, 5)
> +#define GPIO_BUTTON3	IMX_GPIO_NR(1, 7)
> +#define GPIO_BUTTON4	IMX_GPIO_NR(1, 8)
> +#define GPIO_BUTTON5	IMX_GPIO_NR(1, 9)
> +#define GPIO_BUTTON6	IMX_GPIO_NR(1, 10)
> +#define GPIO_BUTTON7	IMX_GPIO_NR(1, 11)
> +#define GPIO_BUTTON8	IMX_GPIO_NR(1, 12)
> +
> +static const struct fb_videomode fb_modedb[] = {
> +	{
> +	/* 800x480 @ 60 Hz */
> +	.name		= "PT0708048",
> +	.refresh	= 60,
> +	.xres		= 800,
> +	.yres		= 480,
> +	.pixclock	= KHZ2PICOS(33260),
> +	.left_margin	= 50,
> +	.right_margin	= 156,
> +	.upper_margin	= 10,
> +	.lower_margin	= 10,
> +	.hsync_len	= 1,	/* note: DE only display */
> +	.vsync_len	= 1,	/* note: DE only display */
> +	.sync		= FB_SYNC_CLK_IDLE_EN | FB_SYNC_OE_ACT_HIGH,
> +	.vmode		= FB_VMODE_NONINTERLACED,
> +	.flag		= 0,
> +	}, {
> +	/* 800x480 @ 60 Hz */
> +	.name		= "CTP-CLAA070LC0ACW",
> +	.refresh	= 60,
> +	.xres		= 800,
> +	.yres		= 480,
> +	.pixclock	= KHZ2PICOS(27000),
> +	.left_margin	= 50,
> +	.right_margin	= 50,	/* whole line should have 900 clocks */
> +	.upper_margin	= 10,
> +	.lower_margin	= 10,	/* whole frame should have 500 lines */
> +	.hsync_len	= 1,	/* note: DE only display */
> +	.vsync_len	= 1,	/* note: DE only display */
> +	.sync		= FB_SYNC_CLK_IDLE_EN | FB_SYNC_OE_ACT_HIGH,
> +	.vmode		= FB_VMODE_NONINTERLACED,
> +	.flag		= 0,
> +	}
> +};

I think the contents of each array entry would usually have an extra 
level of indendation here.

[...]
> +static void vpr200_init_keys(void)
> +{
> +	gpio_request(GPIO_BUTTON1, "BUTTON1");
> +	gpio_direction_input(GPIO_BUTTON1);
> +	gpio_free(GPIO_BUTTON1);
> +
> +	gpio_request(GPIO_BUTTON2, "BUTTON2");
> +	gpio_direction_input(GPIO_BUTTON2);
> +	gpio_free(GPIO_BUTTON2);
> +
> +	gpio_request(GPIO_BUTTON3, "BUTTON3");
> +	gpio_direction_input(GPIO_BUTTON3);
> +	gpio_free(GPIO_BUTTON3);
> +
> +	gpio_request(GPIO_BUTTON4, "BUTTON4");
> +	gpio_direction_input(GPIO_BUTTON4);
> +	gpio_free(GPIO_BUTTON4);
> +
> +	gpio_request(GPIO_BUTTON5, "BUTTON5");
> +	gpio_direction_input(GPIO_BUTTON5);
> +	gpio_free(GPIO_BUTTON5);
> +
> +	gpio_request(GPIO_BUTTON6, "BUTTON6");
> +	gpio_direction_input(GPIO_BUTTON6);
> +	gpio_free(GPIO_BUTTON6);
> +
> +	gpio_request(GPIO_BUTTON7, "BUTTON7");
> +	gpio_direction_input(GPIO_BUTTON7);
> +	gpio_free(GPIO_BUTTON7);
> +
> +	gpio_request(GPIO_BUTTON8, "BUTTON8");
> +	gpio_direction_input(GPIO_BUTTON8);
> +	gpio_free(GPIO_BUTTON8);
> +
> +	platform_device_register(&vpr200_device_gpiokeys);
> +}

You can use gpio_request_array() and gpio_free_array() here to simplify 
any potential error handling.  Is this function just to turn the buttons 
into inputs for the gpio_keys driver?  AFAICT t looks to me that the 
gpio_keys driver does this for you in the probe method with 
gpio_keys_setup_key().  

> +static void vpr200_lcd_power_set(struct plat_lcd_data *pd,
> +				   unsigned int power)
> +{
> +	if (power)
> +		gpio_direction_output(GPIO_LCDPWR, 0);
> +	else
> +		gpio_direction_output(GPIO_LCDPWR, 1);

Does this GPIO ever change direction or could you use gpio_set_value() 
here?

[...]
> +static struct plat_lcd_data vpr200_lcd_power_data = {
> +	.set_power		= vpr200_lcd_power_set,
> +};
> +
> +static struct platform_device vpr200_lcd_powerdev = {
> +	.name			= "platform-lcd",
> +	.dev.platform_data	= &vpr200_lcd_power_data,
> +};

Should you have an explicit .id in this device?

[...]
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
> +{
> +	mxc_iomux_v3_setup_multiple_pads(vpr200_pads, ARRAY_SIZE(vpr200_pads));
> +
> +	imx35_add_fec(NULL);
> +	imx35_add_imx2_wdt(NULL);
> +
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +
> +	gpio_request(GPIO_LCDPWR, "LCDPWR");
> +	gpio_direction_output(GPIO_LCDPWR, 0);
> +	gpio_free(GPIO_LCDPWR);
> +
> +	gpio_request(GPIO_PMIC_INT, "PMIC_INT");
> +	gpio_direction_input(GPIO_PMIC_INT);
> +	gpio_free(GPIO_PMIC_INT);

Why are these gpio's requested, configured, then freed?  They're
used in vpr200_lcd_power_set() so does something else request them again 
later?  It's probably worth checking the return value of gpio_request() 
too.
