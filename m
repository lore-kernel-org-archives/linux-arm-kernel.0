From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:30 +0800
Subject: [PATCH 06/11] ARM: imx: Add IOMUX support for i.MX28
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-7-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Soc i.MX28 supports IOMUX function in block PINCTRL. Comparing
to the naming of iomux-v1 and iomux-v3, it uses iomux-pinctrl,
since PINCTRL is a totally different IP block from IOMUX and it's
not reasonable to name it iomux-v2 or iomux-v4, which is used to
distinguish the different revision of same IP block.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx28.h    |   50 +++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-pinctrl.h |   91 +++++++++++++++++++++++
 arch/arm/plat-mxc/iomux-pinctrl.c              |   94 ++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx28.h
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-pinctrl.h
 create mode 100644 arch/arm/plat-mxc/iomux-pinctrl.c

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx28.h b/arch/arm/plat-mxc/include/mach/iomux-mx28.h
new file mode 100644
index 0000000..8c68bd6
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx28.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __MACH_IOMUX_MX28_H__
+#define __MACH_IOMUX_MX28_H__
+
+#include <mach/iomux-pinctrl.h>
+
+/*
+ * The naming convention for the pad modes is MX28_PAD_<padname>__<padmode>
+ * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
+ * See also iomux-pinctrl.h
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
diff --git a/arch/arm/plat-mxc/include/mach/iomux-pinctrl.h b/arch/arm/plat-mxc/include/mach/iomux-pinctrl.h
new file mode 100644
index 0000000..c2fdb33
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/iomux-pinctrl.h
@@ -0,0 +1,91 @@
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
+#ifndef __MACH_IOMUX_PINCTRL_H__
+#define __MACH_IOMUX_PINCTRL_H__
+
+typedef struct deprecated_pad_desc {
+	unsigned bank:3;
+	unsigned pin:5;
+	unsigned muxsel:2;
+	unsigned ma:3;
+	unsigned vol:2;
+	unsigned pull:1;
+} iomux_pinctrl_cfg_t;
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
+#define MX51_NUM_GPIO_PORT	4
+
+#define GPIO_PIN_MASK 0x1f
+
+#define GPIO_PORT_SHIFT 5
+#define GPIO_PORT_MASK (0x7 << GPIO_PORT_SHIFT)
+
+#define GPIO_PORTA	(0 << GPIO_PORT_SHIFT)
+#define GPIO_PORTB	(1 << GPIO_PORT_SHIFT)
+#define GPIO_PORTC	(2 << GPIO_PORT_SHIFT)
+#define GPIO_PORTD	(3 << GPIO_PORT_SHIFT)
+#define GPIO_PORTE	(4 << GPIO_PORT_SHIFT)
+#define GPIO_PORTF	(5 << GPIO_PORT_SHIFT)
+
+/*
+ * setups a single pad in the iomuxer
+ */
+int mxc_iomux_pinctrl_setup_pad(iomux_pinctrl_cfg_t *pad);
+
+/*
+ * setups mutliple pads
+ * convenient way to call the above function with tables
+ */
+int mxc_iomux_pinctrl_setup_multiple_pads(iomux_pinctrl_cfg_t *pad_list, unsigned count);
+
+/*
+ * Initialise the iomux controller
+ */
+void mxc_iomux_pinctrl_init(void __iomem *iomux_pinctrl_base);
+
+#endif /* __MACH_IOMUX_PINCTRL_H__*/
diff --git a/arch/arm/plat-mxc/iomux-pinctrl.c b/arch/arm/plat-mxc/iomux-pinctrl.c
new file mode 100644
index 0000000..5f5b5ac
--- /dev/null
+++ b/arch/arm/plat-mxc/iomux-pinctrl.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/gpio.h>
+#include <asm/mach/map.h>
+#include <mach/hardware.h>
+#include <mach/iomux-pinctrl.h>
+
+static void __iomem *base;
+
+/*
+ * configures a single pad in the iomuxer
+ */
+int mxc_iomux_pinctrl_setup_pad(iomux_pinctrl_cfg_t *pad)
+{
+	u32 reg, ofs, bp, bm;
+
+	/* MUXSEL */
+	ofs = pad->bank * 0x20 + pad->pin / 16 * 0x10;
+	bp = pad->pin % 16 * 2;
+	bm = 0x3 << bp;
+	reg = __raw_readl(base + ofs);
+	reg &= ~bm;
+	reg |= pad->muxsel << bp;
+	__raw_writel(reg, base + ofs);
+
+	/* DRIVE */
+	if (pad->ma != PAD_MA_NONE && pad->vol != PAD_VOL_NONE)
+	{
+		ofs = 0x300 + pad->bank * 0x40 + pad->pin / 8 * 0x10;
+		bp = pad->pin % 8 * 4;
+		bm = 0x7 << bp;
+		reg = __raw_readl(base + ofs);
+		reg &= ~bm;
+		reg |= pad->ma << bp | pad->vol << (bp + 2);
+		__raw_writel(reg, base + ofs);
+	}
+
+	/* PULL */
+	ofs = 0x600 + pad->bank * 0x10;
+	bp = pad->pin;
+	bm = 0x1 << bp;
+	reg = __raw_readl(base + ofs);
+	reg &= ~bm;
+	reg |= pad->pull << bp;
+	__raw_writel(reg, base + ofs);
+
+	return 0;
+}
+EXPORT_SYMBOL(mxc_iomux_pinctrl_setup_pad);
+
+int mxc_iomux_pinctrl_setup_multiple_pads(iomux_pinctrl_cfg_t *pad_list, unsigned count)
+{
+	iomux_pinctrl_cfg_t *p = pad_list;
+	int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		ret = mxc_iomux_pinctrl_setup_pad(p);
+		if (ret)
+			return ret;
+		p++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mxc_iomux_pinctrl_setup_multiple_pads);
+
+void mxc_iomux_pinctrl_init(void __iomem *iomux_pinctrl_base)
+{
+	base = iomux_pinctrl_base;
+}
-- 
1.7.1
