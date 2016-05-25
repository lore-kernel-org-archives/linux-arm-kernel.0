From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 25 May 2016 15:39:35 +0800
Subject: [RESEND PATCH] ARM64: dts: rockchip: add thermal zone node for rk3399
 SoCs
Message-ID: <1464161975-31299-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds thermal zone node to rk3399 dtsi, rk3399 thermal data is
including the cpu and gpu sensor zone node.

The thermal zone node is the node containing all the required info
for describing a thermal zone, including its cooling device bindings.
The thermal zone node must contain, apart from its own properties, one
sub-node containing trip nodes and one sub-node containing all the zone
cooling maps.

The following is the parameter is introduced:
* polling-delay:
The maximum number of milliseconds to wait between polls

* polling-delay-passive:
The maximum number of milliseconds to wait between polls when performing
passive cooling.

* trips:
A sub-node which is a container of only trip point nodes required to
describe the thermal zone.

* cooling-maps:
A sub-node which is a container of only cooling device map nodes, used to
describe the relation between trips and cooling devices.

* cooling-device:
A phandle of a cooling device with its specifier, referring to which
cooling device is used in this cooling specifier binding. In the cooling
specifier, the first cell is the minimum cooling state and the second cell
is the maximum cooling state used in this map.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 100 +++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 46f325a..f8a80c2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3399";
@@ -389,6 +390,95 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert1: cpu_alert1 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_crit: cpu_crit {
+					temperature = <95000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				gpu_alert0: gpu_alert0 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				gpu_crit: gpu_crit {
+					temperature = <95000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	tsadc: tsadc at ff260000 {
+		compatible = "rockchip,rk3399-tsadc";
+		reg = <0x0 0xff260000 0x0 0x100>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <750000>;
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
 	pmugrf: syscon at ff320000 {
 		compatible = "rockchip,rk3399-pmugrf", "syscon";
 		reg = <0x0 0xff320000 0x0 0x1000>;
@@ -881,6 +971,16 @@
 			};
 		};
 
+		tsadc {
+			otp_gpio: otp-gpio {
+				rockchip,pins = <1 6 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
+			otp_out: otp-out {
+				rockchip,pins = <1 6 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins =
-- 
1.9.1
