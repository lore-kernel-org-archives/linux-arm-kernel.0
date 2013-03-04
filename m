From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:40 +0100
Subject: [PATCH 1/9] MXS/i.MX28: add the possibility to define the used
 crystals via device tree
In-Reply-To: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1362405948-12992-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
 drivers/clk/mxs/clk-imx28.c  |   16 +++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..958bd10 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -37,6 +37,17 @@
 		};
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc24m: system_oscillator {
+			compatible = "fsl,mxs-system", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+	};
+
 	apb at 80000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 76ce6c6..01048b5 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -158,7 +158,21 @@ int __init mx28_clocks_init(void)
 
 	clk_misc_init();
 
-	clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
+	/* retrieve the crystal's frequencies from device tree */
+	for_each_compatible_node(np, NULL, "fixed-clock") {
+		u32 rate;
+
+		if (of_property_read_u32(np, "clock-frequency", &rate))
+			continue;
+
+		if (of_device_is_compatible(np, "fsl,mxs-system"))
+			clks[ref_xtal] = mxs_clk_fixed("ref_xtal", rate);
+	}
+
+	/* if not set, guess their frequency */
+	if (clks[ref_xtal] == NULL)
+		clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
+
 	clks[pll0] = mxs_clk_pll("pll0", "ref_xtal", PLL0CTRL0, 17, 480000000);
 	clks[pll1] = mxs_clk_pll("pll1", "ref_xtal", PLL1CTRL0, 17, 480000000);
 	clks[pll2] = mxs_clk_pll("pll2", "ref_xtal", PLL2CTRL0, 23, 50000000);
-- 
1.7.10.4
