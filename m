From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 16:15:56 +0800
Subject: [PATCH] ARM: imx6q: register fixed clocks in the common way
Message-ID: <1344932156-8275-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT clock support in place, we can register fixed clocks in DT
standard way.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi  |   11 +++++++----
 arch/arm/mach-imx/clk-imx6q.c |   21 +++++++--------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3d3c64b..0052fe7 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -65,17 +65,20 @@
 		#size-cells = <0>;
 
 		ckil {
-			compatible = "fsl,imx-ckil", "fixed-clock";
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 		};
 
-		ckih1 {
-			compatible = "fsl,imx-ckih1", "fixed-clock";
+		ckih {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
 			clock-frequency = <0>;
 		};
 
 		osc {
-			compatible = "fsl,imx-osc", "fixed-clock";
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 		};
 	};
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index ea89520..475bc93 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -162,27 +162,20 @@ static enum mx6q_clks const clks_init_on[] __initconst = {
 	mmdc_ch0_axi, rom,
 };
 
+static const struct of_device_id clk_match[] __initconst = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ /* sentinel */ }
+};
+
 int __init mx6q_clocks_init(void)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int i, irq;
 
-	clk[dummy] = imx_clk_fixed("dummy", 0);
+	of_clk_init(clk_match);
 
-	/* retrieve the freqency of fixed clocks from device tree */
-	for_each_compatible_node(np, NULL, "fixed-clock") {
-		u32 rate;
-		if (of_property_read_u32(np, "clock-frequency", &rate))
-			continue;
-
-		if (of_device_is_compatible(np, "fsl,imx-ckil"))
-			clk[ckil] = imx_clk_fixed("ckil", rate);
-		else if (of_device_is_compatible(np, "fsl,imx-ckih1"))
-			clk[ckih] = imx_clk_fixed("ckih", rate);
-		else if (of_device_is_compatible(np, "fsl,imx-osc"))
-			clk[osc] = imx_clk_fixed("osc", rate);
-	}
+	clk[dummy] = imx_clk_fixed("dummy", 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	base = of_iomap(np, 0);
-- 
1.7.5.4
