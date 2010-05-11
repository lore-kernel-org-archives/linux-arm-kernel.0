From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 11 May 2010 01:15:42 +0100
Subject: [PATCH 1/5] Add HP iPAQ RX1950 machine support
In-Reply-To: <1273524194-13346-2-git-send-email-anarsoul@gmail.com>
References: <1273524194-13346-1-git-send-email-anarsoul@gmail.com>
	<1273524194-13346-2-git-send-email-anarsoul@gmail.com>
Message-ID: <20100511001542.GG6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 11:43:10PM +0300, Vasily Khoruzhick wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Denis Grigoriev <dgreenday@gmail.com>
> ---
>  arch/arm/mach-s3c2440/Kconfig       |   13 +
>  arch/arm/mach-s3c2440/Makefile      |    1 +
>  arch/arm/mach-s3c2440/mach-rx1950.c |  550 +++++++++++++++++++++++++++++++++++
>  3 files changed, 564 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2440/mach-rx1950.c
> 
> diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
> index 9d102b9..cd8e7de 100644
> --- a/arch/arm/mach-s3c2440/Kconfig
> +++ b/arch/arm/mach-s3c2440/Kconfig
> @@ -188,4 +188,17 @@ config MACH_MINI2440
>  	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
>  	  available via various sources. It can come with a 3.5" or 7" touch LCD.
>  
> +config MACH_RX1950
> +	bool "HP iPAQ rx1950"
> +	select CPU_S3C2442
> +	select S3C24XX_DCLK
> +	select PM_H1940 if PM
> +	select I2C
> +	select S3C2410_PWM
> +	select S3C_DEV_NAND
> +	select S3C2410_IOTIMING if S3C2440_CPUFREQ
> +	select S3C2440_XTAL_16934400
> +	help
> +	   Say Y here if you're using HP iPAQ rx1950
> +
>  endmenu
> diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
> index c85ba32..d5440fa 100644
> --- a/arch/arm/mach-s3c2440/Makefile
> +++ b/arch/arm/mach-s3c2440/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_NEXCODER_2440) += mach-nexcoder.o
>  obj-$(CONFIG_MACH_AT2440EVB) += mach-at2440evb.o
>  obj-$(CONFIG_MACH_MINI2440) += mach-mini2440.o
>  obj-$(CONFIG_MACH_NEO1973_GTA02) += mach-gta02.o
> +obj-$(CONFIG_MACH_RX1950) += mach-rx1950.o
>  
>  # extra machine support
>  
> diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
> new file mode 100644
> index 0000000..260969a
> --- /dev/null
> +++ b/arch/arm/mach-s3c2440/mach-rx1950.c
> @@ -0,0 +1,550 @@
> +/* linux/arch/arm/mach-s3c2440/mach-rx1950.c
> + *
> + * Copyright (c) 2006-2009 Victor Chukhantsev, Denis Grigoriev,
> + * Copyright (c) 2007-2010 Vasily Khoruzhick
> + *
> + * based on smdk2440 written by Ben Dooks
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/init.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/serial_core.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/sysdev.h>
> +#include <linux/pwm_backlight.h>
> +#include <linux/pwm.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <linux/mmc/host.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach-types.h>
> +
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-gpioj.h>
> +#include <mach/h1940.h>
> +#include <mach/fb.h>
> +
> +#include <plat/clock.h>
> +#include <plat/regs-serial.h>
> +#include <plat/regs-iic.h>
> +#include <plat/mci.h>
> +#include <plat/udc.h>
> +#include <plat/nand.h>
> +#include <plat/iic.h>
> +#include <plat/devs.h>
> +#include <plat/cpu.h>
> +#include <plat/pm.h>
> +#include <plat/irq.h>
> +#include <plat/ts.h>
> +
> +#define LCD_PWM_PERIOD 192960
> +#define LCD_PWM_DUTY 127353
> +
> +static struct map_desc rx1950_iodesc[] __initdata = {
> +	/* ISA IO Space map (memory space selected by A24) */
> +	{
> +	 .virtual = (u32) S3C24XX_VA_ISA_WORD,
> +	 .pfn = __phys_to_pfn(S3C2410_CS2),
> +	 .length = 0x10000,
> +	 .type = MT_DEVICE,
> +	},
> +	{
> +	 .virtual = (u32) S3C24XX_VA_ISA_WORD + 0x10000,
> +	 .pfn = __phys_to_pfn(S3C2410_CS2 + (1 << 24)),
> +	 .length = SZ_4M,
> +	 .type = MT_DEVICE,
> +	},
> +};

firstly, do you need this mapping for anything and secondly can
you check the indentation on it if it is staying.

> +static struct s3c24xx_uart_clksrc rx1950_serial_clocks[] = {
> +	[0] = {
> +	       .name = "fclk",
> +	       .divisor = 0x0a,
> +	       .min_baud = 0,
> +	       .max_baud = 0,
> +	},
> +};
> +
> +static struct s3c2410_uartcfg rx1950_uartcfgs[] __initdata = {
> +	[0] = {
> +	       .hwport = 0,
> +	       .flags = 0,
> +	       .ucon = 0x3c5,
> +	       .ulcon = 0x03,
> +	       .ufcon = 0x51,
> +	       .clocks = rx1950_serial_clocks,
> +	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
> +	},
> +	[1] = {
> +	       .hwport = 1,
> +	       .flags = 0,
> +	       .ucon = 0x3c5,
> +	       .ulcon = 0x03,
> +	       .ufcon = 0x51,
> +	       .clocks = rx1950_serial_clocks,
> +	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
> +	},
> +	/* IR port */
> +	[2] = {
> +	       .hwport = 2,
> +	       .flags = 0,
> +	       .ucon = 0x3c5,
> +	       .ulcon = 0x43,
> +	       .ufcon = 0xf1,
> +	       .clocks = rx1950_serial_clocks,
> +	       .clocks_size = ARRAY_SIZE(rx1950_serial_clocks),
> +	},
> +};
> +
> +static struct s3c2410fb_display rx1950_display __initdata = {

don't think this is allowed to be __initdata at the moment.

> +	.type = S3C2410_LCDCON1_TFT,
> +	.width = 240,
> +	.height = 320,
> +	.xres = 240,
> +	.yres = 320,
> +	.bpp = 16,
> +
> +	.pixclock = 260000,
> +	.left_margin = 10,
> +	.right_margin = 20,
> +	.hsync_len = 10,
> +	.upper_margin = 2,
> +	.lower_margin = 2,
> +	.vsync_len = 2,
> +
> +	.lcdcon5 = S3C2410_LCDCON5_FRM565 |
> +			   S3C2410_LCDCON5_INVVCLK |
> +			   S3C2410_LCDCON5_INVVLINE |
> +			   S3C2410_LCDCON5_INVVFRAME |
> +			   S3C2410_LCDCON5_HWSWP |
> +			   (0x02 << 13) |
> +			   (0x02 << 15),
> +
> +};
> +
> +static struct s3c2410fb_mach_info rx1950_lcd_cfg __initdata = {
> +	.displays = &rx1950_display,
> +	.num_displays = 1,
> +	.default_display = 0,
> +
> +	.lpcsel = 0x02,
> +	.gpccon = 0xaa9556a9,
> +	.gpccon_mask = 0xffc003fc,
> +	.gpcup = 0x0000ffff,
> +	.gpcup_mask = 0xffffffff,
> +
> +	.gpdcon = 0xaa90aaa1,
> +	.gpdcon_mask = 0xffc0fff0,
> +	.gpdup = 0x0000fcfd,
> +	.gpdup_mask = 0xffffffff,
> +
> +};
> +
> +static struct pwm_device *lcd_pwm;
> +
> +void rx1950_lcd_power(int enable)
> +{
> +	int i;
> +	static int enabled;
> +	if (enabled == enable)
> +		return;
> +	if (!enable) {
> +
> +		/* GPC11-GPC15->OUTPUT */
> +		for (i = 11; i < 16; i++)
> +			gpio_direction_output(S3C2410_GPC(i), 1);
> +
> +		/* Wait a bit here... */
> +		mdelay(100);

would msleep() be a better thing to do herer.

> +		/* GPD2-GPD7->OUTPUT */
> +		/* GPD11-GPD15->OUTPUT */
> +		/* GPD2-GPD7->1, GPD11-GPD15->1 */
> +		for (i = 2; i < 8; i++)
> +			gpio_direction_output(S3C2410_GPD(i), 1);
> +		for (i = 11; i < 16; i++)
> +			gpio_direction_output(S3C2410_GPD(i), 1);
> +
> +		/* Wait a bit here...*/
> +		mdelay(100);
> +
> +		/* GPB0->OUTPUT, GPB0->0 */
> +		gpio_direction_output(S3C2410_GPB(0), 0);
> +
> +		/* GPC1-GPC4->OUTPUT, GPC1-4->0 */
> +		for (i = 1; i < 5; i++)
> +			gpio_direction_output(S3C2410_GPC(i), 0);
> +
> +		/* GPC15-GPC11->0 */
> +		for (i = 11; i < 16; i++)
> +			gpio_direction_output(S3C2410_GPC(i), 0);
> +
> +		/* GPD15-GPD11->0, GPD2->GPD7->0 */
> +		for (i = 11; i < 16; i++)
> +			gpio_direction_output(S3C2410_GPD(i), 0);
> +
> +		for (i = 2; i < 8; i++)
> +			gpio_direction_output(S3C2410_GPD(i), 0);
> +
> +		/* GPC6->0, GPC7->0, GPC5->0 */
> +		gpio_direction_output(S3C2410_GPC(6), 0);
> +		gpio_direction_output(S3C2410_GPC(7), 0);
> +		gpio_direction_output(S3C2410_GPC(5), 0);
> +
> +		/* GPB1->OUTPUT, GPB1->0 */
> +		gpio_direction_output(S3C2410_GPB(1), 0);
> +		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> +		pwm_disable(lcd_pwm);
> +
> +		/* GPC0->0, GPC10->0 */
> +		gpio_direction_output(S3C2410_GPC(0), 0);
> +		gpio_direction_output(S3C2410_GPC(10), 0);
> +	} else {
> +		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
> +		pwm_enable(lcd_pwm);
> +
> +		gpio_direction_output(S3C2410_GPC(0), 1);
> +		gpio_direction_output(S3C2410_GPC(5), 1);
> +
> +		s3c_gpio_cfgpin(S3C2410_GPB(1), S3C2410_GPB1_TOUT1);
> +		gpio_direction_output(S3C2410_GPC(7), 1);
> +
> +		s3c_gpio_cfgpin(S3C2410_GPC(1), S3C2410_GPC1_VCLK);
> +		s3c_gpio_cfgpin(S3C2410_GPC(2), S3C2410_GPC2_VLINE);
> +		s3c_gpio_cfgpin(S3C2410_GPC(3), S3C2410_GPC3_VFRAME);
> +		s3c_gpio_cfgpin(S3C2410_GPC(4), S3C2410_GPC4_VM);
> +		s3c_gpio_cfgpin(S3C2410_GPC(11), S3C2410_GPC11_VD3);
> +		s3c_gpio_cfgpin(S3C2410_GPC(12), S3C2410_GPC12_VD4);
> +		s3c_gpio_cfgpin(S3C2410_GPC(13), S3C2410_GPC13_VD5);
> +		s3c_gpio_cfgpin(S3C2410_GPC(14), S3C2410_GPC14_VD6);
> +		s3c_gpio_cfgpin(S3C2410_GPC(15), S3C2410_GPC15_VD7);
> +
> +		s3c_gpio_cfgpin(S3C2410_GPD(2), S3C2410_GPD2_VD10);
> +		s3c_gpio_cfgpin(S3C2410_GPD(3), S3C2410_GPD3_VD11);
> +		s3c_gpio_cfgpin(S3C2410_GPD(4), S3C2410_GPD4_VD12);
> +		s3c_gpio_cfgpin(S3C2410_GPD(5), S3C2410_GPD5_VD13);
> +		s3c_gpio_cfgpin(S3C2410_GPD(6), S3C2410_GPD6_VD14);
> +		s3c_gpio_cfgpin(S3C2410_GPD(7), S3C2410_GPD7_VD15);
> +		s3c_gpio_cfgpin(S3C2410_GPD(11), S3C2410_GPD11_VD19);
> +		s3c_gpio_cfgpin(S3C2410_GPD(12), S3C2410_GPD12_VD20);
> +		s3c_gpio_cfgpin(S3C2410_GPD(13), S3C2410_GPD13_VD21);
> +		s3c_gpio_cfgpin(S3C2410_GPD(14), S3C2410_GPD14_VD22);
> +		s3c_gpio_cfgpin(S3C2410_GPD(15), S3C2410_GPD15_VD23);

i think S3C_GPIO_SFN(2) would do for all of these, and would allow
you to loop over the range.

> +		gpio_direction_output(S3C2410_GPC(10), 1);
> +		gpio_direction_output(S3C2410_GPC(6), 1);
> +	}
> +	enabled = enable;
> +}
> +
> +static void rx1950_bl_power(int enable)
> +{
> +	static int enabled;
> +	if (enabled == enable)
> +		return;
> +	if (!enable) {
> +			gpio_direction_output(S3C2410_GPB(0), 0);
> +	} else {
> +			/* LED driver need a "push" to power on */
> +			gpio_direction_output(S3C2410_GPB(0), 1);
> +			/* Warm up backlight for one period of PWM.
> +			 * Without this trick its almost impossible to
> +			 * enable backlight with low brightness value
> +			 */
> +			ndelay(48000);
> +			s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
> +	}
> +	enabled = enable;
> +}
> +
> +static int rx1950_backlight_init(struct device *dev)
> +{
> +	gpio_request(S3C2410_GPB(0), "Backlight");
> +	lcd_pwm = pwm_request(1, "RX1950 LCD");
> +	if (IS_ERR(lcd_pwm)) {
> +		dev_err(dev, "Unable to request PWM for LCD power!\n");
> +		return PTR_ERR(lcd_pwm);
> +	}
> +
> +	rx1950_lcd_power(1);
> +	rx1950_bl_power(1);
> +
> +	return 0;
> +}
> +
> +static void rx1950_backlight_exit(struct device *dev)
> +{
> +	rx1950_bl_power(0);
> +	rx1950_lcd_power(0);
> +
> +	pwm_free(lcd_pwm);
> +	gpio_free(S3C2410_GPB(0));
> +}
> +
> +
> +static int rx1950_backlight_notify(struct device *dev, int brightness)
> +{
> +	if (!brightness) {
> +		rx1950_bl_power(0);
> +		rx1950_lcd_power(0);
> +	} else {
> +		rx1950_lcd_power(1);
> +		rx1950_bl_power(1);
> +	}
> +	return brightness;
> +}
> +
> +static struct platform_pwm_backlight_data rx1950_backlight_data = {
> +	.pwm_id = 0,
> +	.max_brightness = 24,
> +	.dft_brightness = 4,
> +	.pwm_period_ns = 48000,
> +	.init = rx1950_backlight_init,
> +	.notify = rx1950_backlight_notify,
> +	.exit = rx1950_backlight_exit,
> +};
> +
> +static struct platform_device rx1950_backlight = {
> +	.name = "pwm-backlight",
> +	.dev = {
> +		.parent = &s3c_device_timer[0].dev,
> +		.platform_data = &rx1950_backlight_data,
> +	},
> +};
> +
> +static void rx1950_set_mmc_power(unsigned char power_mode, unsigned short vdd)
> +{
> +	switch (power_mode) {
> +	case MMC_POWER_OFF:
> +		gpio_direction_output(S3C2410_GPJ(1), 0);
> +		break;
> +	case MMC_POWER_UP:
> +	case MMC_POWER_ON:
> +		gpio_direction_output(S3C2410_GPJ(1), 1);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static struct s3c24xx_mci_pdata rx1950_mmc_cfg __initdata = {
> +	.gpio_detect = S3C2410_GPF(5),
> +	.gpio_wprotect = S3C2410_GPH(8),
> +	.set_power = rx1950_set_mmc_power,
> +	.ocr_avail = MMC_VDD_32_33,
> +};
> +
> +static struct mtd_partition rx1950_nand_part[] = {
> +	[0] = {
> +	       .name = "Boot0",
> +	       .offset = 0,
> +	       .size = 0x4000,
> +	       .mask_flags = MTD_WRITEABLE,
> +	},
> +	[1] = {
> +	       .name = "Boot1",
> +	       .offset = MTDPART_OFS_APPEND,
> +	       .size = 0x40000,
> +	       .mask_flags = MTD_WRITEABLE,
> +	},
> +	[2] = {
> +	       .name = "Kernel",
> +	       .offset = MTDPART_OFS_APPEND,
> +	       .size = 0x300000,
> +	       .mask_flags = 0,
> +	},
> +	[3] = {
> +	       .name = "Filesystem",
> +	       .offset = MTDPART_OFS_APPEND,
> +	       .size = MTDPART_SIZ_FULL,
> +	       .mask_flags = 0,
> +	},
> +};
> +
> +static struct s3c2410_nand_set rx1950_nand_sets[] = {
> +	[0] = {
> +	       .name = "Internal",
> +	       .nr_chips = 1,
> +	       .nr_partitions = ARRAY_SIZE(rx1950_nand_part),
> +	       .partitions = rx1950_nand_part,
> +	},
> +};
> +
> +static struct s3c2410_platform_nand rx1950_nand_info = {
> +	.tacls = 25,
> +	.twrph0 = 50,
> +	.twrph1 = 15,
> +	.nr_sets = ARRAY_SIZE(rx1950_nand_sets),
> +	.sets = rx1950_nand_sets,
> +};
> +
> +static void rx1950_udc_pullup(enum s3c2410_udc_cmd_e cmd)
> +{
> +	switch (cmd) {
> +	case S3C2410_UDC_P_ENABLE:
> +		gpio_direction_output(S3C2410_GPJ(5), 1);
> +		break;
> +	case S3C2410_UDC_P_DISABLE:
> +		gpio_direction_output(S3C2410_GPJ(5), 0);
> +		break;
> +	case S3C2410_UDC_P_RESET:
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static struct s3c2410_udc_mach_info rx1950_udc_cfg __initdata = {
> +	.udc_command = rx1950_udc_pullup,
> +	.vbus_pin = S3C2410_GPG(5),
> +	.vbus_pin_inverted = 1,
> +};
> +
> +static struct s3c2410_ts_mach_info rx1950_ts_cfg __initdata = {
> +	.delay = 10000,
> +	.presc = 49,
> +	.oversampling_shift = 3,
> +};
> +
> +static struct gpio_keys_button rx1950_gpio_keys_table[] = {
> +	{KEY_POWER, S3C2410_GPF(0), 1, "Power button"},
> +	{KEY_F5, S3C2410_GPF(7), 1, "Record button"},
> +	{KEY_F1, S3C2410_GPG(0), 1, "Calendar button"},
> +	{KEY_F2, S3C2410_GPG(2), 1, "Contacts button"},
> +	{KEY_F3, S3C2410_GPG(3), 1, "Mail button"},
> +	{KEY_F4, S3C2410_GPG(7), 1, "WLAN button"},
> +	{KEY_LEFT, S3C2410_GPG(10), 1, "Left button"},
> +	{KEY_RIGHT, S3C2410_GPG(11), 1, "Right button"},
> +	{KEY_UP, S3C2410_GPG(4), 1, "Up button"},
> +	{KEY_DOWN, S3C2410_GPG(6), 1, "Down button"},
> +	{KEY_ENTER, S3C2410_GPG(9), 1, "Ok button"},
> +};

at-least get a space between { and KEY_
would prefer to see properly named initialisers.

> +static struct gpio_keys_platform_data rx1950_gpio_keys_data = {
> +	.buttons = rx1950_gpio_keys_table,
> +	.nbuttons = ARRAY_SIZE(rx1950_gpio_keys_table),
> +};
> +
> +static struct platform_device rx1950_device_gpiokeys = {
> +	.name = "gpio-keys",
> +	.dev.platform_data = &rx1950_gpio_keys_data,
> +};
> +
> +static struct s3c2410_platform_i2c rx1950_i2c_data = {
> +	.flags = 0,
> +	.slave_addr = 0x42,
> +	.frequency = 400 * 1000,
> +	.sda_delay = S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
> +};
> +
> +static struct platform_device *rx1950_devices[] __initdata = {
> +	&s3c_device_lcd,
> +	&s3c_device_wdt,
> +	&s3c_device_i2c0,
> +	&s3c_device_iis,
> +	&s3c_device_usbgadget,
> +	&s3c_device_rtc,
> +	&s3c_device_nand,
> +	&s3c_device_sdi,
> +	&s3c_device_adc,
> +	&s3c_device_ts,
> +	&s3c_device_timer[0],
> +	&s3c_device_timer[1],
> +	&rx1950_backlight,
> +	&rx1950_device_gpiokeys,
> +};
> +
> +static struct clk *rx1950_clocks[] __initdata = {
> +	&s3c24xx_clkout0,
> +	&s3c24xx_clkout1,
> +};
> +
> +static void __init rx1950_map_io(void)
> +{
> +	s3c24xx_clkout0.parent  = &clk_h;
> +	s3c24xx_clkout1.parent  = &clk_f;
> +
> +	s3c24xx_register_clocks(rx1950_clocks, ARRAY_SIZE(rx1950_clocks));
> +
> +	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
> +	s3c24xx_init_clocks(16934000);
> +	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
> +
> +	/* setup PM */
> +
> +#ifdef CONFIG_PM_H1940
> +	memcpy(phys_to_virt(H1940_SUSPEND_RESUMEAT), h1940_pm_return, 8);
> +#endif
> +
> +	s3c_pm_init();
> +	s3c_irq_wake(IRQ_EINT0, 1);
> +}

surely this should be propertyu of a key in the keys table?

> +static void __init rx1950_init_machine(void)
> +{
> +	int i;
> +
> +	s3c24xx_fb_set_platdata(&rx1950_lcd_cfg);
> +	s3c24xx_udc_set_platdata(&rx1950_udc_cfg);
> +	s3c24xx_ts_set_platdata(&rx1950_ts_cfg);
> +	s3c24xx_mci_set_platdata(&rx1950_mmc_cfg);
> +	s3c_i2c0_set_platdata(&rx1950_i2c_data);
> +	s3c_nand_set_platdata(&rx1950_nand_info);
> +
> +	/* Turn off suspend on both USB ports, and switch the
> +	 * selectable USB port to USB device mode. */
> +	s3c2410_modify_misccr(S3C2410_MISCCR_USBHOST |
> +						S3C2410_MISCCR_USBSUSPND0 |
> +						S3C2410_MISCCR_USBSUSPND1, 0x0);
> +
> +	gpio_request(S3C2410_GPJ(5), "UDC pullup");
> +	gpio_direction_output(S3C2410_GPJ(5), 0);
> +
> +	/* mmc power is disabled by default */
> +	gpio_request(S3C2410_GPJ(1), "MMC power");
> +	gpio_direction_output(S3C2410_GPJ(1), 0);

you might want to WARN_ON() the result of gpio_request().

> +	for (i = 0; i < 8; i++)
> +		gpio_request(S3C2410_GPC(i), "LCD power");
> +
> +	for (i = 10; i < 16; i++)
> +		gpio_request(S3C2410_GPC(i), "LCD power");
> +
> +	for (i = 2; i < 8; i++)
> +		gpio_request(S3C2410_GPD(i), "LCD power");
> +
> +	for (i = 11; i < 16; i++)
> +		gpio_request(S3C2410_GPD(i), "LCD power");
> +
> +	gpio_request(S3C2410_GPB(1), "LCD power");
> +
> +	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
> +}
> +
> +MACHINE_START(RX1950, "HP iPAQ RX1950")
> +	/* Maintainers: Vasily Khoruzhick */
> +	.phys_io = S3C2410_PA_UART,
> +	.io_pg_offst = (((u32) S3C24XX_VA_UART) >> 18) & 0xfffc,
> +	.boot_params = S3C2410_SDRAM_PA + 0x100,
> +	.map_io = rx1950_map_io,
> +	.init_irq = s3c24xx_init_irq,
> +	.init_machine = rx1950_init_machine,
> +	.timer = &s3c24xx_timer,
> +MACHINE_END
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
