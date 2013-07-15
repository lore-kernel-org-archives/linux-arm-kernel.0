From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Jul 2013 18:33:42 +0300
Subject: [PATCH 3/4] arm: omap5: dts: add palmas-usb node
In-Reply-To: <1373902423-28654-1-git-send-email-balbi@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
Message-ID: <1373902423-28654-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this node, there will be no palmas
driver to notify dwc3 that a cable has
been connected and, without that, dwc3
will never initialize.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 10 ++++++++++
 arch/arm/boot/dts/omap5.dtsi     |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..badceb8 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -272,6 +272,11 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		extcon_usb3: palmas_usb {
+			compatible = "ti,palmas-usb";
+			ti,wakeup;
+		};
+
 		palmas_pmic {
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
@@ -450,6 +455,11 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
+&usb3 {
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_reg>;
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
