From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 13 Jul 2010 11:59:41 +0200
Subject: [PATCH 2/5] pxa: Introduce Palm27x
In-Reply-To: <AANLkTile1TGlVf1ICjgeo95RQgozamdOhsKb78bkR95i@mail.gmail.com>
References: <1279006733-17731-1-git-send-email-marek.vasut@gmail.com>
	<1279006733-17731-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTile1TGlVf1ICjgeo95RQgozamdOhsKb78bkR95i@mail.gmail.com>
Message-ID: <201007131159.41375.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 13. ?ervence 2010 10:14:17 Eric Miao napsal(a):
> On Tue, Jul 13, 2010 at 3:38 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This contains common code for Palm LD, TX, T5, Z72
> 
> Not enough sure about the commonalities between these PALM code .vs.
> the differences. Yet my simple idea is:
> 
> palm27x.c - for all pxa27x based machines
> palm25x.c - for all pxa25x based machines

Right, this is the first step toward it.
> 
> See ezx.c, I'd pretty much like number of files being reduced in
> mach-pxa/*.
> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  arch/arm/mach-pxa/Kconfig                |    3 +
> >  arch/arm/mach-pxa/Makefile               |    1 +
> >  arch/arm/mach-pxa/include/mach/palm27x.h |   48 +++
> >  arch/arm/mach-pxa/palm27x.c              |  473
> > ++++++++++++++++++++++++++++++ 4 files changed, 525 insertions(+), 0
> > deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/include/mach/palm27x.h
> > 
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index 2ff0b32..f3eaade 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -347,6 +347,9 @@ config ARCH_PXA_PALM
> >        bool "PXA based Palm PDAs"
> >        select HAVE_PWM
> > 
> > +config MACH_PALM27X
> > +       bool
> > +
> >  config MACH_PALMTE2
> >        bool "Palm Tungsten|E2"
> >        default y
> > diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> > index 3f72218..20c80e8 100644
> > --- a/arch/arm/mach-pxa/Makefile
> > +++ b/arch/arm/mach-pxa/Makefile
> > @@ -75,6 +75,7 @@ obj-$(CONFIG_PXA_EZX)           += ezx.o
> >  obj-$(CONFIG_MACH_MP900C)      += mp900.o
> >  obj-$(CONFIG_MACH_PALMTE2)     += palmte2.o
> >  obj-$(CONFIG_MACH_PALMTC)      += palmtc.o
> > +obj-$(CONFIG_MACH_PALM27X)     += palm27x.o
> >  obj-$(CONFIG_MACH_PALMT5)      += palmt5.o
> >  obj-$(CONFIG_MACH_PALMTX)      += palmtx.o
> >  obj-$(CONFIG_MACH_PALMZ72)     += palmz72.o
> > diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h
> > b/arch/arm/mach-pxa/include/mach/palm27x.h new file mode 100644
> > index 0000000..94ae6d9
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/include/mach/palm27x.h
> > @@ -0,0 +1,48 @@
> > +/*
> > + * Common functions for Palm LD, T5, TX, Z72
> > + *
> > + * Copyright (C) 2010
> > + * Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +struct palm27x_handheld {
> > +       /* SD/MMC */
> > +       int             mmc_detect;
> > +       int             mmc_ro;
> > +       int             mmc_power;
> > +
> > +       /* PM */
> > +       unsigned long   pm_str_base;
> > +
> > +       /* UDC */
> > +       int             udc_detect;
> > +       int             udc_pullup;
> > +
> > +       /* IrDA */
> > +       int             irda_pwdn;
> > +
> > +       /* Battery */
> > +       int             batt_minv;
> > +       int             batt_maxv;
> > +
> > +       /* Audio */
> > +       int             jack_gpio;
> > +
> > +       /* Backlight */
> > +       int             bl_bl;
> > +       int             bl_lcd;
> > +
> > +       /* Power supply */
> > +       int             power_ac;
> > +       int             power_usb;
> > +
> > +       /* LCD */
> > +       int             lcd_power;
> > +};
> > +
> > +extern void __init palm27x_common_init(struct palm27x_handheld *);
> > diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
> > index e69de29..6d7b978 100644
> > --- a/arch/arm/mach-pxa/palm27x.c
> > +++ b/arch/arm/mach-pxa/palm27x.c
> > @@ -0,0 +1,473 @@
> > +/*
> > + * Common code for Palm LD, T5, TX, Z72
> > + *
> > + * Copyright (C) 2010
> > + * Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/gpio_keys.h>
> > +#include <linux/input.h>
> > +#include <linux/pda_power.h>
> > +#include <linux/pwm_backlight.h>
> > +#include <linux/gpio.h>
> > +#include <linux/wm97xx.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/usb/gpio_vbus.h>
> > +
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> > +
> > +#include <mach/pxa27x.h>
> > +#include <mach/audio.h>
> > +#include <mach/mmc.h>
> > +#include <mach/pxafb.h>
> > +#include <mach/irda.h>
> > +#include <mach/udc.h>
> > +#include <mach/palmasoc.h>
> > +#include <mach/palm27x.h>
> > +
> > +#include "generic.h"
> > +#include "devices.h"
> > +
> > +/***********************************************************************
> > ******* + * SD/MMC card controller
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> > +static struct pxamci_platform_data palm27x_mci_platform_data = {
> > +       .ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
> > +       .detect_delay_ms        = 200,
> > +};
> > +
> > +static void __init palm27x_mmc_init(int detect, int ro, int power)
> > +{
> > +       palm27x_mci_platform_data.gpio_card_detect      = detect;
> > +       palm27x_mci_platform_data.gpio_card_ro          = ro;
> > +       palm27x_mci_platform_data.gpio_power            = power;
> > +
> > +       if (machine_is_palmz72() || machine_is_centro())
> > +               palm27x_mci_platform_data.gpio_power_invert = 1;
> > +
> > +       pxa_set_mci_info(&palm27x_mci_platform_data);
> > +}
> > +#else
> > +static inline void palm27x_mmc_init(int detect, int ro, int power) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * Power management - standby
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_SUSPEND)
> > +static void __init palm27x_pm_init(unsigned long str_base)
> > +{
> > +       static const unsigned long resume[] = {
> > +               0xe3a00101,     /* mov  r0,     #0x40000000 */
> > +               0xe380060f,     /* orr  r0, r0, #0x00f00000 */
> > +               0xe590f008,     /* ldr  pc, [r0, #0x08] */
> > +       };
> > +
> > +       /*
> > +        * Copy the bootloader.
> > +        * NOTE: PalmZ72 uses a different wakeup method!
> > +        */
> > +       if (!machine_is_palmz72())
> > +               memcpy(phys_to_virt(str_base), resume, sizeof(resume));
> > +}
> > +#else
> > +static inline void palm27x_pm_init(unsigned long str_base) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * Framebuffer
> > +
> > ************************************************************************
> > ******/ +/*
> > + * NOTE: PalmZ72 has so called HiRes screen -- 320x320
> > + *       The rest of devices has HiRes+ screen -- 320x480
> > + */
> > +#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> > +static struct pxafb_mode_info palm27x_modes[] = {
> > +       {
> > +               .pixclock       = 57692,
> > +               .xres           = 320,
> > +               .yres           = 480,
> > +               .bpp            = 16,
> > +
> > +               .left_margin    = 32,
> > +               .right_margin   = 1,
> > +               .upper_margin   = 7,
> > +               .lower_margin   = 1,
> > +
> > +               .hsync_len      = 4,
> > +               .vsync_len      = 1,
> > +       }, {
> > +               .pixclock       = 115384,
> > +               .xres           = 320,
> > +               .yres           = 320,
> > +               .bpp            = 16,
> > +
> > +               .left_margin    = 27,
> > +               .right_margin   = 7,
> > +               .upper_margin   = 7,
> > +               .lower_margin   = 8,
> > +
> > +               .hsync_len      = 6,
> > +               .vsync_len      = 1,
> > +       }, {
> > +               .pixclock       = 86538,
> > +               .xres           = 320,
> > +               .yres           = 320,
> > +               .bpp            = 16,
> > +
> > +               .left_margin    = 20,
> > +               .right_margin   = 8,
> > +               .upper_margin   = 8,
> > +               .lower_margin   = 5,
> > +
> > +               .hsync_len      = 4,
> > +               .vsync_len      = 1,
> > +       }
> > +};
> > +
> > +static struct pxafb_mach_info palm27x_lcd_screen = {
> > +       .num_modes      = 1,
> > +       .lcd_conn       = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
> > +};
> > +
> > +static int palm27x_lcd_power;
> > +static void palm27x_lcd_ctl(int on, struct fb_var_screeninfo *info)
> > +{
> > +       gpio_set_value(palm27x_lcd_power, on);
> > +}
> > +
> > +static void __init palm27x_lcd_init(int power)
> > +{
> > +       if (machine_is_palmz72())
> > +               palm27x_lcd_screen.modes = &palm27x_modes[0];
> > +       else
> > +               palm27x_lcd_screen.modes = &palm27x_modes[1];
> > +
> > +       if (gpio_is_valid(power)) {
> > +               if (!gpio_request(power, "LCD power")) {
> > +                       pr_err("Palm27x: failed to claim lcd power
> > gpio!\n"); +                       return;
> > +               }
> > +               if (!gpio_direction_output(power, 1)) {
> > +                       pr_err("Palm27x: lcd power configuration
> > failed!\n"); +                       return;
> > +               }
> > +               palm27x_lcd_power = power;
> > +               palm27x_lcd_screen.pxafb_lcd_power = palm27x_lcd_ctl;
> > +       }
> > +
> > +       set_pxa_fb_info(&palm27x_lcd_screen);
> > +}
> > +
> > +#else
> > +static inline void palm27x_lcd_init(int power) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * USB Gadget
> > +
> > ************************************************************************
> > ******/ +#if    defined(CONFIG_USB_GADGET_PXA27X) || \
> > +       defined(CONFIG_USB_GADGET_PXA27X_MODULE)
> > +static struct gpio_vbus_mach_info palm27x_udc_info = {
> > +       .gpio_vbus_inverted     = 1,
> > +};
> > +
> > +static struct platform_device palm27x_gpio_vbus = {
> > +       .name   = "gpio-vbus",
> > +       .id     = -1,
> > +       .dev    = {
> > +               .platform_data  = &palm27x_udc_info,
> > +       },
> > +};
> > +
> > +static void __init palm27x_udc_init(int vbus, int pullup)
> > +{
> > +       if (machine_is_palmld())
> > +               return;
> > +
> > +       palm27x_udc_info.gpio_vbus      = vbus;
> > +       palm27x_udc_info.gpio_pullup    = pullup;
> > +
> > +       if (machine_is_palmz72())
> > +               palm27x_udc_info.gpio_vbus_inverted = 0;
> > +
> > +       if (!gpio_request(pullup, "USB Pullup")) {
> > +               gpio_direction_output(pullup,
> > +                       palm27x_udc_info.gpio_vbus_inverted);
> > +               gpio_free(pullup);
> > +       } else
> > +               return;
> > +
> > +       platform_device_register(&palm27x_gpio_vbus);
> > +}
> > +#else
> > +static inline void palm27x_udc_init(int vbus, int pullup) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * IrDA
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
> > +static struct pxaficp_platform_data palm27x_ficp_platform_data = {
> > +       .transceiver_cap        = IR_SIRMODE | IR_OFF,
> > +};
> > +
> > +static void __init palm27x_irda_init(int pwdn)
> > +{
> > +       palm27x_ficp_platform_data.gpio_pwdown = pwdn;
> > +       pxa_set_ficp_info(&palm27x_ficp_platform_data);
> > +}
> > +#else
> > +static inline void palm27x_irda_init(int pwdn) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * WM97xx audio, battery
> > +
> > ************************************************************************
> > ******/ +#if    defined(CONFIG_TOUCHSCREEN_WM97XX) || \
> > +       defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
> > +static struct wm97xx_batt_pdata palm27x_batt_pdata = {
> > +       .batt_aux       = WM97XX_AUX_ID3,
> > +       .temp_aux       = WM97XX_AUX_ID2,
> > +       .charge_gpio    = -1,
> > +       .batt_mult      = 1000,
> > +       .batt_div       = 414,
> > +       .temp_mult      = 1,
> > +       .temp_div       = 1,
> > +       .batt_tech      = POWER_SUPPLY_TECHNOLOGY_LIPO,
> > +       .batt_name      = "main-batt",
> > +};
> > +
> > +static struct wm97xx_pdata palm27x_wm97xx_pdata = {
> > +       .batt_pdata     = &palm27x_batt_pdata,
> > +};
> > +
> > +static pxa2xx_audio_ops_t palm27x_ac97_pdata = {
> > +       .codec_pdata    = { &palm27x_wm97xx_pdata, },
> > +};
> > +
> > +static struct palm27x_asoc_info palm27x_asoc_pdata = {
> > +       .jack_gpio      = -1,
> > +};
> > +
> > +static struct platform_device palm27x_asoc = {
> > +       .name = "palm27x-asoc",
> > +       .id   = -1,
> > +       .dev  = {
> > +               .platform_data = &palm27x_asoc_pdata,
> > +       },
> > +};
> > +
> > +static void __init palm27x_ac97_init(int minv, int maxv, int jack)
> > +{
> > +       if (!machine_is_palmz72())
> > +               palm27x_ac97_pdata.reset_gpio = 95;
> > +       else
> > +               palm27x_asoc_pdata.jack_gpio = jack;
> > +
> > +       if (machine_is_treo680() || machine_is_centro()) {
> > +               palm27x_ac97_pdata.codec_pdata[0] = NULL;
> > +               pxa_set_ac97_info(&palm27x_ac97_pdata);
> > +       } else {
> > +               palm27x_batt_pdata.min_voltage  = minv,
> > +               palm27x_batt_pdata.max_voltage  = maxv,
> > +
> > +               pxa_set_ac97_info(&palm27x_ac97_pdata);
> > +               platform_device_register(&palm27x_asoc);
> > +       }
> > +}
> > +#else
> > +static inline void palm27x_ac97_init(int minv, int maxv, int jack) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * Backlight
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_BACKLIGHT_PWM) ||
> > defined(CONFIG_BACKLIGHT_PWM_MODULE) +struct {
> > +       int     bl_power;
> > +       int     lcd_power;
> > +} palm27x_bl_info;
> > +
> > +static int palm27x_backlight_init(struct device *dev)
> > +{
> > +       int ret;
> > +
> > +       ret = gpio_request(palm27x_bl_info.bl_power, "BL POWER");
> > +       if (ret)
> > +               goto err;
> > +       ret = gpio_direction_output(palm27x_bl_info.bl_power, 0);
> > +       if (ret)
> > +               goto err2;
> > +
> > +       if (gpio_is_valid(palm27x_bl_info.lcd_power)) {
> > +               ret = gpio_request(palm27x_bl_info.lcd_power, "LCD
> > POWER"); +               if (ret)
> > +                       goto err2;
> > +               ret = gpio_direction_output(palm27x_bl_info.lcd_power,
> > 0); +               if (ret)
> > +                       goto err3;
> > +       }
> > +
> > +       return 0;
> > +err3:
> > +       gpio_free(palm27x_bl_info.lcd_power);
> > +err2:
> > +       gpio_free(palm27x_bl_info.bl_power);
> > +err:
> > +       return ret;
> > +}
> > +
> > +static int palm27x_backlight_notify(struct device *dev, int brightness)
> > +{
> > +       gpio_set_value(palm27x_bl_info.bl_power, brightness);
> > +       if (gpio_is_valid(palm27x_bl_info.lcd_power))
> > +               gpio_set_value(palm27x_bl_info.lcd_power, brightness);
> > +       return brightness;
> > +}
> > +
> > +static void palm27x_backlight_exit(struct device *dev)
> > +{
> > +       gpio_free(palm27x_bl_info.bl_power);
> > +       if (gpio_is_valid(palm27x_bl_info.lcd_power))
> > +               gpio_free(palm27x_bl_info.lcd_power);
> > +}
> > +
> > +static struct platform_pwm_backlight_data palm27x_backlight_data = {
> > +       .pwm_id         = 0,
> > +       .max_brightness = 0xfe,
> > +       .dft_brightness = 0x7e,
> > +       .pwm_period_ns  = 3500,
> > +       .init           = palm27x_backlight_init,
> > +       .notify         = palm27x_backlight_notify,
> > +       .exit           = palm27x_backlight_exit,
> > +};
> > +
> > +static struct platform_device palm27x_backlight = {
> > +       .name   = "pwm-backlight",
> > +       .dev    = {
> > +               .parent         = &pxa27x_device_pwm0.dev,
> > +               .platform_data  = &palm27x_backlight_data,
> > +       },
> > +};
> > +
> > +static void __init palm27x_pwm_init(int bl, int lcd)
> > +{
> > +       palm27x_bl_info.bl_power        = bl;
> > +       palm27x_bl_info.lcd_power       = lcd;
> > +       platform_device_register(&palm27x_backlight);
> > +}
> > +#else
> > +static inline void palm27x_pwm_init(int bl, int lcd) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * Power supply
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_PDA_POWER) ||
> > defined(CONFIG_PDA_POWER_MODULE) +struct {
> > +       int     ac_state;
> > +       int     usb_state;
> > +} palm27x_power_info;
> > +
> > +static int palm27x_power_supply_init(struct device *dev)
> > +{
> > +       int ret;
> > +
> > +       ret = gpio_request(palm27x_power_info.ac_state, "AC state");
> > +       if (ret)
> > +               goto err1;
> > +       ret = gpio_direction_input(palm27x_power_info.ac_state);
> > +       if (ret)
> > +               goto err2;
> > +
> > +       if (gpio_is_valid(palm27x_power_info.usb_state)) {
> > +               ret = gpio_request(palm27x_power_info.usb_state, "USB
> > state"); +               if (ret)
> > +                       goto err2;
> > +               ret = gpio_direction_input(palm27x_power_info.usb_state);
> > +               if (ret)
> > +                       goto err3;
> > +       }
> > +
> > +       return 0;
> > +err3:
> > +       gpio_free(palm27x_power_info.usb_state);
> > +err2:
> > +       gpio_free(palm27x_power_info.ac_state);
> > +err1:
> > +       return ret;
> > +}
> > +
> > +static void palm27x_power_supply_exit(struct device *dev)
> > +{
> > +       gpio_free(palm27x_power_info.usb_state);
> > +       gpio_free(palm27x_power_info.ac_state);
> > +}
> > +
> > +static int palm27x_is_ac_online(void)
> > +{
> > +       return gpio_get_value(palm27x_power_info.ac_state);
> > +}
> > +
> > +static int palm27x_is_usb_online(void)
> > +{
> > +       return !gpio_get_value(palm27x_power_info.usb_state);
> > +}
> > +static char *palm27x_supplicants[] = {
> > +       "main-battery",
> > +};
> > +
> > +static struct pda_power_pdata palm27x_ps_info = {
> > +       .init                   = palm27x_power_supply_init,
> > +       .exit                   = palm27x_power_supply_exit,
> > +       .is_ac_online           = palm27x_is_ac_online,
> > +       .is_usb_online          = palm27x_is_usb_online,
> > +       .supplied_to            = palm27x_supplicants,
> > +       .num_supplicants        = ARRAY_SIZE(palm27x_supplicants),
> > +};
> > +
> > +static struct platform_device palm27x_power_supply = {
> > +       .name = "pda-power",
> > +       .id   = -1,
> > +       .dev  = {
> > +               .platform_data = &palm27x_ps_info,
> > +       },
> > +};
> > +
> > +static void __init palm27x_power_init(int ac, int usb)
> > +{
> > +       palm27x_power_info.ac_state     = ac;
> > +       palm27x_power_info.usb_state    = usb;
> > +       platform_device_register(&palm27x_power_supply);
> > +}
> > +#else
> > +static inline void palm27x_power_init(int ac, int usb) {}
> > +#endif
> > +
> > +void __init palm27x_common_init(struct palm27x_handheld *palm)
> > +{
> > +       pxa_set_ffuart_info(NULL);
> > +       pxa_set_btuart_info(NULL);
> > +       pxa_set_stuart_info(NULL);
> > +
> > +       palm27x_mmc_init(palm->mmc_detect, palm->mmc_ro,
> > palm->mmc_power); +       palm27x_pm_init(palm->pm_str_base);
> > +       palm27x_lcd_init(palm->lcd_power);
> > +       palm27x_udc_init(palm->udc_detect, palm->udc_pullup);
> > +       palm27x_irda_init(palm->irda_pwdn);
> > +       palm27x_ac97_init(palm->batt_minv, palm->batt_maxv,
> > palm->jack_gpio); +       palm27x_pwm_init(palm->bl_bl, palm->bl_lcd);
> > +       palm27x_power_init(palm->power_ac, palm->power_usb);
> > +}
> > --
> > 1.7.1
