From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:27:42 +0100
Subject: [PATCHv3 06/12] arm: mvebu: define and use common Armada 370 SPI
 pinctrl settings
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <153bdd2b24b1760a264e5f2b5db83da1939a1306.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada 370 pinctrl settings for spi0 and spi1
interfaces:

 spi0: MPP33-36 as default, MPP32,63-65 as available alternate config
 spi1: MPP49-52 as default

Currently, the Armada 370 DB .dts file has no explicit pinctrl info
for the spi0 interface used to access the flash on the board. The
patch fixes that by also adding explicit pinctrl info (MPP32,63-65)
for this SPI interface.

Note: this patch has the potential to break out-of-tree users w/o
specific pinctrl settings for their spi interfaces if the default
above does not match their config.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-db.dts |  2 ++
 arch/arm/boot/dts/armada-370.dtsi   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index a495e5821ab8..c73fe9a91e59 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -135,6 +135,8 @@
 			};
 
 			spi0: spi at 10600 {
+				pinctrl-0 = <&spi0_pins2>;
+				pinctrl-names = "default";
 				status = "okay";
 
 				spi-flash at 0 {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 2040da11462b..901806f35f40 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -114,6 +114,24 @@
 			pinctrl {
 				compatible = "marvell,mv88f6710-pinctrl";
 
+				spi0_pins1: spi0-pins1 {
+					marvell,pins = "mpp33", "mpp34",
+						       "mpp35", "mpp36";
+					marvell,function = "spi0";
+				};
+
+				spi0_pins2: spi0_pins2 {
+					marvell,pins = "mpp32", "mpp63",
+						       "mpp64", "mpp65";
+					marvell,function = "spi0";
+				};
+
+				spi1_pins: spi1-pins {
+					marvell,pins = "mpp49", "mpp50",
+						       "mpp51", "mpp52";
+					marvell,function = "spi1";
+				};
+
 				sdio_pins1: sdio-pins1 {
 					marvell,pins = "mpp9",  "mpp11", "mpp12",
 							"mpp13", "mpp14", "mpp15";
@@ -256,6 +274,20 @@
 				status = "disabled";
 			};
 
+			/*
+			 * Default SPI pinctrl setting, can be overwritten on
+			 * board level if a different configuration is used.
+			 */
+			spi0: spi at 10600 {
+				pinctrl-0 = <&spi0_pins1>;
+				pinctrl-names = "default";
+			};
+
+			spi1: spi at 10680 {
+				pinctrl-0 = <&spi1_pins>;
+				pinctrl-names = "default";
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
-- 
2.1.1
