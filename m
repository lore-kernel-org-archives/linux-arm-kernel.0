From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Nov 2018 15:57:34 +0100
Subject: [PATCH v2 1/4] clk: meson: Add vid_pll divider driver
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1541516257-16157-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support the VID_PLL fully programmable divider used right after the
HDMI PLL clock source. It is used to achieve complex fractional division
with a programmble bitfield.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Makefile      |  2 +-
 drivers/clk/meson/clkc.h        |  6 +++
 drivers/clk/meson/vid-pll-div.c | 91 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c4..0234767 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6b96d55..9166605 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -90,6 +90,11 @@ struct meson_clk_phase_data {
 int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
 unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
 
+struct meson_vid_pll_div_data {
+	struct parm val;
+	struct parm sel;
+};
+
 #define MESON_GATE(_name, _reg, _bit)					\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data){				\
@@ -112,5 +117,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_vid_pll_div_ro_ops;
 
 #endif /* __CLKC_H */
diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
new file mode 100644
index 0000000..b3370ea
--- /dev/null
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+static inline struct meson_vid_pll_div_data *
+meson_vid_pll_div_data(struct clk_regmap *clk)
+{
+	return (struct meson_vid_pll_div_data *)clk->data;
+}
+
+/*
+ * This vid_pll divided is a fully programmable fractionnal divider to
+ * achieve complex video clock rates.
+ *
+ * Here are provided the commonly used fraction values provided by Amlogic.
+ */
+
+struct vid_pll_div {
+	unsigned int shift_val;
+	unsigned int shift_sel;
+	unsigned int divider;
+	unsigned int multiplier;
+};
+
+#define VID_PLL_DIV(_val, _sel, _ft, _fb)				\
+	{								\
+		.shift_val = (_val),					\
+		.shift_sel = (_sel),					\
+		.divider = (_ft),					\
+		.multiplier = (_fb),					\
+	}
+
+static const struct vid_pll_div vid_pll_div_table[] = {
+	VID_PLL_DIV(0x0aaa, 0, 2, 1),	/* 2/1  => /2 */
+	VID_PLL_DIV(0x5294, 2, 5, 2),	/* 5/2  => /2.5 */
+	VID_PLL_DIV(0x0db6, 0, 3, 1),	/* 3/1  => /3 */
+	VID_PLL_DIV(0x36cc, 1, 7, 2),	/* 7/2  => /3.5 */
+	VID_PLL_DIV(0x6666, 2, 15, 4),	/* 15/4 => /3.75 */
+	VID_PLL_DIV(0x0ccc, 0, 4, 1),	/* 4/1  => /4 */
+	VID_PLL_DIV(0x739c, 2, 5, 1),	/* 5/1  => /5 */
+	VID_PLL_DIV(0x0e38, 0, 6, 1),	/* 6/1  => /6 */
+	VID_PLL_DIV(0x0000, 3, 25, 4),	/* 25/4 => /6.25 */
+	VID_PLL_DIV(0x3c78, 1, 7, 1),	/* 7/1  => /7 */
+	VID_PLL_DIV(0x78f0, 2, 15, 2),	/* 15/2 => /7.5 */
+	VID_PLL_DIV(0x0fc0, 0, 12, 1),	/* 12/1 => /12 */
+	VID_PLL_DIV(0x3f80, 1, 14, 1),	/* 14/1 => /14 */
+	VID_PLL_DIV(0x7f80, 2, 15, 1),	/* 15/1 => /15 */
+};
+
+#define to_meson_vid_pll_div(_hw) \
+	container_of(_hw, struct meson_vid_pll_div, hw)
+
+const struct vid_pll_div *_get_table_val(unsigned int shift_val,
+					 unsigned int shift_sel)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
+		if (vid_pll_div_table[i].shift_val == shift_val &&
+		    vid_pll_div_table[i].shift_sel == shift_sel)
+			return &vid_pll_div_table[i];
+	}
+
+	return NULL;
+}
+
+static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
+	const struct vid_pll_div *div;
+
+	div = _get_table_val(meson_parm_read(clk->map, &pll_div->val),
+			     meson_parm_read(clk->map, &pll_div->sel));
+	if (!div || !div->divider) {
+		pr_info("%s: Invalid config value for vid_pll_div\n", __func__);
+		return parent_rate;
+	}
+
+	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
+}
+
+const struct clk_ops meson_vid_pll_div_ro_ops = {
+	.recalc_rate	= meson_vid_pll_div_recalc_rate,
+};
-- 
2.7.4
