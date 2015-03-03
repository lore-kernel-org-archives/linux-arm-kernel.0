From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:09 +0100
Subject: [PATCH v3 14/20] clk: mvebu: add Marvell Armada 39x driver
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a new clock driver for the Marvell Armada 39x family
of processors. This driver is fairly similar to the ones already used
on other Marvell EBU processors, with the following main differences:

 * Different set of ratios
 * Different set of core clocks
 * Configurable reference clock in frequency

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/Kconfig      |   4 ++
 drivers/clk/mvebu/Makefile     |   1 +
 drivers/clk/mvebu/armada-39x.c | 156 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/clk/mvebu/armada-39x.c

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index 3b34dba..2769625 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -21,6 +21,10 @@ config ARMADA_38X_CLK
 	bool
 	select MVEBU_CLK_COMMON
 
+config ARMADA_39X_CLK
+	bool
+	select MVEBU_CLK_COMMON
+
 config ARMADA_XP_CLK
 	bool
 	select MVEBU_CLK_COMMON
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index a9a56fc..645ac7e 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MVEBU_CLK_COREDIV)	+= clk-corediv.o
 obj-$(CONFIG_ARMADA_370_CLK)	+= armada-370.o
 obj-$(CONFIG_ARMADA_375_CLK)	+= armada-375.o
 obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
+obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o
 obj-$(CONFIG_KIRKWOOD_CLK)	+= kirkwood.o
diff --git a/drivers/clk/mvebu/armada-39x.c b/drivers/clk/mvebu/armada-39x.c
new file mode 100644
index 0000000..efb974d
--- /dev/null
+++ b/drivers/clk/mvebu/armada-39x.c
@@ -0,0 +1,156 @@
+/*
+ * Marvell Armada 39x SoC clocks
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ * Andrew Lunn <andrew@lunn.ch>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include "common.h"
+
+/*
+ * SARL[14:10] : Ratios between CPU, NBCLK, HCLK and DCLK.
+ *
+ * SARL[15]    : TCLK frequency
+ *		 0 = 250 MHz
+ *		 1 = 200 MHz
+ *
+ * SARH[0]     : Reference clock frequency
+ *               0 = 25 Mhz
+ *               1 = 40 Mhz
+ */
+
+#define SARL 					0
+#define  SARL_A390_TCLK_FREQ_OPT		15
+#define  SARL_A390_TCLK_FREQ_OPT_MASK		0x1
+#define  SARL_A390_CPU_DDR_L2_FREQ_OPT		10
+#define  SARL_A390_CPU_DDR_L2_FREQ_OPT_MASK	0x1F
+#define SARH					4
+#define  SARH_A390_REFCLK_FREQ			BIT(0)
+
+static const u32 armada_39x_tclk_frequencies[] __initconst = {
+	250000000,
+	200000000,
+};
+
+static u32 __init armada_39x_get_tclk_freq(void __iomem *sar)
+{
+	u8 tclk_freq_select;
+
+	tclk_freq_select = ((readl(sar + SARL) >> SARL_A390_TCLK_FREQ_OPT) &
+			    SARL_A390_TCLK_FREQ_OPT_MASK);
+	return armada_39x_tclk_frequencies[tclk_freq_select];
+}
+
+static const u32 armada_39x_cpu_frequencies[] __initconst = {
+	[0x0] = 666 * 1000 * 1000,
+	[0x2] = 800 * 1000 * 1000,
+	[0x3] = 800 * 1000 * 1000,
+	[0x4] = 1066 * 1000 * 1000,
+	[0x5] = 1066 * 1000 * 1000,
+	[0x6] = 1200 * 1000 * 1000,
+	[0x8] = 1332 * 1000 * 1000,
+	[0xB] = 1600 * 1000 * 1000,
+	[0xC] = 1600 * 1000 * 1000,
+	[0x12] = 1800 * 1000 * 1000,
+	[0x1E] = 1800 * 1000 * 1000,
+};
+
+static u32 __init armada_39x_get_cpu_freq(void __iomem *sar)
+{
+	u8 cpu_freq_select;
+
+	cpu_freq_select = ((readl(sar + SARL) >> SARL_A390_CPU_DDR_L2_FREQ_OPT) &
+			   SARL_A390_CPU_DDR_L2_FREQ_OPT_MASK);
+	if (cpu_freq_select >= ARRAY_SIZE(armada_39x_cpu_frequencies)) {
+		pr_err("Selected CPU frequency (%d) unsupported\n",
+			cpu_freq_select);
+		return 0;
+	}
+
+	return armada_39x_cpu_frequencies[cpu_freq_select];
+}
+
+enum { A390_CPU_TO_NBCLK, A390_CPU_TO_HCLK, A390_CPU_TO_DCLK };
+
+static const struct coreclk_ratio armada_39x_coreclk_ratios[] __initconst = {
+	{ .id = A390_CPU_TO_NBCLK, .name = "nbclk" },
+	{ .id = A390_CPU_TO_HCLK, .name = "hclk" },
+	{ .id = A390_CPU_TO_DCLK, .name = "dclk" },
+};
+
+static void __init armada_39x_get_clk_ratio(
+	void __iomem *sar, int id, int *mult, int *div)
+{
+	switch (id) {
+	case A390_CPU_TO_NBCLK:
+		*mult = 1;
+		*div = 2;
+		break;
+	case A390_CPU_TO_HCLK:
+		*mult = 1;
+		*div = 4;
+		break;
+	case A390_CPU_TO_DCLK:
+		*mult = 1;
+		*div = 2;
+		break;
+	}
+}
+
+static u32 __init armada_39x_refclk_ratio(void __iomem *sar)
+{
+	if (readl(sar + SARH) & SARH_A390_REFCLK_FREQ)
+		return 40 * 1000 * 1000;
+	else
+		return 25 * 1000 * 1000;
+}
+
+static const struct coreclk_soc_desc armada_39x_coreclks = {
+	.get_tclk_freq = armada_39x_get_tclk_freq,
+	.get_cpu_freq = armada_39x_get_cpu_freq,
+	.get_clk_ratio = armada_39x_get_clk_ratio,
+	.get_refclk_freq = armada_39x_refclk_ratio,
+	.ratios = armada_39x_coreclk_ratios,
+	.num_ratios = ARRAY_SIZE(armada_39x_coreclk_ratios),
+};
+
+static void __init armada_39x_coreclk_init(struct device_node *np)
+{
+	mvebu_coreclk_setup(np, &armada_39x_coreclks);
+}
+CLK_OF_DECLARE(armada_39x_core_clk, "marvell,armada-390-core-clock",
+	       armada_39x_coreclk_init);
+
+/*
+ * Clock Gating Control
+ */
+static const struct clk_gating_soc_desc armada_39x_gating_desc[] __initconst = {
+	{ "pex1", NULL, 5 },
+	{ "pex2", NULL, 6 },
+	{ "pex3", NULL, 7 },
+	{ "pex0", NULL, 8 },
+	{ "usb3h0", NULL, 9 },
+	{ "sdio", NULL, 17 },
+	{ "xor0", NULL, 22 },
+	{ "xor1", NULL, 28 },
+	{ }
+};
+
+static void __init armada_39x_clk_gating_init(struct device_node *np)
+{
+	mvebu_clk_gating_setup(np, armada_39x_gating_desc);
+}
+CLK_OF_DECLARE(armada_39x_clk_gating, "marvell,armada-390-gating-clock",
+	       armada_39x_clk_gating_init);
-- 
2.1.0
