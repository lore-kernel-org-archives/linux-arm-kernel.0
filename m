From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 21 Sep 2010 23:53:35 +0200
Subject: [PATCH 05/11] ARM: pxa: Rename Colibri evalboard
In-Reply-To: <AANLkTi=5zFGmxbNh_KQTo7KPSx==38Bp_K9YOaN640D0@mail.gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
	<1284604382-23683-5-git-send-email-marek.vasut@gmail.com>
	<AANLkTi=5zFGmxbNh_KQTo7KPSx==38Bp_K9YOaN640D0@mail.gmail.com>
Message-ID: <201009212353.35235.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 20. z??? 2010 16:41:48 Eric Miao napsal(a):
> On Thu, Sep 16, 2010 at 10:32 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Rename colibri-pxa270-evalboard to colibri-evalboard as this board is
> > used with all Colibri modules.
> 
> As mentioned, would be more straight-forward if this rename happens
> first?

You might be right, but I think it's ok either way.
> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > Acked-by: Daniel Mack <daniel@caiaq.de>
> > ---
> >  arch/arm/mach-pxa/Kconfig                    |    2 +-
> >  arch/arm/mach-pxa/Makefile                   |    2 +-
> >  arch/arm/mach-pxa/colibri-evalboard.c        |  121
> > ++++++++++++++++++++++++++ arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > |  121 -------------------------- arch/arm/mach-pxa/colibri-pxa270.c    
> >       |    6 +-
> >  arch/arm/mach-pxa/colibri-pxa300.c           |    4 +-
> >  arch/arm/mach-pxa/colibri-pxa320.c           |    4 +-
> >  arch/arm/mach-pxa/include/mach/colibri.h     |    8 +-
> >  8 files changed, 134 insertions(+), 134 deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/colibri-evalboard.c
> >  delete mode 100644 arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > 
> > diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> > index b44d613..e0ac5aa 100644
> > --- a/arch/arm/mach-pxa/Kconfig
> > +++ b/arch/arm/mach-pxa/Kconfig
> > @@ -249,7 +249,7 @@ config MACH_COLIBRI320
> >        select PXA3xx
> >        select CPU_PXA320
> > 
> > -config MACH_COLIBRI_PXA270_EVALBOARD
> > +config MACH_COLIBRI_EVALBOARD
> >        bool "Toradex Colibri Evaluation Carrier Board support"
> >        depends on MACH_COLIBRI || MACH_COLIBRI300 || MACH_COLIBRI320
> > 
> > diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> > index e2f89c2..3197756 100644
> > --- a/arch/arm/mach-pxa/Makefile
> > +++ b/arch/arm/mach-pxa/Makefile
> > @@ -60,7 +60,7 @@ obj-$(CONFIG_MACH_LOGICPD_PXA270)     += lpd270.o
> >  obj-$(CONFIG_MACH_PCM027)              += pcm027.o
> >  obj-$(CONFIG_MACH_PCM990_BASEBOARD)    += pcm990-baseboard.o
> >  obj-$(CONFIG_MACH_COLIBRI)                     += colibri-pxa270.o
> > -obj-$(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD)    +=
> > colibri-pxa270-evalboard.o +obj-$(CONFIG_MACH_COLIBRI_EVALBOARD)   +=
> > colibri-evalboard.o
> >  obj-$(CONFIG_MACH_COLIBRI_PXA270_INCOME)       +=
> > colibri-pxa270-income.o obj-$(CONFIG_MACH_COLIBRI300)  +=
> > colibri-pxa3xx.o colibri-pxa300.o obj-$(CONFIG_MACH_COLIBRI320)  +=
> > colibri-pxa3xx.o colibri-pxa320.o diff --git
> > a/arch/arm/mach-pxa/colibri-evalboard.c
> > b/arch/arm/mach-pxa/colibri-evalboard.c new file mode 100644
> > index 0000000..6b2c800
> > --- /dev/null
> > +++ b/arch/arm/mach-pxa/colibri-evalboard.c
> > @@ -0,0 +1,121 @@
> > +/*
> > + *  linux/arch/arm/mach-pxa/colibri-evalboard.c
> > + *
> > + *  Support for Toradex Colibri Evaluation Carrier Board
> > + *  Daniel Mack <daniel@caiaq.de>
> > + *  Marek Vasut <marek.vasut@gmail.com>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License version 2 as
> > + *  published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sysdev.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/gpio.h>
> > +#include <asm/mach-types.h>
> > +#include <mach/hardware.h>
> > +#include <asm/mach/arch.h>
> > +#include <linux/i2c.h>
> > +
> > +#include <mach/pxa27x.h>
> > +#include <mach/colibri.h>
> > +#include <mach/mmc.h>
> > +#include <mach/ohci.h>
> > +#include <mach/pxa27x-udc.h>
> > +
> > +#include <plat/i2c.h>
> > +
> > +#include "generic.h"
> > +#include "devices.h"
> > +
> > +/***********************************************************************
> > ******* + * SD/MMC card controller
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> > +static struct pxamci_platform_data colibri_mci_platform_data = {
> > +       .ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
> > +       .gpio_power             = -1,
> > +       .gpio_card_ro           = -1,
> > +       .detect_delay_ms        = 200,
> > +};
> > +
> > +static void __init colibri_mmc_init(void)
> > +{
> > +       if (machine_is_colibri())       /* PXA270 Colibri */
> > +               colibri_mci_platform_data.gpio_card_detect =
> > +                       GPIO0_COLIBRI_PXA270_SD_DETECT;
> > +       if (machine_is_colibri300())    /* PXA300 Colibri */
> > +               colibri_mci_platform_data.gpio_card_detect =
> > +                       GPIO39_COLIBRI_PXA300_SD_DETECT;
> > +       else                            /* PXA320 Colibri */
> > +               colibri_mci_platform_data.gpio_card_detect =
> > +                       GPIO28_COLIBRI_PXA320_SD_DETECT;
> > +
> > +       pxa_set_mci_info(&colibri_mci_platform_data);
> > +}
> > +#else
> > +static inline void colibri_mmc_init(void) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * USB Host
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_USB_OHCI_HCD) ||
> > defined(CONFIG_USB_OHCI_HCD_MODULE) +static int colibri_ohci_init(struct
> > device *dev)
> > +{
> > +       UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> > +       return 0;
> > +}
> > +
> > +static struct pxaohci_platform_data colibri_ohci_info = {
> > +       .port_mode      = PMM_PERPORT_MODE,
> > +       .flags          = ENABLE_PORT1 |
> > +                         POWER_CONTROL_LOW | POWER_SENSE_LOW,
> > +       .init           = colibri_ohci_init,
> > +};
> > +
> > +static void __init colibri_uhc_init(void)
> > +{
> > +       /* Colibri PXA270 has two usb ports, TBA for 320 */
> > +       if (machine_is_colibri())
> > +               colibri_ohci_info.flags |= ENABLE_PORT2;
> > +
> > +       pxa_set_ohci_info(&colibri_ohci_info);
> > +}
> > +#else
> > +static inline void colibri_uhc_init(void) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* + * I2C RTC
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_RTC_DRV_DS1307) ||
> > defined(CONFIG_RTC_DRV_DS1307_MODULE) +static struct i2c_board_info
> > __initdata colibri_i2c_devs[] = {
> > +       {
> > +               I2C_BOARD_INFO("m41t00", 0x68),
> > +       },
> > +};
> > +
> > +static void __init colibri_rtc_init(void)
> > +{
> > +       pxa_set_i2c_info(NULL);
> > +       i2c_register_board_info(0, ARRAY_AND_SIZE(colibri_i2c_devs));
> > +}
> > +#else
> > +static inline void colibri_rtc_init(void) {}
> > +#endif
> > +
> > +void __init colibri_evalboard_init(void)
> > +{
> > +       pxa_set_ffuart_info(NULL);
> > +       pxa_set_btuart_info(NULL);
> > +       pxa_set_stuart_info(NULL);
> > +
> > +       colibri_mmc_init();
> > +       colibri_uhc_init();
> > +       colibri_rtc_init();
> > +}
> > diff --git a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > b/arch/arm/mach-pxa/colibri-pxa270-evalboard.c deleted file mode 100644
> > index 7f27aec..0000000
> > --- a/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > +++ /dev/null
> > @@ -1,121 +0,0 @@
> > -/*
> > - *  linux/arch/arm/mach-pxa/colibri-pxa270-evalboard.c
> > - *
> > - *  Support for Toradex PXA270 based Colibri Evaluation Carrier Board
> > - *  Daniel Mack <daniel@caiaq.de>
> > - *  Marek Vasut <marek.vasut@gmail.com>
> > - *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License version 2 as
> > - *  published by the Free Software Foundation.
> > - */
> > -
> > -#include <linux/init.h>
> > -#include <linux/kernel.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/sysdev.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/gpio.h>
> > -#include <asm/mach-types.h>
> > -#include <mach/hardware.h>
> > -#include <asm/mach/arch.h>
> > -#include <linux/i2c.h>
> > -
> > -#include <mach/pxa27x.h>
> > -#include <mach/colibri.h>
> > -#include <mach/mmc.h>
> > -#include <mach/ohci.h>
> > -#include <mach/pxa27x-udc.h>
> > -
> > -#include <plat/i2c.h>
> > -
> > -#include "generic.h"
> > -#include "devices.h"
> > -
> > -/***********************************************************************
> > ******* - * SD/MMC card controller
> > -
> > ************************************************************************
> > ******/ -#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> > -static struct pxamci_platform_data colibri_pxa270_mci_platform_data = {
> > -       .ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
> > -       .gpio_power             = -1,
> > -       .gpio_card_ro           = -1,
> > -       .detect_delay_ms        = 200,
> > -};
> > -
> > -static void __init colibri_pxa270_mmc_init(void)
> > -{
> > -       if (machine_is_colibri())       /* PXA270 Colibri */
> > -               colibri_pxa270_mci_platform_data.gpio_card_detect =
> > -                       GPIO0_COLIBRI_PXA270_SD_DETECT;
> > -       if (machine_is_colibri300())    /* PXA300 Colibri */
> > -               colibri_pxa270_mci_platform_data.gpio_card_detect =
> > -                       GPIO39_COLIBRI_PXA300_SD_DETECT;
> > -       else                            /* PXA320 Colibri */
> > -               colibri_pxa270_mci_platform_data.gpio_card_detect =
> > -                       GPIO28_COLIBRI_PXA320_SD_DETECT;
> > -
> > -       pxa_set_mci_info(&colibri_pxa270_mci_platform_data);
> > -}
> > -#else
> > -static inline void colibri_pxa270_mmc_init(void) {}
> > -#endif
> > -
> > -/***********************************************************************
> > ******* - * USB Host
> > -
> > ************************************************************************
> > ******/ -#if defined(CONFIG_USB_OHCI_HCD) ||
> > defined(CONFIG_USB_OHCI_HCD_MODULE) -static int
> > colibri_pxa270_ohci_init(struct device *dev)
> > -{
> > -       UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;
> > -       return 0;
> > -}
> > -
> > -static struct pxaohci_platform_data colibri_pxa270_ohci_info = {
> > -       .port_mode      = PMM_PERPORT_MODE,
> > -       .flags          = ENABLE_PORT1 |
> > -                         POWER_CONTROL_LOW | POWER_SENSE_LOW,
> > -       .init           = colibri_pxa270_ohci_init,
> > -};
> > -
> > -static void __init colibri_pxa270_uhc_init(void)
> > -{
> > -       /* Colibri PXA270 has two usb ports, TBA for 320 */
> > -       if (machine_is_colibri())
> > -               colibri_pxa270_ohci_info.flags  |= ENABLE_PORT2;
> > -
> > -       pxa_set_ohci_info(&colibri_pxa270_ohci_info);
> > -}
> > -#else
> > -static inline void colibri_pxa270_uhc_init(void) {}
> > -#endif
> > -
> > -/***********************************************************************
> > ******* - * I2C RTC
> > -
> > ************************************************************************
> > ******/ -#if defined(CONFIG_RTC_DRV_DS1307) ||
> > defined(CONFIG_RTC_DRV_DS1307_MODULE) -static struct i2c_board_info
> > __initdata colibri_pxa270_i2c_devs[] = { -       {
> > -               I2C_BOARD_INFO("m41t00", 0x68),
> > -       },
> > -};
> > -
> > -static void __init colibri_pxa270_rtc_init(void)
> > -{
> > -       pxa_set_i2c_info(NULL);
> > -       i2c_register_board_info(0,
> > ARRAY_AND_SIZE(colibri_pxa270_i2c_devs)); -}
> > -#else
> > -static inline void colibri_pxa270_rtc_init(void) {}
> > -#endif
> > -
> > -void __init colibri_pxa270_evalboard_init(void)
> > -{
> > -       pxa_set_ffuart_info(NULL);
> > -       pxa_set_btuart_info(NULL);
> > -       pxa_set_stuart_info(NULL);
> > -
> > -       colibri_pxa270_mmc_init();
> > -       colibri_pxa270_uhc_init();
> > -       colibri_pxa270_rtc_init();
> > -}
> > diff --git a/arch/arm/mach-pxa/colibri-pxa270.c
> > b/arch/arm/mach-pxa/colibri-pxa270.c index 1024da5..dc05af4 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa270.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> > @@ -35,7 +35,7 @@
> >  /***********************************************************************
> > ******* * Evaluation board MFP
> >  ************************************************************************
> > ******/ -#ifdef  CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
> > +#ifdef  CONFIG_MACH_COLIBRI_EVALBOARD
> >  static mfp_cfg_t colibri_pxa270_evalboard_pin_config[] __initdata = {
> >        /* MMC */
> >        GPIO32_MMC_CLK,
> > @@ -281,10 +281,10 @@ static void __init colibri_pxa270_init(void)
> >        colibri_pxa270_tsc_init();
> > 
> >        switch (colibri_pxa270_baseboard) {
> > -       case COLIBRI_PXA270_EVALBOARD:
> > +       case COLIBRI_EVALBOARD:
> >                pxa2xx_mfp_config(ARRAY_AND_SIZE(
> >                        colibri_pxa270_evalboard_pin_config));
> > -               colibri_pxa270_evalboard_init();
> > +               colibri_evalboard_init();
> >                break;
> >        case COLIBRI_PXA270_INCOME:
> >                pxa2xx_mfp_config(ARRAY_AND_SIZE(income_pin_config));
> > diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
> > b/arch/arm/mach-pxa/colibri-pxa300.c index 5bf8055..77e760f 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa300.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> > @@ -32,7 +32,7 @@
> >  #include "devices.h"
> > 
> > 
> > -#ifdef CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
> > +#ifdef CONFIG_MACH_COLIBRI_EVALBOARD
> >  static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {
> >        /* MMC */
> >        GPIO7_MMC1_CLK,
> > @@ -173,7 +173,7 @@ void __init colibri_pxa300_init(void)
> > 
> >        /* Evalboard init */
> >      
> >  pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_evalboard_pin_config));
> > -       colibri_pxa270_evalboard_init();
> > +       colibri_evalboard_init();
> >  }
> > 
> >  MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
> > diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
> > b/arch/arm/mach-pxa/colibri-pxa320.c index 4257382..7c003cd 100644
> > --- a/arch/arm/mach-pxa/colibri-pxa320.c
> > +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> > @@ -35,7 +35,7 @@
> >  #include "generic.h"
> >  #include "devices.h"
> > 
> > -#ifdef CONFIG_MACH_COLIBRI_PXA270_EVALBOARD
> > +#ifdef CONFIG_MACH_COLIBRI_EVALBOARD
> >  static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {
> >        /* MMC */
> >        GPIO22_MMC1_CLK,
> > @@ -229,7 +229,7 @@ void __init colibri_pxa320_init(void)
> > 
> >        /* Evalboard init */
> >      
> >  pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_evalboard_pin_config));
> > -       colibri_pxa270_evalboard_init();
> > +       colibri_evalboard_init();
> >  }
> > 
> >  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
> > diff --git a/arch/arm/mach-pxa/include/mach/colibri.h
> > b/arch/arm/mach-pxa/include/mach/colibri.h index 63a948a..388a96f 100644
> > --- a/arch/arm/mach-pxa/include/mach/colibri.h
> > +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> > @@ -9,14 +9,14 @@
> >  */
> > 
> >  enum {
> > -       COLIBRI_PXA270_EVALBOARD = 0,
> > +       COLIBRI_EVALBOARD = 0,
> >        COLIBRI_PXA270_INCOME,
> >  };
> > 
> > -#if defined(CONFIG_MACH_COLIBRI_PXA270_EVALBOARD)
> > -extern void colibri_pxa270_evalboard_init(void);
> > +#if defined(CONFIG_MACH_COLIBRI_EVALBOARD)
> > +extern void colibri_evalboard_init(void);
> >  #else
> > -static inline void colibri_pxa270_evalboard_init(void) {}
> > +static inline void colibri_evalboard_init(void) {}
> >  #endif
> > 
> >  #if defined(CONFIG_MACH_COLIBRI_PXA270_INCOME)
> > --
> > 1.7.1
