From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Jul 2017 14:42:37 +0200
Subject: [PATCH v3 4/4] clk: meson: gxbb-aoclk: Add CEC 32k clock
In-Reply-To: <1501504957-19476-1-git-send-email-narmstrong@baylibre.com>
References: <1501504957-19476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1501504957-19476-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CEC 32K AO Clock is a dual divider with dual counter to provide a more
precise 32768Hz clock for the CEC subsystem from the external xtal.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Makefile         |   2 +-
 drivers/clk/meson/gxbb-aoclk-32k.c | 194 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb-aoclk.c     |  21 +++-
 drivers/clk/meson/gxbb-aoclk.h     |  16 +++
 4 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index de65427..b139d41 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o
+obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o gxbb-aoclk-32k.o
diff --git a/drivers/clk/meson/gxbb-aoclk-32k.c b/drivers/clk/meson/gxbb-aoclk-32k.c
new file mode 100644
index 0000000..c11eabd
--- /dev/null
+++ b/drivers/clk/meson/gxbb-aoclk-32k.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include "gxbb-aoclk.h"
+
+/*
+ * The AO Domain embeds a dual/divider to generate a more precise
+ * 32,768KHz clock for low-power suspend mode and CEC.
+ *                      ______   ______
+ *                     |      | |      |
+ *         ______      | Div1 |-| Cnt1 |       ______
+ *        |      |    /|______| |______|\     |      |
+ * Xtal-->| Gate |---|  ______   ______  X-X--| Gate |-->
+ *        |______| |  \|      | |      |/  |  |______|
+ *                 |   | Div2 |-| Cnt2 |   |
+ *                 |   |______| |______|   |
+ *                 |_______________________|
+ *
+ * The dividing can be switched to single or dual, with a counter
+ * for each divider to set when the switching is done.
+ * The entire dividing mechanism can be also bypassed.
+ */
+
+#define CLK_CNTL0_N1_MASK	GENMASK(11, 0)
+#define CLK_CNTL0_N2_MASK	GENMASK(23, 12)
+#define CLK_CNTL0_DUALDIV_EN	BIT(28)
+#define CLK_CNTL0_OUT_GATE_EN	BIT(30)
+#define CLK_CNTL0_IN_GATE_EN	BIT(31)
+
+#define CLK_CNTL1_M1_MASK	GENMASK(11, 0)
+#define CLK_CNTL1_M2_MASK	GENMASK(23, 12)
+#define CLK_CNTL1_BYPASS_EN	BIT(24)
+#define CLK_CNTL1_SELECT_OSC	BIT(27)
+
+#define PWR_CNTL_ALT_32K_SEL	GENMASK(13, 10)
+
+struct cec_32k_freq_table {
+	unsigned long parent_rate;
+	unsigned long target_rate;
+	bool dualdiv;
+	unsigned int n1;
+	unsigned int n2;
+	unsigned int m1;
+	unsigned int m2;
+};
+
+static const struct cec_32k_freq_table aoclk_cec_32k_table[] = {
+	[0] = {
+		.parent_rate = 24000000,
+		.target_rate = 32768,
+		.dualdiv = true,
+		.n1 = 733,
+		.n2 = 732,
+		.m1 = 8,
+		.m2 = 11,
+	},
+};
+
+/*
+ * If CLK_CNTL0_DUALDIV_EN == 0
+ *  - will use N1 divider only
+ * If CLK_CNTL0_DUALDIV_EN == 1
+ *  - hold M1 cycles of N1 divider then changes to N2
+ *  - hold M2 cycles of N2 divider then changes to N1
+ * Then we can get more accurate division.
+ */
+static unsigned long aoclk_cec_32k_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct aoclk_cec_32k *cec_32k = to_aoclk_cec_32k(hw);
+	unsigned long n1;
+	u32 reg0, reg1;
+
+	regmap_read(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, &reg0);
+	regmap_read(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL1, &reg1);
+
+	if (reg1 & CLK_CNTL1_BYPASS_EN)
+		return parent_rate;
+
+	if (reg0 & CLK_CNTL0_DUALDIV_EN) {
+		unsigned long n2, m1, m2, f1, f2, p1, p2;
+
+		n1 = FIELD_GET(CLK_CNTL0_N1_MASK, reg0) + 1;
+		n2 = FIELD_GET(CLK_CNTL0_N2_MASK, reg0) + 1;
+
+		m1 = FIELD_GET(CLK_CNTL1_M1_MASK, reg1) + 1;
+		m2 = FIELD_GET(CLK_CNTL1_M2_MASK, reg1) + 1;
+
+		f1 = DIV_ROUND_CLOSEST(parent_rate, n1);
+		f2 = DIV_ROUND_CLOSEST(parent_rate, n2);
+
+		p1 = DIV_ROUND_CLOSEST(100000000 * m1, f1 * (m1 + m2));
+		p2 = DIV_ROUND_CLOSEST(100000000 * m2, f2 * (m1 + m2));
+
+		return DIV_ROUND_UP(100000000, p1 + p2);
+	}
+
+	n1 = FIELD_GET(CLK_CNTL0_N1_MASK, reg0) + 1;
+
+	return DIV_ROUND_CLOSEST(parent_rate, n1);
+}
+
+static const struct cec_32k_freq_table *find_cec_32k_freq(unsigned long rate,
+							  unsigned long prate)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(aoclk_cec_32k_table) ; ++i)
+		if (aoclk_cec_32k_table[i].parent_rate == prate &&
+		    aoclk_cec_32k_table[i].target_rate == rate)
+			return &aoclk_cec_32k_table[i];
+
+	return NULL;
+}
+
+static long aoclk_cec_32k_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *prate)
+{
+	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
+								  *prate);
+
+	/* If invalid return first one */
+	if (!freq)
+		return aoclk_cec_32k_table[0].target_rate;
+
+	return freq->target_rate;
+}
+
+/*
+ * From the Amlogic init procedure, the IN and OUT gates needs to be handled
+ * in the init procedure to avoid any glitches.
+ */
+
+static int aoclk_cec_32k_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
+								  parent_rate);
+	struct aoclk_cec_32k *cec_32k = to_aoclk_cec_32k(hw);
+	u32 reg = 0;
+
+	if (!freq)
+		return -EINVAL;
+
+	/* Disable clock */
+	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
+			   CLK_CNTL0_IN_GATE_EN | CLK_CNTL0_OUT_GATE_EN, 0);
+
+	reg = FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1);
+	if (freq->dualdiv)
+		reg |= CLK_CNTL0_DUALDIV_EN |
+		       FIELD_PREP(CLK_CNTL0_N2_MASK, freq->n2 - 1);
+
+	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, reg);
+
+	reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1);
+	if (freq->dualdiv)
+		reg = FIELD_PREP(CLK_CNTL1_M2_MASK, freq->m2 - 1);
+
+	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL1, reg);
+
+	/* Enable clock */
+	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
+			   CLK_CNTL0_IN_GATE_EN, CLK_CNTL0_IN_GATE_EN);
+
+	udelay(200);
+
+	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
+			   CLK_CNTL0_OUT_GATE_EN, CLK_CNTL0_OUT_GATE_EN);
+
+	regmap_update_bits(cec_32k->regmap, AO_CRT_CLK_CNTL1,
+			   CLK_CNTL1_SELECT_OSC, CLK_CNTL1_SELECT_OSC);
+
+	/* Select 32k from XTAL */
+	regmap_update_bits(cec_32k->regmap,
+			  AO_RTI_PWR_CNTL_REG0,
+			  PWR_CNTL_ALT_32K_SEL,
+			  FIELD_PREP(PWR_CNTL_ALT_32K_SEL, 4));
+
+	return 0;
+}
+
+const struct clk_ops meson_aoclk_cec_32k_ops = {
+	.recalc_rate = aoclk_cec_32k_recalc_rate,
+	.round_rate = aoclk_cec_32k_round_rate,
+	.set_rate = aoclk_cec_32k_set_rate,
+};
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index f61506c..6c161e0 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -59,6 +59,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/reset/gxbb-aoclkc.h>
 #include "gxbb-aoclk.h"
@@ -105,6 +106,17 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 GXBB_AO_GATE(uart2, 5);
 GXBB_AO_GATE(ir_blaster, 6);
 
+static struct aoclk_cec_32k cec_32k_ao = {
+	.lock = &gxbb_aoclk_lock,
+	.hw.init = &(struct clk_init_data) {
+		.name = "cec_32k_ao",
+		.ops = &meson_aoclk_cec_32k_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+		.flags = CLK_IGNORE_UNUSED,
+	},
+};
+
 static unsigned int gxbb_aoclk_reset[] = {
 	[RESET_AO_REMOTE] = 16,
 	[RESET_AO_I2C_MASTER] = 18,
@@ -131,8 +143,9 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 		[CLKID_AO_UART1] = &uart1_ao.hw,
 		[CLKID_AO_UART2] = &uart2_ao.hw,
 		[CLKID_AO_IR_BLASTER] = &ir_blaster_ao.hw,
+		[CLKID_AO_CEC_32K] = &cec_32k_ao.hw,
 	},
-	.num = ARRAY_SIZE(gxbb_aoclk_gate),
+	.num = 7,
 };
 
 static int gxbb_aoclkc_probe(struct platform_device *pdev)
@@ -172,6 +185,12 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	/* Specific clocks */
+	cec_32k_ao.regmap = regmap;
+	ret = devm_clk_hw_register(dev, &cec_32k_ao.hw);
+	if (ret)
+		return ret;
+
 	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
 			&gxbb_aoclk_onecell_data);
 }
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index 2e26108..e8604c8 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -9,7 +9,13 @@
 #define __GXBB_AOCLKC_H
 
 /* AO Configuration Clock registers offsets */
+#define AO_RTI_PWR_CNTL_REG1	0x0c
+#define AO_RTI_PWR_CNTL_REG0	0x10
 #define AO_RTI_GEN_CNTL_REG0	0x40
+#define AO_OSCIN_CNTL		0x58
+#define AO_CRT_CLK_CNTL1	0x68
+#define AO_RTC_ALT_CLK_CNTL0	0x94
+#define AO_RTC_ALT_CLK_CNTL1	0x98
 
 struct aoclk_gate_regmap {
 	struct clk_hw hw;
@@ -23,4 +29,14 @@ struct aoclk_gate_regmap {
 
 extern const struct clk_ops meson_aoclk_gate_regmap_ops;
 
+struct aoclk_cec_32k {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	spinlock_t *lock;
+};
+
+#define to_aoclk_cec_32k(_hw) container_of(_hw, struct aoclk_cec_32k, hw)
+
+extern const struct clk_ops meson_aoclk_cec_32k_ops;
+
 #endif /* __GXBB_AOCLKC_H */
-- 
1.9.1
