From: marco.franchi@nxp.com (Marco Franchi)
Date: Thu, 26 Oct 2017 13:25:14 -0200
Subject: [PATCH v5] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with unit
 name and no reg property
Message-ID: <1509031514-30602-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property

Fix this warning by adding reg property from such node and, consequently, 
includes a mdio node into the fec node, with the 'address-cells' and 
'size-cells' to avoid these other following warnings:

Warning (reg_format): "reg" property in /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Change since v4:
-pass the 'address-cells' and 'size-cells' values using a mdio node
-change message log
 arch/arm/boot/dts/imx53-tx53.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 71b58b6..a22e461 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -225,10 +225,16 @@
 	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
 	status = "okay";
 
-	phy0: ethernet-phy at 0 {
-		interrupt-parent = <&gpio2>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		device_type = "ethernet-phy";
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 0 {
+			reg = <0>;
+			interrupt-parent = <&gpio2>;
+			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+			device_type = "ethernet-phy";
+		};
 	};
 };
 
-- 
2.7.4
