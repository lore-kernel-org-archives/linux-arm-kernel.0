From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Jun 2013 15:32:09 +0200
Subject: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible string for
 mv64xxx-i2c
In-Reply-To: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv64xxx-i2c embedded in the Armada XP have a new feature to
offload i2c transaction. This new version of the IP come also with
some errata. This lead to the introduction to a another compatible
string.

This commit split the i2c information into armada-370.dtsi and
armada-xp.dtsi. Most of the data remains the same and stay in the
common file Armada-370-xp.dtsi. With this new feature the size of the
registers are bigger for Armada XP and the new compatible string is
used.

The Device Tree binding documentation is updated accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 13 ++++++++++++-
 arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
 arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi                      | 10 ++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index a1ee681..ce7af6a 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -4,7 +4,8 @@
 Required properties :
 
  - reg             : Offset and length of the register set for the device
- - compatible      : Should be "marvell,mv64xxx-i2c"
+ - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv7230-i2c"
+for controller which support the I2C Transaction Generator
  - interrupts      : The interrupt number
 
 Optional properties :
@@ -20,3 +21,13 @@ Examples:
 		interrupts = <29>;
 		clock-frequency = <100000>;
 	};
+
+For a controller which support the I2C Transaction Generator:
+
+	i2c at 11000 {
+		compatible = "marvell,mv64xxx-i2c", "marvell,mv78230-i2c";
+		reg = <0x11000 0x100>;
+		compatible = "marvell,mv64xxx-i2c";
+		interrupts = <29>;
+		clock-frequency = <100000>;
+	};
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 550eb77..b6f475c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -112,7 +112,6 @@
 
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
-				reg = <0x11000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <31>;
@@ -123,7 +122,6 @@
 
 			i2c1: i2c at 11100 {
 				compatible = "marvell,mv64xxx-i2c";
-				reg = <0x11100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <32>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index aee2b18..39b26d6 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -155,6 +155,14 @@
 				};
 			};
 
+			i2c0: i2c at 11000 {
+				reg = <0x11000 0x20>;
+			};
+
+			i2c1: i2c at 11100 {
+				reg = <0x11100 0x20>;
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 5b902f9..c2c357e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -134,6 +134,16 @@
 				};
 			};
 
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c", "marvell,mv78230-i2c";
+				reg = <0x11000 0x100>;
+			};
+
+			i2c1: i2c at 11100 {
+				compatible = "marvell,mv64xxx-i2c", "marvell,mv78230-i2c";
+				reg = <0x11100 0x100>;
+			};
+
 			usb at 50000 {
 				clocks = <&gateclk 18>;
 			};
-- 
1.8.1.2
