From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 27 Jan 2015 15:13:55 +0800
Subject: [PATCH 2/3] arm64: mediatek: Add Pinctrl/GPIO/EINT driver for mt8173.
In-Reply-To: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1422342836-27689-3-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongzhou Yang <hongzhou.yang@mediatek.com>

Add mt8173 support using mediatek common pinctrl driver.
MT8173 have a different ies_smt setting register than mt8135,
so adding this support to common code.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  452 +++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   14 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    7 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h | 1226 +++++++++++++++++++++++++
 6 files changed, 1704 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8173.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 70bbf39..49b8649 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -11,4 +11,8 @@ config PINCTRL_MT8135
 	def_bool MACH_MT8135
 	select PINCTRL_MTK_COMMON
 
+config PINCTRL_MT8173
+	def_bool MACH_MT8173
+	select PINCTRL_MTK_COMMON
+
 endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 8157dad..d8606a2 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_PINCTRL_MTK_COMMON)	+= pinctrl-mtk-common.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_MT8135)		+= pinctrl-mt8135.o
+obj-$(CONFIG_PINCTRL_MT8173)		+= pinctrl-mt8173.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
new file mode 100644
index 0000000..66b01bb
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -0,0 +1,452 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
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
+#include "pinctrl-mtk-mt8173.h"
+
+#define DRV_BASE				0xb00
+
+/**
+ * struct mtk_pin_ies_smt_set - For special pins' ies and smt setting.
+ * @start: The start pin number of those special pins.
+ * @end: The end pin number of those special pins.
+ * @offset: The offset of special setting register.
+ * @bit: The bit of special setting register.
+ */
+struct mtk_pin_ies_smt_set {
+	unsigned int start;
+	unsigned int end;
+	unsigned int offset;
+	unsigned char bit;
+};
+
+#define MTK_PIN_IES_SMT_SET(_start, _end, _offset, _bit)	\
+	{	\
+		.start = _start,	\
+		.end = _end,	\
+		.bit = _bit,	\
+		.offset = _offset,	\
+	}
+
+/**
+ * struct mtk_pin_spec_pupd_set - For special pins' pull up/down setting.
+ * @pin: The pin number.
+ * @offset: The offset of special pull up/down setting register.
+ * @pupd_bit: The pull up/down bit in this register.
+ * @r0_bit: The r0 bit of pull resistor.
+ * @r1_bit: The r1 bit of pull resistor.
+ */
+struct mtk_pin_spec_pupd_set {
+	unsigned int pin;
+	unsigned int offset;
+	unsigned char pupd_bit;
+	unsigned char r1_bit;
+	unsigned char r0_bit;
+};
+
+#define MTK_PIN_PUPD_SPEC(_pin, _offset, _pupd, _r1, _r0)	\
+	{	\
+		.pin = _pin,	\
+		.offset = _offset,	\
+		.pupd_bit = _pupd,	\
+		.r1_bit = _r1,		\
+		.r0_bit = _r0,		\
+	}
+
+static const struct mtk_pin_spec_pupd_set mt8173_spec_pupd[] = {
+	MTK_PIN_PUPD_SPEC(119, 0xe00, 2, 1, 0),  /* KROW0 */
+	MTK_PIN_PUPD_SPEC(120, 0xe00, 6, 5, 4),  /* KROW1 */
+	MTK_PIN_PUPD_SPEC(121, 0xe00, 10, 9, 8), /* KROW2 */
+	MTK_PIN_PUPD_SPEC(122, 0xe10, 2, 1, 0),  /* KCOL0 */
+	MTK_PIN_PUPD_SPEC(123, 0xe10, 6, 5, 4),  /* KCOL1 */
+	MTK_PIN_PUPD_SPEC(124, 0xe10, 10, 9, 8), /* KCOL2 */
+
+	MTK_PIN_PUPD_SPEC(67, 0xd10, 2, 1, 0),   /* ms0 DS */
+	MTK_PIN_PUPD_SPEC(68, 0xd00, 2, 1, 0),   /* ms0 RST */
+	MTK_PIN_PUPD_SPEC(66, 0xc10, 2, 1, 0),   /* ms0 cmd */
+	MTK_PIN_PUPD_SPEC(65, 0xc00, 2, 1, 0),   /* ms0 clk */
+	MTK_PIN_PUPD_SPEC(57, 0xc20, 2, 1, 0),   /* ms0 data0 */
+	MTK_PIN_PUPD_SPEC(58, 0xc20, 2, 1, 0),   /* ms0 data1 */
+	MTK_PIN_PUPD_SPEC(59, 0xc20, 2, 1, 0),   /* ms0 data2 */
+	MTK_PIN_PUPD_SPEC(60, 0xc20, 2, 1, 0),   /* ms0 data3 */
+	MTK_PIN_PUPD_SPEC(61, 0xc20, 2, 1, 0),   /* ms0 data4 */
+	MTK_PIN_PUPD_SPEC(62, 0xc20, 2, 1, 0),   /* ms0 data5 */
+	MTK_PIN_PUPD_SPEC(63, 0xc20, 2, 1, 0),   /* ms0 data6 */
+	MTK_PIN_PUPD_SPEC(64, 0xc20, 2, 1, 0),   /* ms0 data7 */
+
+	MTK_PIN_PUPD_SPEC(78, 0xc50, 2, 1, 0),    /* ms1 cmd */
+	MTK_PIN_PUPD_SPEC(73, 0xd20, 2, 1, 0),    /* ms1 dat0 */
+	MTK_PIN_PUPD_SPEC(74, 0xd20, 6, 5, 4),    /* ms1 dat1 */
+	MTK_PIN_PUPD_SPEC(75, 0xd20, 10, 9, 8),   /* ms1 dat2 */
+	MTK_PIN_PUPD_SPEC(76, 0xd20, 14, 13, 12), /* ms1 dat3 */
+	MTK_PIN_PUPD_SPEC(77, 0xc40, 2, 1, 0),    /* ms1 clk */
+
+	MTK_PIN_PUPD_SPEC(100, 0xd40, 2, 1, 0),    /* ms2 dat0 */
+	MTK_PIN_PUPD_SPEC(101, 0xd40, 6, 5, 4),    /* ms2 dat1 */
+	MTK_PIN_PUPD_SPEC(102, 0xd40, 10, 9, 8),   /* ms2 dat2 */
+	MTK_PIN_PUPD_SPEC(103, 0xd40, 14, 13, 12), /* ms2 dat3 */
+	MTK_PIN_PUPD_SPEC(104, 0xc80, 2, 1, 0),    /* ms2 clk */
+	MTK_PIN_PUPD_SPEC(105, 0xc90, 2, 1, 0),    /* ms2 cmd */
+
+	MTK_PIN_PUPD_SPEC(22, 0xd60, 2, 1, 0),    /* ms3 dat0 */
+	MTK_PIN_PUPD_SPEC(23, 0xd60, 6, 5, 4),    /* ms3 dat1 */
+	MTK_PIN_PUPD_SPEC(24, 0xd60, 10, 9, 8),   /* ms3 dat2 */
+	MTK_PIN_PUPD_SPEC(25, 0xd60, 14, 13, 12), /* ms3 dat3 */
+	MTK_PIN_PUPD_SPEC(26, 0xcc0, 2, 1, 0),    /* ms3 clk */
+	MTK_PIN_PUPD_SPEC(27, 0xcd0, 2, 1, 0)     /* ms3 cmd */
+};
+
+static int spec_pull_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, bool isup, unsigned int r1r0)
+{
+	unsigned int i;
+	unsigned int reg_pupd, reg_set, reg_rst;
+	unsigned int bit_pupd, bit_r0, bit_r1;
+	const struct mtk_pin_spec_pupd_set *spec_pupd_pin;
+	bool find = false;
+
+	for (i = 0; i < ARRAY_SIZE(mt8173_spec_pupd); i++) {
+		if (pin == mt8173_spec_pupd[i].pin) {
+			find = true;
+			break;
+		}
+	}
+
+	if (!find)
+		return -EINVAL;
+
+	spec_pupd_pin = mt8173_spec_pupd + i;
+	reg_set = spec_pupd_pin->offset + align;
+	reg_rst = spec_pupd_pin->offset + (align << 1);
+
+	if (isup)
+		reg_pupd = reg_rst;
+	else
+		reg_pupd = reg_set;
+
+	bit_pupd = BIT(spec_pupd_pin->pupd_bit);
+	regmap_write(regmap, reg_pupd, bit_pupd);
+
+	bit_r0 = BIT(spec_pupd_pin->r0_bit);
+	bit_r1 = BIT(spec_pupd_pin->r1_bit);
+
+	switch (r1r0) {
+	case MTK_PUPD_SET_R1R0_00:
+		regmap_write(regmap, reg_rst, bit_r0);
+		regmap_write(regmap, reg_rst, bit_r1);
+		break;
+	case MTK_PUPD_SET_R1R0_01:
+		regmap_write(regmap, reg_set, bit_r0);
+		regmap_write(regmap, reg_rst, bit_r1);
+		break;
+	case MTK_PUPD_SET_R1R0_10:
+		regmap_write(regmap, reg_rst, bit_r0);
+		regmap_write(regmap, reg_set, bit_r1);
+		break;
+	case MTK_PUPD_SET_R1R0_11:
+		regmap_write(regmap, reg_set, bit_r0);
+		regmap_write(regmap, reg_set, bit_r1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct mtk_pin_ies_smt_set mt8173_ies_smt_set[] = {
+	MTK_PIN_IES_SMT_SET(0, 4, 0x930, 1),
+	MTK_PIN_IES_SMT_SET(5, 9, 0x930, 2),
+	MTK_PIN_IES_SMT_SET(10, 13, 0x930, 10),
+	MTK_PIN_IES_SMT_SET(14, 15, 0x940, 10),
+	MTK_PIN_IES_SMT_SET(16, 16, 0x930, 0),
+	MTK_PIN_IES_SMT_SET(17, 17, 0x950, 2),
+	MTK_PIN_IES_SMT_SET(18, 21, 0x940, 3),
+	MTK_PIN_IES_SMT_SET(29, 32, 0x930, 3),
+	MTK_PIN_IES_SMT_SET(33, 33, 0x930, 4),
+	MTK_PIN_IES_SMT_SET(34, 36, 0x930, 5),
+	MTK_PIN_IES_SMT_SET(37, 38, 0x930, 6),
+	MTK_PIN_IES_SMT_SET(39, 39, 0x930, 7),
+	MTK_PIN_IES_SMT_SET(40, 41, 0x930, 9),
+	MTK_PIN_IES_SMT_SET(42, 42, 0x940, 0),
+	MTK_PIN_IES_SMT_SET(43, 44, 0x930, 11),
+	MTK_PIN_IES_SMT_SET(45, 46, 0x930, 12),
+	MTK_PIN_IES_SMT_SET(57, 64, 0xc20, 13),
+	MTK_PIN_IES_SMT_SET(65, 65, 0xc10, 13),
+	MTK_PIN_IES_SMT_SET(66, 66, 0xc00, 13),
+	MTK_PIN_IES_SMT_SET(67, 67, 0xd10, 13),
+	MTK_PIN_IES_SMT_SET(68, 68, 0xd00, 13),
+	MTK_PIN_IES_SMT_SET(69, 72, 0x940, 14),
+	MTK_PIN_IES_SMT_SET(73, 76, 0xc60, 13),
+	MTK_PIN_IES_SMT_SET(77, 77, 0xc40, 13),
+	MTK_PIN_IES_SMT_SET(78, 78, 0xc50, 13),
+	MTK_PIN_IES_SMT_SET(79, 82, 0x940, 15),
+	MTK_PIN_IES_SMT_SET(83, 83, 0x950, 0),
+	MTK_PIN_IES_SMT_SET(84, 85, 0x950, 1),
+	MTK_PIN_IES_SMT_SET(86, 91, 0x950, 2),
+	MTK_PIN_IES_SMT_SET(92, 92, 0x930, 13),
+	MTK_PIN_IES_SMT_SET(93, 95, 0x930, 14),
+	MTK_PIN_IES_SMT_SET(96, 99, 0x930, 15),
+	MTK_PIN_IES_SMT_SET(100, 103, 0xca0, 13),
+	MTK_PIN_IES_SMT_SET(104, 104, 0xc80, 13),
+	MTK_PIN_IES_SMT_SET(105, 105, 0xc90, 13),
+	MTK_PIN_IES_SMT_SET(106, 107, 0x940, 4),
+	MTK_PIN_IES_SMT_SET(108, 112, 0x940, 1),
+	MTK_PIN_IES_SMT_SET(113, 116, 0x940, 2),
+	MTK_PIN_IES_SMT_SET(117, 118, 0x940, 5),
+	MTK_PIN_IES_SMT_SET(119, 124, 0x940, 6),
+	MTK_PIN_IES_SMT_SET(125, 126, 0x940, 7),
+	MTK_PIN_IES_SMT_SET(127, 127, 0x940, 0),
+	MTK_PIN_IES_SMT_SET(128, 128, 0x950, 8),
+	MTK_PIN_IES_SMT_SET(129, 130, 0x950, 9),
+	MTK_PIN_IES_SMT_SET(131, 132, 0x950, 8),
+	MTK_PIN_IES_SMT_SET(133, 134, 0x910, 8)
+};
+
+static int spec_ies_smt_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, int value)
+{
+	unsigned int i, reg_addr, bit;
+	bool find = false;
+
+	for (i = 0; i < ARRAY_SIZE(mt8173_ies_smt_set); i++) {
+		if (pin >= mt8173_ies_smt_set[i].start &&
+				pin <= mt8173_ies_smt_set[i].end) {
+			find = true;
+			break;
+		}
+	}
+
+	if (!find)
+		return -EINVAL;
+
+	if (value)
+		reg_addr = mt8173_ies_smt_set[i].offset + align;
+	else
+		reg_addr = mt8173_ies_smt_set[i].offset + (align << 1);
+
+	bit = BIT(mt8173_ies_smt_set[i].bit);
+	regmap_write(regmap, reg_addr, bit);
+	return 0;
+}
+
+static const struct mtk_drv_group_desc mt8173_drv_grp[] =  {
+	/* 0E4E8SR 4/8/12/16 */
+	MTK_DRV_GRP(4, 16, 1, 2, 4),
+	/* 0E2E4SR  2/4/6/8 */
+	MTK_DRV_GRP(2, 8, 1, 2, 2),
+	/* E8E4E2  2/4/6/8/10/12/14/16 */
+	MTK_DRV_GRP(2, 16, 0, 2, 2)
+};
+
+static const struct mtk_pin_drv_grp mt8173_pin_drv[] = {
+	MTK_PIN_DRV_GRP(0, DRV_BASE+0x20, 12, 0),
+	MTK_PIN_DRV_GRP(1, DRV_BASE+0x20, 12, 0),
+	MTK_PIN_DRV_GRP(2, DRV_BASE+0x20, 12, 0),
+	MTK_PIN_DRV_GRP(3, DRV_BASE+0x20, 12, 0),
+	MTK_PIN_DRV_GRP(4, DRV_BASE+0x20, 12, 0),
+	MTK_PIN_DRV_GRP(5, DRV_BASE+0x30, 0, 0),
+	MTK_PIN_DRV_GRP(6, DRV_BASE+0x30, 0, 0),
+	MTK_PIN_DRV_GRP(7, DRV_BASE+0x30, 0, 0),
+	MTK_PIN_DRV_GRP(8, DRV_BASE+0x30, 0, 0),
+	MTK_PIN_DRV_GRP(9, DRV_BASE+0x30, 0, 0),
+	MTK_PIN_DRV_GRP(10, DRV_BASE+0x30, 4, 1),
+	MTK_PIN_DRV_GRP(11, DRV_BASE+0x30, 4, 1),
+	MTK_PIN_DRV_GRP(12, DRV_BASE+0x30, 4, 1),
+	MTK_PIN_DRV_GRP(13, DRV_BASE+0x30, 4, 1),
+	MTK_PIN_DRV_GRP(14, DRV_BASE+0x40, 8, 1),
+	MTK_PIN_DRV_GRP(15, DRV_BASE+0x40, 8, 1),
+	MTK_PIN_DRV_GRP(16, DRV_BASE, 8, 1),
+	MTK_PIN_DRV_GRP(17, 0xce0, 8, 2),
+	MTK_PIN_DRV_GRP(22, 0xce0, 8, 2),
+	MTK_PIN_DRV_GRP(23, 0xce0, 8, 2),
+	MTK_PIN_DRV_GRP(24, 0xce0, 8, 2),
+	MTK_PIN_DRV_GRP(25, 0xce0, 8, 2),
+	MTK_PIN_DRV_GRP(26, 0xcc0, 8, 2),
+	MTK_PIN_DRV_GRP(27, 0xcd0, 8, 2),
+	MTK_PIN_DRV_GRP(28, 0xd70, 8, 2),
+	MTK_PIN_DRV_GRP(29, DRV_BASE+0x80, 12, 1),
+	MTK_PIN_DRV_GRP(30, DRV_BASE+0x80, 12, 1),
+	MTK_PIN_DRV_GRP(31, DRV_BASE+0x80, 12, 1),
+	MTK_PIN_DRV_GRP(32, DRV_BASE+0x80, 12, 1),
+	MTK_PIN_DRV_GRP(33, DRV_BASE+0x10, 12, 1),
+	MTK_PIN_DRV_GRP(34, DRV_BASE+0x10, 8, 1),
+	MTK_PIN_DRV_GRP(35, DRV_BASE+0x10, 8, 1),
+	MTK_PIN_DRV_GRP(36, DRV_BASE+0x10, 8, 1),
+	MTK_PIN_DRV_GRP(37, DRV_BASE+0x10, 4, 1),
+	MTK_PIN_DRV_GRP(38, DRV_BASE+0x10, 4, 1),
+	MTK_PIN_DRV_GRP(39, DRV_BASE+0x20, 0, 0),
+	MTK_PIN_DRV_GRP(40, DRV_BASE+0x20, 8, 0),
+	MTK_PIN_DRV_GRP(41, DRV_BASE+0x20, 8, 0),
+	MTK_PIN_DRV_GRP(42, DRV_BASE+0x50, 8, 1),
+	MTK_PIN_DRV_GRP(57, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(58, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(59, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(60, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(61, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(62, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(63, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(64, 0xc20, 8, 2),
+	MTK_PIN_DRV_GRP(65, 0xc00, 8, 2),
+	MTK_PIN_DRV_GRP(66, 0xc10, 8, 2),
+	MTK_PIN_DRV_GRP(67, 0xd10, 8, 2),
+	MTK_PIN_DRV_GRP(68, 0xd00, 8, 2),
+	MTK_PIN_DRV_GRP(69, DRV_BASE+0x80, 0, 1),
+	MTK_PIN_DRV_GRP(70, DRV_BASE+0x80, 0, 1),
+	MTK_PIN_DRV_GRP(71, DRV_BASE+0x80, 0, 1),
+	MTK_PIN_DRV_GRP(72, DRV_BASE+0x80, 0, 1),
+	MTK_PIN_DRV_GRP(73, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(74, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(75, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(76, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(77, 0xc40, 8, 2),
+	MTK_PIN_DRV_GRP(78, 0xc50, 8, 2),
+	MTK_PIN_DRV_GRP(79, DRV_BASE+0x70, 12, 1),
+	MTK_PIN_DRV_GRP(80, DRV_BASE+0x70, 12, 1),
+	MTK_PIN_DRV_GRP(81, DRV_BASE+0x70, 12, 1),
+	MTK_PIN_DRV_GRP(82, DRV_BASE+0x70, 12, 1),
+	MTK_PIN_DRV_GRP(83, DRV_BASE, 4, 1),
+	MTK_PIN_DRV_GRP(84, DRV_BASE, 0, 1),
+	MTK_PIN_DRV_GRP(85, DRV_BASE, 0, 1),
+	MTK_PIN_DRV_GRP(85, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(86, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(87, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(88, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(89, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(90, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(91, DRV_BASE+0x60, 8, 1),
+	MTK_PIN_DRV_GRP(92, DRV_BASE+0x60, 4, 0),
+	MTK_PIN_DRV_GRP(93, DRV_BASE+0x60, 0, 0),
+	MTK_PIN_DRV_GRP(94, DRV_BASE+0x60, 0, 0),
+	MTK_PIN_DRV_GRP(95, DRV_BASE+0x60, 0, 0),
+	MTK_PIN_DRV_GRP(96, DRV_BASE+0x80, 8, 1),
+	MTK_PIN_DRV_GRP(97, DRV_BASE+0x80, 8, 1),
+	MTK_PIN_DRV_GRP(98, DRV_BASE+0x80, 8, 1),
+	MTK_PIN_DRV_GRP(99, DRV_BASE+0x80, 8, 1),
+	MTK_PIN_DRV_GRP(100, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(101, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(102, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(103, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(104, 0xc80, 8, 2),
+	MTK_PIN_DRV_GRP(105, 0xc90, 8, 2),
+	MTK_PIN_DRV_GRP(108, DRV_BASE+0x50, 0, 1),
+	MTK_PIN_DRV_GRP(109, DRV_BASE+0x50, 0, 1),
+	MTK_PIN_DRV_GRP(110, DRV_BASE+0x50, 0, 1),
+	MTK_PIN_DRV_GRP(111, DRV_BASE+0x50, 0, 1),
+	MTK_PIN_DRV_GRP(112, DRV_BASE+0x50, 0, 1),
+	MTK_PIN_DRV_GRP(113, DRV_BASE+0x80, 4, 1),
+	MTK_PIN_DRV_GRP(114, DRV_BASE+0x80, 4, 1),
+	MTK_PIN_DRV_GRP(115, DRV_BASE+0x80, 4, 1),
+	MTK_PIN_DRV_GRP(116, DRV_BASE+0x80, 4, 1),
+	MTK_PIN_DRV_GRP(117, DRV_BASE+0x90, 0, 1),
+	MTK_PIN_DRV_GRP(118, DRV_BASE+0x90, 0, 1),
+	MTK_PIN_DRV_GRP(119, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(120, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(121, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(122, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(123, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(124, DRV_BASE+0x50, 4, 1),
+	MTK_PIN_DRV_GRP(125, DRV_BASE+0x30, 12, 1),
+	MTK_PIN_DRV_GRP(126, DRV_BASE+0x30, 12, 1),
+	MTK_PIN_DRV_GRP(127, DRV_BASE+0x50, 8, 1),
+	MTK_PIN_DRV_GRP(128, DRV_BASE+0x40, 0, 1),
+	MTK_PIN_DRV_GRP(129, DRV_BASE+0x40, 0, 1),
+	MTK_PIN_DRV_GRP(130, DRV_BASE+0x40, 0, 1),
+	MTK_PIN_DRV_GRP(131, DRV_BASE+0x40, 0, 1),
+	MTK_PIN_DRV_GRP(132, DRV_BASE+0x40, 0, 1)
+};
+
+static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
+	.pins = mtk_pins_mt8173,
+	.npins = ARRAY_SIZE(mtk_pins_mt8173),
+	.grp_desc = mt8173_drv_grp,
+	.n_grp_cls = ARRAY_SIZE(mt8173_drv_grp),
+	.pin_drv_grp = mt8173_pin_drv,
+	.n_pin_drv_grps = ARRAY_SIZE(mt8173_pin_drv),
+	.spec_pull_set = spec_pull_set,
+	.spec_ies_smt_set = spec_ies_smt_set,
+	.dir_offset = 0x0000,
+	.pullen_offset = 0x0100,
+	.pullsel_offset = 0x0200,
+	.dout_offset = 0x0400,
+	.din_offset = 0x0500,
+	.pinmux_offset = 0x0600,
+	.type1_start = 135,
+	.type1_end = 135,
+	.port_shf = 4,
+	.port_mask = 0xf,
+	.port_align = 4,
+	.eint_offsets = {
+		.name = "mt8173_eint",
+		.stat      = 0x000,
+		.ack       = 0x040,
+		.mask      = 0x080,
+		.mask_set  = 0x0c0,
+		.mask_clr  = 0x100,
+		.sens      = 0x140,
+		.sens_set  = 0x180,
+		.sens_clr  = 0x1c0,
+		.pol       = 0x300,
+		.pol_set   = 0x340,
+		.pol_clr   = 0x380,
+		.dom_en    = 0x400,
+		.dbnc_ctrl = 0x500,
+		.dbnc_set  = 0x600,
+		.dbnc_clr  = 0x700,
+		.port_mask = 7,
+		.ports     = 6,
+	},
+	.ap_num = 224,
+	.db_cnt = 16,
+};
+
+static int mt8173_pinctrl_probe(struct platform_device *pdev)
+{
+	return mtk_pctrl_init(pdev, &mt8173_pinctrl_data);
+}
+
+static struct of_device_id mt8173_pctrl_match[] = {
+	{
+		.compatible = "mediatek,mt8173-pinctrl",
+	}, {
+	}
+};
+MODULE_DEVICE_TABLE(of, mt8173_pctrl_match);
+
+static struct platform_driver mtk_pinctrl_driver = {
+	.probe = mt8173_pinctrl_probe,
+	.driver = {
+		.name = "mediatek-mt8173-pinctrl",
+		.of_match_table = mt8173_pctrl_match,
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
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
+MODULE_AUTHOR("Hongzhou Yang <hongzhou.yang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 1c0c0ae..35cdfe2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -32,6 +32,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
 
 #include "../core.h"
@@ -111,6 +112,19 @@ static void mtk_pconf_set_ies_smt(struct mtk_pinctrl *pctl, unsigned pin,
 {
 	unsigned int reg_addr, offset;
 	unsigned int bit;
+	int ret;
+
+	/*
+	 * Due to some pins are irregular, their input enable and smt
+	 * control register are discontinuous, but they are mapping together.
+	 * So we need this special handle.
+	 */
+	if (pctl->devdata->spec_ies_smt_set) {
+		ret = pctl->devdata->spec_ies_smt_set(mtk_get_regmap(pctl, pin),
+			pin, pctl->devdata->port_align, value);
+		if (!ret)
+			return;
+	}
 
 	bit = BIT(pin & 0xf);
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 14614cf..602f5e9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -152,6 +152,11 @@ struct mtk_eint_offsets {
  *  up/down bit, R0 and R1 resistor bit, so they need special pull setting.
  *  If special setting is success, this should return 0, otherwise it should
  *  return non-zero value.
+ * @spec_ies_smt_set: Some pins are irregular, their input enable and smt
+ * control register are discontinuous, but they are mapping together. That
+ * means when user set smt, input enable is set at the same time. So they
+ * also need special control. If special control is success, this should
+ * return 0, otherwise return non-zero value.
  *
  * @dir_offset: The direction register offset.
  * @pullen_offset: The pull-up/pull-down enable register offset.
@@ -175,6 +180,8 @@ struct mtk_pinctrl_devdata {
 	unsigned int	n_pin_drv_grps;
 	int (*spec_pull_set)(struct regmap *reg, unsigned int pin,
 			unsigned char align, bool isup, unsigned int arg);
+	int (*spec_ies_smt_set)(struct regmap *reg, unsigned int pin,
+			unsigned char align, int value);
 	unsigned int dir_offset;
 	unsigned int ies_offset;
 	unsigned int smt_offset;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
new file mode 100644
index 0000000..c1a3ca0
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
@@ -0,0 +1,1226 @@
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
+#ifndef __PINCTRL_MTK_MT8173_H
+#define __PINCTRL_MTK_MT8173_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <pinctrl-mtk-common.h>
+
+static const struct mtk_desc_pin mtk_pins_mt8173[] = {
+	MTK_PIN(
+		PINCTRL_PIN(0, "EINT0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 0),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "IRDA_PDN"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(3, "AUD_SPDIF"),
+		MTK_FUNCTION(4, "UTXD0"),
+		MTK_FUNCTION(7, "DBG_MON_A_20_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(1, "EINT1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 1),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "IRDA_RXD"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(3, "SDA5"),
+		MTK_FUNCTION(4, "URXD0"),
+		MTK_FUNCTION(7, "DBG_MON_A_21_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(2, "EINT2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 2),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "IRDA_TXD"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(3, "SCL5"),
+		MTK_FUNCTION(4, "UTXD3"),
+		MTK_FUNCTION(7, "DBG_MON_A_22_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(3, "EINT3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 3),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "DSI1_TE"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(3, "SDA3"),
+		MTK_FUNCTION(4, "URXD3"),
+		MTK_FUNCTION(7, "DBG_MON_A_23_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(4, "EINT4"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 4),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "DISP_PWM1"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(3, "SCL3"),
+		MTK_FUNCTION(4, "UCTS3"),
+		MTK_FUNCTION(6, "SFWP_B")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(5, "EINT5"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 5),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "I2S2_WS"),
+		MTK_FUNCTION(3, "SPI_CK_3_"),
+		MTK_FUNCTION(4, "URTS3"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TMS"),
+		MTK_FUNCTION(6, "SFOUT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(6, "EINT6"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 6),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "I2S2_BCK"),
+		MTK_FUNCTION(3, "SPI_MI_3_"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TCK"),
+		MTK_FUNCTION(6, "SFCS0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(7, "EINT7"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 7),
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "I2S2_DI_1"),
+		MTK_FUNCTION(3, "SPI_MO_3_"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDI"),
+		MTK_FUNCTION(6, "SFHOLD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(8, "EINT8"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 8),
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "PCM1_DO"),
+		MTK_FUNCTION(2, "I2S2_DI_2"),
+		MTK_FUNCTION(3, "SPI_CS_3_"),
+		MTK_FUNCTION(4, "AUD_SPDIF"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDO"),
+		MTK_FUNCTION(6, "SFIN")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(9, "EINT9"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 9),
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(2, "I2S2_MCK"),
+		MTK_FUNCTION(4, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TRST"),
+		MTK_FUNCTION(6, "SFCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(10, "EINT10"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 10),
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "CLKM0"),
+		MTK_FUNCTION(2, "DSI1_TE"),
+		MTK_FUNCTION(3, "DISP_PWM1"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "IRDA_RXD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(11, "EINT11"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 11),
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "CLKM1"),
+		MTK_FUNCTION(2, "I2S3_WS"),
+		MTK_FUNCTION(3, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "IRDA_TXD"),
+		MTK_FUNCTION(6, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(7, "DBG_MON_B_30_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(12, "EINT12"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 12),
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "CLKM2"),
+		MTK_FUNCTION(2, "I2S3_BCK"),
+		MTK_FUNCTION(3, "SRCLKENA0"),
+		MTK_FUNCTION(5, "I2S2_WS"),
+		MTK_FUNCTION(7, "DBG_MON_B_32_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(13, "EINT13"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 13),
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "CLKM3"),
+		MTK_FUNCTION(2, "I2S3_MCK"),
+		MTK_FUNCTION(3, "SRCLKENA0"),
+		MTK_FUNCTION(5, "I2S2_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_A_32_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(14, "EINT14"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 14),
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "CMDAT0"),
+		MTK_FUNCTION(2, "CMCSD0"),
+		MTK_FUNCTION(4, "CLKM2"),
+		MTK_FUNCTION(7, "DBG_MON_B_6_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(15, "EINT15"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 15),
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "CMDAT1"),
+		MTK_FUNCTION(2, "CMCSD1"),
+		MTK_FUNCTION(3, "CMFLASH"),
+		MTK_FUNCTION(4, "CLKM3"),
+		MTK_FUNCTION(7, "DBG_MON_B_29_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(16, "IDDIG"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 16),
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "CMFLASH"),
+		MTK_FUNCTION(4, "PWM5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(17, "WATCHDOG"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 17),
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "WATCHDOG_AO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(18, "CEC"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 18),
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "CEC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(19, "HDMISCK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 19),
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "HDMISCK"),
+		MTK_FUNCTION(2, "HDCP_SCL")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(20, "HDMISD"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 20),
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "HDMISD"),
+		MTK_FUNCTION(2, "HDCP_SDA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(21, "HTPLG"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 21),
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "HTPLG")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(22, "MSDC3_DAT0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 22),
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "MSDC3_DAT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(23, "MSDC3_DAT1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 23),
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "MSDC3_DAT1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(24, "MSDC3_DAT2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 24),
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "MSDC3_DAT2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(25, "MSDC3_DAT3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 25),
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "MSDC3_DAT3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(26, "MSDC3_CLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 26),
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "MSDC3_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(27, "MSDC3_CMD"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 27),
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "MSDC3_CMD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(28, "MSDC3_DSL"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 28),
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "MSDC3_DSL")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(29, "UCTS2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 29),
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "UCTS2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(30, "URTS2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 30),
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "URTS2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(31, "URXD2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 31),
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "UTXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(32, "UTXD2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 32),
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "URXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(33, "DAICLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 33),
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, " MRG_CLK"),
+		MTK_FUNCTION(2, "PCM0_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(34, "DAIPCMIN"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 34),
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, " MRG_DI"),
+		MTK_FUNCTION(2, "PCM0_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(35, "DAIPCMOUT"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 35),
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, " MRG_DO"),
+		MTK_FUNCTION(2, "PCM0_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(36, "DAISYNC"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 36),
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, " MRG_SYNC"),
+		MTK_FUNCTION(2, "PCM0_SYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(37, "EINT16"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 37),
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(2, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(3, "PWM0"),
+		MTK_FUNCTION(4, "PWM1"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(6, "CLKM0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(38, "CONN_RST"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 38),
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(2, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(6, "CLKM1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(39, "CM2MCLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 39),
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "CM2MCLK"),
+		MTK_FUNCTION(2, "CMCSD0"),
+		MTK_FUNCTION(7, "DBG_MON_A_17_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(40, "CMPCLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 40),
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "CMPCLK"),
+		MTK_FUNCTION(2, "CMCSK"),
+		MTK_FUNCTION(3, "CMCSD2"),
+		MTK_FUNCTION(7, "DBG_MON_A_18_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(41, "CMMCLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 41),
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "CMMCLK"),
+		MTK_FUNCTION(7, "DBG_MON_A_19_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(42, "DSI_TE"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 42),
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "DSI_TE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(43, "SDA2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 43),
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(44, "SCL2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 44),
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(45, "SDA0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 45),
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(46, "SCL0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 46),
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(47, "RDN0_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 47),
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "CMDAT2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(48, "RDP0_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 48),
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "CMDAT3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(49, "RDN1_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 49),
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "CMDAT4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(50, "RDP1_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 50),
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "CMDAT5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(51, "RCN_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 51),
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "CMDAT6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(52, "RCP_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 52),
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "CMDAT7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(53, "RDN2_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 53),
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "CMDAT8"),
+		MTK_FUNCTION(2, "CMCSD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(54, "RDP2_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 54),
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "CMDAT9"),
+		MTK_FUNCTION(2, "CMCSD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(55, "RDN3_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 55),
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "CMHSYNC"),
+		MTK_FUNCTION(2, "CMCSD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(56, "RDP3_A"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 56),
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "CMVSYNC"),
+		MTK_FUNCTION(2, "CMCSD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(57, "MSDC0_DAT0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 57),
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "MSDC0_DAT0"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(7, "DBG_MON_B_7_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(58, "MSDC0_DAT1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 58),
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "MSDC0_DAT1"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_8_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(59, "MSDC0_DAT2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 59),
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "MSDC0_DAT2"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_9_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(60, "MSDC0_DAT3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 60),
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "MSDC0_DAT3"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(7, "DBG_MON_B_10_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(61, "MSDC0_DAT4"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 61),
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "MSDC0_DAT4"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(7, "DBG_MON_B_11_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(62, "MSDC0_DAT5"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 62),
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "MSDC0_DAT5"),
+		MTK_FUNCTION(2, "I2S2_WS"),
+		MTK_FUNCTION(7, "DBG_MON_B_12_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(63, "MSDC0_DAT6"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 63),
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "MSDC0_DAT6"),
+		MTK_FUNCTION(2, "I2S2_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_13_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(64, "MSDC0_DAT7"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 64),
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "MSDC0_DAT7"),
+		MTK_FUNCTION(2, "I2S2_DI_1"),
+		MTK_FUNCTION(7, "DBG_MON_B_14_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(65, "MSDC0_CLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 65),
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "MSDC0_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B_16_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(66, "MSDC0_CMD"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 66),
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "MSDC0_CMD"),
+		MTK_FUNCTION(2, "I2S2_DI_2"),
+		MTK_FUNCTION(7, "DBG_MON_B_15_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(67, "MSDC0_DSL"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 67),
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "MSDC0_DSL"),
+		MTK_FUNCTION(7, "DBG_MON_B_17_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(68, "MSDC0_RST_"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 68),
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "MSDC0_RSTB"),
+		MTK_FUNCTION(2, "I2S2_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_18_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(69, "SPI_CK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 69),
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "SPI_CK_0_"),
+		MTK_FUNCTION(2, "I2S3_DO_1"),
+		MTK_FUNCTION(3, "PWM0"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "I2S2_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_19_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(70, "SPI_MI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 70),
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "SPI_MI_0_"),
+		MTK_FUNCTION(2, "I2S3_DO_2"),
+		MTK_FUNCTION(3, "PWM1"),
+		MTK_FUNCTION(4, "SPI_MO_0_"),
+		MTK_FUNCTION(5, "I2S2_DI_1"),
+		MTK_FUNCTION(6, "DSI1_TE"),
+		MTK_FUNCTION(7, "DBG_MON_B_20_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(71, "SPI_MO"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 71),
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "SPI_MO_0_"),
+		MTK_FUNCTION(2, "I2S3_DO_3"),
+		MTK_FUNCTION(3, "PWM2"),
+		MTK_FUNCTION(4, "SPI_MI_0_"),
+		MTK_FUNCTION(5, "I2S2_DI_2"),
+		MTK_FUNCTION(7, "DBG_MON_B_21_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(72, "SPI_CS"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 72),
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "SPI_CS_0_"),
+		MTK_FUNCTION(2, "I2S3_DO_4"),
+		MTK_FUNCTION(3, "PWM3"),
+		MTK_FUNCTION(4, "PWM6"),
+		MTK_FUNCTION(5, "DISP_PWM1"),
+		MTK_FUNCTION(7, "DBG_MON_B_22_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(73, "MSDC1_DAT0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 73),
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "MSDC1_DAT0"),
+		MTK_FUNCTION(7, "DBG_MON_B_24_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(74, "MSDC1_DAT1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 74),
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(7, "DBG_MON_B_25_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(75, "MSDC1_DAT2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 75),
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(7, "DBG_MON_B_26_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(76, "MSDC1_DAT3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 76),
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(7, "DBG_MON_B_27_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(77, "MSDC1_CLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 77),
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B_28_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(78, "MSDC1_CMD"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 78),
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "MSDC1_CMD"),
+		MTK_FUNCTION(7, "DBG_MON_B_23_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(79, "PWRAP_SPI0_MI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 79),
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "PWRAP_SPIMI"),
+		MTK_FUNCTION(2, "PWRAP_SPIMO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(80, "PWRAP_SPI0_MO"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 80),
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "PWRAP_SPIMO"),
+		MTK_FUNCTION(2, "PWRAP_SPIMI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(81, "PWRAP_SPI0_CK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 81),
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "PWRAP_SPICK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(82, "PWRAP_SPI0_CSN"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 82),
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "PWRAP_SPICS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(83, "AUD_CLK_MOSI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 83),
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "AUD_CLK_MOSI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(84, "AUD_DAT_MISO"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 84),
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO"),
+		MTK_FUNCTION(2, "AUD_DAT_MOSI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(85, "AUD_DAT_MOSI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 85),
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI"),
+		MTK_FUNCTION(2, "AUD_DAT_MISO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(86, "RTC32K_CK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 86),
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(87, "DISP_PWM0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 87),
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "DISP_PWM0"),
+		MTK_FUNCTION(2, "DISP_PWM1"),
+		MTK_FUNCTION(7, "DBG_MON_B_31_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(88, "SRCLKENAI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 88),
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "SRCLKENAI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(89, "SRCLKENAI2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 89),
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "SRCLKENAI2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(90, "SRCLKENA0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 90),
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "SRCLKENA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(91, "SRCLKENA1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 91),
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "SRCLKENA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(92, "PCM_CLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 92),
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "I2S0_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_A_24_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(93, "PCM_SYNC"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 93),
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "I2S0_WS"),
+		MTK_FUNCTION(7, "DBG_MON_A_25_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(94, "PCM_RX"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 94),
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "I2S0_DI"),
+		MTK_FUNCTION(7, "DBG_MON_A_26_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(95, "PCM_TX"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 95),
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "PCM1_DO"),
+		MTK_FUNCTION(2, "I2S0_DO"),
+		MTK_FUNCTION(7, "DBG_MON_A_27_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(96, "URXD1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 96),
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1"),
+		MTK_FUNCTION(7, "DBG_MON_A_28_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(97, "UTXD1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 97),
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1"),
+		MTK_FUNCTION(7, "DBG_MON_A_29_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(98, "URTS1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 98),
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "URTS1"),
+		MTK_FUNCTION(2, "UCTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A_30_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(99, "UCTS1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 99),
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "UCTS1"),
+		MTK_FUNCTION(2, "URTS1"),
+		MTK_FUNCTION(7, "DBG_MON_A_31_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(100, "MSDC2_DAT0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 100),
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(3, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(4, "SDA5"),
+		MTK_FUNCTION(5, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(7, "DBG_MON_B_0_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(101, "MSDC2_DAT1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 101),
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(3, "AUD_SPDIF"),
+		MTK_FUNCTION(4, "SCL5"),
+		MTK_FUNCTION(7, "DBG_MON_B_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(102, "MSDC2_DAT2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 102),
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(3, "UTXD0"),
+		MTK_FUNCTION(5, "PWM0"),
+		MTK_FUNCTION(6, "SPI_CK_1_"),
+		MTK_FUNCTION(7, "DBG_MON_B_2_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(103, "MSDC2_DAT3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 103),
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(3, "URXD0"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(6, "SPI_MI_1_"),
+		MTK_FUNCTION(7, "DBG_MON_B_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(104, "MSDC2_CLK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 104),
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "SDA3"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(6, "SPI_MO_1_"),
+		MTK_FUNCTION(7, "DBG_MON_B_4_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(105, "MSDC2_CMD"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 105),
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "SCL3"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "SPI_CS_1_"),
+		MTK_FUNCTION(7, "DBG_MON_B_5_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(106, "SDA3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 106),
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "SDA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(107, "SCL3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 107),
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "SCL3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(108, "JTMS"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 108),
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, " MFG_JTAG_TMS"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TMS"),
+		MTK_FUNCTION(6, "DFD_TMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(109, "JTCK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 109),
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, " MFG_JTAG_TCK"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TCK"),
+		MTK_FUNCTION(6, "DFD_TCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(110, "JTDI"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 110),
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, " MFG_JTAG_TDI"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDI"),
+		MTK_FUNCTION(6, "DFD_TDI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(111, "JTDO"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 111),
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "MFG_JTAG_TDO"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDO"),
+		MTK_FUNCTION(6, "DFD_TDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(112, "JTRST_B"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 112),
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "JTRST_B"),
+		MTK_FUNCTION(2, " MFG_JTAG_TRSTN"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TRST"),
+		MTK_FUNCTION(6, "DFD_NTRST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(113, "URXD0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 113),
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0"),
+		MTK_FUNCTION(6, "I2S2_WS"),
+		MTK_FUNCTION(7, "DBG_MON_A_0_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(114, "UTXD0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 114),
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0"),
+		MTK_FUNCTION(6, "I2S2_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_A_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(115, "URTS0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 115),
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "URTS0"),
+		MTK_FUNCTION(2, "UCTS0"),
+		MTK_FUNCTION(6, "I2S2_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_A_2_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(116, "UCTS0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 116),
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "UCTS0"),
+		MTK_FUNCTION(2, "URTS0"),
+		MTK_FUNCTION(6, "I2S2_DI_1"),
+		MTK_FUNCTION(7, "DBG_MON_A_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(117, "URXD3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 117),
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "UTXD3"),
+		MTK_FUNCTION(7, "DBG_MON_A_9_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(118, "UTXD3"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 118),
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "URXD3"),
+		MTK_FUNCTION(7, "DBG_MON_A_10_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(119, "KPROW0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 119),
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "KROW0"),
+		MTK_FUNCTION(7, "DBG_MON_A_11_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(120, "KPROW1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 120),
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "KROW1"),
+		MTK_FUNCTION(3, "PWM6"),
+		MTK_FUNCTION(7, "DBG_MON_A_12_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(121, "KPROW2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 121),
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "KROW2"),
+		MTK_FUNCTION(2, "IRDA_PDN"),
+		MTK_FUNCTION(3, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(7, "DBG_MON_A_13_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(122, "KPCOL0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 122),
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "KCOL0"),
+		MTK_FUNCTION(7, "DBG_MON_A_14_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(123, "KPCOL1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 123),
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "KCOL1"),
+		MTK_FUNCTION(2, "IRDA_RXD"),
+		MTK_FUNCTION(3, "PWM5"),
+		MTK_FUNCTION(7, "DBG_MON_A_15_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(124, "KPCOL2"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 124),
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "KCOL2"),
+		MTK_FUNCTION(2, "IRDA_TXD"),
+		MTK_FUNCTION(3, "USB_DRVVBUS_P0"),
+		MTK_FUNCTION(4, "PWM3"),
+		MTK_FUNCTION(5, "USB_DRVVBUS_P1"),
+		MTK_FUNCTION(7, "DBG_MON_A_16_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(125, "SDA1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 125),
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(126, "SCL1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 126),
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(127, "LCM_RST"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 127),
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "LCM_RST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(128, "I2S0_LRCK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 128),
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "I2S0_WS"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(3, "I2S2_WS"),
+		MTK_FUNCTION(5, "SPI_CK_2_"),
+		MTK_FUNCTION(7, "DBG_MON_A_4_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(129, "I2S0_BCK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 129),
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "I2S0_BCK"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(3, "I2S2_BCK"),
+		MTK_FUNCTION(5, "SPI_MI_2_"),
+		MTK_FUNCTION(7, "DBG_MON_A_5_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(130, "I2S0_MCK"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 130),
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "I2S0_MCK"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(3, "I2S2_MCK"),
+		MTK_FUNCTION(5, "SPI_MO_2_"),
+		MTK_FUNCTION(7, "DBG_MON_A_6_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(131, "I2S0_DATA0"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 131),
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "I2S0_DO"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(3, "I2S2_DI_1"),
+		MTK_FUNCTION(5, "SPI_CS_2_"),
+		MTK_FUNCTION(7, "DBG_MON_A_7_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(132, "I2S0_DATA1"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 132),
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "I2S0_DI"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(3, "I2S2_DI_2"),
+		MTK_FUNCTION(7, "DBG_MON_A_8_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(133, "SDA4"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 133),
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "SDA4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(134, "SCL4"),
+		NULL, "mt8173",
+		MTK_EINT_FUNCTION(0, 134),
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "SCL4")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT8173_H */
-- 
1.8.1.1.dirty
