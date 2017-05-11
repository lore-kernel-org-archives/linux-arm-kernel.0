From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 11 May 2017 15:29:24 +0200
Subject: [PATCH 4/5] dt-bindings: phy: Modify Broadcom NS USB 3.0 PHY binding
 to use MDIO
In-Reply-To: <20170511132925.14564-1-zajec5@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
Message-ID: <20170511132925.14564-5-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Thanks to work done by Broadcom explaining their USB 3.0 PHY details we
know it's attached to the MDIO bus. Use this knowledge to update the
binding: make it a subnode to the MDIO bus and rework way of specifying
required registers.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../devicetree/bindings/phy/bcm-ns-usb3-phy.txt    | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
index 09aeba94538d..32f057260351 100644
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
+++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
@@ -3,9 +3,10 @@ Driver for Broadcom Northstar USB 3.0 PHY
 Required properties:
 
 - compatible: one of: "brcm,ns-ax-usb3-phy", "brcm,ns-bx-usb3-phy".
-- reg: register mappings for DMP (Device Management Plugin) and ChipCommon B
-       MMI.
-- reg-names: "dmp" and "ccb-mii"
+- reg: address of MDIO bus device
+- usb3-dmp-syscon: phandle to syscon with DMP (Device Management Plugin)
+		   registers
+- #phy-cells: must be 0
 
 Initialization of USB 3.0 PHY depends on Northstar version. There are currently
 three known series: Ax, Bx and Cx.
@@ -15,9 +16,19 @@ Known B1: BCM4707 rev 6
 Known C0: BCM47094 rev 0
 
 Example:
-	usb3-phy {
-		compatible = "brcm,ns-ax-usb3-phy";
-		reg = <0x18105000 0x1000>, <0x18003000 0x1000>;
-		reg-names = "dmp", "ccb-mii";
-		#phy-cells = <0>;
+	mdio: mdio at 0 {
+		reg = <0x0>;
+		#size-cells = <1>;
+		#address-cells = <0>;
+
+		usb3-phy at 10 {
+			compatible = "brcm,ns-ax-usb3-phy";
+			reg = <0x10>;
+			usb3-dmp-syscon = <&usb3_dmp>;
+			#phy-cells = <0>;
+		};
+	};
+
+	usb3_dmp: syscon at 18105000 {
+		reg = <0x18105000 0x1000>;
 	};
-- 
2.11.0
