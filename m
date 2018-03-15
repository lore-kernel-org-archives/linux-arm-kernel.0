From: npcomplete13@gmail.com (Vivek Unune)
Date: Thu, 15 Mar 2018 09:56:47 -0400
Subject: [PATCH] ARM: dts: BCM5301X:Make usb3 phy use mdio phy driver
Message-ID: <20180315135647.48456-1-npcomplete13@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, usb3 phy in bcm5301x.dtsi uses platform driver which
requires register range "ccb-mii" <0x18003000 0x1000>. This range
overlaps with mdio cmd and param registers (<0x18003000 0x8>).
Essentially, the platform driver partly acts like a mdio bus
driver, hence to use of this register range.

In some Northstar devices like Linksys EA9500, secondary switch
is connected via external mdio. The only way to access and
configure the external switch is via mdio bus. When we enable the
mdio bus in it's current state, the mdio bus and any child buses
fail to register because of the register range overlap.

On Northstar, the usb3 phy is connected at address 0x10 on the
internal mdio bus. This change moves the usb3_phy node and makes
it a child node of internal mdio bus.

Thanks to Rafa? Mi?ecki's commit af850e14a7ae
("phy: bcm-ns-usb3: add MDIO driver using proper bus layer") the
same usb3 platform driver can now act as usb3 phy mdio driver.

Tested on Linksys Panamera (EA9500)

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 arch/arm/boot/dts/bcm47094.dtsi |  7 ++++---
 arch/arm/boot/dts/bcm5301x.dtsi | 34 ++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
index 4840a782fc05..f7c3e274b354 100644
--- a/arch/arm/boot/dts/bcm47094.dtsi
+++ b/arch/arm/boot/dts/bcm47094.dtsi
@@ -7,9 +7,10 @@
 #include "bcm4708.dtsi"
 
 / {
-	usb3_phy: usb3-phy {
-		compatible = "brcm,ns-bx-usb3-phy";
-	};
+};
+
+&usb3_phy {
+	compatible = "brcm,ns-bx-usb3-phy";
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9a076c409f4e..7ba6533f7615 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -154,13 +154,6 @@
 		clock-names = "phy-ref-clk";
 	};
 
-	usb3_phy: usb3-phy {
-		compatible = "brcm,ns-ax-usb3-phy";
-		reg = <0x18105000 0x1000>, <0x18003000 0x1000>;
-		reg-names = "dmp", "ccb-mii";
-		#phy-cells = <0>;
-	};
-
 	axi at 18000000 {
 		compatible = "brcm,bus-axi";
 		reg = <0x18000000 0x1000>;
@@ -359,7 +352,32 @@
 		reg = <0x18003000 0x8>;
 		#size-cells = <1>;
 		#address-cells = <0>;
-		status = "disabled";
+	};
+
+	mdio-bus-mux {
+		compatible = "mdio-mux-mmioreg";
+		mdio-parent-bus = <&mdio>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x18003000 0x4>;
+		mux-mask = <0x200>;
+
+		mdio_int: mdio at 0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb3_phy: usb3-phy at 10 {
+				compatible = "brcm,ns-ax-usb3-phy";
+				reg = <0x10>;
+				usb3-dmp-syscon = <&usb3_dmp>;
+				#phy-cells = <0>;
+			};
+		};
+	};
+
+	usb3_dmp: syscon at 18105000 {
+		reg = <0x18105000 0x1000>;
 	};
 
 	i2c0: i2c at 18009000 {
-- 
2.11.0
