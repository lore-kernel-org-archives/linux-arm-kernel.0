From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Jan 2015 15:10:00 +0100
Subject: [PATCH 5/7] ARM: dts: mt8135: Add pericfg,
 infracfg and pmic wrapper nodes
In-Reply-To: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
References: <1422022202-7526-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1422022202-7526-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the perisys, infracfg and pmic wrapper nodes to the
MediaTek MT8135 dtsi file.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/mt8135.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 7d56a98..14ba41d 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -14,6 +14,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset-controller/mt8135-resets.h>
 #include "skeleton64.dtsi"
 
 / {
@@ -86,6 +87,12 @@
 			clock-frequency = <32000>;
 			#clock-cells = <0>;
 		};
+
+		clk_26m: clk26m {
+			compatible = "fixed-clock";
+			clock-frequency = <26000000>;
+			#clock-cells = <0>;
+		};
 	};
 
 	soc {
@@ -94,6 +101,33 @@
 		compatible = "simple-bus";
 		ranges;
 
+		infracfg: infracfg at 10001000 {
+			#reset-cells = <1>;
+			#clock-cells = <1>;
+			compatible = "mediatek,mt8135-infracfg";
+			reg = <0 0x10001000 0 0x1000>;
+		};
+
+		pericfg: pericfg at 10003000 {
+			#reset-cells = <1>;
+			#clock-cells = <1>;
+			compatible = "mediatek,mt8135-pericfg";
+			reg = <0 0x10003000 0 0x1000>;
+		};
+
+		pwrap: pwrap at 1000f000 {
+			compatible = "mediatek,mt8135-pwrap";
+			reg = <0 0x1000f000 0 0x1000>,
+				<0 0x11017000 0 0x1000>;
+			reg-names = "pwrap-base", "pwrap-bridge-base";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
+					<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+			reset-names = "pwrap", "pwrap-bridge";
+			clocks = <&clk_26m>, <&clk_26m>;
+			clock-names = "spi", "wrap";
+		};
+
 		timer: timer at 10008000 {
 			compatible = "mediatek,mt8135-timer",
 					"mediatek,mt6577-timer";
-- 
2.1.4
