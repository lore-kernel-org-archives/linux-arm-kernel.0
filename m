From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Thu, 23 Oct 2014 17:40:06 +0800
Subject: [PATCH v13 4/5] ARM: dts: add main Thermal info to rk3288
In-Reply-To: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com>
References: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1414057207-1576-5-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is depend on rk3288-thermal.dtsi,or
it will compile error.

If the temperature over a period of time High,over 120C
the resulting TSHUT gave CRU module,let it reset
the entire chip,or via GPIO give PMIC.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cb18bb4..85fc17a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "skeleton.dtsi"
 
 / {
@@ -66,6 +67,7 @@
 				 216000  900000
 				 126000  900000
 			>;
+			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
@@ -346,6 +348,19 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc at ff280000 {
+		compatible = "rockchip,rk3288-tsadc";
+		reg = <0xff280000 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&otp_out>;
+		#thermal-sensor-cells = <1>;
+		hw-shut-temp = <120000>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb at ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
@@ -965,6 +980,12 @@
 			};
 		};
 
+		tsadc {
+			otp_out: otp-out {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_pin: pwm0-pin {
 				rockchip,pins = <7 0 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
