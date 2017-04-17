From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 17 Apr 2017 23:39:38 +0200
Subject: [PATCH 2/2] ARM: dts: meson8b: inherit meson.dtsi from meson8b.dtsi
In-Reply-To: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
References: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170417213938.22626-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only meson6.dtsi and meson8.dtsi inherit the generic
meson.dtsi. However, since the Meson8b platform is basically a slightly
updated version of Meson8 we can safely inherit meson.dtsi. An indicator
for this are the nodes which are identical in meson.dtsi and
meson8b.dtsi (L2, gic, timer, uart_AO, uart_A, uart_B, uart_C).

Additionally this makes the following devices available on Meson8b which
were not avaialble before (however, since all affected drivers support
Meson6, Meson8 and the whole GX series there's no reason to assume that
they are not working):
- i2c_a and i2c_B
- the IR receiver
- SPFIC (SPI flash controller)
- the dwmac ethernet controller

Differences between Meson8 and Meson8b seem to be:
- ARM Cortex-A5 core instead of Cortex-A9 on Meson8
- dwmac on Meson8b supports RGMII
- small pinctrl updates

Inheriting meson.dtsi makes it easier to maintain by removing duplicate
definitions.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 210 +++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 126 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 828aa49c678c..ef9ac974111c 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -47,11 +47,9 @@
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
-#include "skeleton.dtsi"
+#include "meson.dtsi"
 
 / {
-	interrupt-parent = <&gic>;
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -84,147 +82,107 @@
 			reg = <0x203>;
 		};
 	};
+}; /* end of / */
 
-	soc {
-		compatible = "simple-bus";
+&aobus {
+	pinctrl_aobus: pinctrl at 84 {
+		compatible = "amlogic,meson8b-aobus-pinctrl";
+		reg = <0x84 0xc>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		L2: l2-cache-controller at c4200000 {
-			compatible = "arm,pl310-cache";
-			reg = <0xc4200000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
+		gpio_ao: ao-bank at 14 {
+			reg = <0x14 0x4>,
+				<0x2c 0x4>,
+				<0x24 0x8>;
+			reg-names = "mux", "pull", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aobus 0 130 16>;
 		};
 
-		gic: interrupt-controller at c4301000 {
-			compatible = "arm,cortex-a9-gic";
-			reg = <0xc4301000 0x1000>,
-			      <0xc4300100 0x0100>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-
-		reset: reset-controller at c1104404 {
-			compatible = "amlogic,meson8b-reset";
-			reg = <0xc1104404 0x20>;
-			#reset-cells = <1>;
-		};
-
-		wdt: watchdog at c1109900 {
-			compatible = "amlogic,meson8b-wdt";
-			reg = <0xc1109900 0x8>;
-			interrupts = <0 0 1>;
+		uart_ao_a_pins: uart_ao_a {
+			mux {
+				groups = "uart_tx_ao_a", "uart_rx_ao_a";
+				function = "uart_ao";
+			};
 		};
+	};
+};
 
-		timer at c1109940 {
-			compatible = "amlogic,meson6-timer";
-			reg = <0xc1109940 0x18>;
-			interrupts = <0 10 1>;
-		};
+&cbus {
+	clkc: clock-controller at 4000 {
+		#clock-cells = <1>;
+		compatible = "amlogic,meson8b-clkc";
+		reg = <0x8000 0x4>, <0x4000 0x460>;
+	};
 
-		uart_AO: serial at c81004c0 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc81004c0 0x18>;
-			interrupts = <0 90 1>;
-			clocks = <&clkc CLKID_CLK81>;
-			status = "disabled";
-		};
+	reset: reset-controller at 4404 {
+		compatible = "amlogic,meson8b-reset";
+		reg = <0x4404 0x20>;
+		#reset-cells = <1>;
+	};
 
-		uart_A: serial at c11084c0 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc11084c0 0x18>;
-			interrupts = <0 26 1>;
-			clocks = <&clkc CLKID_CLK81>;
-			status = "disabled";
-		};
+	pwm_ab: pwm at 8550 {
+		compatible = "amlogic,meson8b-pwm";
+		reg = <0x8550 0x10>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
 
-		uart_B: serial at c11084dc {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc11084dc 0x18>;
-			interrupts = <0 75 1>;
-			clocks = <&clkc CLKID_CLK81>;
-			status = "disabled";
-		};
+	pwm_cd: pwm at 8650 {
+		compatible = "amlogic,meson8b-pwm";
+		reg = <0x8650 0x10>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
 
-		uart_C: serial at c1108700 {
-			compatible = "amlogic,meson-uart";
-			reg = <0xc1108700 0x18>;
-			interrupts = <0 93 1>;
-			clocks = <&clkc CLKID_CLK81>;
-			status = "disabled";
-		};
+	pwm_ef: pwm at 86c0 {
+		compatible = "amlogic,meson8b-pwm";
+		reg = <0x86c0 0x10>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
 
-		clkc: clock-controller at c1104000 {
-			#clock-cells = <1>;
-			compatible = "amlogic,meson8b-clkc";
-			reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
-		};
+	wdt: watchdog at 9900 {
+		compatible = "amlogic,meson8b-wdt";
+		reg = <0x9900 0x8>;
+		interrupts = <0 0 1>;
+	};
 
-		pwm_ab: pwm at 8550 {
-			compatible = "amlogic,meson8b-pwm";
-			reg = <0xc1108550 0x10>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
+	pinctrl_cbus: pinctrl at 9880 {
+		compatible = "amlogic,meson8b-cbus-pinctrl";
+		reg = <0x9880 0x10>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
 
-		pwm_cd: pwm at 8650 {
-			compatible = "amlogic,meson8b-pwm";
-			reg = <0xc1108650 0x10>;
-			#pwm-cells = <3>;
-			status = "disabled";
+		gpio: banks at 80b0 {
+			reg = <0x80b0 0x28>,
+				<0x80e8 0x18>,
+				<0x8120 0x18>,
+				<0x8030 0x38>;
+			reg-names = "mux", "pull", "pull-enable", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_cbus 0 0 130>;
 		};
+	};
+};
 
-		pwm_ef: pwm at 86c0 {
-			compatible = "amlogic,meson8b-pwm";
-			reg = <0xc11086c0 0x10>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
+&uart_AO {
+	clocks = <&clkc CLKID_CLK81>;
+};
 
-		pinctrl_cbus: pinctrl at c1109880 {
-			compatible = "amlogic,meson8b-cbus-pinctrl";
-			reg = <0xc1109880 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			gpio: banks at c11080b0 {
-				reg = <0xc11080b0 0x28>,
-				      <0xc11080e8 0x18>,
-				      <0xc1108120 0x18>,
-				      <0xc1108030 0x38>;
-				reg-names = "mux", "pull", "pull-enable", "gpio";
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl_cbus 0 0 130>;
-			};
-		};
+&uart_A {
+	clocks = <&clkc CLKID_CLK81>;
+};
 
-		pinctrl_aobus: pinctrl at c8100084 {
-			compatible = "amlogic,meson8b-aobus-pinctrl";
-			reg = <0xc8100084 0xc>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			gpio_ao: ao-bank at c1108030 {
-				reg = <0xc8100014 0x4>,
-				      <0xc810002c 0x4>,
-				      <0xc8100024 0x8>;
-				reg-names = "mux", "pull", "gpio";
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl_aobus 0 130 16>;
-			};
+&uart_B {
+	clocks = <&clkc CLKID_CLK81>;
+};
 
-			uart_ao_a_pins: uart_ao_a {
-				mux {
-					groups = "uart_tx_ao_a", "uart_rx_ao_a";
-					function = "uart_ao";
-				};
-			};
-		};
-	};
-}; /* end of / */
+&uart_C {
+	clocks = <&clkc CLKID_CLK81>;
+};
-- 
2.12.2
