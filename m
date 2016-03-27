From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:26:15 +0200
Subject: [PATCH v4 3/5] clk: mvebu: new driver for Armada AP806 system
 controller
In-Reply-To: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1459070777-18049-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada AP806 system controller, amongst other things, provides a
number of clocks for the platform: the CPU cluster clocks, whose
frequencies are found by reading the Sample At Reset register, one
fixed clock, and another clock derived from the fixed clock, which is
the one used by most peripherals in AP806.

The AP806 is one of the two core HW blocks used in the Marvell 7K/8K
SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/Kconfig                   |   3 +
 drivers/clk/mvebu/Makefile                  |   1 +
 drivers/clk/mvebu/ap806-system-controller.c | 106 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/clk/mvebu/ap806-system-controller.c

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index eaee8f0..bf7ae00 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -29,6 +29,9 @@ config ARMADA_XP_CLK
 	select MVEBU_CLK_COMMON
 	select MVEBU_CLK_CPU
 
+config ARMADA_AP806_SYSCON
+	bool
+
 config DOVE_CLK
 	bool
 	select MVEBU_CLK_COMMON
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index 8866115..f4aa481 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARMADA_375_CLK)	+= armada-375.o
 obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
 obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
+obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o dove-divider.o
 obj-$(CONFIG_KIRKWOOD_CLK)	+= kirkwood.o
 obj-$(CONFIG_ORION_CLK)		+= orion.o
diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
new file mode 100644
index 0000000..c33c209
--- /dev/null
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -0,0 +1,106 @@
+/*
+ * Marvell Armada AP806 System Controller
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "ap806-system-controller: " fmt
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+#define AP806_SAR_REG			0x400
+#define AP806_SAR_CLKFREQ_MODE_MASK	0x1f
+
+#define AP806_CLK_NUM 			4
+
+static struct clk *ap806_clks[AP806_CLK_NUM];
+
+static struct clk_onecell_data ap806_clk_data = {
+	.clks = ap806_clks,
+	.clk_num = AP806_CLK_NUM,
+};
+
+static void __init ap806_syscon_clk_init(struct device_node *np)
+{
+	unsigned int freq_mode, cpuclk_freq;
+	const char *name, *fixedclk_name;
+	struct regmap *regmap;
+	u32 reg;
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		pr_err("cannot get regmap\n");
+		return;
+	}
+
+	if (regmap_read(regmap, AP806_SAR_REG, &reg)) {
+		pr_err("cannot read from regmap\n");
+		return;
+	}
+
+	freq_mode = reg & AP806_SAR_CLKFREQ_MODE_MASK;
+	switch(freq_mode) {
+	case 0x0 ... 0x5:
+		cpuclk_freq = 2000;
+		break;
+	case 0x6 ... 0xB:
+		cpuclk_freq = 1800;
+		break;
+	case 0xC ... 0x11:
+		cpuclk_freq = 1600;
+		break;
+	case 0x12 ... 0x16:
+		cpuclk_freq = 1400;
+		break;
+	case 0x17 ... 0x19:
+		cpuclk_freq = 1300;
+		break;
+	default:
+		pr_err("invalid SAR value\n");
+		return;
+	}
+
+	/* Convert to hertz */
+	cpuclk_freq *= 1000 * 1000;
+
+	/* CPU clocks depend on the Sample At Reset configuration */
+	of_property_read_string_index(np, "clock-output-names",
+				      0, &name);
+	ap806_clks[0] = clk_register_fixed_rate(NULL, name, NULL,
+						0, cpuclk_freq);
+
+	of_property_read_string_index(np, "clock-output-names",
+				      1, &name);
+	ap806_clks[1] = clk_register_fixed_rate(NULL, name, NULL, 0,
+						cpuclk_freq);
+
+	/* Fixed clock is always 1200 Mhz */
+	of_property_read_string_index(np, "clock-output-names",
+				      2, &fixedclk_name);
+	ap806_clks[2] = clk_register_fixed_rate(NULL, fixedclk_name, NULL, 0,
+						1200 * 1000 * 1000);
+
+	/* MSS Clock is fixed clock divided by 6 */
+	of_property_read_string_index(np, "clock-output-names",
+				      3, &name);
+	ap806_clks[3] = clk_register_fixed_factor(NULL, name, fixedclk_name,
+						  0, 1, 6);
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &ap806_clk_data);
+}
+
+CLK_OF_DECLARE(ap806_syscon_clk, "marvell,ap806-system-controller",
+	       ap806_syscon_clk_init);
-- 
2.6.4
