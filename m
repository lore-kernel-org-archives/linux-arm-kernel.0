From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Jun 2013 17:42:23 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: Add the i2c-bridge capability to the
 mv64xxx-i2c
In-Reply-To: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv64xxx-i2c embedded in the Armada XP have a new feature called
i2c-bridge. This commit split the i2c information into armada-370.dtsi
and armada-xp.dtsi. Most of the data remains the same and stay in the
common file Armada-370-xp.dtsi. With this new feature the size of the
registers are bigger for Armada XP and for this SoCs we add a new flag
for the i2c-bridge capability.

The Device Tree binding documentation is updated accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |  6 ++++++
 arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
 arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi                      | 10 ++++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index f46d928..8ede3e7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -8,6 +8,12 @@ Required properties :
  - interrupts      : The interrupt number
  - clock-frequency : Desired I2C bus clock frequency in Hz.
 
+Optional  properties :
+
+- i2c,i2c-bridge : This flag indicate that the i2c controller have the
+  Transaction Generator support and we want to use it. Not all the
+  mv64xxx controller have this feature.
+
 Examples:
 
 	i2c at 11000 {
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
index 5b902f9..db36bfb 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -134,6 +134,16 @@
 				};
 			};
 
+			i2c0: i2c at 11000 {
+				reg = <0x11000 0x100>;
+				i2c,i2c-bridge;
+			};
+
+			i2c1: i2c at 11100 {
+				reg = <0x11100 0x100>;
+				i2c,i2c-bridge;
+			};
+
 			usb at 50000 {
 				clocks = <&gateclk 18>;
 			};
-- 
1.8.1.2
