From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:11 +0200
Subject: [PATCH 36/39] ARM: u300: convert MMC/SD clock to device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-37-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the last of the U300 clocks to being probed from
the device tree.

Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/clock/ste-u300-syscon-clock.txt       | 23 ++++++++++++++++++++++
 arch/arm/boot/dts/ste-u300.dts                     |  9 +++++++--
 drivers/clk/clk-u300.c                             | 22 ++++++++++++++++-----
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt b/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
index b6a30f5..7cafcb9 100644
--- a/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
+++ b/Documentation/devicetree/bindings/clock/ste-u300-syscon-clock.txt
@@ -55,3 +55,26 @@ gpio: gpio at c0016000 {
 	(...)
 	clocks = <&gpio_clk>;
 };
+
+
+Bindings for the MMC/SD card clock:
+
+Required properties:
+- compatible: must be "stericsson,u300-syscon-mclk"
+- #clock-cells: must be <0>
+
+Optional properties:
+- clocks: parent clock(s)
+
+mmc_mclk: mmc_mclk {
+	#clock-cells = <0>;
+	compatible = "stericsson,u300-syscon-mclk";
+	clocks = <&mmc_pclk>;
+};
+
+mmcsd: mmcsd at c0001000 {
+	compatible = "arm,pl18x", "arm,primecell";
+	clocks = <&mmc_pclk>, <&mmc_mclk>;
+	clock-names = "apb_pclk", "mclk";
+	(...)
+};
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 7edc5e5..05a0821 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -205,6 +205,11 @@
 			clock-id = <5>;
 			clocks = <&fast_clk>;
 		};
+		mmc_mclk: mmc_mclk {
+			#clock-cells = <0>;
+			compatible = "stericsson,u300-syscon-mclk";
+			clocks = <&mmc_pclk>;
+		};
 		spi_clk: spi_p_clk at 26M {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
@@ -433,8 +438,8 @@
 			reg = <0xc0001000 0x1000>;
 			interrupt-parent = <&vicb>;
 			interrupts = <6 7>;
-			clocks = <&mmc_pclk>;
-			clock-names = "apb_pclk";
+			clocks = <&mmc_pclk>, <&mmc_mclk>;
+			clock-names = "apb_pclk", "mclk";
 			max-frequency = <24000000>;
 			bus-width = <4>; // SD-card slot
 			mmc-cap-mmc-highspeed;
diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index 5f234d3..8774e05 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -1139,6 +1139,18 @@ mclk_clk_register(struct device *dev, const char *name,
 	return clk;
 }
 
+static void __init of_u300_syscon_mclk_init(struct device_node *np)
+{
+	struct clk *clk = ERR_PTR(-EINVAL);
+	const char *clk_name = np->name;
+	const char *parent_name;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	clk = mclk_clk_register(NULL, clk_name, parent_name, false);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
 static const __initconst struct of_device_id u300_clk_match[] = {
 	{
 		.compatible = "fixed-clock",
@@ -1152,12 +1164,16 @@ static const __initconst struct of_device_id u300_clk_match[] = {
 		.compatible = "stericsson,u300-syscon-clk",
 		.data = of_u300_syscon_clk_init,
 	},
+	{
+		.compatible = "stericsson,u300-syscon-mclk",
+		.data = of_u300_syscon_mclk_init,
+	},
 };
 
+
 void __init u300_clk_init(void __iomem *base)
 {
 	u16 val;
-	struct clk *clk;
 
 	syscon_vbase = base;
 
@@ -1175,8 +1191,4 @@ void __init u300_clk_init(void __iomem *base)
 	writew(val, syscon_vbase + U300_SYSCON_PMCR);
 
 	of_clk_init(u300_clk_match);
-
-	/* Then this special MMC/SD clock */
-	clk = mclk_clk_register(NULL, "mmc_clk", "mmc_p_clk", false);
-	clk_register_clkdev(clk, NULL, "mmci");
 }
-- 
1.7.11.3
