From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 28 Jul 2017 11:53:07 +0200
Subject: [PATCH v2 2/4] clk: meson: gxbb-aoclk: Switch to regmap for register
 access
In-Reply-To: <1501235589-318-1-git-send-email-narmstrong@baylibre.com>
References: <1501235589-318-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1501235589-318-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the aoclk driver to use the new bindings and switch all the
registers access to regmap only.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Makefile            |  2 +-
 drivers/clk/meson/gxbb-aoclk-regmap.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb-aoclk.c        | 44 ++++++++++++++++-----------------
 drivers/clk/meson/gxbb-aoclk.h        | 26 ++++++++++++++++++++
 4 files changed, 95 insertions(+), 23 deletions(-)
 create mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c
 create mode 100644 drivers/clk/meson/gxbb-aoclk.h

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 83b6d9d..de65427 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
+obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o
diff --git a/drivers/clk/meson/gxbb-aoclk-regmap.c b/drivers/clk/meson/gxbb-aoclk-regmap.c
new file mode 100644
index 0000000..2515fbf
--- /dev/null
+++ b/drivers/clk/meson/gxbb-aoclk-regmap.c
@@ -0,0 +1,46 @@
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
+static int aoclk_gate_regmap_enable(struct clk_hw *hw)
+{
+	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
+
+	return regmap_update_bits(gate->regmap, AO_RTI_GEN_CNTL_REG0,
+				  BIT(gate->bit_idx), BIT(gate->bit_idx));
+}
+
+static void aoclk_gate_regmap_disable(struct clk_hw *hw)
+{
+	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
+
+	regmap_update_bits(gate->regmap, AO_RTI_GEN_CNTL_REG0,
+			   BIT(gate->bit_idx), 0);
+}
+
+static int aoclk_gate_regmap_is_enabled(struct clk_hw *hw)
+{
+	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(gate->regmap, AO_RTI_GEN_CNTL_REG0, &val);
+	if (ret)
+		return ret;
+
+	return (val & BIT(gate->bit_idx)) != 0;
+}
+
+const struct clk_ops meson_aoclk_gate_regmap_ops = {
+	.enable = aoclk_gate_regmap_enable,
+	.disable = aoclk_gate_regmap_disable,
+	.is_enabled = aoclk_gate_regmap_is_enabled,
+};
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index b45c5fb..f61506c 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -56,16 +56,19 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/init.h>
 #include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/reset/gxbb-aoclkc.h>
+#include "gxbb-aoclk.h"
 
 static DEFINE_SPINLOCK(gxbb_aoclk_lock);
 
 struct gxbb_aoclk_reset_controller {
 	struct reset_controller_dev reset;
 	unsigned int *data;
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
 static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
@@ -74,9 +77,8 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 	struct gxbb_aoclk_reset_controller *reset =
 		container_of(rcdev, struct gxbb_aoclk_reset_controller, reset);
 
-	writel(BIT(reset->data[id]), reset->base);
-
-	return 0;
+	return regmap_write(reset->regmap, AO_RTI_GEN_CNTL_REG0,
+			    BIT(reset->data[id]));
 }
 
 static const struct reset_control_ops gxbb_aoclk_reset_ops = {
@@ -84,13 +86,12 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 };
 
 #define GXBB_AO_GATE(_name, _bit)					\
-static struct clk_gate _name##_ao = {					\
-	.reg = (void __iomem *)0,					\
+static struct aoclk_gate_regmap _name##_ao = {				\
 	.bit_idx = (_bit),						\
 	.lock = &gxbb_aoclk_lock,					\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name "_ao",					\
-		.ops = &clk_gate_ops,					\
+		.ops = &meson_aoclk_gate_regmap_ops,			\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
 		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
@@ -113,7 +114,7 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 	[RESET_AO_IR_BLASTER] = 23,
 };
 
-static struct clk_gate *gxbb_aoclk_gate[] = {
+static struct aoclk_gate_regmap *gxbb_aoclk_gate[] = {
 	[CLKID_AO_REMOTE] = &remote_ao,
 	[CLKID_AO_I2C_MASTER] = &i2c_master_ao,
 	[CLKID_AO_I2C_SLAVE] = &i2c_slave_ao,
@@ -136,24 +137,23 @@ static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
 
 static int gxbb_aoclkc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-	void __iomem *base;
-	int ret, clkid;
-	struct device *dev = &pdev->dev;
 	struct gxbb_aoclk_reset_controller *rstc;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret, clkid;
 
 	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
 		return -ENOMEM;
 
-	/* Generic clocks */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap\n");
+		return -ENODEV;
+	}
 
 	/* Reset Controller */
-	rstc->base = base;
+	rstc->regmap = regmap;
 	rstc->data = gxbb_aoclk_reset;
 	rstc->reset.ops = &gxbb_aoclk_reset_ops;
 	rstc->reset.nr_resets = ARRAY_SIZE(gxbb_aoclk_reset);
@@ -161,10 +161,10 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 	ret = devm_reset_controller_register(dev, &rstc->reset);
 
 	/*
-	 * Populate base address and register all clks
+	 * Populate regmap and register all clks
 	 */
-	for (clkid = 0; clkid < gxbb_aoclk_onecell_data.num; clkid++) {
-		gxbb_aoclk_gate[clkid]->reg = base;
+	for (clkid = 0; clkid < ARRAY_SIZE(gxbb_aoclk_gate); clkid++) {
+		gxbb_aoclk_gate[clkid]->regmap = regmap;
 
 		ret = devm_clk_hw_register(dev,
 					gxbb_aoclk_onecell_data.hws[clkid]);
@@ -177,7 +177,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
-	{ .compatible = "amlogic,gxbb-aoclkc" },
+	{ .compatible = "amlogic,meson-gx-aoclkc" },
 	{ }
 };
 
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
new file mode 100644
index 0000000..2e26108
--- /dev/null
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+
+#ifndef __GXBB_AOCLKC_H
+#define __GXBB_AOCLKC_H
+
+/* AO Configuration Clock registers offsets */
+#define AO_RTI_GEN_CNTL_REG0	0x40
+
+struct aoclk_gate_regmap {
+	struct clk_hw hw;
+	unsigned bit_idx;
+	struct regmap *regmap;
+	spinlock_t *lock;
+};
+
+#define to_aoclk_gate_regmap(_hw) \
+	container_of(_hw, struct aoclk_gate_regmap, hw)
+
+extern const struct clk_ops meson_aoclk_gate_regmap_ops;
+
+#endif /* __GXBB_AOCLKC_H */
-- 
1.9.1
