From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:28:14 +0100
Subject: [PATCHv3 10/12] arm: mvebu: define and use common Armada XP SPI
 pinctrl setting
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <aca62306a1fc94cb9db68c656d92e5026bdfe842.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada XP pinctrl settings in armada-xp.dtsi
for the supported SPI interface (MPP36-39) and use it as default
for Armada XP spi interface.

Note: this patch has the potential to break out-of-tree users w/o
specific pinctrl settings for their spi interfaces if the default
above does not match their config (i.e. if they do not use CS0).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts |  7 -------
 arch/arm/boot/dts/armada-xp.dtsi          | 11 +++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 7a6e50632a1f..804496edac9a 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -69,11 +69,6 @@
 					marvell,function = "gpio";
 				};
 
-				pmx_spi: pmx-spi {
-					marvell,pins = "mpp36", "mpp37", "mpp38", "mpp39";
-					marvell,function = "spi";
-				};
-
 				pmx_phy_int: pmx-phy-int {
 					marvell,pins = "mpp32";
 					marvell,function = "gpio";
@@ -120,8 +115,6 @@
 
 			spi0: spi at 10600 {
 				status = "okay";
-				pinctrl-0 = <&pmx_spi>;
-				pinctrl-names = "default";
 
 				spi-flash at 0 {
 					#address-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 4f685f7ec273..51454de322b1 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -72,6 +72,17 @@
 						       "mpp20", "mpp21", "mpp22", "mpp23";
 					marvell,function = "ge1";
 				};
+
+				spi0_pins: spi0-pins {
+					marvell,pins = "mpp36", "mpp37",
+						       "mpp38", "mpp39";
+					marvell,function = "spi";
+				};
+			};
+
+			spi0: spi at 10600 {
+				pinctrl-0 = <&spi0_pins>;
+				pinctrl-names = "default";
 			};
 
 			i2c0: i2c at 11000 {
-- 
2.1.1
