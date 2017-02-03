From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  3 Feb 2017 16:40:12 +1300
Subject: [PATCH 4/4] clk: mvebu: Expand mv98dx3236-core-clock support
In-Reply-To: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
References: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170203034012.29399-5-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial implementation in commit e120c17a70e5 ("clk: mvebu: support
for 98DX3236 SoC") hardcoded a fixed value for the main PLL frequency.
Port code from the Marvell supplied Linux kernel to support different
PLL frequencies and provide clock gating support.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
 .../bindings/clock/mvebu-gated-clock.txt           |  11 ++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |  14 +-
 drivers/clk/mvebu/Makefile                         |   2 +-
 drivers/clk/mvebu/armada-xp.c                      |  13 --
 drivers/clk/mvebu/mv98dx3236.c                     | 144 +++++++++++++++++++++
 6 files changed, 170 insertions(+), 21 deletions(-)
 create mode 100644 drivers/clk/mvebu/mv98dx3236.c

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index eb985a633d59..796c260c183d 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -31,6 +31,12 @@ The following is a list of provided IDs and clock names on Armada 39x:
  4 = dclk    (SDRAM Interface Clock)
  5 = refclk  (Reference Clock)
 
+The following is a list of provided IDs and clock names on 98dx3236:
+ 0 = tclk    (Internal Bus clock)
+ 1 = cpuclk  (CPU clock)
+ 2 = ddrclk   (DDR clock)
+ 3 = mpll    (MPLL Clock)
+
 The following is a list of provided IDs and clock names on Kirkwood and Dove:
  0 = tclk   (Internal Bus clock)
  1 = cpuclk (CPU0 clock)
@@ -49,6 +55,7 @@ Required properties:
 	"marvell,armada-380-core-clock" - For Armada 380/385 SoC core clocks
 	"marvell,armada-390-core-clock" - For Armada 39x SoC core clocks
 	"marvell,armada-xp-core-clock" - For Armada XP SoC core clocks
+	"marvell,mv98dx3236-core-clock" - For 98dx3236 family SoC core clocks
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
 	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 5142efc8099d..de562da2ae77 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -119,6 +119,16 @@ ID	Clock	Peripheral
 29	sata1lnk
 30	sata1	SATA Host 1
 
+The following is a list of provided IDs for 98dx3236:
+ID	Clock	Peripheral
+-----------------------------------
+3	ge1	Gigabit Ethernet 1
+4	ge0	Gigabit Ethernet 0
+5	pex0	PCIe Cntrl 0
+17	sdio	SDHCI Host
+18	usb0	USB Host 0
+22	xor0	XOR DMA 0
+
 The following is a list of provided IDs for Dove:
 ID	Clock	Peripheral
 -----------------------------------
@@ -169,6 +179,7 @@ Required properties:
 	"marvell,armada-380-gating-clock" - for Armada 380/385 SoC clock gating
 	"marvell,armada-390-gating-clock" - for Armada 39x SoC clock gating
 	"marvell,armada-xp-gating-clock" - for Armada XP SoC clock gating
+	"marvell,mv98dx3236-gating-clock" - for 98dx3236 SoC clock gating
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
 - reg : shall be the register address of the Clock Gating Control register
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index e4baa97836e7..e80a5ee835e5 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -176,18 +176,12 @@
 			};
 
 			gateclk: clock-gating-control at 18220 {
-				compatible = "marvell,armada-xp-gating-clock";
+				compatible = "marvell,mv98dx3236-gating-clock";
 				reg = <0x18220 0x4>;
 				clocks = <&coreclk 0>;
 				#clock-cells = <1>;
 			};
 
-			coreclk: mvebu-sar at 18230 {
-				compatible = "marvell,mv98dx3236-core-clock";
-				reg = <0x18230 0x08>;
-				#clock-cells = <1>;
-			};
-
 			cpuclk: clock-complex at 18700 {
 				#clock-cells = <1>;
 				compatible = "marvell,mv98dx3236-cpu-clock";
@@ -264,6 +258,12 @@
 			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
 			reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
 
+			coreclk: mvebu-sar at f8204 {
+				compatible = "marvell,mv98dx3236-core-clock";
+				reg = <0xf8204 0x4>;
+				#clock-cells = <1>;
+			};
+
 			soc-id at f8244 {
 				compatible = "marvell,mv98dx3236-soc-id";
 				reg = <0xf8244 0x4>;
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index d9ae97fb43c4..d71c7fd5da16 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-xtal.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-tbg.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-periph.o
-obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
+obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o mv98dx3236.o
 obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
 obj-$(CONFIG_ARMADA_CP110_SYSCON) += cp110-system-controller.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o dove-divider.o
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index 890a863ae0d0..0ec44ae9a2a2 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -232,16 +232,3 @@ static void __init axp_clk_init(struct device_node *np)
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
-
-static void __init mv98dx3236_clk_init(struct device_node *np)
-{
-	struct device_node *cgnp =
-		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
-
-	mvebu_coreclk_setup(np, &mv98dx3236_coreclks);
-
-	if (cgnp)
-		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
-}
-CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock",
-	       mv98dx3236_clk_init);
diff --git a/drivers/clk/mvebu/mv98dx3236.c b/drivers/clk/mvebu/mv98dx3236.c
new file mode 100644
index 000000000000..b3948c96bb0a
--- /dev/null
+++ b/drivers/clk/mvebu/mv98dx3236.c
@@ -0,0 +1,144 @@
+/*
+ * Marvell MV98DX3236 SoC clocks
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ * Andrew Lunn <andrew@lunn.ch>
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
+
+/* For 98DX3236 Sample At Reset the CPU, DDR and Main PLL clocks are all
+ * defined at the same time
+ *
+ * SAR1[20:18]   : CPU frequency    DDR frequency   MPLL frequency
+ *		 1  =  667 MHz	    667 MHz	    2000 MHz
+ *		 2  =  400 MHz	    400 MHz	    400 MHz
+ *		 3  =  800 MHz	    800 MHz	    800 MHz
+ *		 5  =  800 MHz	    400 MHz	    800 MHz
+ *		 others reserved.
+ */
+
+#define	SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT		18
+#define	SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT_MASK	0x7
+
+static u32 __init mv98dx3236_get_tclk_freq(void __iomem *sar)
+{
+	/* Tclk = 200MHz, no SaR dependency */
+	return 200000000;
+}
+
+static const u32 mv98dx3236_cpu_frequencies[] __initconst = {
+	0,
+	667000000,
+	400000000,
+	800000000,
+	0,
+	800000000,
+	0, 0,
+};
+
+static u32 __init mv98dx3236_get_cpu_freq(void __iomem *sar)
+{
+	u32 cpu_freq = 0;
+	u8 cpu_freq_select = 0;
+
+	cpu_freq_select = ((readl(sar) >> SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT) &
+			   SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT_MASK);
+
+	if (of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		cpu_freq = mv98dx3236_cpu_frequencies[cpu_freq_select];
+
+	if (!cpu_freq)
+		pr_err("CPU freq select unsupported %d\n", cpu_freq_select);
+
+	return cpu_freq;
+}
+
+enum {
+	MV98DX3236_CPU_TO_DDR,
+	MV98DX3236_CPU_TO_MPLL
+};
+
+static const struct coreclk_ratio mv98dx3236_core_ratios[] __initconst = {
+	{ .id = MV98DX3236_CPU_TO_DDR, .name = "ddrclk" },
+	{ .id = MV98DX3236_CPU_TO_MPLL, .name = "mpll" },
+};
+
+static const int __initconst mv98dx3236_cpu_mpll_ratios[8][2] = {
+	{0, 1}, {3, 1}, {1, 1}, {1, 1},
+	{0, 1}, {1, 1}, {0, 1}, {0, 1},
+};
+
+static const int __initconst mv98dx3236_cpu_ddr_ratios[8][2] = {
+	{0, 1}, {1, 1}, {1, 1}, {1, 1},
+	{0, 1}, {1, 2}, {0, 1}, {0, 1},
+};
+
+static void __init mv98dx3236_get_clk_ratio(
+	void __iomem *sar, int id, int *mult, int *div)
+{
+	u32 opt = ((readl(sar) >> SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT) &
+		SAR1_MV98DX3236_CPU_DDR_MPLL_FREQ_OPT_MASK);
+
+	switch (id) {
+	case MV98DX3236_CPU_TO_DDR:
+		if (of_machine_is_compatible("marvell,armadaxp-98dx3236")) {
+			*mult = mv98dx3236_cpu_ddr_ratios[opt][0];
+			*div = mv98dx3236_cpu_ddr_ratios[opt][1];
+		}
+		break;
+	case MV98DX3236_CPU_TO_MPLL:
+		if (of_machine_is_compatible("marvell,armadaxp-98dx3236")) {
+			*mult = mv98dx3236_cpu_mpll_ratios[opt][0];
+			*div = mv98dx3236_cpu_mpll_ratios[opt][1];
+		}
+		break;
+	}
+}
+
+static const struct coreclk_soc_desc mv98dx3236_core_clocks = {
+	.get_tclk_freq = mv98dx3236_get_tclk_freq,
+	.get_cpu_freq = mv98dx3236_get_cpu_freq,
+	.get_clk_ratio = mv98dx3236_get_clk_ratio,
+	.ratios = mv98dx3236_core_ratios,
+	.num_ratios = ARRAY_SIZE(mv98dx3236_core_ratios),
+};
+
+
+/*
+ * Clock Gating Control
+ */
+
+static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initconst = {
+	{ "ge1", NULL, 3, 0 },
+	{ "ge0", NULL, 4, 0 },
+	{ "pex00", NULL, 5, 0 },
+	{ "sdio", NULL, 17, 0 },
+	{ "usb0", NULL, 18, 0 },
+	{ "xor0", NULL, 22, 0 },
+	{ }
+};
+
+static void __init mv98dx3236_clk_init(struct device_node *np)
+{
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,mv98dx3236-gating-clock");
+
+	mvebu_coreclk_setup(np, &mv98dx3236_core_clocks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
+}
+CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock", mv98dx3236_clk_init);
-- 
2.11.0.24.ge6920cf
