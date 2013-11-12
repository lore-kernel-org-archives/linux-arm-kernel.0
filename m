From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 12 Nov 2013 23:05:35 +0100
Subject: [PATCH v5 08/17] clk: at91: add PMC system clocks
In-Reply-To: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1384293935-4755-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new at91 system clock implementation using common clk
framework.

Some peripherals need to enable a "system" clock in order to work properly.
Each system clock is given an id based on the bit position in SCER/SCDR
registers.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clk/at91/Makefile     |    1 +
 drivers/clk/at91/clk-system.c |  137 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/at91/pmc.c        |    5 ++
 drivers/clk/at91/pmc.h        |    3 +
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/clk/at91/clk-system.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index e28fb2b..c2b7068 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += pmc.o
 obj-y += clk-main.o clk-pll.o clk-plldiv.o clk-master.o
+obj-y += clk-system.o
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
new file mode 100644
index 0000000..1c086f4
--- /dev/null
+++ b/drivers/clk/at91/clk-system.c
@@ -0,0 +1,137 @@
+/*
+ * drivers/clk/at91/clk-system.c
+ *
+ *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+#include "pmc.h"
+
+#define SYSTEM_MAX_ID		31
+
+#define SYSTEM_MAX_NAME_SZ	32
+
+#define to_clk_system(hw) container_of(hw, struct clk_system, hw)
+struct clk_system {
+	struct clk_hw hw;
+	struct at91_pmc *pmc;
+	u8 id;
+};
+
+static int clk_system_enable(struct clk_hw *hw)
+{
+	struct clk_system *sys = to_clk_system(hw);
+	struct at91_pmc *pmc = sys->pmc;
+
+	pmc_write(pmc, AT91_PMC_SCER, 1 << sys->id);
+	return 0;
+}
+
+static void clk_system_disable(struct clk_hw *hw)
+{
+	struct clk_system *sys = to_clk_system(hw);
+	struct at91_pmc *pmc = sys->pmc;
+
+	pmc_write(pmc, AT91_PMC_SCDR, 1 << sys->id);
+}
+
+static int clk_system_is_enabled(struct clk_hw *hw)
+{
+	struct clk_system *sys = to_clk_system(hw);
+	struct at91_pmc *pmc = sys->pmc;
+
+	return !!(pmc_read(pmc, AT91_PMC_SCSR) & (1 << sys->id));
+}
+
+static const struct clk_ops system_ops = {
+	.enable = clk_system_enable,
+	.disable = clk_system_disable,
+	.is_enabled = clk_system_is_enabled,
+};
+
+static struct clk * __init
+at91_clk_register_system(struct at91_pmc *pmc, const char *name,
+			 const char *parent_name, u8 id)
+{
+	struct clk_system *sys;
+	struct clk *clk = NULL;
+	struct clk_init_data init;
+
+	if (!parent_name || id > SYSTEM_MAX_ID)
+		return ERR_PTR(-EINVAL);
+
+	sys = kzalloc(sizeof(*sys), GFP_KERNEL);
+	if (!sys)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &system_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	/*
+	 * CLK_IGNORE_UNUSED is used to avoid ddrck switch off.
+	 * TODO : we should implement a driver supporting at91 ddr controller
+	 * (see drivers/memory) which would request and enable the ddrck clock.
+	 * When this is done we will be able to remove CLK_IGNORE_UNUSED flag.
+	 */
+	init.flags = CLK_IGNORE_UNUSED;
+
+	sys->id = id;
+	sys->hw.init = &init;
+	sys->pmc = pmc;
+
+	clk = clk_register(NULL, &sys->hw);
+	if (IS_ERR(clk))
+		kfree(sys);
+
+	return clk;
+}
+
+static void __init
+of_at91_clk_sys_setup(struct device_node *np, struct at91_pmc *pmc)
+{
+	int num;
+	u32 id;
+	struct clk *clk;
+	const char *name;
+	struct device_node *sysclknp;
+	const char *parent_name;
+
+	num = of_get_child_count(np);
+	if (num > (SYSTEM_MAX_ID + 1))
+		return;
+
+	for_each_child_of_node(np, sysclknp) {
+		if (of_property_read_u32(sysclknp, "reg", &id))
+			continue;
+
+		if (of_property_read_string(np, "clock-output-names", &name))
+			name = sysclknp->name;
+
+		parent_name = of_clk_get_parent_name(sysclknp, 0);
+
+		clk = at91_clk_register_system(pmc, name, parent_name, id);
+		if (IS_ERR(clk))
+			continue;
+
+		of_clk_add_provider(sysclknp, of_clk_src_simple_get, clk);
+	}
+}
+
+void __init of_at91rm9200_clk_sys_setup(struct device_node *np,
+					struct at91_pmc *pmc)
+{
+	of_at91_clk_sys_setup(np, pmc);
+}
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index d9975e7..6adc5be 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -266,6 +266,11 @@ static const struct of_device_id pmc_clk_ids[] __initdata = {
 		.compatible = "atmel,at91sam9x5-clk-master",
 		.data = of_at91sam9x5_clk_master_setup,
 	},
+	/* System clocks */
+	{
+		.compatible = "atmel,at91rm9200-clk-system",
+		.data = of_at91rm9200_clk_sys_setup,
+	},
 	{ /*sentinel*/ }
 };
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index be5c964..9c8a397 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -77,4 +77,7 @@ extern void __init of_at91rm9200_clk_master_setup(struct device_node *np,
 extern void __init of_at91sam9x5_clk_master_setup(struct device_node *np,
 						  struct at91_pmc *pmc);
 
+extern void __init of_at91rm9200_clk_sys_setup(struct device_node *np,
+					       struct at91_pmc *pmc);
+
 #endif /* __PMC_H_ */
-- 
1.7.9.5
