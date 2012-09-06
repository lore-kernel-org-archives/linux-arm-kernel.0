From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  6 Sep 2012 14:48:14 +0200
Subject: [PATCH 8/9] ARM i.MX53: Add pwm support
In-Reply-To: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1346935695-25179-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 arch/arm/boot/dts/imx53.dtsi        |   14 ++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c |    4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..18b9fc3 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -189,6 +189,20 @@
 				status = "disabled";
 			};
 
+			pwm1: pwm at 53fb4000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
+				reg = <0x53fb4000 0x4000>;
+				interrupts = <61>;
+			};
+
+			pwm2: pwm at 53fb8000 {
+				#pwm-cells = <2>;
+				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
+				reg = <0x53fb8000 0x4000>;
+				interrupts = <94>;
+			};
+
 			uart1: serial at 53fbc000 {
 				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
 				reg = <0x53fbc000 0x4000>;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 4bdcaa9..b522411 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -455,6 +455,10 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
+	clk_register_clkdev(clk[pwm1_ipg_gate], "ipg", "53fb4000.pwm");
+	clk_register_clkdev(clk[pwm1_hf_gate], "per", "53fb4000.pwm");
+	clk_register_clkdev(clk[pwm2_ipg_gate], "ipg", "53fb8000.pwm");
+	clk_register_clkdev(clk[pwm2_hf_gate], "per", "53fb8000.pwm");
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[esdhc_a_podf], 200000000);
-- 
1.7.10.4
