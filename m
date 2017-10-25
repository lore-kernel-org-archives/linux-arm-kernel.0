From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 25 Oct 2017 13:40:42 -0200
Subject: [PATCH v4] ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with unit
 name and no reg property
Message-ID: <1508946042-17671-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has a unit name, but no reg property

Fix this warning by adding reg property from such node and, consequently, 
by adding the 'address-cells' and 'size-cells' values to the fec node to 
avoid the warnings below:

Warning (reg_format): "reg" property in /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/aips at 60000000/ethernet at 63fec000/ethernet-phy at 0

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Change since v3:
-remove from a group of patches
-add 'address-cells' and 'size-cells' values to the fec node
-change message log
 arch/arm/boot/dts/imx53-tx53.dtsi | 1 +
 arch/arm/boot/dts/imx53.dtsi      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 71b58b6..655d51a 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -226,6 +226,7 @@
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
+		reg = <0>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
 		device_type = "ethernet-phy";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c937949..be487b1 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -770,6 +770,8 @@
 			};
 
 			fec: ethernet at 63fec000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
 				reg = <0x63fec000 0x4000>;
 				interrupts = <87>;
-- 
2.7.4
