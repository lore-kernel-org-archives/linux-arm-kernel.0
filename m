From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 30 May 2010 05:39:50 +0200
Subject: [PATCH v2 5/5] input: samsung-keypad - Add samsung keypad driver
In-Reply-To: <1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
Message-ID: <201005300539.50619.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 30. kv?tna 2010 05:06:24 Joonyoung Shim napsal(a):
> This patch adds support for keypad driver running on Samsung cpus. This
> driver is tested on GONI and Aquila board using S5PC110 cpu.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig          |    9 +
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/samsung-keypad.c |  364
> +++++++++++++++++++++++++++++++ 3 files changed, 374 insertions(+), 0
> deletions(-)
>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
> 
> diff --git a/drivers/input/keyboard/Kconfig
> b/drivers/input/keyboard/Kconfig index d8fa5d7..bf6a50f 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -342,6 +342,15 @@ config KEYBOARD_PXA930_ROTARY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pxa930_rotary.
> 
> +config KEYBOARD_SAMSUNG
> +	tristate "Samsung keypad support"
> +	depends on SAMSUNG_DEV_KEYPAD
> +	help
> +	  Say Y here if you want to use the Samsung keypad.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called samsung-keypad.
> +
>  config KEYBOARD_STOWAWAY
>  	tristate "Stowaway keyboard"
>  	select SERIO
> diff --git a/drivers/input/keyboard/Makefile
> b/drivers/input/keyboard/Makefile index 4596d0c..8f973ed 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
>  obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
>  obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
>  obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
> +obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
>  obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
> diff --git a/drivers/input/keyboard/samsung-keypad.c
> b/drivers/input/keyboard/samsung-keypad.c new file mode 100644
> index 0000000..f4bcf97
> --- /dev/null
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -0,0 +1,364 @@
> +/*
> + * samsung-keypad.c  --  Samsung keypad driver
> + *
> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> + * Author: Donghwa Lee <dh09.lee@samsung.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify
> it + *  under  the terms of  the GNU General  Public License as published
> by the + *  Free Software Foundation;  either version 2 of the  License,
> or (at your + *  option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <plat/cpu.h>
> +#include <plat/keypad.h>
> +#include <plat/regs-keypad.h>
> +
> +struct samsung_kp {
> +	struct input_dev *input_dev;
> +	struct timer_list timer;
> +	struct clk *clk;
> +	struct work_struct work;
> +	void __iomem *base;
> +	unsigned short *keycodes;
> +	unsigned int row_shift;
> +	unsigned int rows;
> +	unsigned int cols;
> +	unsigned int row_state[SAMSUNG_MAX_COLS];
> +	int irq;
> +};
> +
> +static void samsung_kp_scan(struct samsung_kp *keypad, unsigned int
> *row_state) +{
> +	unsigned int col;
> +	unsigned int val;
> +
> +	for (col = 0; col < keypad->cols; col++) {
> +#if CONFIG_ARCH_S5PV210
> +		val = S5PV210_KEYIFCOLEN_MASK;
> +		val &= ~(1 << col) << 8;
> +#else
> +		val = SAMSUNG_KEYIFCOL_MASK;
> +		val &= ~(1 << col);
> +#endif


No, what if you want to run this on both S5PV210 and some other samsung soc?
Fix the #if CONFIG_ARCH_S5PV210 please. Maybe like this:

if (cpu_is_s5pv210()) {} else {} ?

The rest looks good.

Cheers!
