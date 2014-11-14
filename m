From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Nov 2014 16:21:34 +0100
Subject: [PATCHv2 14/16] ARM: mvebu: add suspend/resume DT information for
 Armada XP GP
In-Reply-To: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1415978496-9334-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit improves the Armada XP GP Device Tree description to
describe the 3 GPIOs that are used to connect the SoC to the PIC
micro-controller that we talk to shutdown the SoC when entering
suspend to RAM.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 0478c55..ea86736 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -23,6 +23,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-xp-mv78460.dtsi"
 
 / {
@@ -48,6 +49,14 @@
 		      <0x00000001 0x00000000 0x00000001 0x00000000>;
 	};
 
+	cpus {
+		pm_pic {
+			ctrl-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>,
+				     <&gpio0 17 GPIO_ACTIVE_LOW>,
+				     <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
@@ -115,7 +124,15 @@
 			serial@12300 {
 				status = "okay";
 			};
-
+			pinctrl {
+				pinctrl-0 = <&pic_pins>;
+				pinctrl-names = "default";
+				pic_pins: pic-pins-0 {
+					marvell,pins = "mpp16", "mpp17",
+						       "mpp18";
+					marvell,function = "gpio";
+				};
+			};
 			sata at a0000 {
 				nr-ports = <2>;
 				status = "okay";
-- 
2.1.0
