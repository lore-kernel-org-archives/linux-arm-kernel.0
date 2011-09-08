From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 8 Sep 2011 09:28:50 +0530
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
	option
In-Reply-To: <20110907214954.GA32235@core.coreip.homeip.net>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<20110907182248.GA2874@core.coreip.homeip.net>
	<20110907214954.GA32235@core.coreip.homeip.net>
Message-ID: <CAJuYYwSMLOZD9b2F=yYQnUQ2BgB69smaeQJmopk3izR7gEjNyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 8 September 2011 03:19, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

[...]

> BTW, should we do something like below?
>
> Thanks.
>
> --
> Dmitry
>
> Input: samsung-keypad - enable compiling on other platforms
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> There is nothing in keypad platform definitions that requires
> the driver be complied on Samsung platform only, so let's move them
> out of the platform subdirectory and relax the dependencies.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> ?arch/arm/plat-samsung/include/plat/keypad.h | ? 27 +----------------
> ?drivers/input/keyboard/Kconfig ? ? ? ? ? ? ?| ? ?5 ++-
> ?drivers/input/keyboard/samsung-keypad.c ? ? | ? ?2 +
> ?include/linux/input/samsung-keypad.h ? ? ? ?| ? 43 +++++++++++++++++++++++++++
> ?4 files changed, 48 insertions(+), 29 deletions(-)
> ?create mode 100644 include/linux/input/samsung-keypad.h
>
>
> diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/plat-samsung/include/plat/keypad.h
> index b59a648..8fddee3 100644
> --- a/arch/arm/plat-samsung/include/plat/keypad.h
> +++ b/arch/arm/plat-samsung/include/plat/keypad.h
> @@ -13,32 +13,7 @@
> ?#ifndef __PLAT_SAMSUNG_KEYPAD_H
> ?#define __PLAT_SAMSUNG_KEYPAD_H
>
> -#include <linux/input/matrix_keypad.h>
> -
> -#define SAMSUNG_MAX_ROWS ? ? ? 8
> -#define SAMSUNG_MAX_COLS ? ? ? 8
> -
> -/**
> - * struct samsung_keypad_platdata - Platform device data for Samsung Keypad.
> - * @keymap_data: pointer to &matrix_keymap_data.
> - * @rows: number of keypad row supported.
> - * @cols: number of keypad col supported.
> - * @no_autorepeat: disable key autorepeat.
> - * @wakeup: controls whether the device should be set up as wakeup source.
> - * @cfg_gpio: configure the GPIO.
> - *
> - * Initialisation data specific to either the machine or the platform
> - * for the device driver to use or call-back when configuring gpio.
> - */
> -struct samsung_keypad_platdata {
> - ? ? ? const struct matrix_keymap_data *keymap_data;
> - ? ? ? unsigned int rows;
> - ? ? ? unsigned int cols;
> - ? ? ? bool no_autorepeat;
> - ? ? ? bool wakeup;
> -
> - ? ? ? void (*cfg_gpio)(unsigned int rows, unsigned int cols);
> -};
> +#include <linux/input/samsung_keypad.h>
>
> ?/**
> ?* samsung_keypad_set_platdata - Set platform data for Samsung Keypad device.
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index de846f8..db1b221 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -434,9 +434,10 @@ config KEYBOARD_PMIC8XXX
>
> ?config KEYBOARD_SAMSUNG
> ? ? ? ?tristate "Samsung keypad support"
> - ? ? ? depends on SAMSUNG_DEV_KEYPAD
> + ? ? ? depends on HAVE_CLK
> ? ? ? ?help
> - ? ? ? ? Say Y here if you want to use the Samsung keypad.
> + ? ? ? ? Say Y here if you want to use the keypad on your Samsung mobile
> + ? ? ? ? device.

In this case, Samsung Keyboad option would be listed in the available
keyboard list in menuconfig for non-samsung platforms as well. Knowing
that Samsung keypad controller has been used only in Samsung
Application Processor SoC's only (and would be this way for quite
sometime), should we not retain its selection to Samsung AP SoC's
only?

>
> ? ? ? ? ?To compile this driver as a module, choose M here: the
> ? ? ? ? ?module will be called samsung-keypad.
> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
> index d244fdf..1a2b755 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -22,7 +22,7 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/slab.h>
> ?#include <linux/sched.h>
> -#include <plat/keypad.h>
> +#include <linux/input/samsung-keypad.h>
>
> ?#define SAMSUNG_KEYIFCON ? ? ? ? ? ? ? ? ? ? ? 0x00
> ?#define SAMSUNG_KEYIFSTSCLR ? ? ? ? ? ? ? ? ? ?0x04
> diff --git a/include/linux/input/samsung-keypad.h b/include/linux/input/samsung-keypad.h
> new file mode 100644
> index 0000000..f25619b
> --- /dev/null
> +++ b/include/linux/input/samsung-keypad.h
> @@ -0,0 +1,43 @@
> +/*
> + * Samsung Keypad platform data definitions
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + *
> + * This program is free software; you can redistribute ?it and/or modify it
> + * under ?the terms of ?the GNU General ?Public License as published by the
> + * Free Software Foundation; ?either version 2 of the ?License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __SAMSUNG_KEYPAD_H
> +#define __SAMSUNG_KEYPAD_H
> +
> +#include <linux/input/matrix_keypad.h>
> +
> +#define SAMSUNG_MAX_ROWS ? ? ? 8
> +#define SAMSUNG_MAX_COLS ? ? ? 8
> +
> +/**
> + * struct samsung_keypad_platdata - Platform device data for Samsung Keypad.
> + * @keymap_data: pointer to &matrix_keymap_data.
> + * @rows: number of keypad row supported.
> + * @cols: number of keypad col supported.
> + * @no_autorepeat: disable key autorepeat.
> + * @wakeup: controls whether the device should be set up as wakeup source.
> + * @cfg_gpio: configure the GPIO.
> + *
> + * Initialisation data specific to either the machine or the platform
> + * for the device driver to use or call-back when configuring gpio.
> + */
> +struct samsung_keypad_platdata {
> + ? ? ? const struct matrix_keymap_data *keymap_data;
> + ? ? ? unsigned int rows;
> + ? ? ? unsigned int cols;
> + ? ? ? bool no_autorepeat;
> + ? ? ? bool wakeup;
> +
> + ? ? ? void (*cfg_gpio)(unsigned int rows, unsigned int cols);
> +};
> +
> +#endif /* __SAMSUNG_KEYPAD_H */
>

The movement of samsung-keypad.h to include/linux/input would be
helpful if it is decided to make samsung-keypad driver available to
non-samsung platforms as well.

Thanks,
Thomas.
