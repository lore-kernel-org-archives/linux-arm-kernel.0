From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:00 +0800
Subject: [PATCH 01/16] pinctrl: mediatek: add pinctrl-mtk-common-v2 for all
 MediaTek pinctrls
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <96f6610254f1d932c65f81416e5aaa7de3c4676f.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Irregular register arrangement and distinct logic access from various
MediaTek SoCs would cause pinctrl-mtk-common to bloat and really hard to
maintain in the future so that the patch creates pinctrl-mtk-common-v2
based on the core of mt7622-pinctrl.

The goals pinctrl-mtk-common-v2 want to achieve are to hopefully support
all of MediaTek SoCs, and two kinds of dt-bindings being supported,
Linux generic pinctrl dt-binding mt7622 supports and MediaTek per-pin
dt-binding the other SoCs support the MT8183 and MT6765 incline to make
use of.

The patch starts to refactor MT7622 pinctrl driver first with splitting
out these portable ways from there such as table-based register operation
and drive strength control that is common in both kinds of driver.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/Makefile                |   2 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 253 +----------------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 160 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 108 ++++++++++
 4 files changed, 273 insertions(+), 250 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h

diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 3de7156..e3c4ffa 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
 obj-$(CONFIG_PINCTRL_MT2712)	+= pinctrl-mt2712.o
 obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
-obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mt7622.o
+obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mtk-common-v2.o pinctrl-mt7622.o
 obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
 obj-$(CONFIG_PINCTRL_MT6397)	+= pinctrl-mt6397.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 6f931b8..c69dfd7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * MediaTek MT7622 Pinctrl Driver
+ * Copyright (C) 2017-2018 MediaTek Inc.
  *
- * Copyright (C) 2017 Sean Wang <sean.wang@mediatek.com>
+ * Author: Sean Wang <sean.wang@mediatek.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/gpio.h>
@@ -32,6 +25,7 @@
 #include "../pinconf.h"
 #include "../pinmux.h"
 #include "mtk-eint.h"
+#include "pinctrl-mtk-common-v2.h"
 
 #define PINCTRL_PINCTRL_DEV		KBUILD_MODNAME
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
@@ -43,101 +37,10 @@
 		id##_funcs,				\
 	}
 
-#define MTK_GPIO_MODE	1
-#define MTK_INPUT	0
-#define MTK_OUTPUT	1
-#define MTK_DISABLE	0
-#define MTK_ENABLE	1
-
 /* Custom pinconf parameters */
 #define MTK_PIN_CONFIG_TDSEL	(PIN_CONFIG_END + 1)
 #define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
 
-/* List these attributes which could be modified for the pin */
-enum {
-	PINCTRL_PIN_REG_MODE,
-	PINCTRL_PIN_REG_DIR,
-	PINCTRL_PIN_REG_DI,
-	PINCTRL_PIN_REG_DO,
-	PINCTRL_PIN_REG_SR,
-	PINCTRL_PIN_REG_SMT,
-	PINCTRL_PIN_REG_PD,
-	PINCTRL_PIN_REG_PU,
-	PINCTRL_PIN_REG_E4,
-	PINCTRL_PIN_REG_E8,
-	PINCTRL_PIN_REG_TDSEL,
-	PINCTRL_PIN_REG_RDSEL,
-	PINCTRL_PIN_REG_MAX,
-};
-
-/* struct mtk_pin_field - the structure that holds the information of the field
- *			  used to describe the attribute for the pin
- * @offset:		the register offset relative to the base address
- * @mask:		the mask used to filter out the field from the register
- * @bitpos:		the start bit relative to the register
- * @next:		the indication that the field would be extended to the
-			next register
- */
-struct mtk_pin_field {
-	u32 offset;
-	u32 mask;
-	u8  bitpos;
-	u8  next;
-};
-
-/* struct mtk_pin_field_calc - the structure that holds the range providing
- *			       the guide used to look up the relevant field
- * @s_pin:		the start pin within the range
- * @e_pin:		the end pin within the range
- * @s_addr:		the start address for the range
- * @x_addrs:		the address distance between two consecutive registers
- *			within the range
- * @s_bit:		the start bit for the first register within the range
- * @x_bits:		the bit distance between two consecutive pins within
- *			the range
- */
-struct mtk_pin_field_calc {
-	u16 s_pin;
-	u16 e_pin;
-	u32 s_addr;
-	u8  x_addrs;
-	u8  s_bit;
-	u8  x_bits;
-};
-
-/* struct mtk_pin_reg_calc - the structure that holds all ranges used to
- *			     determine which register the pin would make use of
- *			     for certain pin attribute.
- * @range:		     the start address for the range
- * @nranges:		     the number of items in the range
- */
-struct mtk_pin_reg_calc {
-	const struct mtk_pin_field_calc *range;
-	unsigned int nranges;
-};
-
-/* struct mtk_pin_soc - the structure that holds SoC-specific data */
-struct mtk_pin_soc {
-	const struct mtk_pin_reg_calc	*reg_cal;
-	const struct pinctrl_pin_desc	*pins;
-	unsigned int			npins;
-	const struct group_desc		*grps;
-	unsigned int			ngrps;
-	const struct function_desc	*funcs;
-	unsigned int			nfuncs;
-	const struct mtk_eint_regs	*eint_regs;
-	const struct mtk_eint_hw	*eint_hw;
-};
-
-struct mtk_pinctrl {
-	struct pinctrl_dev		*pctrl;
-	void __iomem			*base;
-	struct device			*dev;
-	struct gpio_chip		chip;
-	const struct mtk_pin_soc	*soc;
-	struct mtk_eint			*eint;
-};
-
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
 	{0, 0, 0x320, 0x10, 16, 4},
 	{1, 4, 0x3a0, 0x10,  16, 4},
@@ -936,154 +839,6 @@ static const struct mtk_pin_soc mt7622_data = {
 	.eint_hw = &mt7622_eint_hw,
 };
 
-static void mtk_w32(struct mtk_pinctrl *pctl, u32 reg, u32 val)
-{
-	writel_relaxed(val, pctl->base + reg);
-}
-
-static u32 mtk_r32(struct mtk_pinctrl *pctl, u32 reg)
-{
-	return readl_relaxed(pctl->base + reg);
-}
-
-static void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set)
-{
-	u32 val;
-
-	val = mtk_r32(pctl, reg);
-	val &= ~mask;
-	val |= set;
-	mtk_w32(pctl, reg, val);
-}
-
-static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
-				   const struct mtk_pin_reg_calc *rc,
-				   struct mtk_pin_field *pfd)
-{
-	const struct mtk_pin_field_calc *c, *e;
-	u32 bits;
-
-	c = rc->range;
-	e = c + rc->nranges;
-
-	while (c < e) {
-		if (pin >= c->s_pin && pin <= c->e_pin)
-			break;
-		c++;
-	}
-
-	if (c >= e) {
-		dev_err(hw->dev, "Out of range for pin = %d\n", pin);
-		return -EINVAL;
-	}
-
-	/* Caculated bits as the overall offset the pin is located at */
-	bits = c->s_bit + (pin - c->s_pin) * (c->x_bits);
-
-	/* Fill pfd from bits and 32-bit register applied is assumed */
-	pfd->offset = c->s_addr + c->x_addrs * (bits / 32);
-	pfd->bitpos = bits % 32;
-	pfd->mask = (1 << c->x_bits) - 1;
-
-	/* pfd->next is used for indicating that bit wrapping-around happens
-	 * which requires the manipulation for bit 0 starting in the next
-	 * register to form the complete field read/write.
-	 */
-	pfd->next = pfd->bitpos + c->x_bits - 1 > 31 ? c->x_addrs : 0;
-
-	return 0;
-}
-
-static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw, int pin,
-				int field, struct mtk_pin_field *pfd)
-{
-	const struct mtk_pin_reg_calc *rc;
-
-	if (field < 0 || field >= PINCTRL_PIN_REG_MAX) {
-		dev_err(hw->dev, "Invalid Field %d\n", field);
-		return -EINVAL;
-	}
-
-	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
-		rc = &hw->soc->reg_cal[field];
-	} else {
-		dev_err(hw->dev, "Undefined range for field %d\n", field);
-		return -EINVAL;
-	}
-
-	return mtk_hw_pin_field_lookup(hw, pin, rc, pfd);
-}
-
-static void mtk_hw_bits_part(struct mtk_pin_field *pf, int *h, int *l)
-{
-	*l = 32 - pf->bitpos;
-	*h = get_count_order(pf->mask) - *l;
-}
-
-static void mtk_hw_write_cross_field(struct mtk_pinctrl *hw,
-				     struct mtk_pin_field *pf, int value)
-{
-	int nbits_l, nbits_h;
-
-	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
-
-	mtk_rmw(hw, pf->offset, pf->mask << pf->bitpos,
-		(value & pf->mask) << pf->bitpos);
-
-	mtk_rmw(hw, pf->offset + pf->next, BIT(nbits_h) - 1,
-		(value & pf->mask) >> nbits_l);
-}
-
-static void mtk_hw_read_cross_field(struct mtk_pinctrl *hw,
-				    struct mtk_pin_field *pf, int *value)
-{
-	int nbits_l, nbits_h, h, l;
-
-	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
-
-	l  = (mtk_r32(hw, pf->offset) >> pf->bitpos) & (BIT(nbits_l) - 1);
-	h  = (mtk_r32(hw, pf->offset + pf->next)) & (BIT(nbits_h) - 1);
-
-	*value = (h << nbits_l) | l;
-}
-
-static int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field,
-			    int value)
-{
-	struct mtk_pin_field pf;
-	int err;
-
-	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
-	if (err)
-		return err;
-
-	if (!pf.next)
-		mtk_rmw(hw, pf.offset, pf.mask << pf.bitpos,
-			(value & pf.mask) << pf.bitpos);
-	else
-		mtk_hw_write_cross_field(hw, &pf, value);
-
-	return 0;
-}
-
-static int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field,
-			    int *value)
-{
-	struct mtk_pin_field pf;
-	int err;
-
-	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
-	if (err)
-		return err;
-
-	if (!pf.next)
-		*value = (mtk_r32(hw, pf.offset) >> pf.bitpos) & pf.mask;
-	else
-		mtk_hw_read_cross_field(hw, &pf, value);
-
-	return 0;
-}
-
 static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned int selector, unsigned int group)
 {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
new file mode 100644
index 0000000..a74c3ff
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include "pinctrl-mtk-common-v2.h"
+
+static void mtk_w32(struct mtk_pinctrl *pctl, u32 reg, u32 val)
+{
+	writel_relaxed(val, pctl->base + reg);
+}
+
+static u32 mtk_r32(struct mtk_pinctrl *pctl, u32 reg)
+{
+	return readl_relaxed(pctl->base + reg);
+}
+
+void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set)
+{
+	u32 val;
+
+	val = mtk_r32(pctl, reg);
+	val &= ~mask;
+	val |= set;
+	mtk_w32(pctl, reg, val);
+}
+
+static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
+				   const struct mtk_pin_reg_calc *rc,
+				   struct mtk_pin_field *pfd)
+{
+	const struct mtk_pin_field_calc *c, *e;
+	u32 bits;
+
+	c = rc->range;
+	e = c + rc->nranges;
+
+	while (c < e) {
+		if (pin >= c->s_pin && pin <= c->e_pin)
+			break;
+		c++;
+	}
+
+	if (c >= e) {
+		dev_err(hw->dev, "Out of range for pin = %d\n", pin);
+		return -EINVAL;
+	}
+
+	/* Caculated bits as the overall offset the pin is located at */
+	bits = c->s_bit + (pin - c->s_pin) * (c->x_bits);
+
+	/* Fill pfd from bits and 32-bit register applied is assumed */
+	pfd->offset = c->s_addr + c->x_addrs * (bits / 32);
+	pfd->bitpos = bits % 32;
+	pfd->mask = (1 << c->x_bits) - 1;
+
+	/* pfd->next is used for indicating that bit wrapping-around happens
+	 * which requires the manipulation for bit 0 starting in the next
+	 * register to form the complete field read/write.
+	 */
+	pfd->next = pfd->bitpos + c->x_bits - 1 > 31 ? c->x_addrs : 0;
+
+	return 0;
+}
+
+static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw, int pin,
+				int field, struct mtk_pin_field *pfd)
+{
+	const struct mtk_pin_reg_calc *rc;
+
+	if (field < 0 || field >= PINCTRL_PIN_REG_MAX) {
+		dev_err(hw->dev, "Invalid Field %d\n", field);
+		return -EINVAL;
+	}
+
+	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
+		rc = &hw->soc->reg_cal[field];
+	} else {
+		dev_err(hw->dev, "Undefined range for field %d\n", field);
+		return -EINVAL;
+	}
+
+	return mtk_hw_pin_field_lookup(hw, pin, rc, pfd);
+}
+
+static void mtk_hw_bits_part(struct mtk_pin_field *pf, int *h, int *l)
+{
+	*l = 32 - pf->bitpos;
+	*h = get_count_order(pf->mask) - *l;
+}
+
+static void mtk_hw_write_cross_field(struct mtk_pinctrl *hw,
+				     struct mtk_pin_field *pf, int value)
+{
+	int nbits_l, nbits_h;
+
+	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
+
+	mtk_rmw(hw, pf->offset, pf->mask << pf->bitpos,
+		(value & pf->mask) << pf->bitpos);
+
+	mtk_rmw(hw, pf->offset + pf->next, BIT(nbits_h) - 1,
+		(value & pf->mask) >> nbits_l);
+}
+
+static void mtk_hw_read_cross_field(struct mtk_pinctrl *hw,
+				    struct mtk_pin_field *pf, int *value)
+{
+	int nbits_l, nbits_h, h, l;
+
+	mtk_hw_bits_part(pf, &nbits_h, &nbits_l);
+
+	l  = (mtk_r32(hw, pf->offset) >> pf->bitpos) & (BIT(nbits_l) - 1);
+	h  = (mtk_r32(hw, pf->offset + pf->next)) & (BIT(nbits_h) - 1);
+
+	*value = (h << nbits_l) | l;
+}
+
+int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value)
+{
+	struct mtk_pin_field pf;
+	int err;
+
+	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
+	if (err)
+		return err;
+
+	if (!pf.next)
+		mtk_rmw(hw, pf.offset, pf.mask << pf.bitpos,
+			(value & pf.mask) << pf.bitpos);
+	else
+		mtk_hw_write_cross_field(hw, &pf, value);
+
+	return 0;
+}
+
+int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value)
+{
+	struct mtk_pin_field pf;
+	int err;
+
+	err = mtk_hw_pin_field_get(hw, pin, field, &pf);
+	if (err)
+		return err;
+
+	if (!pf.next)
+		*value = (mtk_r32(hw, pf.offset) >> pf.bitpos) & pf.mask;
+	else
+		mtk_hw_read_cross_field(hw, &pf, value);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
new file mode 100644
index 0000000..b7800c9
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#ifndef __PINCTRL_MTK_COMMON_V2_H
+#define __PINCTRL_MTK_COMMON_V2_H
+
+#define MTK_GPIO_MODE  1
+#define MTK_INPUT      0
+#define MTK_OUTPUT     1
+#define MTK_DISABLE    0
+#define MTK_ENABLE     1
+
+/* List these attributes which could be modified for the pin */
+enum {
+	PINCTRL_PIN_REG_MODE,
+	PINCTRL_PIN_REG_DIR,
+	PINCTRL_PIN_REG_DI,
+	PINCTRL_PIN_REG_DO,
+	PINCTRL_PIN_REG_SR,
+	PINCTRL_PIN_REG_SMT,
+	PINCTRL_PIN_REG_PD,
+	PINCTRL_PIN_REG_PU,
+	PINCTRL_PIN_REG_E4,
+	PINCTRL_PIN_REG_E8,
+	PINCTRL_PIN_REG_TDSEL,
+	PINCTRL_PIN_REG_RDSEL,
+	PINCTRL_PIN_REG_MAX,
+};
+
+/* struct mtk_pin_field - the structure that holds the information of the field
+ *			  used to describe the attribute for the pin
+ * @offset:		the register offset relative to the base address
+ * @mask:		the mask used to filter out the field from the register
+ * @bitpos:		the start bit relative to the register
+ * @next:		the indication that the field would be extended to the
+			next register
+ */
+struct mtk_pin_field {
+	u32 offset;
+	u32 mask;
+	u8  bitpos;
+	u8  next;
+};
+
+/* struct mtk_pin_field_calc - the structure that holds the range providing
+ *			       the guide used to look up the relevant field
+ * @s_pin:		the start pin within the range
+ * @e_pin:		the end pin within the range
+ * @s_addr:		the start address for the range
+ * @x_addrs:		the address distance between two consecutive registers
+ *			within the range
+ * @s_bit:		the start bit for the first register within the range
+ * @x_bits:		the bit distance between two consecutive pins within
+ *			the range
+ */
+struct mtk_pin_field_calc {
+	u16 s_pin;
+	u16 e_pin;
+	u32 s_addr;
+	u8  x_addrs;
+	u8  s_bit;
+	u8  x_bits;
+};
+
+/* struct mtk_pin_reg_calc - the structure that holds all ranges used to
+ *			     determine which register the pin would make use of
+ *			     for certain pin attribute.
+ * @range:		     the start address for the range
+ * @nranges:		     the number of items in the range
+ */
+struct mtk_pin_reg_calc {
+	const struct mtk_pin_field_calc *range;
+	unsigned int nranges;
+};
+
+/* struct mtk_pin_soc - the structure that holds SoC-specific data */
+struct mtk_pin_soc {
+	const struct mtk_pin_reg_calc	*reg_cal;
+	const struct pinctrl_pin_desc	*pins;
+	unsigned int			npins;
+	const struct group_desc		*grps;
+	unsigned int			ngrps;
+	const struct function_desc	*funcs;
+	unsigned int			nfuncs;
+	const struct mtk_eint_regs	*eint_regs;
+	const struct mtk_eint_hw	*eint_hw;
+};
+
+struct mtk_pinctrl {
+	struct pinctrl_dev		*pctrl;
+	void __iomem			*base;
+	struct device			*dev;
+	struct gpio_chip		chip;
+	const struct mtk_pin_soc        *soc;
+	struct mtk_eint			*eint;
+};
+
+void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set);
+
+int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value);
+int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value);
+
+#endif /* __PINCTRL_MTK_COMMON_V2_H */
-- 
2.7.4
