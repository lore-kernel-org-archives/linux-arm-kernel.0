From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:48 +0200
Subject: [PATCH 11/21] arm: kirkwood: ns2: affect pinmux configs to the right
 devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-12-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-is2.dts         |    2 ++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi |   10 ++++++----
 arch/arm/boot/dts/kirkwood-ns2.dts         |    2 ++
 arch/arm/boot/dts/kirkwood-ns2lite.dts     |    2 ++
 arch/arm/boot/dts/kirkwood-ns2max.dts      |    2 ++
 arch/arm/boot/dts/kirkwood-ns2mini.dts     |    2 ++
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
index 0bdce0a..c3f036b 100644
--- a/arch/arm/boot/dts/kirkwood-is2.dts
+++ b/arch/arm/boot/dts/kirkwood-is2.dts
@@ -13,6 +13,8 @@
 
 	ocp at f1000000 {
 		sata at 80000 {
+			pinctrl-0 = <&pmx_ns2_sata0>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <1>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 6affd92..2afac04 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -8,10 +8,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = < &pmx_spi &pmx_twsi0 &pmx_uart0
-					&pmx_ns2_sata0 &pmx_ns2_sata1>;
-			pinctrl-names = "default";
-
 			pmx_ns2_sata0: pmx-ns2-sata0 {
 				marvell,pins = "mpp21";
 				marvell,function = "sata0";
@@ -23,10 +19,14 @@
 		};
 
 		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 			status = "okay";
 		};
 
 		spi at 10600 {
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
 			status = "okay";
 
 			flash at 0 {
@@ -45,6 +45,8 @@
 		};
 
 		i2c at 11000 {
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
 			status = "okay";
 
 			eeprom at 50 {
diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
index f2d36ecf..b50e93d 100644
--- a/arch/arm/boot/dts/kirkwood-ns2.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2.dts
@@ -13,6 +13,8 @@
 
 	ocp at f1000000 {
 		sata at 80000 {
+			pinctrl-0 = <&pmx_ns2_sata0>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <1>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index b02eb4e..af8259f 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -13,6 +13,8 @@
 
 	ocp at f1000000 {
 		sata at 80000 {
+			pinctrl-0 = <&pmx_ns2_sata0>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <1>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
index bcec4d6..85f24d2 100644
--- a/arch/arm/boot/dts/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
@@ -13,6 +13,8 @@
 
 	ocp at f1000000 {
 		sata at 80000 {
+			pinctrl-0 = <&pmx_ns2_sata0 &pmx_ns2_sata1>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <2>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index adab1ab..329e530 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -14,6 +14,8 @@
 
 	ocp at f1000000 {
 		sata at 80000 {
+			pinctrl-0 = <&pmx_ns2_sata0>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <1>;
 		};
-- 
1.7.9.5
