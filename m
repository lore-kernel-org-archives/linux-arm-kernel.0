From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 9 Dec 2010 17:12:28 +0100
Subject: [PATCH v3 08/15] ARM: mxs: Add iomux support
In-Reply-To: <1291907569-8925-8-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291907569-8925-8-git-send-email-shawn.guo@freescale.com>
Message-ID: <19712.65516.814186.356062@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> MXS-based SoCs implements iomux functions in block PINCTRL.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v3:
>  - Change iomux_cfg_t to u64 to facilitate adding platform specific
>    pad_ctrl settings to an existing pad definition
>  - Change inclusion of hardware.h to mxs.h
>  - Get iomux_base a hard-assignment in mxs_iomux_setup_pad(), since
>    mx23 and mx28 share the common pinctrl base adress and it's only
>    used in mxs_iomux_setup_pad().
>  - Remove EXPORT_SYMBOL and the static of mxs_iomux_setup_pad()
> 
> Changes for v2:
>  - Define iomux_cfg_t as u64
>  - Turn mxs_iomux_setup_pad() into a static function
>  - Fix a bug in mxs_iomux_setup_pad(), muxsel starts at offset 0x100 than 0 of pinctrl block.
> 
>  arch/arm/mach-mxs/include/mach/iomux-mx23.h |   29 +++++++
>  arch/arm/mach-mxs/include/mach/iomux-mx28.h |   44 ++++++++++
>  arch/arm/mach-mxs/include/mach/iomux.h      |  117 +++++++++++++++++++++++++++
>  arch/arm/mach-mxs/iomux.c                   |  103 +++++++++++++++++++++++
>  4 files changed, 293 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx23.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx28.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/iomux.h
>  create mode 100644 arch/arm/mach-mxs/iomux.c
> 
> diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx23.h b/arch/arm/mach-mxs/include/mach/iomux-mx23.h
> new file mode 100644
> index 0000000..3fc0439
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/iomux-mx23.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
> + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __MACH_IOMUX_MX23_H__
> +#define __MACH_IOMUX_MX23_H__
> +
> +#include <mach/iomux.h>
> +
> +/*
> + * The naming convention for the pad modes is MX23_PAD_<padname>__<padmode>
> + * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
> + * See also iomux.h
> + *
> + *					 		BANK PIN     MUX            VOL          MA            PULL
                                        ^
TAB/SPACE mixup (emacs can highlight those ;)

> + */
> +/* DUART */
> +#define MX23_PAD_PWM0__DUART_RX			IOMUX_PAD(1, 26, PAD_MUXSEL_2,    PAD_VOL_NONE, PAD_4MA,      PAD_NOPULL)
> +#define MX23_PAD_PWM1__DUART_TX			IOMUX_PAD(1, 27, PAD_MUXSEL_2,    PAD_VOL_NONE, PAD_4MA,      PAD_NOPULL)
> +
> +#endif /* __MACH_IOMUX_MX23_H__ */
> diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx28.h b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
> new file mode 100644
> index 0000000..226bf41
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
> + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __MACH_IOMUX_MX28_H__
> +#define __MACH_IOMUX_MX28_H__
> +
> +#include <mach/iomux.h>
> +
> +/*
> + * The naming convention for the pad modes is MX28_PAD_<padname>__<padmode>
> + * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
> + * See also iomux.h
> + *
> + *					 		BANK PIN     MUX            VOL          MA            PULL
                                        ^
TAB/SPACE mixup

> + */
> +/* DUART */
> +#define MX28_PAD_PWM0__DUART_RX			IOMUX_PAD(3, 16, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +#define MX28_PAD_PWM1__DUART_TX			IOMUX_PAD(3, 17, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +
> +/* FEC */
> +#define MX28_PAD_ENET0_MDC__ENET0_MDC		IOMUX_PAD(4, 0,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_MDIO__ENET0_MDIO		IOMUX_PAD(4, 1,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RX_EN__ENET0_RX_EN	IOMUX_PAD(4, 2,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RXD0__ENET0_RXD0		IOMUX_PAD(4, 3,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RXD1__ENET0_RXD1		IOMUX_PAD(4, 4,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TX_EN__ENET0_TX_EN	IOMUX_PAD(4, 6,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TXD0__ENET0_TXD0		IOMUX_PAD(4, 7,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TXD1__ENET0_TXD1		IOMUX_PAD(4, 8,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET_CLK__ENET_CLK		IOMUX_PAD(4, 16, PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +
> +/* GPIO */
> +#define MX28_PAD_SSP1_DATA3__GPIO_2_15		IOMUX_PAD(2, 15, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +#define MX28_PAD_ENET0_RX_CLK__GPIO_4_13	IOMUX_PAD(4, 13, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +
> +#endif /* __MACH_IOMUX_MX28_H__ */
> diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
> new file mode 100644
> index 0000000..0939446
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/iomux.h
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH,
> + *			<armlinux@phytec.de>
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#ifndef __MACH_MXS_IOMUX_H__
> +#define __MACH_MXS_IOMUX_H__
> +
> +/*
> + * IOMUX/PAD Bit field definitions
> + *
> + * PAD_BANK:	 0..2	(3)
> + * PAD_PIN:	 3..7	(5)
> + * PAD_MUXSEL:	 8..9	(2)
> + * PAD_MA:	10..12	(3)
> + * PAD_VOL:	13..14	(2)
> + * PAD_PULL:	15	(1)
> + * RESERVED:	16..63	(48)
> + */
> +typedef u64 iomux_cfg_t;
> +
Only because i.MX5 has so many bits to remember does not mean we have
to waste space on this arch too. No need for u64 here (could obviously
even be u16).

> +#define PAD_BANK_SHIFT		0
> +#define PAD_BANK_MASK		((iomux_cfg_t)0x7 << PAD_BANK_SHIFT)
> +#define PAD_PIN_SHIFT		3
> +#define PAD_PIN_MASK		((iomux_cfg_t)0x1f << PAD_PIN_SHIFT)
> +#define PAD_MUXSEL_SHIFT	8
> +#define PAD_MUXSEL_MASK		((iomux_cfg_t)0x3 << PAD_MUXSEL_SHIFT)
> +#define PAD_MA_SHIFT		10
> +#define PAD_MA_MASK		((iomux_cfg_t)0x7 << PAD_MA_SHIFT)
> +#define PAD_VOL_SHIFT		13
> +#define PAD_VOL_MASK		((iomux_cfg_t)0x3 << PAD_VOL_SHIFT)
> +#define PAD_PULL_SHIFT		15
> +#define PAD_PULL_MASK		((iomux_cfg_t)0x1 << PAD_PULL_SHIFT)
> +
> +#define IOMUX_PAD(_bank, _pin, _muxsel, _vol, _ma, _pull)		\
> +		(((iomux_cfg_t)(_bank) << PAD_BANK_SHIFT) |		\
> +		((iomux_cfg_t)(_pin) << PAD_PIN_SHIFT) |		\
> +		((iomux_cfg_t)(_muxsel) << PAD_MUXSEL_SHIFT) |		\
> +		((iomux_cfg_t)(_vol) << PAD_VOL_SHIFT) |		\
> +		((iomux_cfg_t)(_ma) << PAD_MA_SHIFT) |			\
> +		((iomux_cfg_t)(_pull) << PAD_PULL_SHIFT))
> +
These also should have a namespace prefix like:
MXS_PAD_*, MXS_IOMUX_PAD()

> +#define PAD_MUXSEL_0		0
> +#define PAD_MUXSEL_1		1
> +#define PAD_MUXSEL_2		2
> +#define PAD_MUXSEL_GPIO		3
> +
> +#define PAD_1V8			0
> +#define PAD_3V3			1
> +#define PAD_VOL_NONE		2
> +
> +#define PAD_4MA			0
> +#define PAD_8MA			1
> +#define PAD_12MA		2
> +#define PAD_16MA		3
> +#define PAD_MA_NONE		4
> +
> +#define PAD_NOPULL		0
> +#define PAD_PULLUP		1
> +
> +static inline unsigned int PAD_BANK(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_BANK_MASK) >> PAD_BANK_SHIFT;
> +}
> +
> +static inline unsigned int PAD_PIN(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_PIN_MASK) >> PAD_PIN_SHIFT;
> +}
> +
> +static inline unsigned int PAD_MUXSEL(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_MUXSEL_MASK) >> PAD_MUXSEL_SHIFT;
> +}
> +
> +static inline unsigned int PAD_MA(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_MA_MASK) >> PAD_MA_SHIFT;
> +}
> +
> +static inline unsigned int PAD_VOL(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_VOL_MASK) >> PAD_VOL_SHIFT;
> +}
> +
> +static inline unsigned int PAD_PULL(iomux_cfg_t pad)
> +{
> +	return (pad & PAD_PULL_MASK) >> PAD_PULL_SHIFT;
> +}
> +
> +/*
> + * setups a single pad in the iomuxer
s/setups/configures/

> + */
> +int mxs_iomux_setup_pad(iomux_cfg_t pad);
> +
> +/*
> + * setups multiple pads
dto.

> + * convenient way to call the above function with tables
> + */
> +int mxs_iomux_setup_multiple_pads(const iomux_cfg_t *pad_list, unsigned count);
> +
> +#endif /* __MACH_MXS_IOMUX_H__*/
> diff --git a/arch/arm/mach-mxs/iomux.c b/arch/arm/mach-mxs/iomux.c
> new file mode 100644
> index 0000000..b6e63a4
> --- /dev/null
> +++ b/arch/arm/mach-mxs/iomux.c
> @@ -0,0 +1,103 @@
> +/*
> + * Copyright 2004-2006,2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
> + * Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH,
> + *                       <armlinux@phytec.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/mach/map.h>
> +
> +#include <mach/mxs.h>
> +#include <mach/iomux.h>
> +
> +/*
> + * configures a single pad in the iomuxer
> + */
> +int mxs_iomux_setup_pad(iomux_cfg_t pad)
> +{
> +	u32 reg, ofs, bp, bm;
> +	void __iomem *iomux_base = MXS_IO_ADDRESS(MXS_PINCTRL_BASE_ADDR);
> +
> +	/* muxsel */
> +	ofs = 0x100;
> +	ofs += PAD_BANK(pad) * 0x20 + PAD_PIN(pad) / 16 * 0x10;
> +	bp = PAD_PIN(pad) % 16 * 2;
> +	bm = 0x3 << bp;
> +	reg = __raw_readl(iomux_base + ofs);
> +	reg &= ~bm;
> +	reg |= PAD_MUXSEL(pad) << bp;
> +	__raw_writel(reg, iomux_base + ofs);
> +
> +	/* drive */
> +	ofs = cpu_is_mx23() ? 0x200 : 0x300;
> +	ofs += PAD_BANK(pad) * 0x40 + PAD_PIN(pad) / 8 * 0x10;
> +	/* ma */
'mA' would make it much clearer that milliamps are meant.

> +	if (PAD_MA(pad) != PAD_MA_NONE)
> +	{
'{' should be at the end of the 'if' line.

> +		bp = PAD_PIN(pad) % 8 * 4;
> +		bm = 0x3 << bp;
> +		reg = __raw_readl(iomux_base + ofs);
> +		reg &= ~bm;
> +		reg |= PAD_MA(pad) << bp;
> +		__raw_writel(reg, iomux_base + ofs);
> +	}
> +	/* vol */
> +	if (PAD_VOL(pad) != PAD_VOL_NONE)
> +	{
dto.

> +		bp = PAD_PIN(pad) % 8 * 4 + 2;
> +		bm = 0x1 << bp;
> +		reg = __raw_readl(iomux_base + ofs);
> +		reg &= ~bm;
> +		reg |= PAD_VOL(pad) << bp;
> +		__raw_writel(reg, iomux_base + ofs);
You could use a write to the SET/CLR address here instead of read/modify/write.

> +	}
> +
> +	/* pull */
> +	ofs = cpu_is_mx23() ? 0x400 : 0x600;
> +	ofs += PAD_BANK(pad) * 0x10;
> +	bp = PAD_PIN(pad);
> +	bm = 0x1 << bp;
> +	reg = __raw_readl(iomux_base + ofs);
> +	reg &= ~bm;
> +	reg |= PAD_PULL(pad) << bp;
> +	__raw_writel(reg, iomux_base + ofs);
dto.

> +
> +	return 0;
> +}
> +
> +int mxs_iomux_setup_multiple_pads(const iomux_cfg_t *pad_list, unsigned count)
> +{
> +	const iomux_cfg_t *p = pad_list;
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = mxs_iomux_setup_pad(*p);
> +		if (ret)
> +			return ret;
> +		p++;
> +	}
> +
> +	return 0;
> +}
> -- 
> 1.7.1
> 
> 
Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
