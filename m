From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:56 +0200
Subject: [PATCH 19/21] arm: kirkwood: ts219: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

This allows the pinctrl subsystem to show in debugfs to which device
is related which pins, for example:

pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts |    8 ++++----
 arch/arm/boot/dts/kirkwood-ts219-6282.dts |    8 ++++----
 arch/arm/boot/dts/kirkwood-ts219.dtsi     |   10 ++++++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 8295c83..a2a90c4 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -7,10 +7,7 @@
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
-			pinctrl-0 = < &pmx_uart0 &pmx_uart1 &pmx_spi
-				      &pmx_twsi0 &pmx_sata0 &pmx_sata1
-				      &pmx_ram_size &pmx_reset_button
-				      &pmx_USB_copy_button &pmx_board_id>;
+			pinctrl-0 = <&pmx_ram_size &pmx_board_id>;
 			pinctrl-names = "default";
 
 			pmx_ram_size: pmx-ram-size {
@@ -38,6 +35,9 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <133>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index df3f95d..a4554cb 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -7,10 +7,7 @@
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 
-			pinctrl-0 = < &pmx_uart0 &pmx_uart1 &pmx_spi
-				      &pmx_twsi0 &pmx_sata0 &pmx_sata1
-				      &pmx_ram_size &pmx_reset_button
-				      &pmx_USB_copy_button &pmx_board_id>;
+			pinctrl-0 = <&pmx_ram_size &pmx_board_id>;
 			pinctrl-names = "default";
 
 			pmx_ram_size: pmx-ram-size {
@@ -38,6 +35,9 @@
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_reset_button &pmx_USB_copy_button>;
+		pinctrl-names = "default";
+
 		button at 1 {
 			label = "USB Copy";
 			linux,code = <133>;
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 64ea27c..b9325d4 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -17,6 +17,8 @@
 		i2c at 11000 {
 			status = "okay";
 			clock-frequency = <400000>;
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
 
 			s35390a: s35390a at 30 {
 				compatible = "s35390a";
@@ -26,13 +28,19 @@
 		serial at 12000 {
 			clock-frequency = <200000000>;
 			status = "okay";
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 		};
 		serial at 12100 {
 			clock-frequency = <200000000>;
 			status = "okay";
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
 		};
 		spi at 10600 {
 			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
 
 			m25p128 at 0 {
 				#address-cells = <1>;
@@ -71,6 +79,8 @@
 			};
 		};
 		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <2>;
 		};
-- 
1.7.9.5
