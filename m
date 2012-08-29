From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Aug 2012 09:40:19 +0200
Subject: [PATCH 4/4] ARM i.MX5: Add nand oftree support
In-Reply-To: <1346226019-23560-1-git-send-email-s.hauer@pengutronix.de>
References: <1346226019-23560-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346226019-23560-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds snippets to the i.MX51/53 devicetrees for the nand
flash controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx51.dtsi        |    7 +++++++
 arch/arm/boot/dts/imx53.dtsi        |    7 +++++++
 arch/arm/mach-imx/clk-imx51-imx53.c |    2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index aba28dc..aaa0c0a 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -263,6 +263,13 @@
 				status = "disabled";
 			};
 
+			nand at 83fdb000 {
+				compatible = "fsl,imx51-nand";
+				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
+				interrupts = <8>;
+				status = "disabled";
+			};
+
 			ssi3: ssi at 83fe8000 {
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..dc00c62 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -321,6 +321,13 @@
 				status = "disabled";
 			};
 
+			nand at 63fdb000 {
+				compatible = "fsl,imx53-nand";
+				reg = <0x63fdb000 0x1000 0xf7ff0000 0x10000>;
+				interrupts = <8>;
+				status = "disabled";
+			};
+
 			ssi3: ssi at 63fe8000 {
 				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 4bdcaa9..e81f17a 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -367,6 +367,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "83fcc000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "70014000.ssi");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "83fe8000.ssi");
+	clk_register_clkdev(clk[nfc_gate], NULL, "83fdb000.nand");
 
 	/* set the usboh3 parent to pll2_sw */
 	clk_set_parent(clk[usboh3_sel], clk[pll2_sw]);
@@ -455,6 +456,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
+	clk_register_clkdev(clk[nfc_gate], NULL, "63fdb000.nand");
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[esdhc_a_podf], 200000000);
-- 
1.7.10.4
