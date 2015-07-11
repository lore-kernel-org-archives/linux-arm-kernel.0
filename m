From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 23:48:26 +0200
Subject: [PATCH 1/2] clk: add lpc18xx creg clk driver
In-Reply-To: <1436651307-24098-1-git-send-email-manabian@gmail.com>
References: <1436651307-24098-1-git-send-email-manabian@gmail.com>
Message-ID: <1436651307-24098-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CREG block on lpc18xx contains configuration register
for two low power clocks. Support enabling of these two
clocks with a clk driver that access CREG trough the
syscon regmap interface.

These clocks are needed to support peripherals like the
internal RTC on lpc18xx.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/clk/nxp/Makefile           |   1 +
 drivers/clk/nxp/clk-lpc18xx-creg.c | 173 +++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-creg.c

diff --git a/drivers/clk/nxp/Makefile b/drivers/clk/nxp/Makefile
index 7f608b0ad7b4..6f6b0f9aa320 100644
--- a/drivers/clk/nxp/Makefile
+++ b/drivers/clk/nxp/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ARCH_LPC18XX)	+= clk-lpc18xx-cgu.o
 obj-$(CONFIG_ARCH_LPC18XX)	+= clk-lpc18xx-ccu.o
+obj-$(CONFIG_ARCH_LPC18XX)	+= clk-lpc18xx-creg.o
diff --git a/drivers/clk/nxp/clk-lpc18xx-creg.c b/drivers/clk/nxp/clk-lpc18xx-creg.c
new file mode 100644
index 000000000000..4bca11eca4a1
--- /dev/null
+++ b/drivers/clk/nxp/clk-lpc18xx-creg.c
@@ -0,0 +1,173 @@
+/*
+ * Clk driver for NXP LPC18xx/43xx Configuration Registers (CREG)
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#define LPC18XX_CREG_CREG0			0x004
+#define  LPC18XX_CREG_CREG0_EN1KHZ		BIT(0)
+#define  LPC18XX_CREG_CREG0_EN32KHZ		BIT(1)
+#define  LPC18XX_CREG_CREG0_RESET32KHZ		BIT(2)
+#define  LPC18XX_CREG_CREG0_PD32KHZ		BIT(3)
+
+#define to_clk_creg(_hw) container_of(_hw, struct clk_creg_data, hw)
+
+enum {
+	CREG_CLK_1KHZ,
+	CREG_CLK_32KHZ,
+	CREG_CLK_MAX,
+};
+
+struct clk_creg_data {
+	struct clk_hw hw;
+	const char *name;
+	struct regmap *reg;
+	unsigned int en_mask;
+	const struct clk_ops *ops;
+};
+
+#define CREG_CLK(_name, _emask, _ops)		\
+{						\
+	.name = _name,				\
+	.en_mask = LPC18XX_CREG_CREG0_##_emask,	\
+	.ops = &_ops,				\
+}
+
+static int clk_creg_32k_prepare(struct clk_hw *hw)
+{
+	struct clk_creg_data *creg = to_clk_creg(hw);
+	int ret;
+
+	ret = regmap_update_bits(creg->reg, LPC18XX_CREG_CREG0,
+				 LPC18XX_CREG_CREG0_PD32KHZ |
+				 LPC18XX_CREG_CREG0_RESET32KHZ, 0);
+
+	/*
+	 * Powering up the 32k oscillator takes a long while
+	 * and sadly there aren't any status bit to poll.
+	 */
+	msleep(2500);
+
+	return ret;
+}
+
+static void clk_creg_32k_unprepare(struct clk_hw *hw)
+{
+	struct clk_creg_data *creg = to_clk_creg(hw);
+
+	regmap_update_bits(creg->reg, LPC18XX_CREG_CREG0,
+			   LPC18XX_CREG_CREG0_PD32KHZ,
+			   LPC18XX_CREG_CREG0_PD32KHZ);
+}
+
+static int clk_creg_32k_is_prepared(struct clk_hw *hw)
+{
+	struct clk_creg_data *creg = to_clk_creg(hw);
+	u32 reg;
+
+	regmap_read(creg->reg, LPC18XX_CREG_CREG0, &reg);
+
+	return !(reg & LPC18XX_CREG_CREG0_PD32KHZ) &&
+	       !(reg & LPC18XX_CREG_CREG0_RESET32KHZ);
+}
+
+static unsigned long clk_creg_1k_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return parent_rate / 32;
+}
+
+static int clk_creg_enable(struct clk_hw *hw)
+{
+	struct clk_creg_data *creg = to_clk_creg(hw);
+
+	return regmap_update_bits(creg->reg, LPC18XX_CREG_CREG0,
+				  creg->en_mask, creg->en_mask);
+}
+
+static void clk_creg_disable(struct clk_hw *hw)
+{
+	struct clk_creg_data *creg = to_clk_creg(hw);
+
+	regmap_update_bits(creg->reg, LPC18XX_CREG_CREG0,
+			   creg->en_mask, 0);
+}
+
+static const struct clk_ops clk_creg_32k = {
+	.enable		= clk_creg_enable,
+	.disable	= clk_creg_disable,
+	.prepare	= clk_creg_32k_prepare,
+	.unprepare	= clk_creg_32k_unprepare,
+	.is_prepared	= clk_creg_32k_is_prepared,
+};
+
+static const struct clk_ops clk_creg_1k = {
+	.enable		= clk_creg_enable,
+	.disable	= clk_creg_disable,
+	.recalc_rate	= clk_creg_1k_recalc_rate,
+};
+
+static struct clk_creg_data clk_creg_clocks[] = {
+	[CREG_CLK_1KHZ]  = CREG_CLK("1khz_clk",  EN1KHZ,  clk_creg_1k),
+	[CREG_CLK_32KHZ] = CREG_CLK("32khz_clk", EN32KHZ, clk_creg_32k),
+};
+
+static struct clk *clk_register_creg_clk(struct clk_creg_data *creg_clk,
+					 const char **parent_name,
+					 struct regmap *syscon)
+{
+	struct clk_init_data init;
+
+	init.ops = creg_clk->ops;
+	init.name = creg_clk->name;
+	init.parent_names = parent_name;
+	init.num_parents = 1;
+
+	creg_clk->reg = syscon;
+	creg_clk->hw.init = &init;
+
+	return clk_register(NULL, &creg_clk->hw);
+}
+
+static struct clk *clk_creg[CREG_CLK_MAX];
+static struct clk_onecell_data clk_base_data = {
+	.clks = clk_creg,
+	.clk_num = CREG_CLK_MAX,
+};
+
+static void __init lpc18xx_creg_clk_init(struct device_node *np)
+{
+	const char *clk_32khz_parent;
+	struct regmap *syscon;
+
+	syscon = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(syscon)) {
+		pr_err("%s: syscon lookup failed\n", __func__);
+		return;
+	}
+
+	clk_32khz_parent = of_clk_get_parent_name(np, 0);
+
+	clk_creg[CREG_CLK_32KHZ] =
+		clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_32KHZ],
+				      &clk_32khz_parent, syscon);
+
+	clk_creg[CREG_CLK_1KHZ] =
+		clk_register_creg_clk(&clk_creg_clocks[CREG_CLK_1KHZ],
+				      &clk_creg_clocks[CREG_CLK_32KHZ].name,
+				      syscon);
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_base_data);
+}
+CLK_OF_DECLARE(lpc18xx_creg_clk, "nxp,lpc1850-creg-clk", lpc18xx_creg_clk_init);
-- 
1.8.0
