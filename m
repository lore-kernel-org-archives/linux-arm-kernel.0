From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:49 +0200
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the ARM syscon ICST clocks to initialized
directly from the device tree syscon node on ARM Integrator,
Versatile and RealView reference designs.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm looking for an ACK from the CLK maintainers to take this
through the ARM SoC tree once the series stabilize.
---
 drivers/clk/versatile/clk-icst.c | 89 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index ab5d5f73818b..b2dc06923ac1 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -3,7 +3,7 @@
  * We wrap the custom interface from <asm/hardware/icst.h> into the generic
  * clock framework.
  *
- * Copyright (C) 2012 Linus Walleij
+ * Copyright (C) 2012-2015 Linus Walleij
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -207,3 +207,90 @@ struct clk *icst_clk_register(struct device *dev,
 	return icst_clk_setup(dev, desc, name, parent_name, map);
 }
 EXPORT_SYMBOL_GPL(icst_clk_register);
+
+#ifdef CONFIG_OF
+/*
+ * In a device tree, an memory-mapped ICST clock appear as a child
+ * of a syscon node. Assume this and probe it only as a child of a
+ * syscon.
+ */
+
+static const struct icst_params icst525_params = {
+	.vco_max	= ICST525_VCO_MAX_5V,
+	.vco_min	= ICST525_VCO_MIN,
+	.vd_min 	= 8,
+	.vd_max 	= 263,
+	.rd_min 	= 3,
+	.rd_max 	= 65,
+	.s2div		= icst525_s2div,
+	.idx2s		= icst525_idx2s,
+};
+
+static const struct icst_params icst307_params = {
+	.vco_max	= ICST307_VCO_MAX,
+	.vco_min	= ICST307_VCO_MIN,
+	.vd_min		= 4 + 8,
+	.vd_max		= 511 + 8,
+	.rd_min		= 1 + 2,
+	.rd_max		= 127 + 2,
+	.s2div		= icst307_s2div,
+	.idx2s		= icst307_idx2s,
+};
+
+static void __init of_syscon_icst_setup(struct device_node *np)
+{
+	struct device_node *parent;
+	struct regmap *map;
+	struct clk_icst_desc icst_desc;
+	const char *name = np->name;
+	const char *parent_name;
+	struct clk *regclk;
+
+	/* We do not release this reference, we are using it perpetually */
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_err("no parent node for syscon ICST clock\n");
+		return;
+	}
+	map = syscon_node_to_regmap(parent);
+	if (IS_ERR(map)) {
+		pr_err("no regmap for syscon ICST clock parent\n");
+		return;
+	}
+
+	if (of_property_read_u32(np, "vco-offset", &icst_desc.vco_offset)) {
+		pr_err("no VCO register offset for ICST clock\n");
+		return;
+	}
+	if (of_property_read_u32(np, "lock-offset", &icst_desc.lock_offset)) {
+		pr_err("no lock register offset for ICST clock\n");
+		return;
+	}
+
+	if (of_device_is_compatible(np, "arm,syscon-icst525"))
+		icst_desc.params = &icst525_params;
+	else if (of_device_is_compatible(np, "arm,syscon-icst307"))
+		icst_desc.params = &icst307_params;
+	else {
+		pr_info("unknown ICST clock %s\n", name);
+		return;
+	}
+
+	/* Parent clock name is not the same as node parent */
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	regclk = icst_clk_setup(NULL, &icst_desc, name, parent_name, map);
+	if (IS_ERR(regclk)) {
+		pr_err("error setting up syscon ICST clock %s\n", name);
+		return;
+	}
+	of_clk_add_provider(np, of_clk_src_simple_get, regclk);
+	pr_info("registered syscon ICST clock %s\n", name);
+}
+
+CLK_OF_DECLARE(arm_syscon_icst525_clk,
+	       "arm,syscon-icst525", of_syscon_icst_setup);
+CLK_OF_DECLARE(arm_syscon_icst307_clk,
+	       "arm,syscon-icst307", of_syscon_icst_setup);
+
+#endif
-- 
2.4.3
