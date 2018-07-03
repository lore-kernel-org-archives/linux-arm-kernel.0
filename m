From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 3 Jul 2018 14:57:16 +0000
Subject: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
In-Reply-To: <20180703145716.31860-1-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
Message-ID: <20180703145716.31860-4-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will add a EMMC clock controller driver support,
It provide a mux and divider clock.

This clock driver can be protentially used by either EMMC and
NAND driver.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/Kconfig     |   9 +++
 drivers/clk/meson/Makefile    |   1 +
 drivers/clk/meson/emmc-clkc.c | 136 ++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/clk/meson/emmc-clkc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index efaa70f682b4..2f27ff08e4eb 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
 	select COMMON_CLK_REGMAP_MESON
 	select RESET_CONTROLLER
 
+config COMMON_CLK_EMMC_MESON
+	tristate "Meson EMMC Sub Clock Controller Driver"
+	depends on COMMON_CLK_AMLOGIC
+	select MFD_SYSCON
+	select REGMAP
+	help
+	  Support for the EMMC sub clock controller on AmLogic Meson Platform,
+	  Say Y if you want this clock enabled.
+
 config COMMON_CLK_REGMAP_MESON
 	bool
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c40d848..2f04f77ba4de 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
+obj-$(CONFIG_COMMON_CLK_EMMC_MESON) 	+= emmc-clkc.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/emmc-clkc.c b/drivers/clk/meson/emmc-clkc.c
new file mode 100644
index 000000000000..cf5bb9f34327
--- /dev/null
+++ b/drivers/clk/meson/emmc-clkc.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson EMMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/emmc-clkc.h>
+
+#include "clkc.h"
+
+#define SD_EMMC_CLOCK		0
+#define MUX_CLK_NUM_PARENTS	2
+#define EMMC_MAX_CLKS		2
+#define CLK_NAME_LEN		48
+
+static struct clk_regmap_mux_data emmc_clkc_mux_data = {
+	.offset = SD_EMMC_CLOCK,
+	.mask = 0x3,
+	.shift = 6,
+};
+
+static struct clk_regmap_div_data emmc_clkc_div_data = {
+	.offset = SD_EMMC_CLOCK,
+	.shift = 0,
+	.width = 6,
+	.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
+};
+
+static const struct of_device_id clkc_match_table[] = {
+	{ .compatible = "amlogic,emmc-clkc" },
+	{}
+};
+
+static int emmc_clkc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_regmap *mux, *div;
+	struct regmap *map;
+	struct clk *clk;
+	int i, ret;
+	const char *parent_names[MUX_CLK_NUM_PARENTS];
+	struct clk_init_data init;
+	char mux_name[CLK_NAME_LEN], div_name[CLK_NAME_LEN];
+	struct clk_hw_onecell_data *onecell_data;
+
+	map = syscon_node_to_regmap(dev->of_node);
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+
+	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
+				    sizeof(*onecell_data->hws) * EMMC_MAX_CLKS,
+				    GFP_KERNEL);
+
+	if (!mux || !div || !onecell_data)
+		return -ENOMEM;
+
+	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
+		char name[8];
+
+		snprintf(name, sizeof(name), "clkin%d", i);
+		clk = devm_clk_get(dev, name);
+		if (IS_ERR(clk)) {
+			if (clk != ERR_PTR(-EPROBE_DEFER))
+				dev_err(dev, "Missing clock %s\n", name);
+			return PTR_ERR(clk);
+		}
+
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	mux->map = map;
+	mux->data = &emmc_clkc_mux_data;
+
+	snprintf(mux_name, CLK_NAME_LEN, "%s#emmc_mux", dev_name(dev));
+
+	init.name = mux_name;
+	init.ops = &clk_regmap_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.num_parents = MUX_CLK_NUM_PARENTS;
+
+	mux->hw.init = &init;
+	ret = devm_clk_hw_register(dev, &mux->hw);
+	if (ret) {
+		dev_err(dev, "Mux clock registration failed\n");
+		return ret;
+	}
+
+	parent_names[0] = mux_name;
+	div->map = map;
+	div->data = &emmc_clkc_div_data;
+
+	snprintf(div_name, CLK_NAME_LEN, "%s#emmc_div", dev_name(dev));
+
+	init.name = div_name;
+	init.ops = &clk_regmap_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div->hw.init = &init;
+	ret = devm_clk_hw_register(dev, &div->hw);
+	if (ret) {
+		dev_err(dev, "Div clock registration failed\n");
+		return ret;
+	}
+
+	onecell_data->hws[CLKID_EMMC_C_MUX] = &mux->hw,
+	onecell_data->hws[CLKID_EMMC_C_DIV] = &div->hw,
+	onecell_data->num = EMMC_MAX_CLKS;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   onecell_data);
+}
+
+static struct platform_driver emmc_clkc_driver = {
+	.probe		= emmc_clkc_probe,
+	.driver		= {
+		.name	= "emmc-clkc",
+		.of_match_table = clkc_match_table,
+	},
+};
+
+builtin_platform_driver(emmc_clkc_driver);
-- 
2.18.0
