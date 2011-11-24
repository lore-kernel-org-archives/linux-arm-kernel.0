From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 24 Nov 2011 14:56:36 +0100
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <20174.19732.607965.664497@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Rusko writes:
> This patch is based on the Freescale SDK 2010.08. It supports the on-chip
> Low Resolution ADC and a capacitive touchscreen connected to it.
> 
> Tested on Ka-Ro TX28 module
> 
> Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
> ---
>  arch/arm/mach-mxs/devices-mx28.h                |    6 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-mxs-lradc.c  |   25 +
>  arch/arm/mach-mxs/devices/platform-mxs-ts.c     |   34 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |   22 +
>  arch/arm/mach-mxs/include/mach/lradc.h          |   61 ++
>  arch/arm/mach-mxs/include/mach/mx28.h           |    4 +-
>  arch/arm/mach-mxs/include/mach/regs-lradc.h     |  772 +++++++++++++++++++++++
>  drivers/input/touchscreen/Kconfig               |   11 +
>  drivers/input/touchscreen/Makefile              |    1 +
>  drivers/input/touchscreen/mxs_ts.c              |  470 ++++++++++++++
>  drivers/misc/Kconfig                            |    3 +
>  drivers/misc/Makefile                           |    1 +
>  drivers/misc/mxs_lradc.c                        |  381 +++++++++++
>  15 files changed, 1793 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-lradc.c
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-ts.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/lradc.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/regs-lradc.h
>  create mode 100644 drivers/input/touchscreen/mxs_ts.c
>  create mode 100644 drivers/misc/mxs_lradc.c
> 
> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> index c888710..b0efa25 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -46,6 +46,12 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
>  struct platform_device *__init mx28_add_mxsfb(
>  		const struct mxsfb_platform_data *pdata);
>  
> +struct platform_device * __init mx28_add_lradc(
> +		const struct mxs_lradc_plat_data *pdata);
> +
> +struct platform_device *__init mx28_add_ts(
> +		const struct mxs_touchscreen_plat_data *pdata);
> +
>  extern const struct mxs_saif_data mx28_saif_data[] __initconst;
>  #define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
>  
> diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
> index 18b6bf5..58d1c1e 100644
> --- a/arch/arm/mach-mxs/devices/Kconfig
> +++ b/arch/arm/mach-mxs/devices/Kconfig
> @@ -15,6 +15,9 @@ config MXS_HAVE_PLATFORM_FLEXCAN
>  config MXS_HAVE_PLATFORM_MXS_I2C
>  	bool
>  
> +config MXS_HAVE_PLATFORM_MXS_LRADC
> +	bool
> +
>  config MXS_HAVE_PLATFORM_MXS_MMC
>  	bool
>  
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> index f52e3e5..9ba66ed 100644
> --- a/arch/arm/mach-mxs/devices/Makefile
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -4,6 +4,7 @@ obj-y += platform-dma.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_I2C) += platform-mxs-i2c.o
> +obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_LRADC) += platform-mxs-lradc.o platform-mxs-ts.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
>  obj-y += platform-gpio-mxs.o
> diff --git a/arch/arm/mach-mxs/devices/platform-mxs-lradc.c b/arch/arm/mach-mxs/devices/platform-mxs-lradc.c
> new file mode 100644
> index 0000000..d1af2ec
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-mxs-lradc.c
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include <mach/devices-common.h>
> +#include <mach/mx28.h>
> +
> +struct platform_device * __init mx28_add_lradc(
> +		const struct mxs_lradc_plat_data *pdata)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = MX28_LRADC_BASE_ADDR,
> +			.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
> +			.flags = IORESOURCE_MEM,
> +		},
> +	};
> +
> +	return mxs_add_platform_device("mxs-lradc", 0,
> +			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
> +}
> diff --git a/arch/arm/mach-mxs/devices/platform-mxs-ts.c b/arch/arm/mach-mxs/devices/platform-mxs-ts.c
> new file mode 100644
> index 0000000..05343af
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-mxs-ts.c
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include <mach/devices-common.h>
> +#include <mach/mx28.h>
> +
> +struct platform_device *__init mx28_add_ts(
> +		const struct mxs_touchscreen_plat_data *pdata)
> +{
> +	struct resource res[] = {
> +		{
> +		 .flags = IORESOURCE_MEM,
> +		 .start = MX28_LRADC_BASE_ADDR,
> +		 .end   = MX28_LRADC_BASE_ADDR + 0x2000 - 1,
>
'MX28_LRADC_BASE_ADDR + SZ_4K - 1' would be more than sufficient.
> +		}, {
> +		 .flags = IORESOURCE_IRQ,
> +		 .start = MX28_INT_LRADC_TOUCH,
> +		 .end   = MX28_INT_LRADC_TOUCH,
> +		}, {
> +		 .flags = IORESOURCE_IRQ,
> +		 .start = MX28_INT_LRADC_CH5,
> +		 .end   = MX28_INT_LRADC_CH5,
>
strange indentation.

> +
> +	return mxs_add_platform_device("mxs-ts", 0,
> +			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
> +
> +}
> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index a8080f4..e86b193 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -76,6 +76,12 @@ struct mxs_mxs_i2c_data {
>  struct platform_device * __init mxs_add_mxs_i2c(
>  		const struct mxs_mxs_i2c_data *data);
>  
> +/* lradc */
> +struct mxs_lradc_plat_data {
> +	unsigned int vddio_voltage;
> +	unsigned int battery_voltage;
> +};
> +
>  /* mmc */
>  #include <mach/mmc.h>
>  struct mxs_mxs_mmc_data {
> @@ -104,3 +110,19 @@ struct mxs_saif_data {
>  
>  struct platform_device *__init mxs_add_saif(
>  		const struct mxs_saif_data *data);
> +
> +/* touchscreen */
> +struct mxs_touchscreen_plat_data {
> +	u8 x_plus_chan;
> +	u8 x_minus_chan;
> +	u8 y_plus_chan;
> +	u8 y_minus_chan;
> +	unsigned int x_plus_val;
> +	unsigned int x_minus_val;
> +	unsigned int y_plus_val;
> +	unsigned int y_minus_val;
> +	unsigned int x_plus_mask;
> +	unsigned int x_minus_mask;
> +	unsigned int y_plus_mask;
> +	unsigned int y_minus_mask;
> +};
> diff --git a/arch/arm/mach-mxs/include/mach/lradc.h b/arch/arm/mach-mxs/include/mach/lradc.h
> new file mode 100644
> index 0000000..c2c0a7d
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/lradc.h
> @@ -0,0 +1,61 @@
> +/*
> + * Freescale STMP37XX/STMP378X LRADC helper interface
> + *
> + * Embedded Alley Solutions, Inc <source@embeddedalley.com>
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#ifndef __ASM_PLAT_LRADC_H
> +#define __ASM_PLAT_LRADC_H
> +
> +int hw_lradc_use_channel(int);
> +int hw_lradc_unuse_channel(int);
> +extern u32 hw_lradc_vddio(void);
> +void hw_lradc_set_delay_trigger_kick(int trigger, int value);
> +void hw_lradc_configure_channel(int channel, int enable_div2,
> +		int enable_acc, int samples);
> +int hw_lradc_present(int channel);
> +int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling);
> +int hw_lradc_stop_ladder(int channel, int trigger);
> +void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
> +		u32 delay_triggers, u32 loops, u32 delays);
> +void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
> +		u32 delay_triggers);
> +
> +
> +#define LRADC_CH0		0
> +#define LRADC_CH1		1
> +#define LRADC_CH2		2
> +#define LRADC_CH3		3
> +#define LRADC_CH4		4
> +#define LRADC_CH5		5
> +#define LRADC_CH6		6
> +#define LRADC_CH7		7
> +#define LRADC_TOUCH_X_PLUS	LRADC_CH2
> +#define LRADC_TOUCH_Y_PLUS	LRADC_CH3
> +#define LRADC_TOUCH_X_MINUS	LRADC_CH4
> +#define LRADC_TOUCH_Y_MINUS	LRADC_CH5
> +#define VDDIO_VOLTAGE_CH	LRADC_CH6
> +#define BATTERY_VOLTAGE_CH	LRADC_CH7
> +
> +#define LRADC_CLOCK_6MHZ	0
> +#define LRADC_CLOCK_4MHZ	1
> +#define LRADC_CLOCK_3MHZ	2
> +#define LRADC_CLOCK_2MHZ	3
> +
> +#define LRADC_DELAY_TRIGGER_BUTTON	0
> +#define LRADC_DELAY_TRIGGER_BATTERY	1
> +#define LRADC_DELAY_TRIGGER_TOUCHSCREEN	2
> +#define LRADC_DELAY_TRIGGER_DIE		3
> +
> +#endif /* __ASM_PLAT_LRADC_H */
> diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
> index 75d8611..30c7990 100644
> --- a/arch/arm/mach-mxs/include/mach/mx28.h
> +++ b/arch/arm/mach-mxs/include/mach/mx28.h
> @@ -104,8 +104,8 @@
>  #define MX28_INT_CAN1			9
>  #define MX28_INT_LRADC_TOUCH		10
>  #define MX28_INT_HSADC			13
> -#define MX28_INT_IRADC_THRESH0		14
> -#define MX28_INT_IRADC_THRESH1		15
> +#define MX28_INT_LRADC_THRESH0		14
> +#define MX28_INT_LRADC_THRESH1		15
>  #define MX28_INT_LRADC_CH0		16
>  #define MX28_INT_LRADC_CH1		17
>  #define MX28_INT_LRADC_CH2		18
> diff --git a/arch/arm/mach-mxs/include/mach/regs-lradc.h b/arch/arm/mach-mxs/include/mach/regs-lradc.h
> new file mode 100644
> index 0000000..d7906b9
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/regs-lradc.h
> @@ -0,0 +1,772 @@
> +/*
> + * Freescale LRADC Register Definitions
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + *
> + * This file is created by xml file. Don't Edit it.
> + *
> + * Xml Revision: 1.50
> + * Template revision: 26195
> + */
> +
> +#ifndef __ARCH_ARM___LRADC_H
> +#define __ARCH_ARM___LRADC_H
> +
> +
> +#define HW_LRADC_CTRL0	(0x00000000)
> +#define HW_LRADC_CTRL0_SET	(0x00000004)
> +#define HW_LRADC_CTRL0_CLR	(0x00000008)
> +#define HW_LRADC_CTRL0_TOG	(0x0000000c)
> +
useless parens.
more of these follow...
[...]
> + *  multi-register-define name HW_LRADC_DELAYn
> + *              base 0x000000D0
> + *              count 4
> + *              offset 0x10
> + */
> +#define HW_LRADC_DELAYn(n)	(0x000000d0 + (n) * 0x10)
> +#define HW_LRADC_DELAYn_SET(n)	(0x000000d4 + (n) * 0x10)
> +#define HW_LRADC_DELAYn_CLR(n)	(0x000000d8 + (n) * 0x10)
> +#define HW_LRADC_DELAYn_TOG(n)	(0x000000dc + (n) * 0x10)
>
You should use MXS_SET_ADDR, MXS_CLR_ADDR, MXS_TOG_ADDR here.
Thus:
|#define HW_LRADC_DELAYn_SET(n)		(HW_LRADC_DELAYn(n) + MXS_SET_ADDR)
|#define HW_LRADC_DELAYn_CLR(n)		(HW_LRADC_DELAYn(n) + MXS_CLR_ADDR)
|#define HW_LRADC_DELAYn_TOG(n)		(HW_LRADC_DELAYn(n) + MXS_TOG_ADDR)
or use the __mxs_setl(), __mxs_clrl(), __mxs_togl() functions instead.

> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 3488ffe..36bd3cf 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -339,6 +339,17 @@ config TOUCHSCREEN_HP7XX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called jornada720_ts.
>  
> +config TOUCHSCREEN_MXS
> +	tristate "MXS LRADC-based touchscreen"
> +	depends on MXS_LRADC
> +	select SERIO
> +	help
> +	  Say Y here if you want to enable touchscreen, connected to MXS
> +	  Low-Resoulion ADC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mxs_ts.
> +
>  config TOUCHSCREEN_HTCPEN
>  	tristate "HTC Shift X9500 touchscreen"
>  	depends on ISA
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f957676..6c3728c 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
>  obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
>  obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_MXS)		+= mxs_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
>  obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
>  obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
> diff --git a/drivers/input/touchscreen/mxs_ts.c b/drivers/input/touchscreen/mxs_ts.c
> new file mode 100644
> index 0000000..ad05c3f
> --- /dev/null
> +++ b/drivers/input/touchscreen/mxs_ts.c
> @@ -0,0 +1,470 @@
> +/*
> + * Freesclae MXS Touchscreen driver
> + *
> + * Author: Vitaly Wool <vital@embeddedalley.com>
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/lradc.h>
> +#include <mach/devices-common.h>
> +#include <mach/regs-lradc.h>
> +#include <mach/mxs.h>
> +
> +#define TOUCH_DEBOUNCE_TOLERANCE	100
> +
> +struct mxs_ts_info {
> +	int touch_irq;
> +	int device_irq;
> +	unsigned int base;
>
void __iomem *base;

> +	u8 x_plus_chan;
> +	u8 x_minus_chan;
> +	u8 y_plus_chan;
> +	u8 y_minus_chan;
> +
> +	unsigned int x_plus_val;
> +	unsigned int x_minus_val;
> +	unsigned int y_plus_val;
> +	unsigned int y_minus_val;
> +	unsigned int x_plus_mask;
> +	unsigned int x_minus_mask;
> +	unsigned int y_plus_mask;
> +	unsigned int y_minus_mask;
> +
> +	struct input_dev *idev;
> +	enum {
> +		TS_STATE_DISABLED,
> +		TS_STATE_TOUCH_DETECT,
> +		TS_STATE_TOUCH_VERIFY,
> +		TS_STATE_X_PLANE,
> +		TS_STATE_Y_PLANE,
> +	} state;
> +	u16 x;
> +	u16 y;
> +	int sample_count;
> +};
> +
> +static inline void enter_state_touch_detect(struct mxs_ts_info *info)
> +{
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_minus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_minus_chan));
>
writel() instead of __raw_writel()?
Also: writing a '0' to the regular register address would be clearer
here:
	 writel(0, info->base + HW_LRADC_CHn(info->x_plus_chan));

> +
> +	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
> +		     info->base + HW_LRADC_CTRL1_CLR);
> +	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
> +		     info->base + HW_LRADC_CTRL1_CLR);
> +	/*
> +	 * turn off the yplus and yminus pullup and pulldown, and turn off touch
> +	 * detect (enables yminus, and xplus through a resistor.On a press,
> +	 * xplus is pulled down)
> +	 */
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_SET);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
> +	info->state = TS_STATE_TOUCH_DETECT;
> +	info->sample_count = 0;
> +}
> +
> +static inline void enter_state_disabled(struct mxs_ts_info *info)
> +{
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_CLR);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
> +	info->state = TS_STATE_DISABLED;
> +	info->sample_count = 0;
> +}
> +
> +
> +static inline void enter_state_x_plane(struct mxs_ts_info *info)
> +{
> +	__raw_writel(info->y_plus_val, info->base + HW_LRADC_CTRL0_SET);
> +	__raw_writel(info->y_minus_val, info->base + HW_LRADC_CTRL0_SET);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_CLR);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +
> +	info->state = TS_STATE_X_PLANE;
> +	info->sample_count = 0;
> +}
> +
> +static inline void enter_state_y_plane(struct mxs_ts_info *info)
> +{
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_val, info->base + HW_LRADC_CTRL0_SET);
> +	__raw_writel(info->x_minus_val, info->base + HW_LRADC_CTRL0_SET);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_CLR);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +	info->state = TS_STATE_Y_PLANE;
> +	info->sample_count = 0;
> +}
> +
> +static inline void enter_state_touch_verify(struct mxs_ts_info *info)
> +{
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_SET);
> +	info->state = TS_STATE_TOUCH_VERIFY;
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +	info->sample_count = 0;
> +}
> +
> +static void process_lradc(struct mxs_ts_info *info, u16 x, u16 y,
> +			int pressure)
> +{
> +	switch (info->state) {
> +	case TS_STATE_X_PLANE:
> +		pr_debug("%s: x plane state, sample_count %d\n", __func__,
> +				info->sample_count);
> +		if (info->sample_count < 2) {
> +			info->x = x;
> +			info->sample_count++;
> +		} else {
> +			if (abs(info->x - x) > TOUCH_DEBOUNCE_TOLERANCE)
> +				info->sample_count = 1;
> +			else {
> +				u16 x_c = info->x * (info->sample_count - 1);
> +				info->x = (x_c + x) / info->sample_count;
> +				info->sample_count++;
> +			}
> +		}
> +		if (info->sample_count > 4)
> +			enter_state_y_plane(info);
> +		else
> +			hw_lradc_set_delay_trigger_kick(
> +					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +		break;
> +
> +	case TS_STATE_Y_PLANE:
> +		pr_debug("%s: y plane state, sample_count %d\n", __func__,
> +				info->sample_count);
> +		if (info->sample_count < 2) {
> +			info->y = y;
> +			info->sample_count++;
> +		} else {
> +			if (abs(info->y - y) > TOUCH_DEBOUNCE_TOLERANCE)
> +				info->sample_count = 1;
> +			else {
> +				u16 y_c = info->y * (info->sample_count - 1);
> +				info->y = (y_c + y) / info->sample_count;
> +				info->sample_count++;
> +			}
> +		}
> +		if (info->sample_count > 4)
> +			enter_state_touch_verify(info);
> +		else
> +			hw_lradc_set_delay_trigger_kick(
> +					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +		break;
> +
> +	case TS_STATE_TOUCH_VERIFY:
> +		pr_debug("%s: touch verify state, sample_count %d\n", __func__,
> +				info->sample_count);
> +		pr_debug("%s: x %d, y %d\n", __func__, info->x, info->y);
> +		input_report_abs(info->idev, ABS_X, info->x);
> +		input_report_abs(info->idev, ABS_Y, info->y);
> +		input_report_abs(info->idev, ABS_PRESSURE, pressure);
> +		input_sync(info->idev);
> +		/* fall through */
> +	case TS_STATE_TOUCH_DETECT:
> +		pr_debug("%s: touch detect state, sample_count %d\n", __func__,
> +				info->sample_count);
> +		if (pressure) {
> +			input_report_abs(info->idev, ABS_PRESSURE, pressure);
> +			enter_state_x_plane(info);
> +			hw_lradc_set_delay_trigger_kick(
> +					LRADC_DELAY_TRIGGER_TOUCHSCREEN, 1);
> +		} else
> +			enter_state_touch_detect(info);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: unknown touchscreen state %d\n", __func__,
> +				info->state);
> +	}
> +}
> +
> +static irqreturn_t ts_handler(int irq, void *dev_id)
> +{
> +	struct mxs_ts_info *info = dev_id;
> +	u16 x_plus, y_plus;
> +	int pressure = 0;
> +
> +	if (irq == info->touch_irq)
> +		__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
> +			     info->base + HW_LRADC_CTRL1_CLR);
> +	else if (irq == info->device_irq)
> +		__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
> +			     info->base + HW_LRADC_CTRL1_CLR);
> +
> +	/* get x, y values */
> +	x_plus = __raw_readl(info->base + HW_LRADC_CHn(info->x_plus_chan)) &
> +		BM_LRADC_CHn_VALUE;
> +	y_plus = __raw_readl(info->base + HW_LRADC_CHn(info->y_plus_chan)) &
> +		BM_LRADC_CHn_VALUE;
> +
> +	/* pressed? */
> +	if (__raw_readl(info->base + HW_LRADC_STATUS) &
> +	    BM_LRADC_STATUS_TOUCH_DETECT_RAW)
> +		pressure = 1;
> +
> +	pr_debug("%s: irq %d, x_plus %d, y_plus %d, pressure %d\n",
> +			__func__, irq, x_plus, y_plus, pressure);
> +
> +	process_lradc(info, x_plus, y_plus, pressure);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit mxs_ts_probe(struct platform_device *pdev)
> +{
> +	struct input_dev *idev;
> +	struct mxs_ts_info *info;
> +	int ret = 0;
> +	struct resource *res;
> +	struct mxs_touchscreen_plat_data *plat_data;
> +
> +	plat_data = (struct mxs_touchscreen_plat_data *)pdev->dev.platform_data;
>
useless type cast.

> +	if (plat_data == NULL)
> +		return -ENODEV;
> +
> +	idev = input_allocate_device();
> +	if (idev == NULL)
> +		return -ENOMEM;
> +
> +	info = kzalloc(sizeof(struct mxs_ts_info), GFP_KERNEL);
> +	if (info == NULL) {
> +		ret = -ENOMEM;
> +		goto out_nomem_info;
> +	}
> +
> +	idev->name = "MXS touchscreen";
> +	idev->evbit[0] = BIT(EV_ABS);
> +	input_set_abs_params(idev, ABS_X, 0, 0xFFF, 0, 0);
> +	input_set_abs_params(idev, ABS_Y, 0, 0xFFF, 0, 0);
> +	input_set_abs_params(idev, ABS_PRESSURE, 0, 1, 0, 0);
> +
> +	ret = input_register_device(idev);
> +	if (ret)
> +		goto out_nomem;
> +
> +	info->idev = idev;
> +	info->x_plus_chan = plat_data->x_plus_chan;
> +	info->x_minus_chan = plat_data->x_minus_chan;
> +	info->y_plus_chan = plat_data->y_plus_chan;
> +	info->y_minus_chan = plat_data->y_minus_chan;
> +	info->x_plus_val = plat_data->x_plus_val;
> +	info->x_minus_val = plat_data->x_minus_val;
> +	info->y_plus_val = plat_data->y_plus_val;
> +	info->y_minus_val = plat_data->y_minus_val;
> +	info->x_plus_mask = plat_data->x_plus_mask;
> +	info->x_minus_mask = plat_data->x_minus_mask;
> +	info->y_plus_mask = plat_data->y_plus_mask;
> +	info->y_minus_mask = plat_data->y_minus_mask;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		printk(KERN_ERR "%s: couldn't get MEM resource\n", __func__);
> +		ret = -ENODEV;
> +		goto out_nodev;
> +	}
> +	info->base = (unsigned int)MXS_IO_ADDRESS(res->start);
>
ioremap() please.

> +	ret = request_irq(info->touch_irq, ts_handler, IRQF_DISABLED,
>
IRQF_DISABLED is a NOP nowadays and will be removed sooner or later.

> +	/* Clear the accumulator & NUM_SAMPLES for the channels */
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_minus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_minus_chan));
> +
see above.

> +static int __devexit mxs_ts_remove(struct platform_device *pdev)
> +{
> +	struct mxs_ts_info *info = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	hw_lradc_unuse_channel(info->x_plus_chan);
> +	hw_lradc_unuse_channel(info->x_minus_chan);
> +	hw_lradc_unuse_channel(info->y_plus_chan);
> +	hw_lradc_unuse_channel(info->y_minus_chan);
> +
> +	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ_EN << info->y_minus_chan,
> +		     info->base + HW_LRADC_CTRL1_CLR);
> +	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
> +		     info->base + HW_LRADC_CTRL1_CLR);
> +
> +	free_irq(info->device_irq, info);
> +	free_irq(info->touch_irq, info);
> +	input_free_device(info->idev);
> +
> +	enter_state_disabled(info);
> +	kfree(info->idev);
> +	kfree(info);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mxs_ts_suspend(struct platform_device *pdev,
> +				pm_message_t state)
> +{
> +	struct mxs_ts_info *info = platform_get_drvdata(pdev);
> +
> +	if (!device_may_wakeup(&pdev->dev)) {
> +		hw_lradc_unuse_channel(info->x_plus_chan);
> +		hw_lradc_unuse_channel(info->x_minus_chan);
> +		hw_lradc_unuse_channel(info->y_plus_chan);
> +		hw_lradc_unuse_channel(info->y_minus_chan);
> +	}
> +	return 0;
> +}
> +
> +static int mxs_ts_resume(struct platform_device *pdev)
> +{
> +	struct mxs_ts_info *info = platform_get_drvdata(pdev);
> +
> +	if (!device_may_wakeup(&pdev->dev)) {
> +		hw_lradc_use_channel(info->x_plus_chan);
> +		hw_lradc_use_channel(info->x_minus_chan);
> +		hw_lradc_use_channel(info->y_plus_chan);
> +		hw_lradc_use_channel(info->y_minus_chan);
> +	}
> +	return 0;
> +}
> +#endif
> +
> +static struct platform_driver mxs_ts_driver = {
> +	.probe		= mxs_ts_probe,
> +	.remove		= __devexit_p(mxs_ts_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= mxs_ts_suspend,
> +	.resume		= mxs_ts_resume,
> +#endif
> +	.driver		= {
> +		.name	= "mxs-ts",
> +	},
> +};
> +
> +static int __init mxs_ts_init(void)
> +{
> +	return platform_driver_register(&mxs_ts_driver);
> +}
> +
> +static void __exit mxs_ts_exit(void)
> +{
> +	platform_driver_unregister(&mxs_ts_driver);
> +}
> +
> +module_init(mxs_ts_init);
> +module_exit(mxs_ts_exit);
> +
> +MODULE_DESCRIPTION("MXS touchscreen driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index d593878..ab89b1b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -499,6 +499,9 @@ config USB_SWITCH_FSA9480
>  	  stereo and mono audio, video, microphone and UART data to use
>  	  a common connector port.
>  
> +config MXS_LRADC
> +	tristate "ARM MXS LRADC Support"
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b26495a..0ce0017 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -47,4 +47,5 @@ obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
>  obj-y				+= lis3lv02d/
>  obj-y				+= carma/
>  obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
> +obj-$(CONFIG_MXS_LRADC)		+= mxs_lradc.o
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
> diff --git a/drivers/misc/mxs_lradc.c b/drivers/misc/mxs_lradc.c
> new file mode 100644
> index 0000000..cc32fac
> --- /dev/null
> +++ b/drivers/misc/mxs_lradc.c
> @@ -0,0 +1,381 @@
> +/*
> + * Freescale STMP37XX/STMP378X LRADC helper routines
> + *
> + * Embedded Alley Solutions, Inc <source@embeddedalley.com>
> + *
> + * Copyright 2008-2010 Freescale Semiconductor, Inc.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/sysdev.h>
> +#include <linux/platform_device.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/delay.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +#include <mach/mxs.h>
> +#include <mach/regs-lradc.h>
> +#include <mach/lradc.h>
> +
> +struct lradc_device {
> +	struct sys_device sys;
> +	unsigned int base;
>
void __iomem *base;

> +	unsigned int vddio_voltage;
> +	unsigned int battery_voltage;
> +};
> +
> +static int channels[8];
> +
> +static __refdata struct lradc_device mxs_lradc;
> +
> +int hw_lradc_use_channel(int channel)
> +{
> +	if (channel < 0 || channel > 7)
> +		return -EINVAL;
> +	channels[channel]++;
>
Missing locking to make the increment atomic.

> +	return 0;
> +}
> +EXPORT_SYMBOL(hw_lradc_use_channel);
> +
> +int hw_lradc_unuse_channel(int channel)
> +{
> +	if (channel < 0 || channel > 7)
> +		return -EINVAL;
> +	channels[channel]--;
>
Locking?

> +void hw_lradc_reinit(int enable_ground_ref, unsigned freq)
> +{
> +	__raw_writel(BM_LRADC_CTRL0_SFTRST,
> +		     mxs_lradc.base + HW_LRADC_CTRL0_SET);
> +	udelay(1);
> +	__raw_writel(BM_LRADC_CTRL0_SFTRST,
> +		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
> +
> +	/* Clear the Clock Gate for normal operation */
> +	__raw_writel(BM_LRADC_CTRL0_CLKGATE,
> +		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
> +
> +	if (enable_ground_ref)
> +		__raw_writel(BM_LRADC_CTRL0_ONCHIP_GROUNDREF,
> +			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
> +	else
> +		__raw_writel(BM_LRADC_CTRL0_ONCHIP_GROUNDREF,
> +			    mxs_lradc.base + HW_LRADC_CTRL0_CLR);
> +
> +	__raw_writel(BM_LRADC_CTRL3_CYCLE_TIME,
> +		     mxs_lradc.base + HW_LRADC_CTRL3_CLR);
> +	__raw_writel(BF_LRADC_CTRL3_CYCLE_TIME(freq),
> +		     mxs_lradc.base + HW_LRADC_CTRL3_SET);
> +
> +	__raw_writel(BM_LRADC_CTRL4_LRADC6SELECT | BM_LRADC_CTRL4_LRADC7SELECT,
> +		     mxs_lradc.base + HW_LRADC_CTRL4_CLR);
> +	__raw_writel(BF_LRADC_CTRL4_LRADC6SELECT(mxs_lradc.vddio_voltage),
> +		     mxs_lradc.base + HW_LRADC_CTRL4_SET);
> +	__raw_writel(BF_LRADC_CTRL4_LRADC7SELECT(mxs_lradc.battery_voltage),
> +		     mxs_lradc.base + HW_LRADC_CTRL4_SET);
> +}
> +
> +int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling)
> +{
> +	/*
> +	 * check if the lradc channel is present in this product
> +	 */
> +	if (!hw_lradc_present(channel))
> +		return -ENODEV;
> +
> +	hw_lradc_configure_channel(channel, !0 /* div2 */ ,
> +				   0 /* acc */ ,
> +				   0 /* num_samples */);
> +
> +	/* Setup the trigger loop forever */
> +	hw_lradc_set_delay_trigger(trigger, 1 << channel,
> +				   1 << trigger, 0, sampling);
> +
> +	/* Clear the accumulator & NUM_SAMPLES */
> +	__raw_writel(0xFFFFFFFF, mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
>
see above.

> +	return 0;
> +}
> +EXPORT_SYMBOL(hw_lradc_init_ladder);
> +
> +int hw_lradc_stop_ladder(int channel, int trigger)
> +{
> +	/*
> +	 * check if the lradc channel is present in this product
> +	 */
> +	if (!hw_lradc_present(channel))
> +		return -ENODEV;
> +	hw_lradc_clear_delay_trigger(trigger, 1 << channel, 1 << trigger);
> +	return 0;
> +}
> +EXPORT_SYMBOL(hw_lradc_stop_ladder);
> +
> +int hw_lradc_present(int channel)
> +{
> +	if (channel < 0 || channel > 7)
> +		return 0;
> +	return __raw_readl(mxs_lradc.base + HW_LRADC_STATUS)
> +	    & (1 << (16 + channel));
>
>From my point it is more readable to have the operator at the end of
the preceding line instead of at the beginning of a continuation line
like:
	return __raw_readl(mxs_lradc.base + HW_LRADC_STATUS) &
		(1 << (16 + channel));
Also one of the following would be safer wrt the processing of the
result:
	return (__raw_readl(mxs_lradc.base + HW_LRADC_STATUS) >>
		(16 + channel)) & 1;
or:
	return !!(__raw_readl(mxs_lradc.base + HW_LRADC_STATUS) &
		(1 << (16 + channel)));

> +EXPORT_SYMBOL(hw_lradc_present);
> +
> +void hw_lradc_configure_channel(int channel, int enable_div2,
> +				int enable_acc, int samples)
> +{
> +	if (enable_div2)
> +		__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << channel),
> +			     mxs_lradc.base + HW_LRADC_CTRL2_SET);
> +	else
> +		__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << channel),
> +			     mxs_lradc.base + HW_LRADC_CTRL2_CLR);
> +
> +	/* Clear the accumulator & NUM_SAMPLES */
> +	__raw_writel(0xFFFFFFFF, mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
>
see above.

> +	/* Sets NUM_SAMPLES bitfield of HW_LRADC_CHn register. */
> +	__raw_writel(BM_LRADC_CHn_NUM_SAMPLES,
> +		     mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
> +	__raw_writel(BF_LRADC_CHn_NUM_SAMPLES(samples),
> +		     mxs_lradc.base + HW_LRADC_CHn_SET(channel));
> +
> +	if (enable_acc)
> +		__raw_writel(BM_LRADC_CHn_ACCUMULATE,
> +			     mxs_lradc.base + HW_LRADC_CHn_SET(channel));
> +	else
> +		__raw_writel(BM_LRADC_CHn_ACCUMULATE,
> +			     mxs_lradc.base + HW_LRADC_CHn_CLR(channel));
> +}
> +EXPORT_SYMBOL(hw_lradc_configure_channel);
> +
> +void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
> +				u32 delay_triggers, u32 loops, u32 delays)
> +{
> +	/* set TRIGGER_LRADCS in HW_LRADC_DELAYn */
> +	__raw_writel(BF_LRADC_DELAYn_TRIGGER_LRADCS(trigger_lradc),
> +		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
> +	__raw_writel(BF_LRADC_DELAYn_TRIGGER_DELAYS(delay_triggers),
> +		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
> +
> +	__raw_writel(BM_LRADC_DELAYn_LOOP_COUNT | BM_LRADC_DELAYn_DELAY,
> +		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
> +	__raw_writel(BF_LRADC_DELAYn_LOOP_COUNT(loops),
> +		     mxs_lradc.base  + HW_LRADC_DELAYn_SET(trigger));
> +	__raw_writel(BF_LRADC_DELAYn_DELAY(delays),
> +		     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
> +}
> +EXPORT_SYMBOL(hw_lradc_set_delay_trigger);
> +
> +void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
> +				  u32 delay_triggers)
> +{
> +	__raw_writel(BF_LRADC_DELAYn_TRIGGER_LRADCS(trigger_lradc),
> +		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
> +	__raw_writel(BF_LRADC_DELAYn_TRIGGER_DELAYS(delay_triggers),
> +		     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
> +}
> +EXPORT_SYMBOL(hw_lradc_clear_delay_trigger);
> +
> +void hw_lradc_set_delay_trigger_kick(int trigger, int value)
> +{
> +	if (value)
> +		__raw_writel(BM_LRADC_DELAYn_KICK,
> +			     mxs_lradc.base + HW_LRADC_DELAYn_SET(trigger));
> +	else
> +		__raw_writel(BM_LRADC_DELAYn_KICK,
> +			     mxs_lradc.base + HW_LRADC_DELAYn_CLR(trigger));
> +}
> +EXPORT_SYMBOL(hw_lradc_set_delay_trigger_kick);
> +
> +u32 hw_lradc_vddio(void)
> +{
> +	/* Clear the Soft Reset and Clock Gate for normal operation */
> +	__raw_writel(BM_LRADC_CTRL0_SFTRST | BM_LRADC_CTRL0_CLKGATE,
> +		     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
> +
> +	/*
> +	 * Clear the divide by two for channel 6 since
> +	 * it has a HW divide-by-two built in.
> +	 */
> +	__raw_writel(BF_LRADC_CTRL2_DIVIDE_BY_TWO(1 << VDDIO_VOLTAGE_CH),
> +		     mxs_lradc.base + HW_LRADC_CTRL2_CLR);
> +
> +	/* Clear the accumulator & NUM_SAMPLES */
> +	__raw_writel(0xFFFFFFFF,
> +		     mxs_lradc.base + HW_LRADC_CHn_CLR(VDDIO_VOLTAGE_CH));
>
see above.

> +
> +	/* Clear the interrupt flag */
> +	__raw_writel(BM_LRADC_CTRL1_LRADC6_IRQ,
> +		     mxs_lradc.base + HW_LRADC_CTRL1_CLR);
> +
> +	/*
> +	 * Get VddIO; this is the max scale value for the button resistor
> +	 * ladder.
> +	 * schedule ch 6:
> +	 */
> +	__raw_writel(BF_LRADC_CTRL0_SCHEDULE(1 << VDDIO_VOLTAGE_CH),
> +		     mxs_lradc.base + HW_LRADC_CTRL0_SET);
> +
> +	/* wait for completion */
> +	while ((__raw_readl(mxs_lradc.base + HW_LRADC_CTRL1)
> +		& BM_LRADC_CTRL1_LRADC6_IRQ) != BM_LRADC_CTRL1_LRADC6_IRQ)
> +		cpu_relax();
>
No endless loops depending solely on a HW bit please!

> +	/* Clear the interrupt flag */
> +	__raw_writel(BM_LRADC_CTRL1_LRADC6_IRQ,
> +		     mxs_lradc.base + HW_LRADC_CTRL1_CLR);
> +
> +	/* read ch 6 value. */
> +	return __raw_readl(mxs_lradc.base + HW_LRADC_CHn(VDDIO_VOLTAGE_CH)) &
> +			   BM_LRADC_CHn_VALUE;
> +}
> +EXPORT_SYMBOL(hw_lradc_vddio);
> +
> +#ifdef CONFIG_PM
> +static u32 lradc_registers[0x16];
                              ^^^^
You are missing to save/restore the HW_LRADC_THRESHOLD1 register at
offset 0x160.

> +static int do_gate;
> +
> +static int hw_lradc_suspend(struct device *dev, pm_message_t state)
> +{
> +	int i;
> +
> +	do_gate = 1;
> +	for (i = 0; i < ARRAY_SIZE(channels); i++)
> +		if (channels[i] > 0) {
> +			do_gate = 0;
> +			break;
> +		}
> +
> +	for (i = 0; i < ARRAY_SIZE(lradc_registers); i++)
> +		lradc_registers[i] = __raw_readl(mxs_lradc.base + (i << 4));
> +
> +	if (do_gate)
> +		__raw_writel(BM_LRADC_CTRL0_CLKGATE,
> +			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
> +	return 0;
> +}
> +
> +static int hw_lradc_resume(struct device *dev)
> +{
> +	int i;
> +
> +	if (do_gate) {
> +		__raw_writel(BM_LRADC_CTRL0_SFTRST,
> +			     mxs_lradc.base + HW_LRADC_CTRL0_SET);
> +		udelay(10);
> +		__raw_writel(BM_LRADC_CTRL0_SFTRST |
> +			     BM_LRADC_CTRL0_CLKGATE,
> +			     mxs_lradc.base + HW_LRADC_CTRL0_CLR);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(lradc_registers); i++)
> +		__raw_writel(lradc_registers[i], mxs_lradc.base + (i << 4));
> +	return 0;
> +}
> +
> +#endif
> +
> +static struct sysdev_class mxs_lradc_sysclass = {
> +	.name = "mxs-lradc",
> +};
> +
> +static int lradc_freq = LRADC_CLOCK_6MHZ;
> +
> +static int __init lradc_freq_setup(char *str)
> +{
> +	long freq;
> +
> +	if (kstrtol(str, 0, &freq) < 0)
> +		return 0;
> +
> +	if (freq < 0)
> +		return 0;
> +	if (freq >= 6)
> +		lradc_freq = LRADC_CLOCK_6MHZ;
> +	else if (freq >= 4)
> +		lradc_freq = LRADC_CLOCK_4MHZ;
> +	else if (freq >= 3)
> +		lradc_freq = LRADC_CLOCK_3MHZ;
> +	else if (freq >= 2)
> +		lradc_freq = LRADC_CLOCK_2MHZ;
> +	else
> +		return 0;
> +	return 1;
> +}
> +
> +__setup("lradc_freq=", lradc_freq_setup);
>
How do you set lradc_freq when the driver is compiled as a module?
module_param() would work for the driver compiled as a module as well
as built-in.

> +static int __devinit mxs_lradc_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mxs_lradc_plat_data *plat_data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL)
> +		return -ENODEV;
> +
> +	plat_data = (struct mxs_lradc_plat_data *)(pdev->dev.platform_data);
>
useless type cast.

> +	if (plat_data == NULL)
> +		return -EFAULT;
>
-EFAULT indicates that a memory access from kernel to userspace memory
failed. -ENODEV would be more appropriate here.

> +	mxs_lradc.base = (unsigned int)MXS_IO_ADDRESS(res->start);
>
ioremap()

> +	mxs_lradc.sys.id = -1;
> +	mxs_lradc.sys.cls = &mxs_lradc_sysclass;
> +	mxs_lradc.vddio_voltage = plat_data->vddio_voltage;
> +	mxs_lradc.battery_voltage = plat_data->battery_voltage;
> +	hw_lradc_reinit(0, lradc_freq);
> +	return sysdev_register(&mxs_lradc.sys);
> +}
> +
> +static int __devexit mxs_lradc_remove(struct platform_device *pdev)
> +{
> +	sysdev_unregister(&mxs_lradc.sys);
> +	return 0;
> +}
> +
> +static __refdata struct platform_driver mxs_lradc_drv = {
> +	.probe = mxs_lradc_probe,
> +	.remove = __devexit_p(mxs_lradc_remove),
> +	.driver = {
> +		.name = "mxs-lradc",
> +		.owner = THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.suspend = hw_lradc_suspend,
> +		.resume = hw_lradc_resume,
> +#endif
> +	}
> +};
> +
> +static int __init hw_lradc_init(void)
> +{
> +	sysdev_class_register(&mxs_lradc_sysclass);
>
Does it make sense to go ahead and register the driver, if this fails?

> +	platform_driver_register(&mxs_lradc_drv);
> +	return 0;
>
return platform_driver_register(&mxs_lradc_drv);



Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
