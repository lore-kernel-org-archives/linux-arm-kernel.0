From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 24 Dec 2014 10:13:30 +1300
Subject: [RFC/PATCHv2 3/5] clk: mvebu: armada-xp: Support for 98DX4251
In-Reply-To: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1419369212-17047-4-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX4251 is one of a range of packet processors with integrated CPUs
based on armada-xp. One difference is that the TCLK frequency is fixed
at 200MHz as opposed to the fixed 250MHz used on armada-xp. Additionally
the clock-gating options are a subset of what's available on the
armada-xp.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
As per Thomas' and Andrews comments I've made this specific to the
98DX4251 and separated out the gating definitions. It should be good for
other variants of what Marvell call "MSYS" but I don't have access to
any to test with.

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304387.html

 .../devicetree/bindings/clock/mvebu-core-clock.txt |  4 +++
 drivers/clk/mvebu/armada-xp.c                      | 35 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index dc5ea5b..503849e 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -34,6 +34,9 @@ The following is a list of provided IDs and clock names on Orion5x:
  1 = cpuclk (CPU0 clock)
  2 = ddrclk (DDR controller clock derived from CPU0 clock)
 
+The following is a list of provided IDs and clock names on MV98DX4251:
+ 0 = tclk   (Internal Bus clock)
+
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-370-core-clock" - For Armada 370 SoC core clocks
@@ -46,6 +49,7 @@ Required properties:
 	"marvell,mv88f5182-core-clock" - for Orion MV88F5182 SoC
 	"marvell,mv88f5281-core-clock" - for Orion MV88F5281 SoC
 	"marvell,mv88f6183-core-clock" - for Orion MV88F6183 SoC
+	"marvell,mv98dx4251-core-clock" - for MV98DX4251 SoC
 - reg : shall be the register address of the Sample-At-Reset (SAR) register
 - #clock-cells : from common clock binding; shall be set to 1
 
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index b309431..eb17817 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -52,6 +52,12 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
 	return 250000000;
 }
 
+/* MV98DX4251 TCLK frequency is fixed to 200MHz */
+static u32 __init mv98dx4251_get_tclk_freq(void __iomem *sar)
+{
+	return 200000000;
+}
+
 static const u32 axp_cpu_freqs[] __initconst = {
 	1000000000,
 	1066000000,
@@ -158,6 +164,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
 	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
 };
 
+static const struct coreclk_soc_desc mv98dx4251_coreclks = {
+	.get_tclk_freq = mv98dx4251_get_tclk_freq,
+	.get_cpu_freq = axp_get_cpu_freq,
+	.get_clk_ratio = axp_get_clk_ratio,
+	.ratios = axp_coreclk_ratios,
+	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
+};
+
 /*
  * Clock Gating Control
  */
@@ -195,6 +209,15 @@ static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ }
 };
 
+static const struct clk_gating_soc_desc mv98dx4251_gating_desc[] __initconst = {
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
@@ -206,3 +229,15 @@ static void __init axp_clk_init(struct device_node *np)
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
+
+static void __init mv98dx4251_clk_init(struct device_node *np)
+{
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
+
+	mvebu_coreclk_setup(np, &mv98dx4251_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, mv98dx4251_gating_desc);
+}
+CLK_OF_DECLARE(mv98dx4251_clk, "marvell,mv98dx4251-core-clock", mv98dx4251_clk_init);
-- 
2.2.0.rc0
