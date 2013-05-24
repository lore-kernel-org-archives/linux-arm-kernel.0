From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:38 +0200
Subject: [PATCH 01/21] arm: kirkwood: cloudbox: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-2-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-cloudbox.dts |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 5f21d4e..00c48d2 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -18,10 +18,6 @@
 
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = < &pmx_spi &pmx_uart0
-					&pmx_cloudbox_sata0 >;
-			pinctrl-names = "default";
-
 			pmx_cloudbox_sata0: pmx-cloudbox-sata0 {
 				marvell,pins = "mpp15";
 				marvell,function = "sata0";
@@ -29,16 +25,22 @@
 		};
 
 		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 			clock-frequency = <166666667>;
 			status = "okay";
 		};
 
 		sata at 80000 {
+			pinctrl-0 = <&pmx_cloudbox_sata0>;
+			pinctrl-names = "default";
 			status = "okay";
 			nr-ports = <1>;
 		};
 
 		spi at 10600 {
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
 			status = "okay";
 
 			flash at 0 {
-- 
1.7.9.5
