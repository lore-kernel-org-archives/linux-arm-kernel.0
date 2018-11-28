From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 28 Nov 2018 17:20:06 -0200
Subject: [PATCH] ARM: dts: imx7d-pico: Describe the Wifi clock
Message-ID: <1543432806-11949-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D 
CLKO2 output pin, so describe the pinmux and clock hierarchy in the 
device tree to allow the Wifi chip to be properly clocked.

Managed to successfully test Wifi with such change. Used the standard
nvram.txt file provided by Technexion, which selects an external 32kHz
clock for the Wifi chip by default.

Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx7d-pico.dtsi | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 4846df0..934a019 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -101,6 +101,19 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
+			  <&clks IMX7D_CLKO2_ROOT_DIV>;
+	assigned-clock-parents = <&clks IMX7D_CKIL>;
+	assigned-clock-rates = <0>, <32768>;
 };
 
 &i2c4 {
@@ -200,12 +213,13 @@
 
 &usdhc2 { /* Wifi SDIO */
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-0 = <&pinctrl_usdhc2 &pinctrl_wifi_clk>;
 	no-1-8-v;
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
 	vmmc-supply = <&reg_ap6212>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
 
@@ -302,6 +316,12 @@
 };
 
 &iomuxc_lpsr {
+	pinctrl_wifi_clk: wificlkgrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO03__CCM_CLKO2	0x7d
+		>;
+	};
+
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
-- 
2.7.4
