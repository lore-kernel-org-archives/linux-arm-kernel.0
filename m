From: denis@eukrea.com (Denis Carikli)
Date: Thu, 13 Mar 2014 10:18:42 +0100
Subject: [PATCH v4][ 4/8] ARM: dts: imx25.dtsi: Fix USB support.
In-Reply-To: <1394702326-25558-1-git-send-email-denis@eukrea.com>
References: <1394702326-25558-1-git-send-email-denis@eukrea.com>
Message-ID: <1394702326-25558-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v3->v4:
- Added Fabio Estevam's Signed-off-by: it was given
  as a mail response to this patch.
- Moved the compatible of usbphy on top to match the other nodes.
- the usb phy's names were renamed from usbphy to usb-phy.
- The patch renaming the fsl,usbphy property in usb-phy was removed.
  So this patch was adapted to that.

Changelog v2->v3:
- rebased on top of the "usb: chipidea: Use standard usb-phy property." patch.
- Fixed the usbphy nodes index and added and added a reg property.

Changelog v1->v2:
- The usbphy nodes were made to look like the ones in imx53.dtsi
- The patch was rebased on top of the clock fixes commits.
---
 arch/arm/boot/dts/imx25.dtsi |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 829791e..18f68f3 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -482,22 +482,13 @@
 				clocks = <&clks 99>;
 			};
 
-			usbphy1: usbphy at 1 {
-				compatible = "nop-usbphy";
-				status = "disabled";
-			};
-
-			usbphy2: usbphy at 2 {
-				compatible = "nop-usbphy";
-				status = "disabled";
-			};
-
 			usbotg: usb at 53ff4000 {
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
 				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -507,6 +498,7 @@
 				interrupts = <35>;
 				clocks = <&clks 70>;
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
@@ -516,7 +508,6 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
-				status = "disabled";
 			};
 
 			dryice at 53ffc000 {
@@ -548,4 +539,20 @@
 			};
 		};
 	};
+
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usb-phy at 0 {
+			reg = <0>;
+			compatible = "usb-nop-xceiv";
+		};
+
+		usbphy1: usb-phy at 1 {
+			reg = <1>;
+			compatible = "usb-nop-xceiv";
+		};
+	};
 };
-- 
1.7.9.5
