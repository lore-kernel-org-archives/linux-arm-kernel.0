From: alex.aring@gmail.com (Alexander Aring)
Date: Sun, 29 Nov 2015 17:59:33 +0100
Subject: [PATCHv2 4/4] ARM: bcm2835: update rpi devicetree entries
In-Reply-To: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
References: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
Message-ID: <1448816373-18235-5-git-send-email-alex.aring@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Raspberry Pi devicetree bindings to support the
power domain driver and enable the USB power domain.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 11 +++++++++++
 arch/arm/boot/dts/bcm2835.dtsi     |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..f828202 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/arm/raspberrypi-power.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -20,6 +21,12 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		power: power {
+			compatible = "raspberrypi,bcm2835-power";
+			firmware = <&firmware>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
 
@@ -60,3 +67,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&usb {
+	power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..6d62af0 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -177,7 +177,7 @@
 			status = "disabled";
 		};
 
-		usb at 7e980000 {
+		usb: usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
-- 
2.6.1
