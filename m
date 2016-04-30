From: carlo@caione.org (Carlo Caione)
Date: Sat, 30 Apr 2016 19:21:15 +0200
Subject: [PATCH 2/2] ARM64: dts: amlogic: Enable pin controller on GXBB-based
 platforms
In-Reply-To: <1462036875-22625-1-git-send-email-carlo@caione.org>
References: <1462036875-22625-1-git-send-email-carlo@caione.org>
Message-ID: <1462036875-22625-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Update DTS and DTSI files to enable the pin controller. We also now
support the blinking blue LED on the Odroid-C2.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 13 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  2 ++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  3 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 41 ++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 7f2c674..41e1e66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -45,6 +45,7 @@
 /dts-v1/;
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
@@ -62,8 +63,20 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		blue {
+			label = "c2:blue:alive";
+			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
 };
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index bf7ff1d..22e6298 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -62,4 +62,6 @@
 /* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 012cdcc..54bb7c7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -56,4 +56,7 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 3126f0c..6dd2768 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/meson-gxbb-gpio.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -158,6 +159,29 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
+			pinctrl_aobus: pinctrl at 14 {
+				compatible = "amlogic,meson-gxbb-aobus-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio_ao: bank at 14 {
+					reg = <0x0 0x00014 0x0 0x8>,
+					      <0x0 0x0002c 0x0 0x4>,
+					      <0x0 0x00024 0x0 0x8>;
+					reg-names = "mux", "pull", "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
+				uart_ao_a_pins: uart_ao_a {
+					mux {
+						groups = "uart_tx_ao_a", "uart_rx_ao_a";
+						function = "uart_ao";
+					};
+				};
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
@@ -173,6 +197,23 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc8834000 0x0 0x2000>;
+
+			pinctrl_periphs: pinctrl at 4b0 {
+				compatible = "amlogic,meson-gxbb-periphs-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio: bank at 4b0 {
+					reg = <0x0 0x004b0 0x0 0x28>,
+					      <0x0 0x004e8 0x0 0x14>,
+					      <0x0 0x00120 0x0 0x14>,
+					      <0x0 0x00430 0x0 0x40>;
+					reg-names = "mux", "pull", "pull-enable", "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
 		};
 
 		hiubus: hiubus at c883c000 {
-- 
2.7.4
