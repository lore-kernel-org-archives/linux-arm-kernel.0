From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:27:51 +0100
Subject: [PATCHv3 07/12] arm: mvebu: define and use common Armada 370 UART
 pinctrl settings
In-Reply-To: <cover.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
Message-ID: <d76ce42c3c580e39e366e6efd16b8764d3f3d372.1416266432.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada 370 pinctrl settings for uart0 and
uart1 interfaces:

 uart0: MPP0-1 as default
 uart1: MPP41-42 as default

Note: this patch has the potential to break out-of-tree users w/o
specific pinctrl settings for their uart interfaces if the default
above does not match their config.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 901806f35f40..84ab0f23b857 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -126,6 +126,16 @@
 					marvell,function = "spi0";
 				};
 
+				uart0_pins: uart0-pins {
+					marvell,pins = "mpp0", "mpp1";
+					marvell,function = "uart0";
+				};
+
+				uart1_pins: uart1-pins {
+					marvell,pins = "mpp41", "mpp42";
+					marvell,function = "uart1";
+				};
+
 				spi1_pins: spi1-pins {
 					marvell,pins = "mpp49", "mpp50",
 						       "mpp51", "mpp52";
@@ -288,6 +298,21 @@
 				pinctrl-names = "default";
 			};
 
+			/*
+			 * Default UART pinctrl setting without RTS/CTS, can
+			 * be overwritten on board level if a different
+			 * configuration is used.
+			 */
+			uart0: serial at 12000 {
+				pinctrl-0 = <&uart0_pins>;
+				pinctrl-names = "default";
+			};
+
+			uart1: serial at 12100 {
+				pinctrl-0 = <&uart1_pins>;
+				pinctrl-names = "default";
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
-- 
2.1.1
