From: ben@trinity.fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 14:32:50 +0100
Subject: [PATCH] ARM: S3C6410: Add basic support for SmartQ machines
In-Reply-To: <4BF50276.2060804@gmail.com>
References: <4BF50276.2060804@gmail.com>
Message-ID: <20100520133250.GQ4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 11:35:50AM +0200, Maurus Cuelenaere wrote:
> This adds new machine definitions for the SmartQ 5 and 7.

ok, merged.
 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/Kconfig        |   31 +++
>  arch/arm/mach-s3c64xx/Makefile       |    3 +
>  arch/arm/mach-s3c64xx/mach-smartq.c  |  363 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-s3c64xx/mach-smartq.h  |   20 ++
>  arch/arm/mach-s3c64xx/mach-smartq5.c |  185 +++++++++++++++++
>  arch/arm/mach-s3c64xx/mach-smartq7.c |  201 +++++++++++++++++++
>  6 files changed, 803 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s3c64xx/mach-smartq.c
>  create mode 100644 arch/arm/mach-s3c64xx/mach-smartq.h
>  create mode 100644 arch/arm/mach-s3c64xx/mach-smartq5.c
>  create mode 100644 arch/arm/mach-s3c64xx/mach-smartq7.c
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 69e9fbf..ad32cf4 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -179,3 +179,34 @@ config MACH_HMT
>  	select HAVE_PWM
>  	help
>  	  Machine support for the Airgoo HMT
> +
> +config MACH_SMARTQ
> +	bool
> +	select CPU_S3C6410
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
> +	select S3C_DEV_HSMMC2
> +	select S3C_DEV_FB
> +	select S3C_DEV_HWMON
> +	select S3C_DEV_RTC
> +	select S3C_DEV_USB_HSOTG
> +	select S3C_DEV_USB_HOST
> +	select S3C64XX_SETUP_SDHCI
> +	select S3C64XX_SETUP_FB_24BPP
> +	select SAMSUNG_DEV_ADC
> +	select SAMSUNG_DEV_TS
> +	select HAVE_PWM
> +	help
> +	    Shared machine support for SmartQ 5/7
> +
> +config MACH_SMARTQ5
> +	bool "SmartQ 5"
> +	select MACH_SMARTQ
> +	help
> +	    Machine support for the SmartQ 5
> +
> +config MACH_SMARTQ7
> +	bool "SmartQ 7"
> +	select MACH_SMARTQ
> +	help
> +	    Machine support for the SmartQ 7
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index a10f1fc..39ef55e 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -52,6 +52,9 @@ obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
>  obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
>  obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
>  obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
> +obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
> +obj-$(CONFIG_MACH_SMARTQ5)	+= mach-smartq5.o
> +obj-$(CONFIG_MACH_SMARTQ7)	+= mach-smartq7.o
>  
>  # device support
>  
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
> new file mode 100644
> index 0000000..028d080
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-smartq.c
> @@ -0,0 +1,363 @@
> +/*
> + * linux/arch/arm/mach-s3c64xx/mach-smartq.c
> + *
> + * Copyright (C) 2010 Maurus Cuelenaere
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm_backlight.h>
> +#include <linux/serial_core.h>
> +#include <linux/usb/gpio_vbus.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-modem.h>
> +
> +#include <plat/clock.h>
> +#include <plat/cpu.h>
> +#include <plat/devs.h>
> +#include <plat/iic.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/hwmon.h>
> +#include <plat/regs-serial.h>
> +#include <plat/udc-hs.h>
> +#include <plat/usb-control.h>
> +#include <plat/sdhci.h>
> +#include <plat/ts.h>
> +
> +#include <video/platform_lcd.h>
> +
> +#define UCON S3C2410_UCON_DEFAULT
> +#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
> +#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
> +
> +static struct s3c2410_uartcfg smartq_uartcfgs[] __initdata = {
> +	[0] = {
> +		.hwport	     = 0,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +	[1] = {
> +		.hwport	     = 1,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +	[2] = {
> +		.hwport	     = 2,
> +		.flags	     = 0,
> +		.ucon	     = UCON,
> +		.ulcon	     = ULCON,
> +		.ufcon	     = UFCON,
> +	},
> +};
> +
> +static void smartq_usb_host_powercontrol(int port, int to)
> +{
> +	pr_debug("%s(%d, %d)\n", __func__, port, to);
> +
> +	if (port == 0) {
> +		gpio_set_value(S3C64XX_GPL(0), to);
> +		gpio_set_value(S3C64XX_GPL(1), to);
> +	}
> +}
> +
> +static irqreturn_t smartq_usb_host_ocirq(int irq, void *pw)
> +{
> +	struct s3c2410_hcd_info *info = pw;
> +
> +	if (gpio_get_value(S3C64XX_GPL(10)) == 0) {
> +		pr_debug("%s: over-current irq (oc detected)\n", __func__);
> +		s3c2410_usb_report_oc(info, 3);
> +	} else {
> +		pr_debug("%s: over-current irq (oc cleared)\n", __func__);
> +		s3c2410_usb_report_oc(info, 0);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void smartq_usb_host_enableoc(struct s3c2410_hcd_info *info, int on)
> +{
> +	int ret;
> +
> +	/* This isn't present on a SmartQ 5 board */
> +	if (machine_is_smartq5())
> +		return;
> +
> +	if (on) {
> +		ret = request_irq(gpio_to_irq(S3C64XX_GPL(10)),
> +				  smartq_usb_host_ocirq, IRQF_DISABLED |
> +				  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				  "USB host overcurrent", info);
> +		if (ret != 0)
> +			pr_err("failed to request usb oc irq: %d\n", ret);
> +	} else {
> +		free_irq(gpio_to_irq(S3C64XX_GPL(10)), info);
> +	}
> +}
> +
> +static struct s3c2410_hcd_info smartq_usb_host_info = {
> +	.port[0]	= {
> +		.flags	= S3C_HCDFLG_USED
> +	},
> +	.port[1]	= {
> +		.flags	= 0
> +	},
> +
> +	.power_control	= smartq_usb_host_powercontrol,
> +	.enable_oc	= smartq_usb_host_enableoc,
> +};
> +
> +static struct gpio_vbus_mach_info smartq_usb_otg_vbus_pdata = {
> +	.gpio_vbus		= S3C64XX_GPL(9),
> +	.gpio_pullup		= -1,
> +	.gpio_vbus_inverted	= true,
> +};
> +
> +static struct platform_device smartq_usb_otg_vbus_dev = {
> +	.name			= "gpio-vbus",
> +	.dev.platform_data	= &smartq_usb_otg_vbus_pdata,
> +};
> +
> +static int __init smartq_bl_init(struct device *dev)
> +{
> +    s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_SFN(2));
> +
> +    return 0;
> +}
> +
> +static struct platform_pwm_backlight_data smartq_backlight_data = {
> +	.pwm_id		= 1,
> +	.max_brightness	= 1000,
> +	.dft_brightness	= 600,
> +	.pwm_period_ns	= 1000000000 / (1000 * 20),
> +	.init		= smartq_bl_init,
> +};
> +
> +static struct platform_device smartq_backlight_device = {
> +	.name		= "pwm-backlight",
> +	.dev		= {
> +		.parent	= &s3c_device_timer[1].dev,
> +		.platform_data = &smartq_backlight_data,
> +	},
> +};
> +
> +static struct s3c2410_ts_mach_info smartq_touchscreen_pdata __initdata = {
> +	.delay			= 65535,
> +	.presc			= 99,
> +	.oversampling_shift	= 4,
> +};
> +
> +static struct s3c_sdhci_platdata smartq_internal_hsmmc_pdata = {
> +	.max_width		= 4,
> +	/*.broken_card_detection	= true,*/
> +};
> +
> +static struct s3c_hwmon_pdata smartq_hwmon_pdata __initdata = {
> +	/* Battery voltage (?-4.2V) */
> +	.in[0] = &(struct s3c_hwmon_chcfg) {
> +		.name		= "smartq:battery-voltage",
> +		.mult		= 3300,
> +		.div		= 2048,
> +	},
> +	/* Reference voltage (1.2V) */
> +	.in[1] = &(struct s3c_hwmon_chcfg) {
> +		.name		= "smartq:reference-voltage",
> +		.mult		= 3300,
> +		.div		= 4096,
> +	},
> +};
> +
> +static void smartq_lcd_power_set(struct plat_lcd_data *pd, unsigned int power)
> +{
> +	gpio_direction_output(S3C64XX_GPM(3), power);
> +}
> +
> +static struct plat_lcd_data smartq_lcd_power_data = {
> +	.set_power	= smartq_lcd_power_set,
> +};
> +
> +static struct platform_device smartq_lcd_power_device = {
> +	.name			= "platform-lcd",
> +	.dev.parent		= &s3c_device_fb.dev,
> +	.dev.platform_data	= &smartq_lcd_power_data,
> +};
> +
> +
> +static struct platform_device *smartq_devices[] __initdata = {
> +	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
> +	&s3c_device_hsmmc0,	/* ... then the external SD card */
> +	&s3c_device_hsmmc2,
> +	&s3c_device_adc,
> +	&s3c_device_fb,
> +	&s3c_device_hwmon,
> +	&s3c_device_i2c0,
> +	&s3c_device_ohci,
> +	&s3c_device_rtc,
> +	&s3c_device_timer[1],
> +	&s3c_device_ts,
> +	&s3c_device_usb_hsotg,
> +	&smartq_backlight_device,
> +	&smartq_lcd_power_device,
> +	&smartq_usb_otg_vbus_dev,
> +};
> +
> +static void __init smartq_lcd_mode_set(void)
> +{
> +	u32 tmp;
> +
> +	/* set the LCD type */
> +	tmp = __raw_readl(S3C64XX_SPCON);
> +	tmp &= ~S3C64XX_SPCON_LCD_SEL_MASK;
> +	tmp |= S3C64XX_SPCON_LCD_SEL_RGB;
> +	__raw_writel(tmp, S3C64XX_SPCON);
> +
> +	/* remove the LCD bypass */
> +	tmp = __raw_readl(S3C64XX_MODEM_MIFPCON);
> +	tmp &= ~MIFPCON_LCD_BYPASS;
> +	__raw_writel(tmp, S3C64XX_MODEM_MIFPCON);
> +}
> +
> +static void smartq_power_off(void)
> +{
> +	gpio_direction_output(S3C64XX_GPK(15), 1);
> +}
> +
> +static int __init smartq_power_off_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request(S3C64XX_GPK(15), "Power control");
> +	if (ret < 0) {
> +		pr_err("%s: failed to get GPK15\n", __func__);
> +		return ret;
> +	}
> +
> +	/* leave power on */
> +	gpio_direction_output(S3C64XX_GPK(15), 0);
> +
> +
> +	pm_power_off = smartq_power_off;
> +
> +	return ret;
> +}
> +
> +static int __init smartq_usb_host_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request(S3C64XX_GPL(0), "USB power control");
> +	if (ret < 0) {
> +		pr_err("%s: failed to get GPL0\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = gpio_request(S3C64XX_GPL(1), "USB host power control");
> +	if (ret < 0) {
> +		pr_err("%s: failed to get GPL1\n", __func__);
> +		goto err;
> +	}
> +
> +	if (!machine_is_smartq5()) {
> +		/* This isn't present on a SmartQ 5 board */
> +		ret = gpio_request(S3C64XX_GPL(10), "USB host overcurrent");
> +		if (ret < 0) {
> +			pr_err("%s: failed to get GPL10\n", __func__);
> +			goto err2;
> +		}
> +	}
> +
> +	/* turn power off */
> +	gpio_direction_output(S3C64XX_GPL(0), 0);
> +	gpio_direction_output(S3C64XX_GPL(1), 0);
> +	if (!machine_is_smartq5())
> +		gpio_direction_input(S3C64XX_GPL(10));
> +
> +	s3c_device_ohci.dev.platform_data = &smartq_usb_host_info;
> +
> +	return 0;
> +
> +err2:
> +	gpio_free(S3C64XX_GPL(1));
> +err:
> +	gpio_free(S3C64XX_GPL(0));
> +	return ret;
> +}
> +
> +static int __init smartq_usb_otg_init(void)
> +{
> +	clk_xusbxti.rate = 12000000;
> +
> +	return 0;
> +}
> +
> +static int __init smartq_wifi_init(void)
> +{
> +	int ret;
> +
> +	ret = gpio_request(S3C64XX_GPK(1), "wifi control");
> +	if (ret < 0) {
> +		pr_err("%s: failed to get GPK1\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = gpio_request(S3C64XX_GPK(2), "wifi reset");
> +	if (ret < 0) {
> +		pr_err("%s: failed to get GPK2\n", __func__);
> +		gpio_free(S3C64XX_GPK(1));
> +		return ret;
> +	}
> +
> +	/* turn power on */
> +	gpio_direction_output(S3C64XX_GPK(1), 1);
> +
> +	/* reset device */
> +	gpio_direction_output(S3C64XX_GPK(2), 0);
> +	mdelay(100);
> +	gpio_set_value(S3C64XX_GPK(2), 1);
> +	gpio_direction_input(S3C64XX_GPK(2));
> +
> +	return 0;
> +}
> +
> +static struct map_desc smartq_iodesc[] __initdata = {};
> +void __init smartq_map_io(void)
> +{
> +	s3c64xx_init_io(smartq_iodesc, ARRAY_SIZE(smartq_iodesc));
> +	s3c24xx_init_clocks(12000000);
> +	s3c24xx_init_uarts(smartq_uartcfgs, ARRAY_SIZE(smartq_uartcfgs));
> +
> +	smartq_lcd_mode_set();
> +}
> +
> +void __init smartq_machine_init(void)
> +{
> +	s3c_i2c0_set_platdata(NULL);
> +	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
> +	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
> +	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
> +	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
> +
> +	WARN_ON(smartq_power_off_init());
> +	WARN_ON(smartq_usb_host_init());
> +	WARN_ON(smartq_usb_otg_init());
> +	WARN_ON(smartq_wifi_init());
> +
> +	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
> +}
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq.h b/arch/arm/mach-s3c64xx/mach-smartq.h
> new file mode 100644
> index 0000000..8e8b693
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-smartq.h
> @@ -0,0 +1,20 @@
> +/*
> + * linux/arch/arm/mach-s3c64xx/mach-smartq.h
> + *
> + * Copyright (C) 2010 Maurus Cuelenaere
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __MACH_SMARTQ_H
> +#define __MACH_SMARTQ_H __FILE__
> +
> +#include <linux/init.h>
> +
> +extern void __init smartq_map_io(void);
> +extern void __init smartq_machine_init(void);
> +
> +#endif /* __MACH_SMARTQ_H */
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
> new file mode 100644
> index 0000000..1d0326e
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
> @@ -0,0 +1,185 @@
> +/*
> + * linux/arch/arm/mach-s3c64xx/mach-smartq5.c
> + *
> + * Copyright (C) 2010 Maurus Cuelenaere
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c-gpio.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/leds.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-fb.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/s3c6410.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/devs.h>
> +#include <plat/fb.h>
> +#include <plat/gpio-cfg.h>
> +
> +#include "mach-smartq.h"
> +
> +static void __init smartq5_lcd_setup_gpio(void)
> +{
> +	gpio_request(S3C64XX_GPM(0), "LCD SCEN pin");
> +	gpio_request(S3C64XX_GPM(1), "LCD SCL pin");
> +	gpio_request(S3C64XX_GPM(2), "LCD SDA pin");
> +	gpio_request(S3C64XX_GPM(3), "LCD power");
> +
> +	/* turn power off */
> +	gpio_direction_output(S3C64XX_GPM(0), 1);
> +	gpio_direction_input(S3C64XX_GPM(1));
> +	gpio_direction_input(S3C64XX_GPM(2));
> +	gpio_direction_output(S3C64XX_GPM(3), 0);
> +}
> +
> +static struct i2c_gpio_platform_data smartq5_lcd_control = {
> +	.sda_pin		= S3C64XX_GPM(2),
> +	.scl_pin		= S3C64XX_GPM(1),
> +};
> +
> +static struct platform_device smartq5_lcd_control_device = {
> +	.name			= "i2c-gpio",
> +	.id			= 1,
> +	.dev.platform_data	= &smartq5_lcd_control,
> +};
> +
> +static struct gpio_led smartq5_leds[] __initdata = {
> +	{
> +		.name			= "smartq5:green",
> +		.active_low		= 1,
> +		.gpio			= S3C64XX_GPN(8),
> +	},
> +	{
> +		.name			= "smartq5:red",
> +		.active_low		= 1,
> +		.gpio			= S3C64XX_GPN(9),
> +	},
> +};
> +
> +static struct gpio_led_platform_data smartq5_led_data = {
> +	.num_leds = ARRAY_SIZE(smartq5_leds),
> +	.leds = smartq5_leds,
> +};
> +
> +static struct platform_device smartq5_leds_device = {
> +	.name			= "leds-gpio",
> +	.id			= -1,
> +	.dev.platform_data	= &smartq5_led_data,
> +};
> +
> +/* Labels according to the SmartQ manual */
> +static struct gpio_keys_button smartq5_buttons[] = {
> +	{
> +		.gpio			= S3C64XX_GPL(14),
> +		.code			= KEY_POWER,
> +		.desc			= "Power",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(2),
> +		.code			= KEY_KPMINUS,
> +		.desc			= "Minus",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(12),
> +		.code			= KEY_KPPLUS,
> +		.desc			= "Plus",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(15),
> +		.code			= KEY_ENTER,
> +		.desc			= "Move",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +};
> +
> +static struct gpio_keys_platform_data smartq5_buttons_data  = {
> +	.buttons	= smartq5_buttons,
> +	.nbuttons	= ARRAY_SIZE(smartq5_buttons),
> +};
> +
> +static struct platform_device smartq5_buttons_device  = {
> +	.name		= "gpio-keys",
> +	.id		= 0,
> +	.num_resources	= 0,
> +	.dev		= {
> +		.platform_data	= &smartq5_buttons_data,
> +	}
> +};
> +
> +static struct s3c_fb_pd_win smartq5_fb_win0 = {
> +	.win_mode	= {
> +		.pixclock	= 1000000000000ULL /
> +				((40+1+216+800)*(10+1+35+480)*80),
> +		.left_margin	= 40,
> +		.right_margin	= 216,
> +		.upper_margin	= 10,
> +		.lower_margin	= 35,
> +		.hsync_len	= 1,
> +		.vsync_len	= 1,
> +		.xres		= 800,
> +		.yres		= 480,
> +	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
> +};
> +
> +static struct s3c_fb_platdata smartq5_lcd_pdata __initdata = {
> +	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +	.win[0]		= &smartq5_fb_win0,
> +	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
> +			  VIDCON1_INV_VDEN,
> +};
> +
> +static struct platform_device *smartq5_devices[] __initdata = {
> +	&smartq5_leds_device,
> +	&smartq5_buttons_device,
> +	&smartq5_lcd_control_device,
> +};
> +
> +static void __init smartq5_machine_init(void)
> +{
> +	s3c_fb_set_platdata(&smartq5_lcd_pdata);
> +
> +	smartq_machine_init();
> +	smartq5_lcd_setup_gpio();
> +
> +	platform_add_devices(smartq5_devices, ARRAY_SIZE(smartq5_devices));
> +}
> +
> +MACHINE_START(SMARTQ5, "SmartQ 5")
> +	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
> +	.phys_io	= S3C_PA_UART & 0xfff00000,
> +	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
> +	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
> +	.init_irq	= s3c6410_init_irq,
> +	.map_io		= smartq_map_io,
> +	.init_machine	= smartq5_machine_init,
> +	.timer		= &s3c24xx_timer,
> +MACHINE_END
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
> new file mode 100644
> index 0000000..e0bc78e
> --- /dev/null
> +++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
> @@ -0,0 +1,201 @@
> +/*
> + * linux/arch/arm/mach-s3c64xx/mach-smartq7.c
> + *
> + * Copyright (C) 2010 Maurus Cuelenaere
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c-gpio.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/leds.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/map.h>
> +#include <mach/regs-fb.h>
> +#include <mach/regs-gpio.h>
> +#include <mach/s3c6410.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/devs.h>
> +#include <plat/fb.h>
> +#include <plat/gpio-cfg.h>
> +
> +#include "mach-smartq.h"
> +
> +static void __init smartq7_lcd_setup_gpio(void)
> +{
> +	gpio_request(S3C64XX_GPM(0), "LCD CSB pin");
> +	gpio_request(S3C64XX_GPM(3), "LCD power");
> +	gpio_request(S3C64XX_GPM(4), "LCD power status");
> +
> +	/* turn power off */
> +	gpio_direction_output(S3C64XX_GPM(0), 1);
> +	gpio_direction_output(S3C64XX_GPM(3), 0);
> +	gpio_direction_input(S3C64XX_GPM(4));
> +}
> +
> +static struct i2c_gpio_platform_data smartq7_lcd_control = {
> +	.sda_pin		= S3C64XX_GPM(2),
> +	.scl_pin		= S3C64XX_GPM(1),
> +	.sda_is_open_drain	= 1,
> +	.scl_is_open_drain	= 1,
> +};
> +
> +static struct platform_device smartq7_lcd_control_device = {
> +	.name			= "i2c-gpio",
> +	.id			= 1,
> +	.dev.platform_data	= &smartq7_lcd_control,
> +};
> +
> +static struct gpio_led smartq7_leds[] __initdata = {
> +	{
> +		.name			= "smartq7:red",
> +		.active_low		= 1,
> +		.gpio			= S3C64XX_GPN(8),
> +	},
> +	{
> +		.name			= "smartq7:green",
> +		.active_low		= 1,
> +		.gpio			= S3C64XX_GPN(9),
> +	},
> +};
> +
> +static struct gpio_led_platform_data smartq7_led_data = {
> +	.num_leds = ARRAY_SIZE(smartq7_leds),
> +	.leds = smartq7_leds,
> +};
> +
> +static struct platform_device smartq7_leds_device = {
> +	.name			= "leds-gpio",
> +	.id			= -1,
> +	.dev.platform_data	= &smartq7_led_data,
> +};
> +
> +/* Labels according to the SmartQ manual */
> +static struct gpio_keys_button smartq7_buttons[] = {
> +	{
> +		.gpio			= S3C64XX_GPL(14),
> +		.code			= KEY_POWER,
> +		.desc			= "Power",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(2),
> +		.code			= KEY_FN,
> +		.desc			= "Function",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(3),
> +		.code			= KEY_KPMINUS,
> +		.desc			= "Minus",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(4),
> +		.code			= KEY_KPPLUS,
> +		.desc			= "Plus",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(12),
> +		.code			= KEY_ENTER,
> +		.desc			= "Enter",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +	{
> +		.gpio			= S3C64XX_GPN(15),
> +		.code			= KEY_ESC,
> +		.desc			= "Cancel",
> +		.active_low		= 1,
> +		.debounce_interval	= 5,
> +		.type                   = EV_KEY,
> +	},
> +};
> +
> +static struct gpio_keys_platform_data smartq7_buttons_data  = {
> +	.buttons	= smartq7_buttons,
> +	.nbuttons	= ARRAY_SIZE(smartq7_buttons),
> +};
> +
> +static struct platform_device smartq7_buttons_device  = {
> +	.name		= "gpio-keys",
> +	.id		= 0,
> +	.num_resources	= 0,
> +	.dev		= {
> +		.platform_data	= &smartq7_buttons_data,
> +	}
> +};
> +
> +static struct s3c_fb_pd_win smartq7_fb_win0 = {
> +	.win_mode	= {
> +		.pixclock	= 1000000000000ULL /
> +				((3+10+5+800)*(1+3+20+480)*80),
> +		.left_margin	= 3,
> +		.right_margin	= 5,
> +		.upper_margin	= 1,
> +		.lower_margin	= 20,
> +		.hsync_len	= 10,
> +		.vsync_len	= 3,
> +		.xres		= 800,
> +		.yres		= 480,
> +	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
> +};
> +
> +static struct s3c_fb_platdata smartq7_lcd_pdata __initdata = {
> +	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +	.win[0]		= &smartq7_fb_win0,
> +	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
> +			  VIDCON1_INV_VCLK,
> +};
> +
> +static struct platform_device *smartq7_devices[] __initdata = {
> +	&smartq7_leds_device,
> +	&smartq7_buttons_device,
> +	&smartq7_lcd_control_device,
> +};
> +
> +static void __init smartq7_machine_init(void)
> +{
> +	s3c_fb_set_platdata(&smartq7_lcd_pdata);
> +
> +	smartq_machine_init();
> +	smartq7_lcd_setup_gpio();
> +
> +	platform_add_devices(smartq7_devices, ARRAY_SIZE(smartq7_devices));
> +}
> +
> +MACHINE_START(SMARTQ7, "SmartQ 7")
> +	/* Maintainer: Maurus Cuelenaere <mcuelenaere AT gmail DOT com> */
> +	.phys_io	= S3C_PA_UART & 0xfff00000,
> +	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
> +	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
> +	.init_irq	= s3c6410_init_irq,
> +	.map_io		= smartq_map_io,
> +	.init_machine	= smartq7_machine_init,
> +	.timer		= &s3c24xx_timer,
> +MACHINE_END
> -- 
> 1.7.1
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
