From: rogerq@ti.com (Roger Quadros)
Date: Mon, 19 Aug 2013 13:37:46 +0300
Subject: [PATCH v4 7/8] ARM: dts: omap4: update omap-control-usb nodes
In-Reply-To: <1376908667-14974-1-git-send-email-rogerq@ti.com>
References: <1376908667-14974-1-git-send-email-rogerq@ti.com>
Message-ID: <1376908667-14974-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split otghs_ctrl and USB2 PHY power down into separate
omap-control-usb nodes. Get rid of "ti,type" property.

Also get rid of "ti,has-mailbox" property from usb_otg_hs
node and provide the ctrl-module phandle.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..a77dd0a 100644
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
-			compatible = "ti,omap-control-usb";
-			reg = <0x4a002300 0x4>,
-			      <0x4a00233c 0x4>;
-			reg-names = "control_dev_conf", "otghs_control";
-			ti,type = <1>;
+		omap_control_usb2phy: omap-control-usb at 4a002300 {
+			compatible = "ti,usb2-control-usb";
+			reg = <0x4a002300 0x4>;
+			reg-names = "power";
+		};
+
+		omap_control_usbotg: omap-control-usb at 4a00233c {
+			compatible = "ti,omap4-control-usb";
+			reg = <0x4a00233c 0x4>;
+			reg-names = "otghs_control";
 		};
 
 		usb_otg_hs: usb_otg_hs at 4a0ab000 {
@@ -661,7 +665,7 @@
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-			ti,has-mailbox;
+			ctrl-module = <&omap_control_usbotg>;
 		};
 	};
 };
-- 
1.7.4.1
