From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Apr 2015 16:14:09 -0700
Subject: [PATCH 3/3] ARM: bcm2835: Add the necessary firmware driver
 information to the DT
In-Reply-To: <1430176449-12322-1-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
Message-ID: <1430176449-12322-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets the USB power domain turned on so that DWC2 can probe, even
if the bootloader didn't turn it on for us (which is the case if you
use the RPi firmware without chainloading U-Boot).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/bcm2835.dtsi     |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 46780bb..fa9afd1 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/arm/raspberrypi-firmware-power.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -14,6 +15,14 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	soc {
+		firmware: firmware {
+			compatible = "raspberrypi,firmware";
+			mboxes = <&mailbox 0>;
+			#power-domain-cells = <1>;
+		};
+	};
 };
 
 &gpio {
@@ -49,3 +58,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&usb {
+	power-domains = <&firmware POWER_DOMAIN_USB>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 664aa25..5734650 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -148,7 +148,7 @@
 			status = "disabled";
 		};
 
-		usb at 7e980000 {
+		usb: usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
-- 
2.1.4
