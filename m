From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 12 Aug 2013 15:47:55 +0530
Subject: [PATCH v3] arm: omap5: dts: add palmas-usb node
In-Reply-To: <1373979037-27587-1-git-send-email-balbi@ti.com>
References: <1373979037-27587-1-git-send-email-balbi@ti.com>
Message-ID: <1376302675-15795-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

Without this node, there will be no palmas
driver to notify dwc3 that a cable has
been connected and, without that, dwc3
will never initialize.

[ kishon at ti.com : fix vbus-supply value after SMPS10 is modeled as 2 regulators]

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change from v2:
fix vbus-supply value after SMPS10 is modeled as 2 regulators. This is needed
after SMPS10 is modeled as 2 regulators.
[1] models SMPS10 as 2 regulators.
[2] splits the SMPS10 node into two to represent the 2 regulators.

[1] -> http://comments.gmane.org/gmane.linux.kernel/1542521
[2] -> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg93779.html

 arch/arm/boot/dts/omap5-uevm.dts |   10 ++++++++++
 arch/arm/boot/dts/omap5.dtsi     |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..51a4acc 100644
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
+	vbus-supply = <&smps10_out1_reg>;
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
1.7.10.4
