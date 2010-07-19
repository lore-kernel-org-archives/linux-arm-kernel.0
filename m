From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 19 Jul 2010 16:54:30 +0200
Subject: [PATCH 4/9] [ARM] pxa: removed mostly unused and confusing two
	sharpsl.h
In-Reply-To: <1279537144-25424-4-git-send-email-eric.y.miao@gmail.com>
References: <1279537144-25424-1-git-send-email-eric.y.miao@gmail.com>
	<1279537144-25424-4-git-send-email-eric.y.miao@gmail.com>
Message-ID: <201007191654.30782.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 19. ?ervence 2010 12:58:59 Eric Miao napsal(a):
> Only a small part of used code is moved into sharpsl_pm.h.

Hey, please don't forget to merge those two zaurus patches I posted. I can take 
C3200 with me tomorrow if you want. I can take C3000 with me too, but we'll have 
to figure out how to return the original flash back (as it's not mine).

Or maybe we should just avoid talking about/doing any work ... :)
> 
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/mach-pxa/corgi.c                   |    3 +-
>  arch/arm/mach-pxa/corgi_pm.c                |    3 +-
>  arch/arm/mach-pxa/include/mach/sharpsl.h    |   35
> --------------------------- arch/arm/mach-pxa/include/mach/sharpsl_pm.h | 
>   9 +++++++
>  arch/arm/mach-pxa/poodle.c                  |    2 -
>  arch/arm/mach-pxa/sharpsl.h                 |   26 --------------------
>  arch/arm/mach-pxa/sharpsl_pm.c              |    3 --
>  arch/arm/mach-pxa/spitz.c                   |    2 +-
>  arch/arm/mach-pxa/spitz_pm.c                |    3 +-
>  9 files changed, 13 insertions(+), 73 deletions(-)
>  delete mode 100644 arch/arm/mach-pxa/include/mach/sharpsl.h
>  delete mode 100644 arch/arm/mach-pxa/sharpsl.h
> 
> diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
> index 34ddc3a..1e25337 100644
> --- a/arch/arm/mach-pxa/corgi.c
> +++ b/arch/arm/mach-pxa/corgi.c
> @@ -50,14 +50,13 @@
>  #include <mach/udc.h>
>  #include <mach/pxa2xx_spi.h>
>  #include <mach/corgi.h>
> -#include <mach/sharpsl.h>
> +#include <mach/sharpsl_pm.h>
> 
>  #include <asm/mach/sharpsl_param.h>
>  #include <asm/hardware/scoop.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> -#include "sharpsl.h"
> 
>  static unsigned long corgi_pin_config[] __initdata = {
>  	/* Static Memory I/O */
> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
> index 41cf945..2903477 100644
> --- a/arch/arm/mach-pxa/corgi_pm.c
> +++ b/arch/arm/mach-pxa/corgi_pm.c
> @@ -23,12 +23,11 @@
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
> 
> -#include <mach/sharpsl.h>
>  #include <mach/corgi.h>
>  #include <mach/pxa2xx-regs.h>
> +#include <mach/sharpsl_pm.h>
> 
>  #include "generic.h"
> -#include "sharpsl.h"
> 
>  #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
>  #define SHARPSL_CHARGE_ON_TEMP         0xe0  /* 2.9V */
> diff --git a/arch/arm/mach-pxa/include/mach/sharpsl.h
> b/arch/arm/mach-pxa/include/mach/sharpsl.h deleted file mode 100644
> index 8242e14..0000000
> --- a/arch/arm/mach-pxa/include/mach/sharpsl.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - * SharpSL SSP Driver
> - */
> -
> -unsigned long corgi_ssp_ads7846_putget(unsigned long);
> -unsigned long corgi_ssp_ads7846_get(void);
> -void corgi_ssp_ads7846_put(unsigned long data);
> -void corgi_ssp_ads7846_lock(void);
> -void corgi_ssp_ads7846_unlock(void);
> -void corgi_ssp_lcdtg_send (unsigned char adrs, unsigned char data);
> -void corgi_ssp_blduty_set(int duty);
> -int corgi_ssp_max1111_get(unsigned long data);
> -
> -/*
> - * SharpSL Touchscreen Driver
> - */
> -
> -struct corgits_machinfo {
> -	unsigned long (*get_hsync_invperiod)(void);
> -	void (*put_hsync)(void);
> -	void (*wait_hsync)(void);
> -};
> -
> -
> -/*
> - * SharpSL Backlight
> - */
> -extern void corgibl_limit_intensity(int limit);
> -extern void corgi_lcd_limit_intensity(int limit);
> -
> -
> -/*
> - * SharpSL Battery/PM Driver
> - */
> -extern void sharpsl_battery_kick(void);
> diff --git a/arch/arm/mach-pxa/include/mach/sharpsl_pm.h
> b/arch/arm/mach-pxa/include/mach/sharpsl_pm.h index 1920dc6..905be67
> 100644
> --- a/arch/arm/mach-pxa/include/mach/sharpsl_pm.h
> +++ b/arch/arm/mach-pxa/include/mach/sharpsl_pm.h
> @@ -93,6 +93,8 @@ struct sharpsl_pm_status {
> 
>  extern struct sharpsl_pm_status sharpsl_pm;
> 
> +extern struct battery_thresh sharpsl_battery_levels_acin[];
> +extern struct battery_thresh sharpsl_battery_levels_noac[];
> 
>  #define SHARPSL_LED_ERROR  2
>  #define SHARPSL_LED_ON     1
> @@ -101,4 +103,11 @@ extern struct sharpsl_pm_status sharpsl_pm;
>  void sharpsl_battery_kick(void);
>  void sharpsl_pm_led(int val);
> 
> +/* MAX1111 Channel Definitions */
> +#define MAX1111_BATT_VOLT   4u
> +#define MAX1111_BATT_TEMP   2u
> +#define MAX1111_ACIN_VOLT   6u
> +int sharpsl_pm_pxa_read_max1111(int channel);
> +
> +void corgi_lcd_limit_intensity(int limit);
>  #endif
> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index f4abdaa..41c8948 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -43,7 +43,6 @@
>  #include <mach/irda.h>
>  #include <mach/poodle.h>
>  #include <mach/pxafb.h>
> -#include <mach/sharpsl.h>
>  #include <mach/pxa2xx_spi.h>
>  #include <plat/i2c.h>
> 
> @@ -53,7 +52,6 @@
> 
>  #include "generic.h"
>  #include "devices.h"
> -#include "sharpsl.h"
> 
>  static unsigned long poodle_pin_config[] __initdata = {
>  	/* I/O */
> diff --git a/arch/arm/mach-pxa/sharpsl.h b/arch/arm/mach-pxa/sharpsl.h
> deleted file mode 100644
> index 0cc1203..0000000
> --- a/arch/arm/mach-pxa/sharpsl.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * Copyright (c) 2004-2005 Richard Purdie
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - */
> -
> -#include <mach/sharpsl_pm.h>
> -
> -/*
> - * SharpSL Battery/PM Driver
> - */
> -#define READ_GPIO_BIT(x)    (GPLR(x) & GPIO_bit(x))
> -
> -/* MAX1111 Channel Definitions */
> -#define MAX1111_BATT_VOLT   4u
> -#define MAX1111_BATT_TEMP   2u
> -#define MAX1111_ACIN_VOLT   6u
> -
> -extern struct battery_thresh sharpsl_battery_levels_acin[];
> -extern struct battery_thresh sharpsl_battery_levels_noac[];
> -int sharpsl_pm_pxa_read_max1111(int channel);
> -
> -
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c
> b/arch/arm/mach-pxa/sharpsl_pm.c index d8c5301..8fed027 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
> @@ -29,11 +29,8 @@
>  #include <mach/pm.h>
>  #include <mach/pxa2xx-regs.h>
>  #include <mach/regs-rtc.h>
> -#include <mach/sharpsl.h>
>  #include <mach/sharpsl_pm.h>
> 
> -#include "sharpsl.h"
> -
>  /*
>   * Constants
>   */
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index ddf7a11..5153bf3 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -44,10 +44,10 @@
>  #include <mach/pxafb.h>
>  #include <mach/pxa2xx_spi.h>
>  #include <mach/spitz.h>
> +#include <mach/sharpsl_pm.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> -#include "sharpsl.h"
> 
>  static unsigned long spitz_pin_config[] __initdata = {
>  	/* Chip Selects */
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> index 53103d3..7fe7406 100644
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ b/arch/arm/mach-pxa/spitz_pm.c
> @@ -22,11 +22,10 @@
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
> 
> -#include <mach/sharpsl.h>
>  #include <mach/spitz.h>
>  #include <mach/pxa27x.h>
> +#include <mach/sharpsl_pm.h>
> 
> -#include "sharpsl.h"
>  #include "generic.h"
> 
>  #define SHARPSL_CHARGE_ON_VOLT         0x99  /* 2.9V */
