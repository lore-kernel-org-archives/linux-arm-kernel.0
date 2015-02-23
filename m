From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:55:35 +0000
Subject: [PATCH 06/12] ARM: DT: apq8064: add pci support in CM QS600
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678135-13178-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>

This patch adds PCIE support to APQ8064, tested with Ethernet on Compulab QS600 board.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 5d75666..6e62f24 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -1,4 +1,5 @@
 #include "qcom-apq8064-v2.0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "CompuLab CM-QS600";
@@ -40,6 +41,24 @@
 			};
 		};
 
+		/* on board fixed 3.3v supply */
+		v3p3_pcieclk: v3p3-pcieclk {
+			compatible = "regulator-fixed";
+			regulator-name = "PCIE V3P3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		pci at 1b500000 {
+			status = "ok";
+			pcie-clk-supply	= <&v3p3_pcieclk>;
+			avdd-supply	= <&pm8921_s3>;
+			vdd-supply	= <&pm8921_lvs6>;
+			qcom,external-phy-refclk;
+			reset-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
-- 
1.9.1
