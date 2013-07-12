From: balbi@ti.com (Felipe Balbi)
Date: Fri, 12 Jul 2013 19:14:41 +0300
Subject: [PATCH] arm: omap5: dts: add palmas-usb node
Message-ID: <1373645681-29779-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this node, there will be no palmas
driver to notify dwc3 that a cable has
been connected and, without that, dwc3
will never initialize.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

after this, all we need is wait EXTCON merge
which contains the final changes necessary
to get USB3 working out of the box.

I'd suggest waiting on this patch until EXTCON
reaches mainline, just to make sure we don't
end up with DTS data for devices which don't
exist.

cheers

 arch/arm/boot/dts/omap5-uevm.dts | 9 +++++++++
 arch/arm/boot/dts/omap5.dtsi     | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..7fe0e2b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -280,6 +280,11 @@
 
 			ti,ldo6-vibrator;
 
+			extcon_usb3: palmas_usb {
+				compatible = "ti,palmas-usb";
+				ti,wakeup;
+			};
+
 			regulators {
 				smps123_reg: smps123 {
 					regulator-name = "smps123";
@@ -450,6 +455,10 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
+&usb3 {
+	extcon = <&extcon_usb3>;
+};
+
 &mcspi1 {
 
 };
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 4e41409..1659246 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -634,7 +634,7 @@
 			ti,type = <2>;
 		};
 
-		omap_dwc3 at 4a020000 {
+		usb3: omap_dwc3 at 4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
 			reg = <0x4a020000 0x10000>;
-- 
1.8.2.1
