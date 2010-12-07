From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 8 Dec 2010 00:31:58 +0800
Subject: [PATCH v2 08/15] ARM: mxs: Add iomux support
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291739523-25077-7-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MXS-based SoCs implements iomux functions in block PINCTRL.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v2:
 - Define iomux_cfg_t as u64
 - Turn mxs_iomux_setup_pad() into a static function
 - Fix a bug in mxs_iomux_setup_pad(), muxsel starts at offset 0x100 than 0 of pinctrl block.

 arch/arm/mach-mxs/include/mach/iomux-mx23.h |   29 +++++++
 arch/arm/mach-mxs/include/mach/iomux-mx28.h |   44 +++++++++++
 arch/arm/mach-mxs/include/mach/iomux.h      |   72 +++++++++++++++++
 arch/arm/mach-mxs/iomux.c                   |  110 +++++++++++++++++++++++++++
 4 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux.h
 create mode 100644 arch/arm/mach-mxs/iomux.c

diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx23.h b/arch/arm/mach-mxs/include/mach/iomux-mx23.h
new file mode 100644
index 0000000..3fc0439
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/iomux-mx23.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
+ * Copyright (C) 2010 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __MACH_IOMUX_MX23_H__
+#define __MACH_IOMUX_MX23_H__
+
+#include <mach/iomux.h>
+
+/*
+ * The naming convention for the pad modes is MX23_PAD_<padname>__<padmode>
+ * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
+ * See also iomux.h
+ *
+ *					 		BANK PIN     MUX            VOL          MA            PULL
+ */
+/* DUART */
+#define MX23_PAD_PWM0__DUART_RX			IOMUX_PAD(1, 26, PAD_MUXSEL_2,    PAD_VOL_NONE, PAD_4MA,      PAD_NOPULL)
+#define MX23_PAD_PWM1__DUART_TX			IOMUX_PAD(1, 27, PAD_MUXSEL_2,    PAD_VOL_NONE, PAD_4MA,      PAD_NOPULL)
+
+#endif /* __MACH_IOMUX_MX23_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/iomux-mx28.h b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
new file mode 100644
index 0000000..ca37a15
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/iomux-mx28.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
+ * Copyright (C) 2010 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __MACH_IOMUX_MX28_H__
+#define __MACH_IOMUX_MX28_H__
+
+#include <mach/iomux.h>
+
+/*
+ * The naming convention for the pad modes is MX28_PAD_<padname>__<padmode>
+ * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
+ * See also iomux.h
+ *
+ *					 		BANK PIN     MUX            VOL          MA            PULL
+ */
+/* DUART */
+#define MX28_PAD_PWM0__DUART_RX			IOMUX_PAD(3, 16, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
+#define MX28_PAD_PWM1__DUART_TX			IOMUX_PAD(3, 17, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
+
+/* FEC */
+#define MX28_PAD_ENET0_MDC__ENET0_MDC		IOMUX_PAD(4, 0,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_MDIO__ENET0_MDIO		IOMUX_PAD(4, 1,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_RX_EN__ENET0_RX_EN	IOMUX_PAD(4, 2,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_RXD0__ENET0_RXD0		IOMUX_PAD(4, 3,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_RXD1__ENET0_RXD1		IOMUX_PAD(4, 4,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_TX_EN__ENET0_TX_EN	IOMUX_PAD(4, 6,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_TXD0__ENET0_TXD0		IOMUX_PAD(4, 7,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET0_TXD1__ENET0_TXD1		IOMUX_PAD(4, 8,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+#define MX28_PAD_ENET_CLK__ENET_CLK		IOMUX_PAD(4, 16, PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULL)
+
+/* GPIO */
+#define MX28_PAD_SSP1_DATA3__GPIO_2_15		IOMUX_PAD(2, 15, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)
+#define MX28_PAD_ENET0_RX_CLK__GPIO_4_13	IOMUX_PAD(4, 13, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)
+
+#endif /* __MACH_IOMUX_MX28_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
new file mode 100644
index 0000000..91de8e7
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/iomux.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH,
+ *			<armlinux@phytec.de>
+ * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#ifndef __MACH_MXS_IOMUX_H__
+#define __MACH_MXS_IOMUX_H__
+
+typedef struct pad_desc {
+	unsigned bank:12;
+	unsigned pin:20;
+	unsigned muxsel:8;
+	unsigned ma:12;
+	unsigned vol:8;
+	unsigned pull:4;
+} iomux_cfg_t;
+
+#define IOMUX_PAD(_bank, _pin, _muxsel, _vol, _ma, _pull)	\
+		{						\
+			.bank	= _bank,			\
+			.pin	= _pin,				\
+			.muxsel	= _muxsel,			\
+			.vol	= _vol,				\
+			.ma	= _ma,				\
+			.pull	= _pull,			\
+		}
+
+#define PAD_MUXSEL_0		0
+#define PAD_MUXSEL_1		1
+#define PAD_MUXSEL_2		2
+#define PAD_MUXSEL_GPIO		3
+
+#define PAD_1V8			0
+#define PAD_3V3			1
+#define PAD_VOL_NONE		2
+
+#define PAD_4MA			0
+#define PAD_8MA			1
+#define PAD_12MA		2
+#define PAD_16MA		3
+#define PAD_MA_NONE		4
+
+#define PAD_NOPULL		0
+#define PAD_PULL		1
+
+/*
+ * setups multiple pads
+ * convenient way to call the above function with tables
+ */
+int mxs_iomux_setup_multiple_pads(iomux_cfg_t *pad_list, unsigned count);
+
+/*
+ * Initialise the iomux controller
+ */
+void mxs_iomux_init(void __iomem *iomux_base);
+
+#endif /* __MACH_MXS_IOMUX_H__*/
diff --git a/arch/arm/mach-mxs/iomux.c b/arch/arm/mach-mxs/iomux.c
new file mode 100644
index 0000000..e6ebb0d
--- /dev/null
+++ b/arch/arm/mach-mxs/iomux.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright 2004-2006,2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2008 by Sascha Hauer <kernel@pengutronix.de>
+ * Copyright (C) 2009 by Jan Weitzel Phytec Messtechnik GmbH,
+ *                       <armlinux@phytec.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/gpio.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/iomux.h>
+
+static void __iomem *base;
+
+/*
+ * configures a single pad in the iomuxer
+ */
+static int mxs_iomux_setup_pad(iomux_cfg_t *pad)
+{
+	u32 reg, ofs, bp, bm;
+
+	/* muxsel */
+	ofs = 0x100;
+	ofs += pad->bank * 0x20 + pad->pin / 16 * 0x10;
+	bp = pad->pin % 16 * 2;
+	bm = 0x3 << bp;
+	reg = __raw_readl(base + ofs);
+	reg &= ~bm;
+	reg |= pad->muxsel << bp;
+	__raw_writel(reg, base + ofs);
+
+	/* drive */
+	ofs = cpu_is_mx23() ? 0x200 : 0x300;
+	ofs += pad->bank * 0x40 + pad->pin / 8 * 0x10;
+	/* ma */
+	if (pad->ma != PAD_MA_NONE)
+	{
+		bp = pad->pin % 8 * 4;
+		bm = 0x3 << bp;
+		reg = __raw_readl(base + ofs);
+		reg &= ~bm;
+		reg |= pad->ma << bp;
+		__raw_writel(reg, base + ofs);
+	}
+	/* vol */
+	if (pad->vol != PAD_VOL_NONE)
+	{
+		bp = pad->pin % 8 * 4 + 2;
+		bm = 0x1 << bp;
+		reg = __raw_readl(base + ofs);
+		reg &= ~bm;
+		reg |= pad->vol << bp;
+		__raw_writel(reg, base + ofs);
+	}
+
+	/* pull */
+	ofs = cpu_is_mx23() ? 0x400 : 0x600;
+	ofs += pad->bank * 0x10;
+	bp = pad->pin;
+	bm = 0x1 << bp;
+	reg = __raw_readl(base + ofs);
+	reg &= ~bm;
+	reg |= pad->pull << bp;
+	__raw_writel(reg, base + ofs);
+
+	return 0;
+}
+
+int mxs_iomux_setup_multiple_pads(iomux_cfg_t *pad_list, unsigned count)
+{
+	iomux_cfg_t *p = pad_list;
+	int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		ret = mxs_iomux_setup_pad(p);
+		if (ret)
+			return ret;
+		p++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mxs_iomux_setup_multiple_pads);
+
+void mxs_iomux_init(void __iomem *iomux_base)
+{
+	base = iomux_base;
+}
-- 
1.7.1
