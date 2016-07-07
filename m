From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  8 Jul 2016 00:37:49 +0200
Subject: [PATCH v2 4/6] clk: mvebu Add the time base generator clocks for
 Armada 3700
In-Reply-To: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
References: <1467931071-31004-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1467931071-31004-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks are children of the xtal clock and each one can be selected
as a source for the peripheral clocks.

According to the datasheet it should be possible to modify their rate,
but currently it is not supported.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/Makefile          |   1 +
 drivers/clk/mvebu/armada-37xx-tbg.c | 165 ++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/mvebu/armada-37xx-tbg.c

diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index 4257a36d0219..72e3512a9d4a 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARMADA_375_CLK)	+= armada-375.o
 obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
 obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-xtal.o
+obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-tbg.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
 obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
 obj-$(CONFIG_ARMADA_CP110_SYSCON) += cp110-system-controller.o
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
new file mode 100644
index 000000000000..f4af12593afa
--- /dev/null
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -0,0 +1,165 @@
+/*
+ * Marvell Armada 37xx SoC Time Base Generator clocks
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define NUM_TBG	    4
+
+#define TBG_CTRL0		0x4
+#define TBG_CTRL1		0x8
+#define TBG_CTRL7		0x20
+#define TBG_CTRL8		0x30
+
+#define TBG_DIV_MASK		0x1FF
+
+#define TBG_A_REFDIV		0
+#define TBG_B_REFDIV		16
+
+#define TBG_A_FBDIV		2
+#define TBG_B_FBDIV		18
+
+#define TBG_A_VCODIV_SE		0
+#define TBG_B_VCODIV_SE		16
+
+#define TBG_A_VCODIV_DIFF	1
+#define TBG_B_VCODIV_DIFF	17
+
+struct tbg_def {
+	char *name;
+	u32 refdiv_offset;
+	u32 fbdiv_offset;
+	u32 vcodiv_reg;
+	u32 vcodiv_offset;
+};
+
+const struct tbg_def tbg[NUM_TBG] = {
+	{"TBG-A-P", TBG_A_REFDIV, TBG_A_FBDIV, TBG_CTRL8, TBG_A_VCODIV_DIFF},
+	{"TBG-B-P", TBG_B_REFDIV, TBG_B_FBDIV, TBG_CTRL8, TBG_B_VCODIV_DIFF},
+	{"TBG-A-S", TBG_A_REFDIV, TBG_A_FBDIV, TBG_CTRL1, TBG_A_VCODIV_SE},
+	{"TBG-B-S", TBG_B_REFDIV, TBG_B_FBDIV, TBG_CTRL1, TBG_B_VCODIV_SE},
+};
+
+unsigned int tbg_get_mult(void __iomem *reg, const struct tbg_def *ptbg)
+{
+	u32 val;
+
+	val = readl(reg + TBG_CTRL0);
+
+	return ((val >> ptbg->fbdiv_offset) & TBG_DIV_MASK) << 2;
+}
+
+unsigned int tbg_get_div(void __iomem *reg, const struct tbg_def *ptbg)
+{
+	u32 val;
+	unsigned int div;
+
+	val = readl(reg + TBG_CTRL7);
+
+	div = (val >> ptbg->refdiv_offset) & TBG_DIV_MASK;
+	if (div == 0)
+		div = 1;
+	val = readl(reg + ptbg->vcodiv_reg);
+
+	div *= 1 << ((val >>  ptbg->vcodiv_offset) & TBG_DIV_MASK);
+
+	return div;
+}
+
+
+static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct clk_hw_onecell_data *hw_tbg_data;
+	struct device *dev = &pdev->dev;
+	const char *parent_name;
+	struct resource *res;
+	struct clk *parent;
+	void __iomem *reg;
+	int i, ret;
+
+	hw_tbg_data = devm_kzalloc(&pdev->dev, sizeof(*hw_tbg_data)
+				   + sizeof(*hw_tbg_data->hws) * NUM_TBG,
+				   GFP_KERNEL);
+	if (!hw_tbg_data)
+		return -ENOMEM;
+	hw_tbg_data->num = NUM_TBG;
+	platform_set_drvdata(pdev, hw_tbg_data);
+
+	parent = devm_clk_get(dev, 0);
+	if (IS_ERR(parent)) {
+		dev_err(dev, "Could get the clock parent\n");
+		return -EINVAL;
+	}
+	parent_name = __clk_get_name(parent);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	for (i = 0; i < NUM_TBG; i++) {
+		const char *name;
+		unsigned int mult, div;
+
+		name = tbg[i].name;
+		mult = tbg_get_mult(reg, &tbg[i]);
+		div = tbg_get_div(reg, &tbg[i]);
+		hw_tbg_data->hws[i] = clk_hw_register_fixed_factor(NULL, name,
+						parent_name, 0, mult, div);
+		if (IS_ERR(hw_tbg_data->hws[i]))
+			dev_err(dev, "Can't register TBG clock %s\n", name);
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, hw_tbg_data);
+
+	return ret;
+}
+
+static int armada_3700_tbg_clock_remove(struct platform_device *pdev)
+{
+	int i;
+	struct clk_hw_onecell_data *hw_tbg_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	for (i = 0; i < hw_tbg_data->num; i++)
+		clk_hw_unregister_fixed_factor(hw_tbg_data->hws[i]);
+
+	return 0;
+}
+
+static const struct of_device_id armada_3700_tbg_clock_of_match[] = {
+	{ .compatible = "marvell,armada-3700-tbg-clock", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, armada_3700_tbg_clock_of_match);
+
+static struct platform_driver armada_3700_tbg_clock_driver = {
+	.probe = armada_3700_tbg_clock_probe,
+	.remove = armada_3700_tbg_clock_remove,
+	.driver		= {
+		.name	= "marvell-armada-3700-tbg-clock",
+		.of_match_table = armada_3700_tbg_clock_of_match,
+	},
+};
+
+module_platform_driver(armada_3700_tbg_clock_driver);
+
+MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell Armada 37xx SoC Time Base Generator driver");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0
