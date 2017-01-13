From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 13 Jan 2017 22:12:16 +1300
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX3236, 98DX3336, 98DX4521 and variants have a different TCLK from
the Armada XP (200MHz vs 250MHz). The CPU core clock is fixed at 800MHz.

The clock gating options are a subset of those on the Armada XP.

The core clock divider is different to the Armada XP also.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - Update devicetree binding documentation for new compatible string
    Changes in v3:
    - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
      driver.
    - Document mv98dx3236-corediv-clock binding
    Changes in v4:
    - None

 .../bindings/clock/mvebu-corediv-clock.txt         |  1 +
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  1 +
 drivers/clk/mvebu/armada-xp.c                      | 42 ++++++++++++++++++++++
 drivers/clk/mvebu/clk-corediv.c                    | 23 ++++++++++++
 drivers/clk/mvebu/clk-cpu.c                        | 31 ++++++++++++++--
 5 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
index 520562a7dc2a..c7b4e3a6b2c6 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible : must be "marvell,armada-370-corediv-clock",
 		       "marvell,armada-375-corediv-clock",
 		       "marvell,armada-380-corediv-clock",
+                       "marvell,mv98dx3236-corediv-clock",
 
 - reg : must be the register address of Core Divider control register
 - #clock-cells : from common clock binding; shall be set to 1
diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
index 99c214660bdc..7f28506eaee7 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -3,6 +3,7 @@ Device Tree Clock bindings for cpu clock of Marvell EBU platforms
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
+	"marvell,mv98dx3236-cpu-clock" - cpu clocks for 98DX3236 SoC
 - reg : Address and length of the clock complex register set, followed
         by address and length of the PMU DFS registers
 - #clock-cells : should be set to 1.
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index b3094315a3c0..0413bf8284e0 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -52,6 +52,12 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
 	return 250000000;
 }
 
+/* MV98DX3236 TCLK frequency is fixed to 200MHz */
+static u32 __init mv98dx3236_get_tclk_freq(void __iomem *sar)
+{
+	return 200000000;
+}
+
 static const u32 axp_cpu_freqs[] __initconst = {
 	1000000000,
 	1066000000,
@@ -89,6 +95,12 @@ static u32 __init axp_get_cpu_freq(void __iomem *sar)
 	return cpu_freq;
 }
 
+/* MV98DX3236 CLK frequency is fixed to 800MHz */
+static u32 __init mv98dx3236_get_cpu_freq(void __iomem *sar)
+{
+	return 800000000;
+}
+
 static const int axp_nbclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 2}, {2, 2},
 	{1, 2}, {1, 2}, {1, 1}, {2, 3},
@@ -158,6 +170,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
 	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
 };
 
+static const struct coreclk_soc_desc mv98dx3236_coreclks = {
+	.get_tclk_freq = mv98dx3236_get_tclk_freq,
+	.get_cpu_freq = mv98dx3236_get_cpu_freq,
+	.get_clk_ratio = NULL,
+	.ratios = NULL,
+	.num_ratios = 0,
+};
+
 /*
  * Clock Gating Control
  */
@@ -195,6 +215,15 @@ static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ }
 };
 
+static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initconst = {
+	{ "ge1", NULL, 3, 0 },
+	{ "ge0", NULL, 4, 0 },
+	{ "pex00", NULL, 5, 0 },
+	{ "sdio", NULL, 17, 0 },
+	{ "xor0", NULL, 22, 0 },
+	{ }
+};
+
 static void __init axp_clk_init(struct device_node *np)
 {
 	struct device_node *cgnp =
@@ -206,3 +235,16 @@ static void __init axp_clk_init(struct device_node *np)
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
+
+static void __init mv98dx3236_clk_init(struct device_node *np)
+{
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
+
+	mvebu_coreclk_setup(np, &mv98dx3236_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
+}
+CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock",
+	       mv98dx3236_clk_init);
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index d1e5863d3375..8491979f4096 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -71,6 +71,10 @@ static const struct clk_corediv_desc mvebu_corediv_desc[] = {
 	{ .mask = 0x3f, .offset = 8, .fieldbit = 1 }, /* NAND clock */
 };
 
+static const struct clk_corediv_desc mv98dx3236_corediv_desc[] = {
+	{ .mask = 0x0f, .offset = 6, .fieldbit = 26 }, /* NAND clock */
+};
+
 #define to_corediv_clk(p) container_of(p, struct clk_corediv, hw)
 
 static int clk_corediv_is_enabled(struct clk_hw *hwclk)
@@ -232,6 +236,18 @@ static const struct clk_corediv_soc_desc armada375_corediv_soc = {
 	.ratio_offset = 0x4,
 };
 
+static const struct clk_corediv_soc_desc mv98dx3236_corediv_soc = {
+	.descs = mv98dx3236_corediv_desc,
+	.ndescs = ARRAY_SIZE(mv98dx3236_corediv_desc),
+	.ops = {
+		.recalc_rate = clk_corediv_recalc_rate,
+		.round_rate = clk_corediv_round_rate,
+		.set_rate = clk_corediv_set_rate,
+	},
+	.ratio_reload = BIT(10),
+	.ratio_offset = 0x8,
+};
+
 static void __init
 mvebu_corediv_clk_init(struct device_node *node,
 		       const struct clk_corediv_soc_desc *soc_desc)
@@ -313,3 +329,10 @@ static void __init armada380_corediv_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE(armada380_corediv_clk, "marvell,armada-380-corediv-clock",
 	       armada380_corediv_clk_init);
+
+static void __init mv98dx3236_corediv_clk_init(struct device_node *node)
+{
+	return mvebu_corediv_clk_init(node, &mv98dx3236_corediv_soc);
+}
+CLK_OF_DECLARE(mv98dx3236_corediv_clk, "marvell,mv98dx3236-corediv-clock",
+	       mv98dx3236_corediv_clk_init);
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 5837eb8a212f..3b8f0e14fa01 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -165,7 +165,9 @@ static const struct clk_ops cpu_ops = {
 	.set_rate = clk_cpu_set_rate,
 };
 
-static void __init of_cpu_clk_setup(struct device_node *node)
+/* Add parameter to allow this to support different clock operations. */
+static void __init _of_cpu_clk_setup(struct device_node *node,
+			const struct clk_ops *cpu_clk_ops)
 {
 	struct cpu_clk *cpuclk;
 	void __iomem *clock_complex_base = of_iomap(node, 0);
@@ -218,7 +220,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		cpuclk[cpu].hw.init = &init;
 
 		init.name = cpuclk[cpu].clk_name;
-		init.ops = &cpu_ops;
+		init.ops = cpu_clk_ops;
 		init.flags = 0;
 		init.parent_names = &cpuclk[cpu].parent_name;
 		init.num_parents = 1;
@@ -243,5 +245,30 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	iounmap(clock_complex_base);
 }
 
+/* Use this function to call the generic setup with the correct
+ * clock operation
+ */
+static void __init of_cpu_clk_setup(struct device_node *node)
+{
+	_of_cpu_clk_setup(node, &cpu_ops);
+}
+
 CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
 					 of_cpu_clk_setup);
+
+/* Define the clock and operations for the mv98dx3236 - it cannot perform
+ * any operations.
+ */
+static const struct clk_ops mv98dx3236_cpu_ops = {
+	.recalc_rate = NULL,
+	.round_rate = NULL,
+	.set_rate = NULL,
+};
+
+static void __init of_mv98dx3236_cpu_clk_setup(struct device_node *node)
+{
+	_of_cpu_clk_setup(node, &mv98dx3236_cpu_ops);
+}
+
+CLK_OF_DECLARE(mv98dx3236_cpu_clock, "marvell,mv98dx3236-cpu-clock",
+					 of_mv98dx3236_cpu_clk_setup);
-- 
2.11.0.24.ge6920cf
