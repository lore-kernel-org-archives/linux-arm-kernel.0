From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 19 Nov 2014 00:02:43 +0100
Subject: [PATCHv4 08/10] arm: mvebu: define and use common Armada XP SPI
 pinctrl setting
In-Reply-To: <cover.1416351425.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
Message-ID: <3761645880ae430085b041ed2d4287e374ccd300.1416351426.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada XP pinctrl settings in armada-xp.dtsi
for the supported SPI interface (MPP36-39) and use it as default
for Armada XP spi interface. That being done, it removes the now
redundant definitions in armada-xp-axpwifiap.dts.

Note: this patch has the potential to break out-of-tree users w/o
specific pinctrl settings for their spi interfaces if the default
above does not match their config (i.e. if they do not use CS0).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts |  7 -------
 arch/arm/boot/dts/armada-xp.dtsi          | 11 +++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 0e53fad111de..c9d25bdbe795 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -100,8 +100,6 @@
 
 			spi0: spi at 10600 {
 				status = "okay";
-				pinctrl-0 = <&pmx_spi>;
-				pinctrl-names = "default";
 
 				spi-flash at 0 {
 					#address-cells = <1>;
@@ -138,11 +136,6 @@
 		marvell,function = "gpio";
 	};
 
-	pmx_spi: pmx-spi {
-		marvell,pins = "mpp36", "mpp37", "mpp38", "mpp39";
-		marvell,function = "spi";
-	};
-
 	pmx_phy_int: pmx-phy-int {
 		marvell,pins = "mpp32";
 		marvell,function = "gpio";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index acb236909649..d095606466ad 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -53,6 +53,11 @@
 				reg = <0x11100 0x100>;
 			};
 
+			spi0: spi at 10600 {
+				pinctrl-0 = <&spi0_pins>;
+				pinctrl-names = "default";
+			};
+
 			uart2: serial at 12200 {
 				compatible = "snps,dw-apb-uart";
 				pinctrl-0 = <&uart2_pins>;
@@ -240,6 +245,12 @@
 		marvell,function = "sd0";
 	};
 
+	spi0_pins: spi0-pins {
+		marvell,pins = "mpp36", "mpp37",
+			       "mpp38", "mpp39";
+		marvell,function = "spi";
+	};
+
 	uart2_pins: uart2-pins {
 		marvell,pins = "mpp42", "mpp43";
 		marvell,function = "uart2";
-- 
2.1.1
