From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 16:15:11 +0300
Subject: [PATCH v2 7/8] ARM: dts: omap4: update omap-control-usb nodes
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Message-ID: <1376572512-9561-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split otghs_ctrl and USB2 PHY power down into separate
omap-control-usb nodes. Get rid of "ti,type" property.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..ca08cf2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -519,7 +519,7 @@
 			usb2_phy: usb2phy at 4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
-				ctrl-module = <&omap_control_usb>;
+				ctrl-module = <&omap_control_usb2phy>;
 			};
 		};
 
@@ -643,12 +643,16 @@
 			};
 		};
 
-		omap_control_usb: omap-control-usb at 4a002300 {
+		omap_control_usb2phy: omap-control-usb at 4a002300 {
+			compatible = "ti,usb2-control-usb";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usbotg: omap-control-usb at 4a00233c {
 			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a00233c 0x4>;
-			reg-names = "control_dev_conf", "otghs_control";
-			ti,type = <1>;
+			reg = <0x4a00233c 0x4>;
+			reg-names = "otghs_control";
 		};
 
 		usb_otg_hs: usb_otg_hs at 4a0ab000 {
@@ -662,6 +666,7 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 			ti,has-mailbox;
+			ctrl-module = <&omap_control_usbotg>;
 		};
 	};
 };
-- 
1.7.4.1
