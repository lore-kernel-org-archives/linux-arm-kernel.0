From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 29 Oct 2015 15:14:17 +0800
Subject: [PATCH v1 5/6] arm64: dts: Add main Thermal info to rk3368.dtsi
In-Reply-To: <1446102858-10116-1-git-send-email-wxt@rock-chips.com>
References: <1446102858-10116-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446102858-10116-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the thermal needed info on RK3368.
Meanwhile, support the trips to throttle for thermal.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v1:
- support the opt gpio pinctrl state

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index cc093a4..7207293 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3368";
@@ -123,6 +124,8 @@
 			reg = <0x0 0x0>;
 			cpu-idle-states = <&cpu_sleep>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_l1: cpu at 1 {
@@ -155,6 +158,8 @@
 			reg = <0x0 0x100>;
 			cpu-idle-states = <&cpu_sleep>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_b1: cpu at 101 {
@@ -404,6 +409,27 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		#include "rk3368-thermal.dtsi"
+	};
+
+	tsadc: tsadc at ff280000 {
+		compatible = "rockchip,rk3368-tsadc";
+		reg = <0x0 0xff280000 0x0 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <95000>;
+		status = "disabled";
+	};
+
 	gmac: ethernet at ff290000 {
 		compatible = "rockchip,rk3368-gmac";
 		reg = <0x0 0xff290000 0x0 0x10000>;
@@ -829,6 +855,16 @@
 			};
 		};
 
+		tsadc {
+			otp_out: otp-gpio {
+				rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
+			otp_out: otp-out {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <2 24 RK_FUNC_1 &pcfg_pull_up>,
-- 
1.9.1
