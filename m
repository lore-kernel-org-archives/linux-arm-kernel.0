From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:20:58 +0100
Subject: [PATCH 2/8] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Referring to the u-boot sources for the Netgear WNR854T, add support
for the mv88f5181.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/mvebu-core-clock.txt |  1 +
 drivers/clk/mvebu/orion.c                          | 70 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
index 670c2af..eb985a6 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
@@ -52,6 +52,7 @@ Required properties:
 	"marvell,dove-core-clock" - for Dove SoC core clocks
 	"marvell,kirkwood-core-clock" - for Kirkwood SoC (except mv88f6180)
 	"marvell,mv88f6180-core-clock" - for Kirkwood MV88f6180 SoC
+	"marvell,mv88f5181-core-clock" - for Orion MV88F5181 SoC
 	"marvell,mv88f5182-core-clock" - for Orion MV88F5182 SoC
 	"marvell,mv88f5281-core-clock" - for Orion MV88F5281 SoC
 	"marvell,mv88f6183-core-clock" - for Orion MV88F6183 SoC
diff --git a/drivers/clk/mvebu/orion.c b/drivers/clk/mvebu/orion.c
index fd12956..a6e5bee 100644
--- a/drivers/clk/mvebu/orion.c
+++ b/drivers/clk/mvebu/orion.c
@@ -21,6 +21,76 @@ static const struct coreclk_ratio orion_coreclk_ratios[] __initconst = {
 };
 
 /*
+ * Orion 5181
+ */
+
+#define SAR_MV88F5181_TCLK_FREQ      8
+#define SAR_MV88F5181_TCLK_FREQ_MASK 0x3
+
+static u32 __init mv88f5181_get_tclk_freq(void __iomem *sar)
+{
+	u32 opt = (readl(sar) >> SAR_MV88F5181_TCLK_FREQ) &
+		SAR_MV88F5181_TCLK_FREQ_MASK;
+	if (opt == 0)
+		return 133333333;
+	else if (opt == 1)
+		return 150000000;
+	else if (opt == 2)
+		return 166666667;
+	else
+		return 0;
+}
+
+#define SAR_MV88F5181_CPU_FREQ       4
+#define SAR_MV88F5181_CPU_FREQ_MASK  0xf
+
+static u32 __init mv88f5181_get_cpu_freq(void __iomem *sar)
+{
+	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
+		SAR_MV88F5181_CPU_FREQ_MASK;
+	if (opt == 0)
+		return 333333333;
+	else if (opt == 1 || opt == 2)
+		return 400000000;
+	else if (opt == 3)
+		return 500000000;
+	else
+		return 0;
+}
+
+static void __init mv88f5181_get_clk_ratio(void __iomem *sar, int id,
+					   int *mult, int *div)
+{
+	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
+		SAR_MV88F5181_CPU_FREQ_MASK;
+	if (opt == 0 || opt == 1) {
+		*mult = 1;
+		*div  = 2;
+	} else if (opt == 2 || opt == 3) {
+		*mult = 1;
+		*div  = 3;
+	} else {
+		*mult = 0;
+		*div  = 1;
+	}
+}
+
+static const struct coreclk_soc_desc mv88f5181_coreclks = {
+	.get_tclk_freq = mv88f5181_get_tclk_freq,
+	.get_cpu_freq = mv88f5181_get_cpu_freq,
+	.get_clk_ratio = mv88f5181_get_clk_ratio,
+	.ratios = orion_coreclk_ratios,
+	.num_ratios = ARRAY_SIZE(orion_coreclk_ratios),
+};
+
+static void __init mv88f5181_clk_init(struct device_node *np)
+{
+	return mvebu_coreclk_setup(np, &mv88f5181_coreclks);
+}
+
+CLK_OF_DECLARE(mv88f5181_clk, "marvell,mv88f5181-core-clock", mv88f5181_clk_init);
+
+/*
  * Orion 5182
  */
 
-- 
2.8.1
