From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 21 Jan 2015 13:28:15 +0800
Subject: [PATCH v5 3/5] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1421818097-9281-4-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongzhou Yang <hongzhou.yang@mediatek.com>

The mediatek SoCs have GPIO controller that handle both the muxing and GPIOs.

The GPIO controller have pinmux, pull enable, pull select, direction and output high/low control.

This driver include common driver and mt8135 part.
The common driver include the pinctrl driver and GPIO driver.
The mt8135 part contain its special device data.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig                |    1 +
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/mediatek/Kconfig              |   14 +
 drivers/pinctrl/mediatek/Makefile             |    5 +
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |  350 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  800 ++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  185 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h | 2114 +++++++++++++++++++++++++
 include/dt-bindings/pinctrl/mt65xx.h          |   40 +
 10 files changed, 3511 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/Kconfig
 create mode 100644 drivers/pinctrl/mediatek/Makefile
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8135.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
 create mode 100644 include/dt-bindings/pinctrl/mt65xx.h

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index f7e463c..9f59e58 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
 	select ARM_GIC
+	select PINCTRL
 	select MTK_TIMER
 	help
 	  Support for Mediatek MT65xx & MT81xx SoCs
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d014f22..d7ce3bd 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -202,6 +202,7 @@ source "drivers/pinctrl/sh-pfc/Kconfig"
 source "drivers/pinctrl/spear/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/vt8500/Kconfig"
+source "drivers/pinctrl/mediatek/Kconfig"
 
 config PINCTRL_XWAY
 	bool
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index c030b3d..bb414d9 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
+obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
new file mode 100644
index 0000000..70bbf39
--- /dev/null
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -0,0 +1,14 @@
+if ARCH_MEDIATEK
+
+config PINCTRL_MTK_COMMON
+	bool
+	select PINMUX
+	select GENERIC_PINCONF
+	select GPIOLIB
+	select OF_GPIO
+
+config PINCTRL_MT8135
+	def_bool MACH_MT8135
+	select PINCTRL_MTK_COMMON
+
+endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
new file mode 100644
index 0000000..8157dad
--- /dev/null
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -0,0 +1,5 @@
+# Core
+obj-$(CONFIG_PINCTRL_MTK_COMMON)	+= pinctrl-mtk-common.o
+
+# SoC Drivers
+obj-$(CONFIG_PINCTRL_MT8135)		+= pinctrl-mt8135.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
new file mode 100644
index 0000000..13694b8
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -0,0 +1,350 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/regmap.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt8135.h"
+
+#define DRV_BASE1				0x500
+#define DRV_BASE2				0x510
+#define PUPD_BASE1				0x400
+#define PUPD_BASE2				0x450
+#define R0_BASE1				0x4d0
+#define R1_BASE1				0x200
+#define R1_BASE2				0x250
+
+struct mtk_spec_pull_set {
+	unsigned int pin;
+	unsigned int pupd_offset;
+	unsigned char pupd_bit;
+	unsigned int r0_offset;
+	unsigned char r0_bit;
+	unsigned int r1_offset;
+	unsigned char r1_bit;
+};
+
+#define SPEC_PULL(_pin, _pupd_offset, _pupd_bit, _r0_offset, \
+	_r0_bit, _r1_offset, _r1_bit)	\
+	{	\
+		.pin = _pin,	\
+		.pupd_offset = _pupd_offset,	\
+		.pupd_bit = _pupd_bit,	\
+		.r0_offset = _r0_offset, \
+		.r0_bit = _r0_bit, \
+		.r1_offset = _r1_offset, \
+		.r1_bit = _r1_bit, \
+	}
+
+static const struct mtk_drv_group_desc mt8135_drv_grp[] =  {
+	/* E8E4E2 2/4/6/8/10/12/14/16 */
+	MTK_DRV_GRP(2, 16, 0, 2, 2),
+	/* E8E4  4/8/12/16 */
+	MTK_DRV_GRP(4, 16, 1, 2, 4),
+	/* E4E2  2/4/6/8 */
+	MTK_DRV_GRP(2, 8, 0, 1, 2),
+	/* E16E8E4 4/8/12/16/20/24/28/32 */
+	MTK_DRV_GRP(4, 32, 0, 2, 4)
+};
+
+static const struct mtk_pin_drv_grp mt8135_pin_drv[] = {
+	MTK_PIN_DRV_GRP(0, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(1, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(2, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(3, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(4, DRV_BASE1, 4, 0),
+	MTK_PIN_DRV_GRP(5, DRV_BASE1, 8, 0),
+	MTK_PIN_DRV_GRP(6, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(7, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(8, DRV_BASE1, 0, 0),
+	MTK_PIN_DRV_GRP(9, DRV_BASE1, 0, 0),
+
+	MTK_PIN_DRV_GRP(10, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(11, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(12, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(13, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(14, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(15, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(16, DRV_BASE1, 12, 1),
+	MTK_PIN_DRV_GRP(17, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(18, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(19, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(20, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(21, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(22, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(23, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(24, DRV_BASE1, 16, 1),
+	MTK_PIN_DRV_GRP(33, DRV_BASE1, 24, 1),
+	MTK_PIN_DRV_GRP(34, DRV_BASE2, 12, 2),
+	MTK_PIN_DRV_GRP(37, DRV_BASE2, 20, 1),
+	MTK_PIN_DRV_GRP(38, DRV_BASE2, 20, 1),
+	MTK_PIN_DRV_GRP(39, DRV_BASE2, 20, 1),
+	MTK_PIN_DRV_GRP(40, DRV_BASE2, 24, 1),
+	MTK_PIN_DRV_GRP(41, DRV_BASE2, 24, 1),
+	MTK_PIN_DRV_GRP(42, DRV_BASE2, 24, 1),
+	MTK_PIN_DRV_GRP(43, DRV_BASE2, 28, 1),
+	MTK_PIN_DRV_GRP(44, DRV_BASE2, 28, 1),
+	MTK_PIN_DRV_GRP(45, DRV_BASE2, 28, 1),
+	MTK_PIN_DRV_GRP(46, DRV_BASE2, 28, 1),
+	MTK_PIN_DRV_GRP(47, DRV_BASE2, 28, 1),
+
+	MTK_PIN_DRV_GRP(49, DRV_BASE2+0x10, 0, 1),
+	MTK_PIN_DRV_GRP(50, DRV_BASE2+0x10, 4, 1),
+	MTK_PIN_DRV_GRP(51, DRV_BASE2+0x10, 8, 1),
+	MTK_PIN_DRV_GRP(52, DRV_BASE2+0x10, 12, 2),
+	MTK_PIN_DRV_GRP(53, DRV_BASE2+0x10, 16, 1),
+	MTK_PIN_DRV_GRP(54, DRV_BASE2+0x10, 20, 1),
+	MTK_PIN_DRV_GRP(55, DRV_BASE2+0x10, 24, 1),
+	MTK_PIN_DRV_GRP(56, DRV_BASE2+0x10, 28, 1),
+
+	MTK_PIN_DRV_GRP(57, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(58, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(59, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(60, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(61, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(62, DRV_BASE2+0x20, 0, 1),
+	MTK_PIN_DRV_GRP(63, DRV_BASE2+0x20, 4, 1),
+	MTK_PIN_DRV_GRP(64, DRV_BASE2+0x20, 8, 1),
+	MTK_PIN_DRV_GRP(65, DRV_BASE2+0x20, 12, 1),
+	MTK_PIN_DRV_GRP(66, DRV_BASE2+0x20, 16, 1),
+	MTK_PIN_DRV_GRP(67, DRV_BASE2+0x20, 20, 1),
+	MTK_PIN_DRV_GRP(68, DRV_BASE2+0x20, 24, 1),
+	MTK_PIN_DRV_GRP(69, DRV_BASE2+0x20, 28, 1),
+
+	MTK_PIN_DRV_GRP(70, DRV_BASE2+0x30, 0, 1),
+	MTK_PIN_DRV_GRP(71, DRV_BASE2+0x30, 4, 1),
+	MTK_PIN_DRV_GRP(72, DRV_BASE2+0x30, 8, 1),
+	MTK_PIN_DRV_GRP(73, DRV_BASE2+0x30, 12, 1),
+	MTK_PIN_DRV_GRP(74, DRV_BASE2+0x30, 16, 1),
+	MTK_PIN_DRV_GRP(75, DRV_BASE2+0x30, 20, 1),
+	MTK_PIN_DRV_GRP(76, DRV_BASE2+0x30, 24, 1),
+	MTK_PIN_DRV_GRP(77, DRV_BASE2+0x30, 28, 3),
+	MTK_PIN_DRV_GRP(78, DRV_BASE2+0x30, 28, 3),
+
+	MTK_PIN_DRV_GRP(79, DRV_BASE2+0x40, 0, 3),
+	MTK_PIN_DRV_GRP(80, DRV_BASE2+0x40, 4, 3),
+
+	MTK_PIN_DRV_GRP(81, DRV_BASE2+0x30, 28, 3),
+	MTK_PIN_DRV_GRP(82, DRV_BASE2+0x30, 28, 3),
+
+	MTK_PIN_DRV_GRP(83, DRV_BASE2+0x40, 8, 3),
+	MTK_PIN_DRV_GRP(84, DRV_BASE2+0x40, 8, 3),
+	MTK_PIN_DRV_GRP(85, DRV_BASE2+0x40, 12, 3),
+	MTK_PIN_DRV_GRP(86, DRV_BASE2+0x40, 16, 3),
+	MTK_PIN_DRV_GRP(87, DRV_BASE2+0x40, 8, 3),
+	MTK_PIN_DRV_GRP(88, DRV_BASE2+0x40, 8, 3),
+
+	MTK_PIN_DRV_GRP(89, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(90, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(91, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(92, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(93, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(94, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(95, DRV_BASE2+0x50, 12, 0),
+
+	MTK_PIN_DRV_GRP(96, DRV_BASE1+0xb0, 28, 0),
+
+	MTK_PIN_DRV_GRP(97, DRV_BASE2+0x50, 12, 0),
+	MTK_PIN_DRV_GRP(98, DRV_BASE2+0x50, 16, 0),
+	MTK_PIN_DRV_GRP(99, DRV_BASE2+0x50, 20, 1),
+	MTK_PIN_DRV_GRP(102, DRV_BASE2+0x50, 24, 1),
+	MTK_PIN_DRV_GRP(103, DRV_BASE2+0x50, 28, 1),
+
+
+	MTK_PIN_DRV_GRP(104, DRV_BASE2+0x60, 0, 1),
+	MTK_PIN_DRV_GRP(105, DRV_BASE2+0x60, 4, 1),
+	MTK_PIN_DRV_GRP(106, DRV_BASE2+0x60, 4, 1),
+	MTK_PIN_DRV_GRP(107, DRV_BASE2+0x60, 4, 1),
+	MTK_PIN_DRV_GRP(108, DRV_BASE2+0x60, 4, 1),
+	MTK_PIN_DRV_GRP(109, DRV_BASE2+0x60, 8, 2),
+	MTK_PIN_DRV_GRP(110, DRV_BASE2+0x60, 12, 2),
+	MTK_PIN_DRV_GRP(111, DRV_BASE2+0x60, 16, 2),
+	MTK_PIN_DRV_GRP(112, DRV_BASE2+0x60, 20, 2),
+	MTK_PIN_DRV_GRP(113, DRV_BASE2+0x60, 24, 2),
+	MTK_PIN_DRV_GRP(114, DRV_BASE2+0x60, 28, 2),
+
+	MTK_PIN_DRV_GRP(115, DRV_BASE2+0x70, 0, 2),
+	MTK_PIN_DRV_GRP(116, DRV_BASE2+0x70, 4, 2),
+	MTK_PIN_DRV_GRP(117, DRV_BASE2+0x70, 8, 2),
+	MTK_PIN_DRV_GRP(118, DRV_BASE2+0x70, 12, 2),
+	MTK_PIN_DRV_GRP(119, DRV_BASE2+0x70, 16, 2),
+	MTK_PIN_DRV_GRP(120, DRV_BASE2+0x70, 20, 2),
+
+	MTK_PIN_DRV_GRP(181, DRV_BASE1+0xa0, 12, 1),
+	MTK_PIN_DRV_GRP(182, DRV_BASE1+0xa0, 16, 1),
+	MTK_PIN_DRV_GRP(183, DRV_BASE1+0xa0, 20, 1),
+	MTK_PIN_DRV_GRP(184, DRV_BASE1+0xa0, 24, 1),
+	MTK_PIN_DRV_GRP(185, DRV_BASE1+0xa0, 28, 1),
+
+	MTK_PIN_DRV_GRP(186, DRV_BASE1+0xb0, 0, 2),
+	MTK_PIN_DRV_GRP(187, DRV_BASE1+0xb0, 0, 2),
+	MTK_PIN_DRV_GRP(188, DRV_BASE1+0xb0, 0, 2),
+	MTK_PIN_DRV_GRP(189, DRV_BASE1+0xb0, 0, 2),
+	MTK_PIN_DRV_GRP(190, DRV_BASE1+0xb0, 4, 1),
+	MTK_PIN_DRV_GRP(191, DRV_BASE1+0xb0, 8, 1),
+	MTK_PIN_DRV_GRP(192, DRV_BASE1+0xb0, 12, 1),
+
+	MTK_PIN_DRV_GRP(197, DRV_BASE1+0xb0, 16, 0),
+	MTK_PIN_DRV_GRP(198, DRV_BASE1+0xb0, 16, 0),
+	MTK_PIN_DRV_GRP(199, DRV_BASE1+0xb0, 20, 0),
+	MTK_PIN_DRV_GRP(200, DRV_BASE1+0xb0, 24, 0),
+	MTK_PIN_DRV_GRP(201, DRV_BASE1+0xb0, 16, 0),
+	MTK_PIN_DRV_GRP(202, DRV_BASE1+0xb0, 16, 0)
+};
+
+static const struct mtk_spec_pull_set spec_pupd[] = {
+	SPEC_PULL(0, PUPD_BASE1, 0, R0_BASE1, 9, R1_BASE1, 0),
+	SPEC_PULL(1, PUPD_BASE1, 1, R0_BASE1, 8, R1_BASE1, 1),
+	SPEC_PULL(2, PUPD_BASE1, 2, R0_BASE1, 7, R1_BASE1, 2),
+	SPEC_PULL(3, PUPD_BASE1, 3, R0_BASE1, 6, R1_BASE1, 3),
+	SPEC_PULL(4, PUPD_BASE1, 4, R0_BASE1, 1, R1_BASE1, 4),
+	SPEC_PULL(5, PUPD_BASE1, 5, R0_BASE1, 0, R1_BASE1, 5),
+	SPEC_PULL(6, PUPD_BASE1, 6, R0_BASE1, 5, R1_BASE1, 6),
+	SPEC_PULL(7, PUPD_BASE1, 7, R0_BASE1, 4, R1_BASE1, 7),
+	SPEC_PULL(8, PUPD_BASE1, 8, R0_BASE1, 3, R1_BASE1, 8),
+	SPEC_PULL(9, PUPD_BASE1, 9, R0_BASE1, 2, R1_BASE1, 9),
+	SPEC_PULL(89, PUPD_BASE2, 9, R0_BASE1, 18, R1_BASE2, 9),
+	SPEC_PULL(90, PUPD_BASE2, 10, R0_BASE1, 19, R1_BASE2, 10),
+	SPEC_PULL(91, PUPD_BASE2, 11, R0_BASE1, 23, R1_BASE2, 11),
+	SPEC_PULL(92, PUPD_BASE2, 12, R0_BASE1, 24, R1_BASE2, 12),
+	SPEC_PULL(93, PUPD_BASE2, 13, R0_BASE1, 25, R1_BASE2, 13),
+	SPEC_PULL(94, PUPD_BASE2, 14, R0_BASE1, 22, R1_BASE2, 14),
+	SPEC_PULL(95, PUPD_BASE2, 15, R0_BASE1, 20, R1_BASE2, 15),
+	SPEC_PULL(96, PUPD_BASE2+0x10, 0, R0_BASE1, 16, R1_BASE2+0x10, 0),
+	SPEC_PULL(97, PUPD_BASE2+0x10, 1, R0_BASE1, 21, R1_BASE2+0x10, 1),
+	SPEC_PULL(98, PUPD_BASE2+0x10, 2, R0_BASE1, 17, R1_BASE2+0x10, 2),
+	SPEC_PULL(197, PUPD_BASE1+0xc0, 5, R0_BASE1, 13, R1_BASE2+0xc0, 5),
+	SPEC_PULL(198, PUPD_BASE2+0xc0, 6, R0_BASE1, 14, R1_BASE2+0xc0, 6),
+	SPEC_PULL(199, PUPD_BASE2+0xc0, 7, R0_BASE1, 11, R1_BASE2+0xc0, 7),
+	SPEC_PULL(200, PUPD_BASE2+0xc0, 8, R0_BASE1, 10, R1_BASE2+0xc0, 8),
+	SPEC_PULL(201, PUPD_BASE2+0xc0, 9, R0_BASE1, 13, R1_BASE2+0xc0, 9),
+	SPEC_PULL(202, PUPD_BASE2+0xc0, 10, R0_BASE1, 12, R1_BASE2+0xc0, 10)
+};
+
+static int spec_pull_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, bool isup, unsigned int r1r0)
+{
+	unsigned int i;
+	unsigned int reg_pupd, reg_set_r0, reg_set_r1;
+	unsigned int reg_rst_r0, reg_rst_r1;
+	bool find = false;
+
+	for (i = 0; i < ARRAY_SIZE(spec_pupd); i++) {
+		if (pin == spec_pupd[i].pin) {
+			find = true;
+			break;
+		}
+	}
+
+	if (!find)
+		return -EINVAL;
+
+	if (isup)
+		reg_pupd = spec_pupd[i].pupd_offset + align;
+	else
+		reg_pupd = spec_pupd[i].pupd_offset + (align << 1);
+
+	regmap_write(regmap, reg_pupd, spec_pupd[i].pupd_bit);
+
+	reg_set_r0 = spec_pupd[i].r0_offset + align;
+	reg_rst_r0 = spec_pupd[i].r0_offset + (align << 1);
+	reg_set_r1 = spec_pupd[i].r1_offset + align;
+	reg_rst_r1 = spec_pupd[i].r1_offset + (align << 1);
+
+	switch (r1r0) {
+	case MTK_PUPD_SET_R1R0_00:
+		regmap_write(regmap, reg_rst_r0, spec_pupd[i].r0_bit);
+		regmap_write(regmap, reg_rst_r1, spec_pupd[i].r1_bit);
+		break;
+	case MTK_PUPD_SET_R1R0_01:
+		regmap_write(regmap, reg_set_r0, spec_pupd[i].r0_bit);
+		regmap_write(regmap, reg_rst_r1, spec_pupd[i].r1_bit);
+		break;
+	case MTK_PUPD_SET_R1R0_10:
+		regmap_write(regmap, reg_rst_r0, spec_pupd[i].r0_bit);
+		regmap_write(regmap, reg_set_r1, spec_pupd[i].r1_bit);
+		break;
+	case MTK_PUPD_SET_R1R0_11:
+		regmap_write(regmap, reg_set_r0, spec_pupd[i].r0_bit);
+		regmap_write(regmap, reg_set_r1, spec_pupd[i].r1_bit);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
+	.pins = mtk_pins_mt8135,
+	.npins = ARRAY_SIZE(mtk_pins_mt8135),
+	.grp_desc = mt8135_drv_grp,
+	.n_grp_cls = ARRAY_SIZE(mt8135_drv_grp),
+	.pin_drv_grp = mt8135_pin_drv,
+	.n_pin_drv_grps = ARRAY_SIZE(mt8135_pin_drv),
+	.spec_pull_set = spec_pull_set,
+	.dir_offset = 0x0000,
+	.ies_offset = 0x0100,
+	.pullen_offset = 0x0200,
+	.smt_offset = 0x0300,
+	.pullsel_offset = 0x0400,
+	.invser_offset = 0x0600,
+	.dout_offset = 0x0800,
+	.din_offset = 0x0A00,
+	.pinmux_offset = 0x0C00,
+	.type1_start = 34,
+	.type1_end = 149,
+	.port_shf = 4,
+	.port_mask = 0xf,
+	.port_align = 4,
+};
+
+static int mt8135_pinctrl_probe(struct platform_device *pdev)
+{
+	return mtk_pctrl_init(pdev, &mt8135_pinctrl_data);
+}
+
+static struct of_device_id mt8135_pctrl_match[] = {
+	{
+		.compatible = "mediatek,mt8135-pinctrl",
+	}, {
+	}
+};
+MODULE_DEVICE_TABLE(of, mt8135_pctrl_match);
+
+static struct platform_driver mtk_pinctrl_driver = {
+	.probe = mt8135_pinctrl_probe,
+	.driver = {
+		.name = "mediatek-mt8135-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = mt8135_pctrl_match,
+	},
+};
+
+static int __init mtk_pinctrl_init(void)
+{
+	return platform_driver_register(&mtk_pinctrl_driver);
+}
+
+module_init(mtk_pinctrl_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
+MODULE_AUTHOR("Hongzhou Yang <hongzhou.yang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
new file mode 100644
index 0000000..5d680c8
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -0,0 +1,800 @@
+/*
+ * mt65xx pinctrl driver based on Allwinner A1X pinctrl driver.
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinctrl-utils.h"
+#include "pinctrl-mtk-common.h"
+
+#define MAX_GPIO_MODE_PER_REG 5
+#define GPIO_MODE_BITS        3
+
+static const char * const mtk_gpio_functions[] = {
+	"func0", "func1", "func2", "func3",
+	"func4", "func5", "func6", "func7",
+};
+
+/*
+ * There are two base address for pull related configuration
+ * in mt8135, and different GPIO pins use different base address.
+ * When pin number greater than type1_start and less than type1_end,
+ * should use the second base address.
+ */
+static struct regmap *mtk_get_regmap(struct mtk_pinctrl *pctl,
+		unsigned long pin)
+{
+	if (pin >= pctl->devdata->type1_start && pin < pctl->devdata->type1_end)
+		return pctl->regmap2;
+	return pctl->regmap1;
+}
+
+static unsigned int mtk_get_port(struct mtk_pinctrl *pctl, unsigned long pin)
+{
+	/* Different SoC has different mask and port shift. */
+	return ((pin >> 4) & pctl->devdata->port_mask)
+			<< pctl->devdata->port_shf;
+}
+
+static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range, unsigned offset,
+			bool input)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	reg_addr = mtk_get_port(pctl, offset) + pctl->devdata->dir_offset;
+	bit = BIT(offset & 0xf);
+
+	if (input)
+		/* Different SoC has different alignment offset. */
+		reg_addr = CLR_ADDR(reg_addr, pctl);
+	else
+		reg_addr = SET_ADDR(reg_addr, pctl);
+
+	regmap_write(mtk_get_regmap(pctl, offset), reg_addr, bit);
+	return 0;
+}
+
+static void mtk_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	reg_addr = mtk_get_port(pctl, offset) + pctl->devdata->dout_offset;
+	bit = BIT(offset & 0xf);
+
+	if (value)
+		reg_addr = SET_ADDR(reg_addr, pctl);
+	else
+		reg_addr = CLR_ADDR(reg_addr, pctl);
+
+	regmap_write(mtk_get_regmap(pctl, offset), reg_addr, bit);
+}
+
+static void mtk_pconf_set_ies_smt(struct mtk_pinctrl *pctl, unsigned pin,
+		int value, enum pin_config_param param)
+{
+	unsigned int reg_addr, offset;
+	unsigned int bit;
+
+	bit = BIT(pin & 0xf);
+
+	if (param == PIN_CONFIG_INPUT_ENABLE)
+		offset = pctl->devdata->ies_offset;
+	else
+		offset = pctl->devdata->smt_offset;
+
+	if (value)
+		reg_addr = SET_ADDR(mtk_get_port(pctl, pin) + offset, pctl);
+	else
+		reg_addr = CLR_ADDR(mtk_get_port(pctl, pin) + offset, pctl);
+
+	regmap_write(mtk_get_regmap(pctl, pin), reg_addr, bit);
+}
+
+static const struct mtk_pin_drv_grp *mtk_find_pin_drv_grp_by_pin(
+		struct mtk_pinctrl *pctl,  unsigned long pin) {
+	int i;
+
+	for (i = 0; i < pctl->devdata->n_pin_drv_grps; i++) {
+		const struct mtk_pin_drv_grp *pin_drv =
+				pctl->devdata->pin_drv_grp + i;
+		if (pin == pin_drv->pin)
+			return pin_drv;
+	}
+
+	return NULL;
+}
+
+static int mtk_pconf_set_driving(struct mtk_pinctrl *pctl,
+		unsigned int pin, unsigned char driving)
+{
+	const struct mtk_pin_drv_grp *pin_drv;
+	unsigned int val;
+	unsigned int bits, mask, shift;
+	const struct mtk_drv_group_desc *drv_grp;
+
+	if (pin >= pctl->devdata->npins)
+		return -EINVAL;
+
+	pin_drv = mtk_find_pin_drv_grp_by_pin(pctl, pin);
+	if (!pin_drv || pin_drv->grp > pctl->devdata->n_grp_cls)
+		return -EINVAL;
+
+	drv_grp = pctl->devdata->grp_desc + pin_drv->grp;
+	if (driving >= drv_grp->min_drv && driving <= drv_grp->max_drv
+		&& !(driving % drv_grp->step)) {
+		val = driving / drv_grp->step - 1;
+		bits = drv_grp->high_bit - drv_grp->low_bit + 1;
+		mask = BIT(bits) - 1;
+		shift = pin_drv->bit + drv_grp->low_bit;
+		mask <<= shift;
+		val <<= shift;
+		return regmap_update_bits(mtk_get_regmap(pctl, pin),
+				pin_drv->offset, mask, val);
+	}
+
+	return -EINVAL;
+}
+
+static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
+		unsigned int pin, bool enable, bool isup, unsigned int arg)
+{
+	unsigned int bit;
+	unsigned int reg_pullen, reg_pullsel;
+	int ret;
+
+	/* Some pins' pull setting are very different,
+	 * they have separate pull up/down bit, R0 and R1
+	 * resistor bit, so we need this special handle.
+	 */
+	if (pctl->devdata->spec_pull_set) {
+		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
+			pin, pctl->devdata->port_align, isup, arg);
+		if (!ret)
+			return 0;
+	}
+
+	/* For generic pull config, default arg value should be 0 or 1. */
+	if (arg != 0 && arg != 1) {
+		dev_err(pctl->dev, "invalid pull-up argument %d on pin %d .\n",
+			arg, pin);
+		return -EINVAL;
+	}
+
+	bit = BIT(pin & 0xf);
+	if (enable)
+		reg_pullen = SET_ADDR(mtk_get_port(pctl, pin) +
+			pctl->devdata->pullen_offset, pctl);
+	else
+		reg_pullen = CLR_ADDR(mtk_get_port(pctl, pin) +
+			pctl->devdata->pullen_offset, pctl);
+
+	if (isup)
+		reg_pullsel = SET_ADDR(mtk_get_port(pctl, pin) +
+			pctl->devdata->pullsel_offset, pctl);
+	else
+		reg_pullsel = CLR_ADDR(mtk_get_port(pctl, pin) +
+			pctl->devdata->pullsel_offset, pctl);
+
+	regmap_write(mtk_get_regmap(pctl, pin), reg_pullen, bit);
+	regmap_write(mtk_get_regmap(pctl, pin), reg_pullsel, bit);
+	return 0;
+}
+
+static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
+		unsigned int pin, enum pin_config_param param,
+		enum pin_config_param arg)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		mtk_pconf_set_pull_select(pctl, pin, false, false, arg);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		mtk_pconf_set_pull_select(pctl, pin, true, true, arg);
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		mtk_pconf_set_ies_smt(pctl, pin, arg, param);
+		break;
+	case PIN_CONFIG_OUTPUT:
+		mtk_gpio_set(pctl->chip, pin, arg);
+		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, false);
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		mtk_pconf_set_ies_smt(pctl, pin, arg, param);
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		mtk_pconf_set_driving(pctl, pin, arg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_pconf_group_get(struct pinctrl_dev *pctldev,
+				 unsigned group,
+				 unsigned long *config)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*config = pctl->groups[group].config;
+
+	return 0;
+}
+
+static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
+				 unsigned long *configs, unsigned num_configs)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct mtk_pinctrl_group *g = &pctl->groups[group];
+	int i;
+
+	for (i = 0; i < num_configs; i++) {
+		mtk_pconf_parse_conf(pctldev, g->pin,
+			pinconf_to_config_param(configs[i]),
+			pinconf_to_config_argument(configs[i]));
+
+		g->config = configs[i];
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops mtk_pconf_ops = {
+	.pin_config_group_get	= mtk_pconf_group_get,
+	.pin_config_group_set	= mtk_pconf_group_set,
+};
+
+static struct mtk_pinctrl_group *
+mtk_pctrl_find_group_by_pin(struct mtk_pinctrl *pctl, u32 pin)
+{
+	int i;
+
+	for (i = 0; i < pctl->ngroups; i++) {
+		struct mtk_pinctrl_group *grp = pctl->groups + i;
+
+		if (grp->pin == pin)
+			return grp;
+	}
+
+	return NULL;
+}
+
+static const struct mtk_desc_function *mtk_pctrl_find_function_by_pin(
+		struct mtk_pinctrl *pctl, u32 pin_num, u32 fnum)
+{
+	const struct mtk_desc_pin *pin = pctl->devdata->pins + pin_num;
+	const struct mtk_desc_function *func = pin->functions;
+
+	while (func && func->name) {
+		if (func->muxval == fnum)
+			return func;
+		func++;
+	}
+
+	return NULL;
+}
+
+static bool mtk_pctrl_is_function_valid(struct mtk_pinctrl *pctl,
+		u32 pin_num, u32 fnum)
+{
+	int i;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mtk_desc_pin *pin = pctl->devdata->pins + i;
+
+		if (pin->pin.number == pin_num) {
+			const struct mtk_desc_function *func =
+					pin->functions;
+
+			while (func && func->name) {
+				if (func->muxval == fnum)
+					return true;
+				func++;
+			}
+
+			break;
+		}
+	}
+
+	return false;
+}
+
+static int mtk_pctrl_dt_node_to_map_func(struct mtk_pinctrl *pctl,
+		u32 pin, u32 fnum, struct mtk_pinctrl_group *grp,
+		struct pinctrl_map **map, unsigned *reserved_maps,
+		unsigned *num_maps)
+{
+	bool ret;
+
+	if (*num_maps == *reserved_maps)
+		return -ENOSPC;
+
+	(*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
+	(*map)[*num_maps].data.mux.group = grp->name;
+
+	ret = mtk_pctrl_is_function_valid(pctl, pin, fnum);
+	if (!ret) {
+		dev_err(pctl->dev, "invalid function %d on pin %d .\n",
+				fnum, pin);
+		return -EINVAL;
+	}
+
+	(*map)[*num_maps].data.mux.function = mtk_gpio_functions[fnum];
+	(*num_maps)++;
+
+	return 0;
+}
+
+static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+				      struct device_node *node,
+				      struct pinctrl_map **map,
+				      unsigned *reserved_maps,
+				      unsigned *num_maps)
+{
+	struct property *pins;
+	u32 pinfunc, pin, func;
+	int num_pins, num_funcs, maps_per_pin;
+	unsigned long *configs;
+	unsigned int num_configs;
+	bool has_config = 0;
+	int i, err;
+	unsigned reserve = 0;
+	struct mtk_pinctrl_group *grp;
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	pins = of_find_property(node, "pinmux", NULL);
+	if (!pins) {
+		dev_err(pctl->dev, "missing pins property in node %s .\n",
+				node->name);
+		return -EINVAL;
+	}
+
+	err = pinconf_generic_parse_dt_config(node, &configs, &num_configs);
+	if (num_configs)
+		has_config = 1;
+
+	num_pins = pins->length / sizeof(u32);
+	num_funcs = num_pins;
+	maps_per_pin = 0;
+	if (num_funcs)
+		maps_per_pin++;
+	if (has_config && num_pins >= 1)
+		maps_per_pin++;
+
+	if (!num_pins || !maps_per_pin)
+		return -EINVAL;
+
+	reserve = num_pins * maps_per_pin;
+
+	err = pinctrl_utils_reserve_map(pctldev, map,
+			reserved_maps, num_maps, reserve);
+	if (err < 0)
+		goto fail;
+
+	for (i = 0; i < num_pins; i++) {
+		err = of_property_read_u32_index(node, "pinmux",
+				i, &pinfunc);
+		if (err)
+			goto fail;
+
+		pin = MTK_GET_PIN_NO(pinfunc);
+		func = MTK_GET_PIN_FUNC(pinfunc);
+
+		if (pin >= pctl->devdata->npins ||
+				func >= ARRAY_SIZE(mtk_gpio_functions)) {
+			dev_err(pctl->dev, "invalid pins value.\n");
+			err = -EINVAL;
+			goto fail;
+		}
+
+		grp = mtk_pctrl_find_group_by_pin(pctl, pin);
+		if (!grp) {
+			dev_err(pctl->dev, "unable to match pin %d to group\n",
+					pin);
+			return -EINVAL;
+		}
+
+		err = mtk_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
+				reserved_maps, num_maps);
+		if (err < 0)
+			goto fail;
+
+		if (has_config) {
+			err = pinctrl_utils_add_map_configs(pctldev, map,
+					reserved_maps, num_maps, grp->name,
+					configs, num_configs,
+					PIN_MAP_TYPE_CONFIGS_GROUP);
+			if (err < 0)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	return err;
+}
+
+static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct device_node *np;
+	unsigned reserved_maps;
+	int ret;
+
+	*map = NULL;
+	*num_maps = 0;
+	reserved_maps = 0;
+
+	for_each_child_of_node(np_config, np) {
+		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
+				&reserved_maps, num_maps);
+		if (ret < 0) {
+			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->ngroups;
+}
+
+static const char *mtk_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					      unsigned group)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->groups[group].name;
+}
+
+static int mtk_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned group,
+				      const unsigned **pins,
+				      unsigned *num_pins)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned *)&pctl->groups[group].pin;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mtk_pctrl_ops = {
+	.dt_node_to_map		= mtk_pctrl_dt_node_to_map,
+	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.get_groups_count	= mtk_pctrl_get_groups_count,
+	.get_group_name		= mtk_pctrl_get_group_name,
+	.get_group_pins		= mtk_pctrl_get_group_pins,
+};
+
+static int mtk_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mtk_gpio_functions);
+}
+
+static const char *mtk_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned selector)
+{
+	return mtk_gpio_functions[selector];
+}
+
+static int mtk_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				     unsigned function,
+				     const char * const **groups,
+				     unsigned * const num_groups)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctl->grp_names;
+	*num_groups = pctl->ngroups;
+
+	return 0;
+}
+
+static int mtk_pmx_set_mode(struct pinctrl_dev *pctldev,
+		unsigned long pin, unsigned long mode)
+{
+	unsigned int reg_addr;
+	unsigned char bit;
+	unsigned int val;
+	unsigned int mask = (1L << GPIO_MODE_BITS) - 1;
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	reg_addr = ((pin / MAX_GPIO_MODE_PER_REG) << pctl->devdata->port_shf)
+			+ pctl->devdata->pinmux_offset;
+
+	bit = pin % MAX_GPIO_MODE_PER_REG;
+	mask <<= (GPIO_MODE_BITS * bit);
+	val = (mode << (GPIO_MODE_BITS * bit));
+	return regmap_update_bits(mtk_get_regmap(pctl, pin),
+			reg_addr, mask, val);
+}
+
+static int mtk_pmx_set_mux(struct pinctrl_dev *pctldev,
+			    unsigned function,
+			    unsigned group)
+{
+	bool ret;
+	const struct mtk_desc_function *desc;
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct mtk_pinctrl_group *g = pctl->groups + group;
+
+	ret = mtk_pctrl_is_function_valid(pctl, g->pin, function);
+	if (!ret) {
+		dev_err(pctl->dev, "invaild function %d on group %d .\n",
+				function, group);
+		return -EINVAL;
+	}
+
+	desc = mtk_pctrl_find_function_by_pin(pctl, g->pin, function);
+	if (!desc)
+		return -EINVAL;
+	mtk_pmx_set_mode(pctldev, g->pin, desc->muxval);
+	return 0;
+}
+
+static const struct pinmux_ops mtk_pmx_ops = {
+	.get_functions_count	= mtk_pmx_get_funcs_cnt,
+	.get_function_name	= mtk_pmx_get_func_name,
+	.get_function_groups	= mtk_pmx_get_func_groups,
+	.set_mux		= mtk_pmx_set_mux,
+	.gpio_set_direction	= mtk_pmx_gpio_set_direction,
+};
+
+static int mtk_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void mtk_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+}
+
+static int mtk_gpio_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	return pinctrl_gpio_direction_input(chip->base + offset);
+}
+
+static int mtk_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	mtk_gpio_set(chip, offset, value);
+	return pinctrl_gpio_direction_output(chip->base + offset);
+}
+
+static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	unsigned int read_val = 0;
+
+	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	reg_addr =  mtk_get_port(pctl, offset) + pctl->devdata->dir_offset;
+	bit = BIT(offset & 0xf);
+	regmap_read(pctl->regmap1, reg_addr, &read_val);
+	return !!(read_val & bit);
+}
+
+static int mtk_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	unsigned int read_val = 0;
+	struct mtk_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	if (mtk_gpio_get_direction(chip, offset))
+		reg_addr = mtk_get_port(pctl, offset) +
+			pctl->devdata->dout_offset;
+	else
+		reg_addr = mtk_get_port(pctl, offset) +
+			pctl->devdata->din_offset;
+
+	bit = BIT(offset & 0xf);
+	regmap_read(pctl->regmap1, reg_addr, &read_val);
+	return !!(read_val & bit);
+}
+
+static struct gpio_chip mtk_gpio_chip = {
+	.owner			= THIS_MODULE,
+	.request		= mtk_gpio_request,
+	.free			= mtk_gpio_free,
+	.direction_input	= mtk_gpio_direction_input,
+	.direction_output	= mtk_gpio_direction_output,
+	.get			= mtk_gpio_get,
+	.set			= mtk_gpio_set,
+	.of_gpio_n_cells	= 2,
+};
+
+static int mtk_pctrl_build_state(struct platform_device *pdev)
+{
+	struct mtk_pinctrl *pctl = platform_get_drvdata(pdev);
+	int i;
+
+	pctl->ngroups = pctl->devdata->npins;
+
+	/* Allocate groups */
+	pctl->groups = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->groups),
+				    GFP_KERNEL);
+	if (!pctl->groups)
+		return -ENOMEM;
+
+	/* We assume that one pin is one group, use pin name as group name. */
+	pctl->grp_names = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->grp_names),
+				    GFP_KERNEL);
+	if (!pctl->grp_names)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mtk_desc_pin *pin = pctl->devdata->pins + i;
+		struct mtk_pinctrl_group *group = pctl->groups + i;
+
+		group->name = pin->pin.name;
+		group->pin = pin->pin.number;
+
+		pctl->grp_names[i] = pin->pin.name;
+	}
+
+	return 0;
+}
+
+static struct pinctrl_desc mtk_pctrl_desc = {
+	.confops	= &mtk_pconf_ops,
+	.pctlops	= &mtk_pctrl_ops,
+	.pmxops		= &mtk_pmx_ops,
+};
+
+int mtk_pctrl_init(struct platform_device *pdev,
+		const struct mtk_pinctrl_devdata *data)
+{
+	struct pinctrl_pin_desc *pins;
+	struct mtk_pinctrl *pctl;
+	struct device_node *np = pdev->dev.of_node, *node;
+	struct property *prop;
+	int i, ret;
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pctl);
+
+	prop = of_find_property(np, "pins-are-numbered", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "only support pins-are-numbered format\n", ret);
+		return -EINVAL;
+	}
+
+	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
+	if (node) {
+		pctl->regmap1 = syscon_node_to_regmap(node);
+		if (IS_ERR(pctl->regmap1))
+			return PTR_ERR(pctl->regmap1);
+	}
+
+	/* Only 8135 has two base addr, other SoCs have only one. */
+	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
+	if (node) {
+		pctl->regmap2 = syscon_node_to_regmap(node);
+		if (IS_ERR(pctl->regmap2))
+			return PTR_ERR(pctl->regmap2);
+	}
+
+	pctl->devdata = data;
+	ret = mtk_pctrl_build_state(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "build state failed: %d\n", ret);
+		return -EINVAL;
+	}
+
+	pins = devm_kzalloc(&pdev->dev,
+			    pctl->devdata->npins * sizeof(*pins),
+			    GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->devdata->npins; i++)
+		pins[i] = pctl->devdata->pins[i].pin;
+	mtk_pctrl_desc.name = dev_name(&pdev->dev);
+	mtk_pctrl_desc.owner = THIS_MODULE;
+	mtk_pctrl_desc.pins = pins;
+	mtk_pctrl_desc.npins = pctl->devdata->npins;
+	pctl->dev = &pdev->dev;
+	pctl->pctl_dev = pinctrl_register(&mtk_pctrl_desc, &pdev->dev, pctl);
+	if (!pctl->pctl_dev) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return -EINVAL;
+	}
+
+	pctl->chip = devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL);
+	if (!pctl->chip) {
+		ret = -ENOMEM;
+		goto pctrl_error;
+	}
+
+	pctl->chip = &mtk_gpio_chip;
+	pctl->chip->ngpio = pctl->devdata->npins;
+	pctl->chip->label = dev_name(&pdev->dev);
+	pctl->chip->dev = &pdev->dev;
+	pctl->chip->base = 0;
+
+	ret = gpiochip_add(pctl->chip);
+	if (ret) {
+		ret = -EINVAL;
+		goto pctrl_error;
+	}
+
+	/* Register the GPIO to pin mappings. */
+	ret = gpiochip_add_pin_range(pctl->chip, dev_name(&pdev->dev),
+			0, 0, pctl->devdata->npins);
+	if (ret) {
+		ret = -EINVAL;
+		goto chip_error;
+	}
+
+	return 0;
+
+chip_error:
+	gpiochip_remove(pctl->chip);
+pctrl_error:
+	pinctrl_unregister(pctl->pctl_dev);
+	return ret;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
+MODULE_AUTHOR("Hongzhou Yang <hongzhou.yang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
new file mode 100644
index 0000000..95a9d57
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -0,0 +1,185 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __PINCTRL_MTK_COMMON_H
+#define __PINCTRL_MTK_COMMON_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/spinlock.h>
+#include <linux/regmap.h>
+
+#define NO_EINT_SUPPORT    255
+
+struct mtk_desc_function {
+	const char *name;
+	unsigned char muxval;
+};
+
+struct mtk_desc_eint {
+	unsigned char eintmux;
+	unsigned char eintnum;
+};
+
+struct mtk_desc_pin {
+	struct pinctrl_pin_desc	pin;
+	const char *chip;
+	const struct mtk_desc_eint eint;
+	const struct mtk_desc_function	*functions;
+};
+
+#define MTK_PIN(_pin, _pad, _chip, _eint, ...)		\
+	{							\
+		.pin = _pin,					\
+		.chip = _chip,					\
+		.eint = _eint,					\
+		.functions = (struct mtk_desc_function[]){	\
+			__VA_ARGS__, { } },			\
+	}
+
+#define MTK_EINT_FUNCTION(_eintmux, _eintnum)				\
+	{							\
+		.eintmux = _eintmux,					\
+		.eintnum = _eintnum,					\
+	}
+
+#define MTK_FUNCTION(_val, _name)				\
+	{							\
+		.muxval = _val,					\
+		.name = _name,					\
+	}
+
+#define SET_ADDR(x, y)  (x + (y->devdata->port_align))
+#define CLR_ADDR(x, y)  (x + (y->devdata->port_align << 1))
+
+struct mtk_pinctrl_group {
+	const char	*name;
+	unsigned long	config;
+	unsigned	pin;
+};
+
+/**
+ * struct mtk_drv_group_desc - Provide driving group data.
+ * @max_drv: The maximum current of this group.
+ * @min_drv: The minimum current of this group.
+ * @low_bit: The lowest bit of this group.
+ * @high_bit: The highest bit of this group.
+ * @step: The step current of this group.
+ */
+struct mtk_drv_group_desc {
+	unsigned char min_drv;
+	unsigned char max_drv;
+	unsigned char low_bit;
+	unsigned char high_bit;
+	unsigned char step;
+};
+
+#define MTK_DRV_GRP(_min, _max, _low, _high, _step)	\
+	{	\
+		.min_drv = _min,	\
+		.max_drv = _max,	\
+		.low_bit = _low,	\
+		.high_bit = _high,	\
+		.step = _step,		\
+	}
+
+/**
+ * struct mtk_pin_drv_grp - Provide each pin driving info.
+ * @pin: The pin number.
+ * @offset: The offset of driving register for this pin.
+ * @bit: The bit of driving register for this pin.
+ * @grp: The group for this pin belongs to.
+ */
+struct mtk_pin_drv_grp {
+	unsigned int pin;
+	unsigned int offset;
+	unsigned char bit;
+	unsigned char grp;
+};
+
+#define MTK_PIN_DRV_GRP(_pin, _offset, _bit, _grp)	\
+	{	\
+		.pin = _pin,	\
+		.offset = _offset,	\
+		.bit = _bit,	\
+		.grp = _grp,	\
+	}
+
+/**
+ * struct mtk_pinctrl_devdata - Provide HW GPIO related data.
+ * @pins: An array describing all pins the pin controller affects.
+ * @npins: The number of entries in @pins.
+ *
+ * @grp_desc: The driving group info.
+ * @pin_drv_grp: The driving group for all pins.
+ * @spec_pull_set: Each SoC may have special pins for pull up/down setting,
+ *  these pins' pull setting are very different, they have separate pull
+ *  up/down bit, R0 and R1 resistor bit, so they need special pull setting.
+ *  If special setting is success, this should return 0, otherwise it should
+ *  return non-zero value.
+ *
+ * @dir_offset: The direction register offset.
+ * @pullen_offset: The pull-up/pull-down enable register offset.
+ * @pinmux_offset: The pinmux register offset.
+ *
+ * @type1_start: Some chips have two base addresses for pull select register,
+ *  that means some pins use the first address and others use the second. This
+ *  member record the start of pin number to use the second address.
+ * @type1_end: The end of pin number to use the second address.
+ *
+ * @port_shf: The shift between two registers.
+ * @port_mask: The mask of register.
+ * @port_align: Provide clear register and set register step.
+ */
+struct mtk_pinctrl_devdata {
+	const struct mtk_desc_pin	*pins;
+	unsigned int				npins;
+	const struct mtk_drv_group_desc	*grp_desc;
+	unsigned int	n_grp_cls;
+	const struct mtk_pin_drv_grp	*pin_drv_grp;
+	unsigned int	n_pin_drv_grps;
+	int (*spec_pull_set)(struct regmap *reg, unsigned int pin,
+			unsigned char align, bool isup, unsigned int arg);
+	unsigned int dir_offset;
+	unsigned int ies_offset;
+	unsigned int smt_offset;
+	unsigned int pullen_offset;
+	unsigned int pullsel_offset;
+	unsigned int drv_offset;
+	unsigned int invser_offset;
+	unsigned int dout_offset;
+	unsigned int din_offset;
+	unsigned int pinmux_offset;
+	unsigned short type1_start;
+	unsigned short type1_end;
+	unsigned char  port_shf;
+	unsigned char  port_mask;
+	unsigned char  port_align;
+};
+
+struct mtk_pinctrl {
+	struct regmap	*regmap1;
+	struct regmap	*regmap2;
+	struct device           *dev;
+	struct gpio_chip	*chip;
+	struct mtk_pinctrl_group	*groups;
+	unsigned			ngroups;
+	const char          **grp_names;
+	struct pinctrl_dev      *pctl_dev;
+	const struct mtk_pinctrl_devdata  *devdata;
+};
+
+int mtk_pctrl_init(struct platform_device *pdev,
+		const struct mtk_pinctrl_devdata *data);
+
+#endif /* __PINCTRL_MTK_COMMON_H */
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
new file mode 100644
index 0000000..5019cef
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
@@ -0,0 +1,2114 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __PINCTRL_MTK_MT8135_H
+#define __PINCTRL_MTK_MT8135_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <pinctrl-mtk-common.h>
+
+static const struct mtk_desc_pin mtk_pins_mt8135[] = {
+	MTK_PIN(
+		PINCTRL_PIN(0, "MSDC0_DAT7"),
+		"D21", "mt8135",
+		MTK_EINT_FUNCTION(2, 49),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "MSDC0_DAT7"),
+		MTK_FUNCTION(2, "EINT49"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "DAC_DAT_OUT"),
+		MTK_FUNCTION(5, "PCM1_DO"),
+		MTK_FUNCTION(6, "SPI1_MO"),
+		MTK_FUNCTION(7, "NALE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(1, "MSDC0_DAT6"),
+		"D22", "mt8135",
+		MTK_EINT_FUNCTION(2, 48),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "MSDC0_DAT6"),
+		MTK_FUNCTION(2, "EINT48"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "DAC_WS"),
+		MTK_FUNCTION(5, "PCM1_WS"),
+		MTK_FUNCTION(6, "SPI1_CSN"),
+		MTK_FUNCTION(7, "NCLE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(2, "MSDC0_DAT5"),
+		"E22", "mt8135",
+		MTK_EINT_FUNCTION(2, 47),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "MSDC0_DAT5"),
+		MTK_FUNCTION(2, "EINT47"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "DAC_CK"),
+		MTK_FUNCTION(5, "PCM1_CK"),
+		MTK_FUNCTION(6, "SPI1_CLK"),
+		MTK_FUNCTION(7, "NLD4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(3, "MSDC0_DAT4"),
+		"F21", "mt8135",
+		MTK_EINT_FUNCTION(2, 46),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "MSDC0_DAT4"),
+		MTK_FUNCTION(2, "EINT46"),
+		MTK_FUNCTION(3, "A_FUNC_CK"),
+		MTK_FUNCTION(6, "LSCE1B_2X"),
+		MTK_FUNCTION(7, "NLD5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(4, "MSDC0_CMD"),
+		"F20", "mt8135",
+		MTK_EINT_FUNCTION(2, 41),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "MSDC0_CMD"),
+		MTK_FUNCTION(2, "EINT41"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[0]"),
+		MTK_FUNCTION(5, "USB_TEST_IO[0]"),
+		MTK_FUNCTION(6, "LRSTB_2X"),
+		MTK_FUNCTION(7, "NRNB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(5, "MSDC0_CLK"),
+		"G18", "mt8135",
+		MTK_EINT_FUNCTION(2, 40),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "MSDC0_CLK"),
+		MTK_FUNCTION(2, "EINT40"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[1]"),
+		MTK_FUNCTION(5, "USB_TEST_IO[1]"),
+		MTK_FUNCTION(6, "LPTE"),
+		MTK_FUNCTION(7, "NREB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(6, "MSDC0_DAT3"),
+		"G21", "mt8135",
+		MTK_EINT_FUNCTION(2, 45),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "MSDC0_DAT3"),
+		MTK_FUNCTION(2, "EINT45"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[2]"),
+		MTK_FUNCTION(5, "USB_TEST_IO[2]"),
+		MTK_FUNCTION(6, "LSCE0B_2X"),
+		MTK_FUNCTION(7, "NLD7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(7, "MSDC0_DAT2"),
+		"E21", "mt8135",
+		MTK_EINT_FUNCTION(2, 44),
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "MSDC0_DAT2"),
+		MTK_FUNCTION(2, "EINT44"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[3]"),
+		MTK_FUNCTION(5, "USB_TEST_IO[3]"),
+		MTK_FUNCTION(6, "LSA0_2X"),
+		MTK_FUNCTION(7, "NLD14")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(8, "MSDC0_DAT1"),
+		"E23", "mt8135",
+		MTK_EINT_FUNCTION(2, 43),
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "MSDC0_DAT1"),
+		MTK_FUNCTION(2, "EINT43"),
+		MTK_FUNCTION(5, "USB_TEST_IO[4]"),
+		MTK_FUNCTION(6, "LSCK_2X"),
+		MTK_FUNCTION(7, "NLD11")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(9, "MSDC0_DAT0"),
+		"F22", "mt8135",
+		MTK_EINT_FUNCTION(2, 42),
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "MSDC0_DAT0"),
+		MTK_FUNCTION(2, "EINT42"),
+		MTK_FUNCTION(5, "USB_TEST_IO[5]"),
+		MTK_FUNCTION(6, "LSDA_2X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(10, "NCEB0"),
+		"G20", "mt8135",
+		MTK_EINT_FUNCTION(2, 139),
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "NCEB0"),
+		MTK_FUNCTION(2, "EINT139"),
+		MTK_FUNCTION(7, "TESTA_OUT4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(11, "NCEB1"),
+		"L17", "mt8135",
+		MTK_EINT_FUNCTION(2, 140),
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "NCEB1"),
+		MTK_FUNCTION(2, "EINT140"),
+		MTK_FUNCTION(6, "USB_DRVVBUS"),
+		MTK_FUNCTION(7, "TESTA_OUT5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(12, "NRNB"),
+		"G19", "mt8135",
+		MTK_EINT_FUNCTION(2, 141),
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "NRNB"),
+		MTK_FUNCTION(2, "EINT141"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[4]"),
+		MTK_FUNCTION(7, "TESTA_OUT6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(13, "NCLE"),
+		"J18", "mt8135",
+		MTK_EINT_FUNCTION(2, 142),
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "NCLE"),
+		MTK_FUNCTION(2, "EINT142"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[5]"),
+		MTK_FUNCTION(4, "CM2PDN_1X"),
+		MTK_FUNCTION(6, "NALE"),
+		MTK_FUNCTION(7, "TESTA_OUT7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(14, "NALE"),
+		"J19", "mt8135",
+		MTK_EINT_FUNCTION(2, 143),
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "NALE"),
+		MTK_FUNCTION(2, "EINT143"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[6]"),
+		MTK_FUNCTION(4, "CM2MCLK_1X"),
+		MTK_FUNCTION(5, "IRDA_RXD"),
+		MTK_FUNCTION(6, "NCLE"),
+		MTK_FUNCTION(7, "TESTA_OUT8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(15, "NREB"),
+		"L18", "mt8135",
+		MTK_EINT_FUNCTION(2, 144),
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "NREB"),
+		MTK_FUNCTION(2, "EINT144"),
+		MTK_FUNCTION(3, "A_FUNC_DOUT[7]"),
+		MTK_FUNCTION(4, "CM2RST_1X"),
+		MTK_FUNCTION(5, "IRDA_TXD"),
+		MTK_FUNCTION(7, "TESTA_OUT9")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(16, "NWEB"),
+		"J20", "mt8135",
+		MTK_EINT_FUNCTION(2, 145),
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "NWEB"),
+		MTK_FUNCTION(2, "EINT145"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[0]"),
+		MTK_FUNCTION(4, "CM2PCLK_1X"),
+		MTK_FUNCTION(5, "IRDA_PDN"),
+		MTK_FUNCTION(7, "TESTA_OUT10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(17, "NLD0"),
+		"K21", "mt8135",
+		MTK_EINT_FUNCTION(2, 146),
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "NLD0"),
+		MTK_FUNCTION(2, "EINT146"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[1]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[0]"),
+		MTK_FUNCTION(5, "I2SIN_CK"),
+		MTK_FUNCTION(6, "DAC_CK"),
+		MTK_FUNCTION(7, "TESTA_OUT11")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(18, "NLD1"),
+		"K22", "mt8135",
+		MTK_EINT_FUNCTION(2, 147),
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "NLD1"),
+		MTK_FUNCTION(2, "EINT147"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[2]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[1]"),
+		MTK_FUNCTION(5, "I2SIN_WS"),
+		MTK_FUNCTION(6, "DAC_WS"),
+		MTK_FUNCTION(7, "TESTA_OUT12")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(19, "NLD2"),
+		"J21", "mt8135",
+		MTK_EINT_FUNCTION(2, 148),
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "NLD2"),
+		MTK_FUNCTION(2, "EINT148"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[3]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[2]"),
+		MTK_FUNCTION(5, "I2SOUT_DAT"),
+		MTK_FUNCTION(6, "DAC_DAT_OUT"),
+		MTK_FUNCTION(7, "TESTA_OUT13")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(20, "NLD3"),
+		"J23", "mt8135",
+		MTK_EINT_FUNCTION(2, 149),
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "NLD3"),
+		MTK_FUNCTION(2, "EINT149"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[4]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[3]"),
+		MTK_FUNCTION(7, "TESTA_OUT14")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(21, "NLD4"),
+		"J22", "mt8135",
+		MTK_EINT_FUNCTION(2, 150),
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "NLD4"),
+		MTK_FUNCTION(2, "EINT150"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[5]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[4]"),
+		MTK_FUNCTION(7, "TESTA_OUT15")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(22, "NLD5"),
+		"H21", "mt8135",
+		MTK_EINT_FUNCTION(2, 151),
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "NLD5"),
+		MTK_FUNCTION(2, "EINT151"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[6]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[5]"),
+		MTK_FUNCTION(7, "TESTA_OUT16")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(23, "NLD6"),
+		"H22", "mt8135",
+		MTK_EINT_FUNCTION(2, 152),
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "NLD6"),
+		MTK_FUNCTION(2, "EINT152"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[7]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[6]"),
+		MTK_FUNCTION(7, "TESTA_OUT17")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(24, "NLD7"),
+		"H20", "mt8135",
+		MTK_EINT_FUNCTION(2, 153),
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "NLD7"),
+		MTK_FUNCTION(2, "EINT153"),
+		MTK_FUNCTION(3, "A_FUNC_DIN[8]"),
+		MTK_FUNCTION(4, "CM2DAT_1X[7]"),
+		MTK_FUNCTION(7, "TESTA_OUT18")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(25, "NLD8"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 154),
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "NLD8"),
+		MTK_FUNCTION(2, "EINT154"),
+		MTK_FUNCTION(4, "CM2DAT_1X[8]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(26, "NLD9"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 155),
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "NLD9"),
+		MTK_FUNCTION(2, "EINT155"),
+		MTK_FUNCTION(4, "CM2DAT_1X[9]"),
+		MTK_FUNCTION(5, "PWM1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(27, "NLD10"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 156),
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "NLD10"),
+		MTK_FUNCTION(2, "EINT156"),
+		MTK_FUNCTION(4, "CM2VSYNC_1X"),
+		MTK_FUNCTION(5, "PWM2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(28, "NLD11"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 157),
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "NLD11"),
+		MTK_FUNCTION(2, "EINT157"),
+		MTK_FUNCTION(4, "CM2HSYNC_1X"),
+		MTK_FUNCTION(5, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(29, "NLD12"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 158),
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "NLD12"),
+		MTK_FUNCTION(2, "EINT158"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "DAC_CK"),
+		MTK_FUNCTION(5, "PCM1_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(30, "NLD13"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 159),
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "NLD13"),
+		MTK_FUNCTION(2, "EINT159"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "DAC_WS"),
+		MTK_FUNCTION(5, "PCM1_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(31, "NLD14"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 160),
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "NLD14"),
+		MTK_FUNCTION(2, "EINT160"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "DAC_DAT_OUT"),
+		MTK_FUNCTION(5, "PCM1_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(32, "NLD15"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 161),
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "NLD15"),
+		MTK_FUNCTION(2, "EINT161"),
+		MTK_FUNCTION(3, "DISP_PWM"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "PCM1_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(33, "MSDC0_RSTB"),
+		"G22", "mt8135",
+		MTK_EINT_FUNCTION(2, 50),
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "MSDC0_RSTB"),
+		MTK_FUNCTION(2, "EINT50"),
+		MTK_FUNCTION(3, "I2SIN_DAT"),
+		MTK_FUNCTION(5, "PCM1_DI"),
+		MTK_FUNCTION(6, "SPI1_MI"),
+		MTK_FUNCTION(7, "NLD10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(34, "IDDIG"),
+		"N17", "mt8135",
+		MTK_EINT_FUNCTION(2, 34),
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "EINT34")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(35, "SCL3"),
+		"L19", "mt8135",
+		MTK_EINT_FUNCTION(2, 96),
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "SCL3"),
+		MTK_FUNCTION(2, "EINT96"),
+		MTK_FUNCTION(3, "CLKM6"),
+		MTK_FUNCTION(4, "PWM6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(36, "SDA3"),
+		"L20", "mt8135",
+		MTK_EINT_FUNCTION(2, 97),
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "SDA3"),
+		MTK_FUNCTION(2, "EINT97")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(37, "AUD_CLK_MOSI"),
+		"L21", "mt8135",
+		MTK_EINT_FUNCTION(4, 19),
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "AUD_CLK"),
+		MTK_FUNCTION(2, "ADC_CK"),
+		MTK_FUNCTION(3, " HDMI_SDATA0"),
+		MTK_FUNCTION(4, "EINT19"),
+		MTK_FUNCTION(5, "USB_TEST_IO[6]"),
+		MTK_FUNCTION(7, "TESTA_OUT19")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(38, "AUD_DAT_MOSI"),
+		"L23", "mt8135",
+		MTK_EINT_FUNCTION(4, 21),
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI"),
+		MTK_FUNCTION(2, "ADC_WS"),
+		MTK_FUNCTION(3, "AUD_DAT_MISO"),
+		MTK_FUNCTION(4, "EINT21"),
+		MTK_FUNCTION(5, "USB_TEST_IO[7]"),
+		MTK_FUNCTION(7, "TESTA_OUT20")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(39, "AUD_DAT_MISO"),
+		"L22", "mt8135",
+		MTK_EINT_FUNCTION(4, 20),
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO"),
+		MTK_FUNCTION(2, "ADC_DAT_IN"),
+		MTK_FUNCTION(3, "AUD_DAT_MOSI"),
+		MTK_FUNCTION(4, "EINT20"),
+		MTK_FUNCTION(5, "USB_TEST_IO[8]"),
+		MTK_FUNCTION(7, "TESTA_OUT21")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(40, "DAC_CLK"),
+		"P21", "mt8135",
+		MTK_EINT_FUNCTION(2, 22),
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "DAC_CK"),
+		MTK_FUNCTION(2, "EINT22"),
+		MTK_FUNCTION(3, " HDMI_SDATA1"),
+		MTK_FUNCTION(5, "USB_TEST_IO[9]"),
+		MTK_FUNCTION(7, "TESTA_OUT22")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(41, "DAC_WS"),
+		"N18", "mt8135",
+		MTK_EINT_FUNCTION(2, 24),
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "DAC_WS"),
+		MTK_FUNCTION(2, "EINT24"),
+		MTK_FUNCTION(3, " HDMI_SDATA2"),
+		MTK_FUNCTION(5, "USB_TEST_IO[10]"),
+		MTK_FUNCTION(7, "TESTA_OUT23")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(42, "DAC_DAT_OUT"),
+		"N22", "mt8135",
+		MTK_EINT_FUNCTION(2, 23),
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "DAC_DAT_OUT"),
+		MTK_FUNCTION(2, "EINT23"),
+		MTK_FUNCTION(3, " HDMI_SDATA3"),
+		MTK_FUNCTION(5, "USB_TEST_IO[11]"),
+		MTK_FUNCTION(7, "TESTA_OUT24")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(43, "PWRAP_SPI0_MO"),
+		"M22", "mt8135",
+		MTK_EINT_FUNCTION(2, 29),
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "PWRAP_SPIDI"),
+		MTK_FUNCTION(2, "EINT29")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(44, "PWRAP_SPI0_MI"),
+		"P23", "mt8135",
+		MTK_EINT_FUNCTION(2, 28),
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "PWRAP_SPIDO"),
+		MTK_FUNCTION(2, "EINT28")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(45, "PWRAP_SPI0_CSN"),
+		"M21", "mt8135",
+		MTK_EINT_FUNCTION(2, 27),
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "PWRAP_SPICS_B_I"),
+		MTK_FUNCTION(2, "EINT27")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(46, "PWRAP_SPI0_CLK"),
+		"P22", "mt8135",
+		MTK_EINT_FUNCTION(2, 26),
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "PWRAP_SPICK_I"),
+		MTK_FUNCTION(2, "EINT26")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(47, "PWRAP_EVENT"),
+		"M23", "mt8135",
+		MTK_EINT_FUNCTION(2, 25),
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "PWRAP_EVENT_IN"),
+		MTK_FUNCTION(2, "EINT25"),
+		MTK_FUNCTION(7, "TESTA_OUT2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(48, "RTC32K_CK"),
+		"N20", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(49, "WATCHDOG"),
+		"R22", "mt8135",
+		MTK_EINT_FUNCTION(2, 36),
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "WATCHDOG"),
+		MTK_FUNCTION(2, "EINT36")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(50, "SRCLKENA"),
+		"T22", "mt8135",
+		MTK_EINT_FUNCTION(2, 38),
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "SRCLKENA"),
+		MTK_FUNCTION(2, "EINT38")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(51, "SRCVOLTEN"),
+		"T23", "mt8135",
+		MTK_EINT_FUNCTION(2, 37),
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "SRCVOLTEN"),
+		MTK_FUNCTION(2, "EINT37")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(52, "EINT0"),
+		"T21", "mt8135",
+		MTK_EINT_FUNCTION(1, 0),
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "EINT0"),
+		MTK_FUNCTION(2, "PWM1"),
+		MTK_FUNCTION(3, "CLKM0"),
+		MTK_FUNCTION(4, " SPDIF_OUT"),
+		MTK_FUNCTION(5, "USB_TEST_IO[12]"),
+		MTK_FUNCTION(7, "USB_SCL")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(53, "URXD2"),
+		"R18", "mt8135",
+		MTK_EINT_FUNCTION(2, 83),
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "EINT83"),
+		MTK_FUNCTION(4, " HDMI_LRCK"),
+		MTK_FUNCTION(5, "CLKM3"),
+		MTK_FUNCTION(7, "UTXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(54, "UTXD2"),
+		"R17", "mt8135",
+		MTK_EINT_FUNCTION(2, 82),
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "EINT82"),
+		MTK_FUNCTION(4, " HDMI_BCK_OUT"),
+		MTK_FUNCTION(5, "CLKM2"),
+		MTK_FUNCTION(7, "URXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(55, "UCTS2"),
+		"R20", "mt8135",
+		MTK_EINT_FUNCTION(2, 84),
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "UCTS2"),
+		MTK_FUNCTION(2, "EINT84"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(7, "URTS2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(56, "URTS2"),
+		"R19", "mt8135",
+		MTK_EINT_FUNCTION(2, 85),
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "URTS2"),
+		MTK_FUNCTION(2, "EINT85"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(7, "UCTS2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(57, "JTCK"),
+		"V17", "mt8135",
+		MTK_EINT_FUNCTION(2, 188),
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, "EINT188"),
+		MTK_FUNCTION(3, "DSP1_ICK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(58, "JTDO"),
+		"T16", "mt8135",
+		MTK_EINT_FUNCTION(2, 190),
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "EINT190"),
+		MTK_FUNCTION(3, "DSP2_IMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(59, "JTRST_B"),
+		"T19", "mt8135",
+		MTK_EINT_FUNCTION(2, 0),
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "JTRST_B"),
+		MTK_FUNCTION(2, "EINT0"),
+		MTK_FUNCTION(3, "DSP2_ICK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(60, "JTDI"),
+		"T18", "mt8135",
+		MTK_EINT_FUNCTION(2, 189),
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, "EINT189"),
+		MTK_FUNCTION(3, "DSP1_IMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(61, "JRTCK"),
+		"T20", "mt8135",
+		MTK_EINT_FUNCTION(2, 187),
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "JRTCK"),
+		MTK_FUNCTION(2, "EINT187"),
+		MTK_FUNCTION(3, "DSP1_ID")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(62, "JTMS"),
+		"T17", "mt8135",
+		MTK_EINT_FUNCTION(2, 191),
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, "EINT191"),
+		MTK_FUNCTION(3, "DSP2_ID")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(63, "MSDC1_INSI"),
+		"V18", "mt8135",
+		MTK_EINT_FUNCTION(1, 15),
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "MSDC1_INSI"),
+		MTK_FUNCTION(3, "SCL5"),
+		MTK_FUNCTION(4, "PWM6"),
+		MTK_FUNCTION(5, "CLKM5"),
+		MTK_FUNCTION(7, "TESTB_OUT6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(64, "MSDC1_SDWPI"),
+		"W18", "mt8135",
+		MTK_EINT_FUNCTION(2, 58),
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "MSDC1_SDWPI"),
+		MTK_FUNCTION(2, "EINT58"),
+		MTK_FUNCTION(3, "SDA5"),
+		MTK_FUNCTION(4, "PWM7"),
+		MTK_FUNCTION(5, "CLKM6"),
+		MTK_FUNCTION(7, "TESTB_OUT7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(65, "MSDC2_INSI"),
+		"U22", "mt8135",
+		MTK_EINT_FUNCTION(1, 14),
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "MSDC2_INSI"),
+		MTK_FUNCTION(5, "USB_TEST_IO[27]"),
+		MTK_FUNCTION(7, "TESTA_OUT3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(66, "MSDC2_SDWPI"),
+		"U21", "mt8135",
+		MTK_EINT_FUNCTION(2, 66),
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "MSDC2_SDWPI"),
+		MTK_FUNCTION(2, "EINT66"),
+		MTK_FUNCTION(5, "USB_TEST_IO[28]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(67, "URXD4"),
+		"V23", "mt8135",
+		MTK_EINT_FUNCTION(2, 89),
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "URXD4"),
+		MTK_FUNCTION(2, "EINT89"),
+		MTK_FUNCTION(3, "URXD1"),
+		MTK_FUNCTION(6, "UTXD4"),
+		MTK_FUNCTION(7, "TESTB_OUT10")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(68, "UTXD4"),
+		"V22", "mt8135",
+		MTK_EINT_FUNCTION(2, 88),
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "UTXD4"),
+		MTK_FUNCTION(2, "EINT88"),
+		MTK_FUNCTION(3, "UTXD1"),
+		MTK_FUNCTION(6, "URXD4"),
+		MTK_FUNCTION(7, "TESTB_OUT11")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(69, "URXD1"),
+		"W22", "mt8135",
+		MTK_EINT_FUNCTION(2, 79),
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "EINT79"),
+		MTK_FUNCTION(3, "URXD4"),
+		MTK_FUNCTION(6, "UTXD1"),
+		MTK_FUNCTION(7, "TESTB_OUT24")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(70, "UTXD1"),
+		"V21", "mt8135",
+		MTK_EINT_FUNCTION(2, 78),
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "EINT78"),
+		MTK_FUNCTION(3, "UTXD4"),
+		MTK_FUNCTION(6, "URXD1"),
+		MTK_FUNCTION(7, "TESTB_OUT25")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(71, "UCTS1"),
+		"V19", "mt8135",
+		MTK_EINT_FUNCTION(2, 80),
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "UCTS1"),
+		MTK_FUNCTION(2, "EINT80"),
+		MTK_FUNCTION(5, "CLKM0"),
+		MTK_FUNCTION(6, "URTS1"),
+		MTK_FUNCTION(7, "TESTB_OUT31")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(72, "URTS1"),
+		"V20", "mt8135",
+		MTK_EINT_FUNCTION(2, 81),
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "URTS1"),
+		MTK_FUNCTION(2, "EINT81"),
+		MTK_FUNCTION(5, "CLKM1"),
+		MTK_FUNCTION(6, "UCTS1"),
+		MTK_FUNCTION(7, "TESTB_OUT21")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(73, "PWM1"),
+		"W17", "mt8135",
+		MTK_EINT_FUNCTION(2, 73),
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "PWM1"),
+		MTK_FUNCTION(2, "EINT73"),
+		MTK_FUNCTION(5, "USB_DRVVBUS"),
+		MTK_FUNCTION(6, "DISP_PWM"),
+		MTK_FUNCTION(7, "TESTB_OUT8")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(74, "PWM2"),
+		"Y17", "mt8135",
+		MTK_EINT_FUNCTION(2, 74),
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "PWM2"),
+		MTK_FUNCTION(2, "EINT74"),
+		MTK_FUNCTION(3, "DPI33_CK"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "URXD2"),
+		MTK_FUNCTION(6, "DISP_PWM"),
+		MTK_FUNCTION(7, "TESTB_OUT9")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(75, "PWM3"),
+		"Y19", "mt8135",
+		MTK_EINT_FUNCTION(2, 75),
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "PWM3"),
+		MTK_FUNCTION(2, "EINT75"),
+		MTK_FUNCTION(3, "DPI33_D0"),
+		MTK_FUNCTION(4, "PWM6"),
+		MTK_FUNCTION(5, "UTXD2"),
+		MTK_FUNCTION(6, "DISP_PWM"),
+		MTK_FUNCTION(7, "TESTB_OUT12")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(76, "PWM4"),
+		"W19", "mt8135",
+		MTK_EINT_FUNCTION(2, 76),
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "PWM4"),
+		MTK_FUNCTION(2, "EINT76"),
+		MTK_FUNCTION(3, "DPI33_D1"),
+		MTK_FUNCTION(4, "PWM7"),
+		MTK_FUNCTION(6, "DISP_PWM"),
+		MTK_FUNCTION(7, "TESTB_OUT13")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(77, "MSDC2_DAT2"),
+		"W21", "mt8135",
+		MTK_EINT_FUNCTION(2, 63),
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(2, "EINT63"),
+		MTK_FUNCTION(4, "DSP2_IMS"),
+		MTK_FUNCTION(6, "DPI33_D6"),
+		MTK_FUNCTION(7, "TESTA_OUT25")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(78, "MSDC2_DAT3"),
+		"AA23", "mt8135",
+		MTK_EINT_FUNCTION(2, 64),
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(2, "EINT64"),
+		MTK_FUNCTION(4, "DSP2_ID"),
+		MTK_FUNCTION(6, "DPI33_D7"),
+		MTK_FUNCTION(7, "TESTA_OUT26")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(79, "MSDC2_CMD"),
+		"Y22", "mt8135",
+		MTK_EINT_FUNCTION(2, 60),
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(2, "EINT60"),
+		MTK_FUNCTION(4, "DSP1_IMS"),
+		MTK_FUNCTION(5, "PCM1_WS"),
+		MTK_FUNCTION(6, "DPI33_D3"),
+		MTK_FUNCTION(7, "TESTA_OUT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(80, "MSDC2_CLK"),
+		"AA22", "mt8135",
+		MTK_EINT_FUNCTION(2, 59),
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(2, "EINT59"),
+		MTK_FUNCTION(4, "DSP1_ICK"),
+		MTK_FUNCTION(5, "PCM1_CK"),
+		MTK_FUNCTION(6, "DPI33_D2"),
+		MTK_FUNCTION(7, "TESTA_OUT1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(81, "MSDC2_DAT1"),
+		"Y21", "mt8135",
+		MTK_EINT_FUNCTION(2, 62),
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(2, "EINT62"),
+		MTK_FUNCTION(4, "DSP2_ICK"),
+		MTK_FUNCTION(5, "PCM1_DO"),
+		MTK_FUNCTION(6, "DPI33_D5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(82, "MSDC2_DAT0"),
+		"AB22", "mt8135",
+		MTK_EINT_FUNCTION(2, 61),
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(2, "EINT61"),
+		MTK_FUNCTION(4, "DSP1_ID"),
+		MTK_FUNCTION(5, "PCM1_DI"),
+		MTK_FUNCTION(6, "DPI33_D4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(83, "MSDC1_DAT0"),
+		"AC19", "mt8135",
+		MTK_EINT_FUNCTION(2, 53),
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "MSDC1_DAT0"),
+		MTK_FUNCTION(2, "EINT53"),
+		MTK_FUNCTION(3, "SCL1"),
+		MTK_FUNCTION(4, "PWM2"),
+		MTK_FUNCTION(5, "CLKM1"),
+		MTK_FUNCTION(7, "TESTB_OUT2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(84, "MSDC1_DAT1"),
+		"AA19", "mt8135",
+		MTK_EINT_FUNCTION(2, 54),
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(2, "EINT54"),
+		MTK_FUNCTION(3, "SDA1"),
+		MTK_FUNCTION(4, "PWM3"),
+		MTK_FUNCTION(5, "CLKM2"),
+		MTK_FUNCTION(7, "TESTB_OUT3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(85, "MSDC1_CMD"),
+		"AA20", "mt8135",
+		MTK_EINT_FUNCTION(2, 52),
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "MSDC1_CMD"),
+		MTK_FUNCTION(2, "EINT52"),
+		MTK_FUNCTION(3, "SDA0"),
+		MTK_FUNCTION(4, "PWM1"),
+		MTK_FUNCTION(5, "CLKM0"),
+		MTK_FUNCTION(7, "TESTB_OUT1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(86, "MSDC1_CLK"),
+		"AB19", "mt8135",
+		MTK_EINT_FUNCTION(2, 51),
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(2, "EINT51"),
+		MTK_FUNCTION(3, "SCL0"),
+		MTK_FUNCTION(4, "DISP_PWM"),
+		MTK_FUNCTION(7, "TESTB_OUT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(87, "MSDC1_DAT2"),
+		"AA21", "mt8135",
+		MTK_EINT_FUNCTION(2, 55),
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(2, "EINT55"),
+		MTK_FUNCTION(3, "SCL4"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "CLKM3"),
+		MTK_FUNCTION(7, "TESTB_OUT4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(88, "MSDC1_DAT3"),
+		"AB20", "mt8135",
+		MTK_EINT_FUNCTION(2, 56),
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(2, "EINT56"),
+		MTK_FUNCTION(3, "SDA4"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "CLKM4"),
+		MTK_FUNCTION(7, "TESTB_OUT5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(89, "MSDC4_DAT0"),
+		"AB8", "mt8135",
+		MTK_EINT_FUNCTION(2, 133),
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "MSDC4_DAT0"),
+		MTK_FUNCTION(2, "EINT133"),
+		MTK_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(5, "USB_DRVVBUS"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[9]"),
+		MTK_FUNCTION(7, "LPTE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(90, "MSDC4_DAT1"),
+		"AB7", "mt8135",
+		MTK_EINT_FUNCTION(2, 134),
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "MSDC4_DAT1"),
+		MTK_FUNCTION(2, "EINT134"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[10]"),
+		MTK_FUNCTION(7, "LRSTB_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(91, "MSDC4_DAT5"),
+		"AA8", "mt8135",
+		MTK_EINT_FUNCTION(2, 136),
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "MSDC4_DAT5"),
+		MTK_FUNCTION(2, "EINT136"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "DAC_WS"),
+		MTK_FUNCTION(5, "PCM1_WS"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[11]"),
+		MTK_FUNCTION(7, "SPI1_CSN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(92, "MSDC4_DAT6"),
+		"AC4", "mt8135",
+		MTK_EINT_FUNCTION(2, 137),
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "MSDC4_DAT6"),
+		MTK_FUNCTION(2, "EINT137"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "DAC_DAT_OUT"),
+		MTK_FUNCTION(5, "PCM1_DO"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[12]"),
+		MTK_FUNCTION(7, "SPI1_MO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(93, "MSDC4_DAT7"),
+		"AC6", "mt8135",
+		MTK_EINT_FUNCTION(2, 138),
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "MSDC4_DAT7"),
+		MTK_FUNCTION(2, "EINT138"),
+		MTK_FUNCTION(3, "I2SIN_DAT"),
+		MTK_FUNCTION(5, "PCM1_DI"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[13]"),
+		MTK_FUNCTION(7, "SPI1_MI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(94, "MSDC4_DAT4"),
+		"AA7", "mt8135",
+		MTK_EINT_FUNCTION(2, 135),
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(1, "MSDC4_DAT4"),
+		MTK_FUNCTION(2, "EINT135"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "DAC_CK"),
+		MTK_FUNCTION(5, "PCM1_CK"),
+		MTK_FUNCTION(6, "A_FUNC_DIN[14]"),
+		MTK_FUNCTION(7, "SPI1_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(95, "MSDC4_DAT2"),
+		"AB6", "mt8135",
+		MTK_EINT_FUNCTION(2, 131),
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "MSDC4_DAT2"),
+		MTK_FUNCTION(2, "EINT131"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "CM2PDN_2X"),
+		MTK_FUNCTION(5, "DAC_WS"),
+		MTK_FUNCTION(6, "PCM1_WS"),
+		MTK_FUNCTION(7, "LSCE0B_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(96, "MSDC4_CLK"),
+		"AB5", "mt8135",
+		MTK_EINT_FUNCTION(2, 129),
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(1, "MSDC4_CLK"),
+		MTK_FUNCTION(2, "EINT129"),
+		MTK_FUNCTION(3, "DPI1_CK_2X"),
+		MTK_FUNCTION(4, "CM2PCLK_2X"),
+		MTK_FUNCTION(5, "PWM4"),
+		MTK_FUNCTION(6, "PCM1_DI"),
+		MTK_FUNCTION(7, "LSCK_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(97, "MSDC4_DAT3"),
+		"Y8", "mt8135",
+		MTK_EINT_FUNCTION(2, 132),
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "MSDC4_DAT3"),
+		MTK_FUNCTION(2, "EINT132"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "CM2RST_2X"),
+		MTK_FUNCTION(5, "DAC_DAT_OUT"),
+		MTK_FUNCTION(6, "PCM1_DO"),
+		MTK_FUNCTION(7, "LSCE1B_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(98, "MSDC4_CMD"),
+		"AC3", "mt8135",
+		MTK_EINT_FUNCTION(2, 128),
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "MSDC4_CMD"),
+		MTK_FUNCTION(2, "EINT128"),
+		MTK_FUNCTION(3, "DPI1_DE_2X"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(7, "LSDA_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(99, "MSDC4_RSTB"),
+		"AB4", "mt8135",
+		MTK_EINT_FUNCTION(2, 130),
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "MSDC4_RSTB"),
+		MTK_FUNCTION(2, "EINT130"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "CM2MCLK_2X"),
+		MTK_FUNCTION(5, "DAC_CK"),
+		MTK_FUNCTION(6, "PCM1_CK"),
+		MTK_FUNCTION(7, "LSA0_1X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(100, "SDA0"),
+		"W9", "mt8135",
+		MTK_EINT_FUNCTION(2, 91),
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "SDA0"),
+		MTK_FUNCTION(2, "EINT91"),
+		MTK_FUNCTION(3, "CLKM1"),
+		MTK_FUNCTION(4, "PWM1"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[15]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(101, "SCL0"),
+		"W11", "mt8135",
+		MTK_EINT_FUNCTION(2, 90),
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "SCL0"),
+		MTK_FUNCTION(2, "EINT90"),
+		MTK_FUNCTION(3, "CLKM0"),
+		MTK_FUNCTION(4, "DISP_PWM"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[16]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(102, "EINT10_AUXIN2"),
+		"AA3", "mt8135",
+		MTK_EINT_FUNCTION(1, 10),
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "EINT10"),
+		MTK_FUNCTION(5, "USB_TEST_IO[16]"),
+		MTK_FUNCTION(6, "TESTB_OUT16"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[17]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(103, "EINT11_AUXIN3"),
+		"AB2", "mt8135",
+		MTK_EINT_FUNCTION(1, 11),
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "EINT11"),
+		MTK_FUNCTION(5, "USB_TEST_IO[17]"),
+		MTK_FUNCTION(6, "TESTB_OUT17"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[18]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(104, "EINT16_AUXIN4"),
+		"AB3", "mt8135",
+		MTK_EINT_FUNCTION(1, 16),
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "EINT16"),
+		MTK_FUNCTION(5, "USB_TEST_IO[18]"),
+		MTK_FUNCTION(6, "TESTB_OUT18"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[19]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(105, "I2S_CLK"),
+		"W6", "mt8135",
+		MTK_EINT_FUNCTION(2, 10),
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "I2SIN_CK"),
+		MTK_FUNCTION(2, "EINT10"),
+		MTK_FUNCTION(3, "DAC_CK"),
+		MTK_FUNCTION(4, "PCM1_CK"),
+		MTK_FUNCTION(5, "USB_TEST_IO[19]"),
+		MTK_FUNCTION(6, "TESTB_OUT19"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[20]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(106, "I2S_WS"),
+		"AA6", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "I2SIN_WS"),
+		MTK_FUNCTION(3, "DAC_WS"),
+		MTK_FUNCTION(4, "PCM1_WS"),
+		MTK_FUNCTION(5, "USB_TEST_IO[20]"),
+		MTK_FUNCTION(6, "TESTB_OUT20"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[21]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(107, "I2S_DATA_IN"),
+		"AA5", "mt8135",
+		MTK_EINT_FUNCTION(2, 11),
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "I2SIN_DAT"),
+		MTK_FUNCTION(2, "EINT11"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "USB_TEST_IO[21]"),
+		MTK_FUNCTION(6, "TESTB_OUT22"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[22]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(108, "I2S_DATA_OUT"),
+		"AA4", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "I2SOUT_DAT"),
+		MTK_FUNCTION(3, "DAC_DAT_OUT"),
+		MTK_FUNCTION(4, "PCM1_DO"),
+		MTK_FUNCTION(5, "USB_TEST_IO[22]"),
+		MTK_FUNCTION(6, "TESTB_OUT23"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[23]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(109, "EINT5"),
+		"W5", "mt8135",
+		MTK_EINT_FUNCTION(1, 5),
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(1, "EINT5"),
+		MTK_FUNCTION(2, "PWM5"),
+		MTK_FUNCTION(3, "CLKM3"),
+		MTK_FUNCTION(4, "GPU_JTRSTB"),
+		MTK_FUNCTION(5, "USB_TEST_IO[23]"),
+		MTK_FUNCTION(6, "TESTB_OUT26"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[24]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(110, "EINT6"),
+		"V5", "mt8135",
+		MTK_EINT_FUNCTION(1, 6),
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "EINT6"),
+		MTK_FUNCTION(2, "PWM6"),
+		MTK_FUNCTION(3, "CLKM4"),
+		MTK_FUNCTION(4, "GPU_JTMS"),
+		MTK_FUNCTION(5, "USB_TEST_IO[24]"),
+		MTK_FUNCTION(6, "TESTB_OUT27"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[25]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(111, "EINT7"),
+		"W3", "mt8135",
+		MTK_EINT_FUNCTION(1, 7),
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "EINT7"),
+		MTK_FUNCTION(2, "PWM7"),
+		MTK_FUNCTION(3, "CLKM5"),
+		MTK_FUNCTION(4, "GPU_JTDO"),
+		MTK_FUNCTION(5, "USB_TEST_IO[25]"),
+		MTK_FUNCTION(6, "TESTB_OUT28"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[26]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(112, "EINT8"),
+		"V6", "mt8135",
+		MTK_EINT_FUNCTION(1, 8),
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "EINT8"),
+		MTK_FUNCTION(2, "DISP_PWM"),
+		MTK_FUNCTION(3, "CLKM6"),
+		MTK_FUNCTION(4, "GPU_JTDI"),
+		MTK_FUNCTION(5, "USB_TEST_IO[26]"),
+		MTK_FUNCTION(6, "TESTB_OUT29"),
+		MTK_FUNCTION(7, "EXT_FRAME_SYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(113, "EINT9"),
+		"W8", "mt8135",
+		MTK_EINT_FUNCTION(1, 9),
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "EINT9"),
+		MTK_FUNCTION(4, "GPU_JTCK"),
+		MTK_FUNCTION(5, "USB_DRVVBUS"),
+		MTK_FUNCTION(6, "TESTB_OUT30"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[27]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(114, "LPCE1B"),
+		"W4", "mt8135",
+		MTK_EINT_FUNCTION(2, 127),
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "LPCE1B"),
+		MTK_FUNCTION(2, "EINT127"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(6, "TESTB_OUT14"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[28]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(115, "LPCE0B"),
+		"T5", "mt8135",
+		MTK_EINT_FUNCTION(2, 126),
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "LPCE0B"),
+		MTK_FUNCTION(2, "EINT126"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(6, "TESTB_OUT15"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[29]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(116, "DISP_PWM"),
+		"V4", "mt8135",
+		MTK_EINT_FUNCTION(2, 77),
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "DISP_PWM"),
+		MTK_FUNCTION(2, "EINT77"),
+		MTK_FUNCTION(3, "LSDI"),
+		MTK_FUNCTION(4, "PWM1"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(7, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(117, "EINT1"),
+		"T6", "mt8135",
+		MTK_EINT_FUNCTION(1, 1),
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "EINT1"),
+		MTK_FUNCTION(2, "PWM2"),
+		MTK_FUNCTION(3, "CLKM1"),
+		MTK_FUNCTION(5, "USB_TEST_IO[13]"),
+		MTK_FUNCTION(7, "USB_SDA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(118, "EINT2"),
+		"T4", "mt8135",
+		MTK_EINT_FUNCTION(1, 2),
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "EINT2"),
+		MTK_FUNCTION(2, "PWM3"),
+		MTK_FUNCTION(3, "CLKM2"),
+		MTK_FUNCTION(5, "USB_TEST_IO[14]"),
+		MTK_FUNCTION(6, "SRCLKENAI2"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[30]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(119, "EINT3"),
+		"R4", "mt8135",
+		MTK_EINT_FUNCTION(1, 3),
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "EINT3"),
+		MTK_FUNCTION(5, "USB_TEST_IO[15]"),
+		MTK_FUNCTION(6, "SRCLKENAI1"),
+		MTK_FUNCTION(7, "EXT_26M_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(120, "EINT4"),
+		"R5", "mt8135",
+		MTK_EINT_FUNCTION(1, 4),
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "EINT4"),
+		MTK_FUNCTION(2, "PWM4"),
+		MTK_FUNCTION(5, "USB_DRVVBUS"),
+		MTK_FUNCTION(7, "A_FUNC_DIN[31]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(121, "DPIDE"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 100),
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "DPI0_DE"),
+		MTK_FUNCTION(2, "EINT100"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "DAC_DAT_OUT"),
+		MTK_FUNCTION(5, "PCM1_DO"),
+		MTK_FUNCTION(6, "IRDA_TXD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(122, "DPICK"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 101),
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "DPI0_CK"),
+		MTK_FUNCTION(2, "EINT101"),
+		MTK_FUNCTION(3, "I2SIN_DAT"),
+		MTK_FUNCTION(5, "PCM1_DI"),
+		MTK_FUNCTION(6, "IRDA_PDN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(123, "DPIG4"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 114),
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "DPI0_G4"),
+		MTK_FUNCTION(2, "EINT114"),
+		MTK_FUNCTION(4, "CM2DAT_2X[0]"),
+		MTK_FUNCTION(5, "DSP2_ID")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(124, "DPIG5"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 115),
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "DPI0_G5"),
+		MTK_FUNCTION(2, "EINT115"),
+		MTK_FUNCTION(4, "CM2DAT_2X[1]"),
+		MTK_FUNCTION(5, "DSP2_ICK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(125, "DPIR3"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 121),
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "DPI0_R3"),
+		MTK_FUNCTION(2, "EINT121"),
+		MTK_FUNCTION(4, "CM2DAT_2X[7]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(126, "DPIG1"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 111),
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "DPI0_G1"),
+		MTK_FUNCTION(2, "EINT111"),
+		MTK_FUNCTION(5, "DSP1_ICK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(127, "DPIVSYNC"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 98),
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "DPI0_VSYNC"),
+		MTK_FUNCTION(2, "EINT98"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "DAC_CK"),
+		MTK_FUNCTION(5, "PCM1_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(128, "DPIHSYNC"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 99),
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "DPI0_HSYNC"),
+		MTK_FUNCTION(2, "EINT99"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "DAC_WS"),
+		MTK_FUNCTION(5, "PCM1_WS"),
+		MTK_FUNCTION(6, "IRDA_RXD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(129, "DPIB0"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 102),
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "DPI0_B0"),
+		MTK_FUNCTION(2, "EINT102"),
+		MTK_FUNCTION(4, "SCL0"),
+		MTK_FUNCTION(5, "DISP_PWM")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(130, "DPIB1"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 103),
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "DPI0_B1"),
+		MTK_FUNCTION(2, "EINT103"),
+		MTK_FUNCTION(3, "CLKM0"),
+		MTK_FUNCTION(4, "SDA0"),
+		MTK_FUNCTION(5, "PWM1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(131, "DPIB2"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 104),
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "DPI0_B2"),
+		MTK_FUNCTION(2, "EINT104"),
+		MTK_FUNCTION(3, "CLKM1"),
+		MTK_FUNCTION(4, "SCL1"),
+		MTK_FUNCTION(5, "PWM2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(132, "DPIB3"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 105),
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "DPI0_B3"),
+		MTK_FUNCTION(2, "EINT105"),
+		MTK_FUNCTION(3, "CLKM2"),
+		MTK_FUNCTION(4, "SDA1"),
+		MTK_FUNCTION(5, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(133, "DPIB4"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 106),
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "DPI0_B4"),
+		MTK_FUNCTION(2, "EINT106"),
+		MTK_FUNCTION(3, "CLKM3"),
+		MTK_FUNCTION(4, "SCL2"),
+		MTK_FUNCTION(5, "PWM4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(134, "DPIB5"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 107),
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "DPI0_B5"),
+		MTK_FUNCTION(2, "EINT107"),
+		MTK_FUNCTION(3, "CLKM4"),
+		MTK_FUNCTION(4, "SDA2"),
+		MTK_FUNCTION(5, "PWM5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(135, "DPIB6"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 108),
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "DPI0_B6"),
+		MTK_FUNCTION(2, "EINT108"),
+		MTK_FUNCTION(3, "CLKM5"),
+		MTK_FUNCTION(4, "SCL3"),
+		MTK_FUNCTION(5, "PWM6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(136, "DPIB7"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 109),
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "DPI0_B7"),
+		MTK_FUNCTION(2, "EINT109"),
+		MTK_FUNCTION(3, "CLKM6"),
+		MTK_FUNCTION(4, "SDA3"),
+		MTK_FUNCTION(5, "PWM7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(137, "DPIG0"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 110),
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "DPI0_G0"),
+		MTK_FUNCTION(2, "EINT110"),
+		MTK_FUNCTION(5, "DSP1_ID")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(138, "DPIG2"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 112),
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "DPI0_G2"),
+		MTK_FUNCTION(2, "EINT112"),
+		MTK_FUNCTION(5, "DSP1_IMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(139, "DPIG3"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 113),
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "DPI0_G3"),
+		MTK_FUNCTION(2, "EINT113"),
+		MTK_FUNCTION(5, "DSP2_IMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(140, "DPIG6"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 116),
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(1, "DPI0_G6"),
+		MTK_FUNCTION(2, "EINT116"),
+		MTK_FUNCTION(4, "CM2DAT_2X[2]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(141, "DPIG7"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 117),
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "DPI0_G7"),
+		MTK_FUNCTION(2, "EINT117"),
+		MTK_FUNCTION(4, "CM2DAT_2X[3]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(142, "DPIR0"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 118),
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "DPI0_R0"),
+		MTK_FUNCTION(2, "EINT118"),
+		MTK_FUNCTION(4, "CM2DAT_2X[4]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(143, "DPIR1"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 119),
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "DPI0_R1"),
+		MTK_FUNCTION(2, "EINT119"),
+		MTK_FUNCTION(4, "CM2DAT_2X[5]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(144, "DPIR2"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 120),
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "DPI0_R2"),
+		MTK_FUNCTION(2, "EINT120"),
+		MTK_FUNCTION(4, "CM2DAT_2X[6]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(145, "DPIR4"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 122),
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "DPI0_R4"),
+		MTK_FUNCTION(2, "EINT122"),
+		MTK_FUNCTION(4, "CM2DAT_2X[8]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(146, "DPIR5"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 123),
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "DPI0_R5"),
+		MTK_FUNCTION(2, "EINT123"),
+		MTK_FUNCTION(4, "CM2DAT_2X[9]")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(147, "DPIR6"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 124),
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "DPI0_R6"),
+		MTK_FUNCTION(2, "EINT124"),
+		MTK_FUNCTION(4, "CM2VSYNC_2X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(148, "DPIR7"),
+		NULL, "mt8135",
+		MTK_EINT_FUNCTION(2, 125),
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "DPI0_R7"),
+		MTK_FUNCTION(2, "EINT125"),
+		MTK_FUNCTION(4, "CM2HSYNC_2X")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(149, "TDN3/LVDS(TDN3)"),
+		"AA2", "mt8135",
+		MTK_EINT_FUNCTION(2, 36),
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(2, "EINT36")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(150, "TDP3/LVDS(TDP3)"),
+		"AA1", "mt8135",
+		MTK_EINT_FUNCTION(2, 35),
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(2, "EINT35")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(151, "TDN2/LVDS(TCN)"),
+		"Y2", "mt8135",
+		MTK_EINT_FUNCTION(2, 169),
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(2, "EINT169")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(152, "TDP2/LVDS(TCP)"),
+		"Y1", "mt8135",
+		MTK_EINT_FUNCTION(2, 168),
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(2, "EINT168")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(153, "TCN/LVDS(TDN2)"),
+		"W2", "mt8135",
+		MTK_EINT_FUNCTION(2, 163),
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(2, "EINT163")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(154, "TCP/LVDS(TDP2)"),
+		"W1", "mt8135",
+		MTK_EINT_FUNCTION(2, 162),
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(2, "EINT162")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(155, "TDN1/LVDS(TDN1)"),
+		"V3", "mt8135",
+		MTK_EINT_FUNCTION(2, 167),
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(2, "EINT167")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(156, "TDP1/LVDS(TDP1)"),
+		"V2", "mt8135",
+		MTK_EINT_FUNCTION(2, 166),
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(2, "EINT166")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(157, "TDN0/LVDS(TDN0)"),
+		"U3", "mt8135",
+		MTK_EINT_FUNCTION(2, 165),
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(2, "EINT165")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(158, "TDP0/LVDS(TDP0)"),
+		"U2", "mt8135",
+		MTK_EINT_FUNCTION(2, 164),
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(2, "EINT164")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(159, "RDN3"),
+		"N5", "mt8135",
+		MTK_EINT_FUNCTION(2, 18),
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(2, "EINT18")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(160, "RDP3"),
+		"N4", "mt8135",
+		MTK_EINT_FUNCTION(2, 30),
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(2, "EINT30")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(161, "RDN2"),
+		"T2", "mt8135",
+		MTK_EINT_FUNCTION(2, 31),
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(2, "EINT31")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(162, "RDP2"),
+		"T3", "mt8135",
+		MTK_EINT_FUNCTION(2, 32),
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(2, "EINT32")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(163, "RCN"),
+		"P2", "mt8135",
+		MTK_EINT_FUNCTION(2, 33),
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(2, "EINT33")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(164, "RCP"),
+		"P3", "mt8135",
+		MTK_EINT_FUNCTION(2, 39),
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(2, "EINT39")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(165, "RDN1"),
+		"R3", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO165")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(166, "RDP1"),
+		"R2", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO166")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(167, "RDN0"),
+		"N3", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO167")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(168, "RDP0"),
+		"N2", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO168")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(169, "RDN1_A"),
+		"M4", "mt8135",
+		MTK_EINT_FUNCTION(2, 175),
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "CMDAT6"),
+		MTK_FUNCTION(2, "EINT175")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(170, "RDP1_A"),
+		"M3", "mt8135",
+		MTK_EINT_FUNCTION(2, 174),
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "CMDAT7"),
+		MTK_FUNCTION(2, "EINT174")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(171, "RCN_A"),
+		"L3", "mt8135",
+		MTK_EINT_FUNCTION(2, 171),
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "CMDAT8"),
+		MTK_FUNCTION(2, "EINT171")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(172, "RCP_A"),
+		"L2", "mt8135",
+		MTK_EINT_FUNCTION(2, 170),
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "CMDAT9"),
+		MTK_FUNCTION(2, "EINT170")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(173, "RDN0_A"),
+		"M2", "mt8135",
+		MTK_EINT_FUNCTION(2, 173),
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "CMHSYNC"),
+		MTK_FUNCTION(2, "EINT173")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(174, "RDP0_A"),
+		"M1", "mt8135",
+		MTK_EINT_FUNCTION(2, 172),
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "CMVSYNC"),
+		MTK_FUNCTION(2, "EINT172")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(175, "RDN1_B"),
+		"H2", "mt8135",
+		MTK_EINT_FUNCTION(2, 181),
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "CMDAT2"),
+		MTK_FUNCTION(2, "EINT181"),
+		MTK_FUNCTION(3, "CMCSD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(176, "RDP1_B"),
+		"H1", "mt8135",
+		MTK_EINT_FUNCTION(2, 180),
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "CMDAT3"),
+		MTK_FUNCTION(2, "EINT180"),
+		MTK_FUNCTION(3, "CMCSD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(177, "RCN_B"),
+		"K3", "mt8135",
+		MTK_EINT_FUNCTION(2, 177),
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "CMDAT4"),
+		MTK_FUNCTION(2, "EINT177")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(178, "RCP_B"),
+		"K2", "mt8135",
+		MTK_EINT_FUNCTION(2, 176),
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "CMDAT5"),
+		MTK_FUNCTION(2, "EINT176")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(179, "RDN0_B"),
+		"J3", "mt8135",
+		MTK_EINT_FUNCTION(2, 179),
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "CMDAT0"),
+		MTK_FUNCTION(2, "EINT179"),
+		MTK_FUNCTION(3, "CMCSD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(180, "RDP0_B"),
+		"J2", "mt8135",
+		MTK_EINT_FUNCTION(2, 178),
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "CMDAT1"),
+		MTK_FUNCTION(2, "EINT178"),
+		MTK_FUNCTION(3, "CMCSD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(181, "CMPCLK"),
+		"K4", "mt8135",
+		MTK_EINT_FUNCTION(2, 182),
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "CMPCLK"),
+		MTK_FUNCTION(2, "EINT182"),
+		MTK_FUNCTION(3, "CMCSK"),
+		MTK_FUNCTION(4, "CM2MCLK_4X"),
+		MTK_FUNCTION(5, "TS_AUXADC_SEL[3]"),
+		MTK_FUNCTION(6, "VENC_TEST_CK"),
+		MTK_FUNCTION(7, "TESTA_OUT27")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(182, "CMMCLK"),
+		"J5", "mt8135",
+		MTK_EINT_FUNCTION(2, 183),
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "CMMCLK"),
+		MTK_FUNCTION(2, "EINT183"),
+		MTK_FUNCTION(5, "TS_AUXADC_SEL[2]"),
+		MTK_FUNCTION(7, "TESTA_OUT28")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(183, "CMRST"),
+		"J6", "mt8135",
+		MTK_EINT_FUNCTION(2, 185),
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "CMRST"),
+		MTK_FUNCTION(2, "EINT185"),
+		MTK_FUNCTION(5, "TS_AUXADC_SEL[1]"),
+		MTK_FUNCTION(7, "TESTA_OUT30")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(184, "CMPDN"),
+		"J4", "mt8135",
+		MTK_EINT_FUNCTION(2, 184),
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "CMPDN"),
+		MTK_FUNCTION(2, "EINT184"),
+		MTK_FUNCTION(5, "TS_AUXADC_SEL[0]"),
+		MTK_FUNCTION(7, "TESTA_OUT29")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(185, "CMFLASH"),
+		"G4", "mt8135",
+		MTK_EINT_FUNCTION(2, 186),
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "CMFLASH"),
+		MTK_FUNCTION(2, "EINT186"),
+		MTK_FUNCTION(3, "CM2MCLK_3X"),
+		MTK_FUNCTION(6, "MFG_TEST_CK_1"),
+		MTK_FUNCTION(7, "TESTA_OUT31")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(186, "MRG_I2S_PCM_CLK"),
+		"F5", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "MRG_I2S_PCM_CLK"),
+		MTK_FUNCTION(3, "I2SIN_CK"),
+		MTK_FUNCTION(4, "PCM0_CK"),
+		MTK_FUNCTION(5, "DSP2_ICK"),
+		MTK_FUNCTION(6, "IMG_TEST_CK"),
+		MTK_FUNCTION(7, "USB_SCL")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(187, "MRG_I2S_PCM_SYNC"),
+		"G6", "mt8135",
+		MTK_EINT_FUNCTION(2, 16),
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "MRG_I2S_PCM_SYNC"),
+		MTK_FUNCTION(2, "EINT16"),
+		MTK_FUNCTION(3, "I2SIN_WS"),
+		MTK_FUNCTION(4, "PCM0_WS"),
+		MTK_FUNCTION(6, "DISP_TEST_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(188, "MRG_I2S_PCM_RX"),
+		"G3", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "MRG_I2S_PCM_RX"),
+		MTK_FUNCTION(3, "I2SIN_DAT"),
+		MTK_FUNCTION(4, "PCM0_DI"),
+		MTK_FUNCTION(5, "DSP2_ID"),
+		MTK_FUNCTION(6, "MFG_TEST_CK"),
+		MTK_FUNCTION(7, "USB_SDA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(189, "MRG_I2S_PCM_TX"),
+		"G5", "mt8135",
+		MTK_EINT_FUNCTION(2, 17),
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(1, "MRG_I2S_PCM_TX"),
+		MTK_FUNCTION(2, "EINT17"),
+		MTK_FUNCTION(3, "I2SOUT_DAT"),
+		MTK_FUNCTION(4, "PCM0_DO"),
+		MTK_FUNCTION(6, "VDEC_TEST_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(190, "SRCLKENAI"),
+		"K5", "mt8135",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "SRCLKENAI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(191, "URXD3"),
+		"C3", "mt8135",
+		MTK_EINT_FUNCTION(2, 87),
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "EINT87"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(5, "TS_AUX_ST"),
+		MTK_FUNCTION(6, "PWM4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(192, "UTXD3"),
+		"B2", "mt8135",
+		MTK_EINT_FUNCTION(2, 86),
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "EINT86"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(5, "TS_AUX_CS_B"),
+		MTK_FUNCTION(6, "PWM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(193, "SDA2"),
+		"G2", "mt8135",
+		MTK_EINT_FUNCTION(2, 95),
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "SDA2"),
+		MTK_FUNCTION(2, "EINT95"),
+		MTK_FUNCTION(3, "CLKM5"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "TS_AUX_PWDB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(194, "SCL2"),
+		"F4", "mt8135",
+		MTK_EINT_FUNCTION(2, 94),
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "SCL2"),
+		MTK_FUNCTION(2, "EINT94"),
+		MTK_FUNCTION(3, "CLKM4"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "TS_AUXADC_TEST_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(195, "SDA1"),
+		"F2", "mt8135",
+		MTK_EINT_FUNCTION(2, 93),
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "SDA1"),
+		MTK_FUNCTION(2, "EINT93"),
+		MTK_FUNCTION(3, "CLKM3"),
+		MTK_FUNCTION(4, "PWM3"),
+		MTK_FUNCTION(5, "TS_AUX_SCLK_PWDB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(196, "SCL1"),
+		"F3", "mt8135",
+		MTK_EINT_FUNCTION(2, 92),
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "SCL1"),
+		MTK_FUNCTION(2, "EINT92"),
+		MTK_FUNCTION(3, "CLKM2"),
+		MTK_FUNCTION(4, "PWM2"),
+		MTK_FUNCTION(5, "TS_AUX_DIN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(197, "MSDC3_DAT2"),
+		"E1", "mt8135",
+		MTK_EINT_FUNCTION(2, 71),
+		MTK_FUNCTION(0, "GPIO197"),
+		MTK_FUNCTION(1, "MSDC3_DAT2"),
+		MTK_FUNCTION(2, "EINT71"),
+		MTK_FUNCTION(3, "SCL6"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "CLKM4"),
+		MTK_FUNCTION(6, "MFG_TEST_CK_2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(198, "MSDC3_DAT3"),
+		"C2", "mt8135",
+		MTK_EINT_FUNCTION(2, 72),
+		MTK_FUNCTION(0, "GPIO198"),
+		MTK_FUNCTION(1, "MSDC3_DAT3"),
+		MTK_FUNCTION(2, "EINT72"),
+		MTK_FUNCTION(3, "SDA6"),
+		MTK_FUNCTION(4, "PWM6"),
+		MTK_FUNCTION(5, "CLKM5"),
+		MTK_FUNCTION(6, "MFG_TEST_CK_3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(199, "MSDC3_CMD"),
+		"D2", "mt8135",
+		MTK_EINT_FUNCTION(2, 68),
+		MTK_FUNCTION(0, "GPIO199"),
+		MTK_FUNCTION(1, "MSDC3_CMD"),
+		MTK_FUNCTION(2, "EINT68"),
+		MTK_FUNCTION(3, "SDA2"),
+		MTK_FUNCTION(4, "PWM2"),
+		MTK_FUNCTION(5, "CLKM1"),
+		MTK_FUNCTION(6, "MFG_TEST_CK_4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(200, "MSDC3_CLK"),
+		"E2", "mt8135",
+		MTK_EINT_FUNCTION(2, 67),
+		MTK_FUNCTION(0, "GPIO200"),
+		MTK_FUNCTION(1, "MSDC3_CLK"),
+		MTK_FUNCTION(2, "EINT67"),
+		MTK_FUNCTION(3, "SCL2"),
+		MTK_FUNCTION(4, "PWM1"),
+		MTK_FUNCTION(5, "CLKM0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(201, "MSDC3_DAT1"),
+		"D3", "mt8135",
+		MTK_EINT_FUNCTION(2, 70),
+		MTK_FUNCTION(0, "GPIO201"),
+		MTK_FUNCTION(1, "MSDC3_DAT1"),
+		MTK_FUNCTION(2, "EINT70"),
+		MTK_FUNCTION(3, "SDA3"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "CLKM3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(202, "MSDC3_DAT0"),
+		"E3", "mt8135",
+		MTK_EINT_FUNCTION(2, 69),
+		MTK_FUNCTION(0, "GPIO202"),
+		MTK_FUNCTION(1, "MSDC3_DAT0"),
+		MTK_FUNCTION(2, "EINT69"),
+		MTK_FUNCTION(3, "SCL3"),
+		MTK_FUNCTION(4, "PWM3"),
+		MTK_FUNCTION(5, "CLKM2")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT8135_H */
diff --git a/include/dt-bindings/pinctrl/mt65xx.h b/include/dt-bindings/pinctrl/mt65xx.h
new file mode 100644
index 0000000..1198f45
--- /dev/null
+++ b/include/dt-bindings/pinctrl/mt65xx.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_MT65XX_H
+#define _DT_BINDINGS_PINCTRL_MT65XX_H
+
+#define MTK_PIN_NO(x) ((x) << 8)
+#define MTK_GET_PIN_NO(x) ((x) >> 8)
+#define MTK_GET_PIN_FUNC(x) ((x) & 0xf)
+
+#define MTK_PUPD_SET_R1R0_00 100
+#define MTK_PUPD_SET_R1R0_01 101
+#define MTK_PUPD_SET_R1R0_10 102
+#define MTK_PUPD_SET_R1R0_11 103
+
+#define MTK_DRIVE_2mA  2
+#define MTK_DRIVE_4mA  4
+#define MTK_DRIVE_6mA  6
+#define MTK_DRIVE_8mA  8
+#define MTK_DRIVE_10mA 10
+#define MTK_DRIVE_12mA 12
+#define MTK_DRIVE_14mA 14
+#define MTK_DRIVE_16mA 16
+#define MTK_DRIVE_20mA 20
+#define MTK_DRIVE_24mA 24
+#define MTK_DRIVE_28mA 28
+#define MTK_DRIVE_32mA 32
+
+#endif /* _DT_BINDINGS_PINCTRL_MT65XX_H */
-- 
1.8.1.1.dirty
