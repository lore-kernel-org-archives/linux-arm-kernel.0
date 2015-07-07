From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jul 2015 14:45:11 +0200
Subject: [PATCH 2/4] ARM: dts: mt8135: Add pmic wrapper nodes
In-Reply-To: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
References: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1436273113-25472-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the pmic wrapper node to the MediaTek MT8135 dtsi file.

This unit is used to access the PMIC on MediaTek boards.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index b99e488..36ff82a 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/mt8135-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset-controller/mt8135-resets.h>
 #include "skeleton64.dtsi"
 #include "mt8135-pinfunc.h"
 
@@ -160,6 +161,19 @@
 			clock-names = "system-clk", "rtc-clk";
 		};
 
+		pwrap: pwrap at 1000f000 {
+			compatible = "mediatek,mt8135-pwrap";
+			reg = <0 0x1000f000 0 0x1000>,
+				<0 0x11017000 0 0x1000>;
+			reg-names = "pwrap", "pwrap-bridge";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
+					<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+			reset-names = "pwrap", "pwrap-bridge";
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "spi", "wrap";
+		};
+
 		sysirq: interrupt-controller at 10200030 {
 			compatible = "mediatek,mt8135-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
2.1.4
