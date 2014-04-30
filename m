From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:34 +0200
Subject: [PATCH 07/15] ARM: dts: kirkwood: consolidate common pinctrl settings
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SoCs have the same pinctrl setting for NAND, UART0/1, SPI, TWSI0,
and GBE1. Move it to the common pinctrl node that we now have.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-6192.dtsi         | 22 -------------------
 arch/arm/boot/dts/kirkwood-6281.dtsi         | 22 -------------------
 arch/arm/boot/dts/kirkwood-6282.dtsi         | 23 -------------------
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi     | 22 -------------------
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts |  7 ------
 arch/arm/boot/dts/kirkwood.dtsi              | 33 ++++++++++++++++++++++++++++
 6 files changed, 33 insertions(+), 96 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index c008e9a877d5..dd81508b919b 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -38,12 +38,6 @@
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6192-pinctrl";
 
-			pmx_nand: pmx-nand {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
-					       "mpp4", "mpp5", "mpp18",
-					       "mpp19";
-				marvell,function = "nand";
-			};
 			pmx_sata0: pmx-sata0 {
 				marvell,pins = "mpp5", "mpp21", "mpp23";
 				marvell,function = "sata0";
@@ -52,22 +46,6 @@
 				marvell,pins = "mpp4", "mpp20", "mpp22";
 				marvell,function = "sata1";
 			};
-			pmx_spi: pmx-spi {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
-				marvell,function = "spi";
-			};
-			pmx_twsi0: pmx-twsi0 {
-				marvell,pins = "mpp8", "mpp9";
-				marvell,function = "twsi0";
-			};
-			pmx_uart0: pmx-uart0 {
-				marvell,pins = "mpp10", "mpp11";
-				marvell,function = "uart0";
-			};
-			pmx_uart1: pmx-uart1 {
-				marvell,pins = "mpp13", "mpp14";
-				marvell,function = "uart1";
-			};
 			pmx_sdio: pmx-sdio {
 				marvell,pins = "mpp12", "mpp13", "mpp14",
 					       "mpp15", "mpp16", "mpp17";
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index 3674a9b9552e..7dc7d6782e83 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -38,12 +38,6 @@
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6281-pinctrl";
 
-			pmx_nand: pmx-nand {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
-					       "mpp4", "mpp5", "mpp18",
-					       "mpp19";
-				marvell,function = "nand";
-			};
 			pmx_sata0: pmx-sata0 {
 				marvell,pins = "mpp5", "mpp21", "mpp23";
 				marvell,function = "sata0";
@@ -52,22 +46,6 @@
 				marvell,pins = "mpp4", "mpp20", "mpp22";
 				marvell,function = "sata1";
 			};
-			pmx_spi: pmx-spi {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
-				marvell,function = "spi";
-			};
-			pmx_twsi0: pmx-twsi0 {
-				marvell,pins = "mpp8", "mpp9";
-				marvell,function = "twsi0";
-			};
-			pmx_uart0: pmx-uart0 {
-				marvell,pins = "mpp10", "mpp11";
-				marvell,function = "uart0";
-			};
-			pmx_uart1: pmx-uart1 {
-				marvell,pins = "mpp13", "mpp14";
-				marvell,function = "uart1";
-			};
 			pmx_sdio: pmx-sdio {
 				marvell,pins = "mpp12", "mpp13", "mpp14",
 					       "mpp15", "mpp16", "mpp17";
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 89a6ba149ec2..b869f48cac02 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -59,12 +59,6 @@
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,88f6282-pinctrl";
 
-			pmx_nand: pmx-nand {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
-							"mpp4", "mpp5", "mpp18", "mpp19";
-				marvell,function = "nand";
-			};
-
 			pmx_sata0: pmx-sata0 {
 				marvell,pins = "mpp5", "mpp21", "mpp23";
 				marvell,function = "sata0";
@@ -73,29 +67,12 @@
 				marvell,pins = "mpp4", "mpp20", "mpp22";
 				marvell,function = "sata1";
 			};
-			pmx_spi: pmx-spi {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
-				marvell,function = "spi";
-			};
-			pmx_twsi0: pmx-twsi0 {
-				marvell,pins = "mpp8", "mpp9";
-				marvell,function = "twsi0";
-			};
 
 			pmx_twsi1: pmx-twsi1 {
 				marvell,pins = "mpp36", "mpp37";
 				marvell,function = "twsi1";
 			};
 
-			pmx_uart0: pmx-uart0 {
-				marvell,pins = "mpp10", "mpp11";
-				marvell,function = "uart0";
-			};
-
-			pmx_uart1: pmx-uart1 {
-				marvell,pins = "mpp13", "mpp14";
-				marvell,function = "uart1";
-			};
 			pmx_sdio: pmx-sdio {
 				marvell,pins = "mpp12", "mpp13", "mpp14",
 					       "mpp15", "mpp16", "mpp17";
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 4a2d1b12d1ca..2e8e412b9db0 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -3,28 +3,6 @@
 		pinctrl: pin-controller at 10000 {
 			compatible = "marvell,98dx4122-pinctrl";
 
-			pmx_nand: pmx-nand {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
-					       "mpp4", "mpp5", "mpp18",
-					       "mpp19";
-				marvell,function = "nand";
-			};
-			pmx_spi: pmx-spi {
-				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
-				marvell,function = "spi";
-			};
-			pmx_twsi0: pmx-twsi0 {
-				marvell,pins = "mpp8", "mpp9";
-				marvell,function = "twsi0";
-			};
-			pmx_uart0: pmx-uart0 {
-				marvell,pins = "mpp10", "mpp11";
-				marvell,function = "uart0";
-			};
-			pmx_uart1: pmx-uart1 {
-				marvell,pins = "mpp13", "mpp14";
-				marvell,function = "uart1";
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index 8c3d50c57fa0..1a7f18d5530d 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -110,13 +110,6 @@
 				marvell,pins = "mpp41", "mpp42", "mpp43";
 				marvell,function = "gpio";
 			};
-
-			pmx_ge1: pmx-ge1 {
-				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23",
-					       "mpp24", "mpp25", "mpp26", "mpp27",
-					       "mpp30", "mpp31", "mpp32", "mpp33";
-				marvell,function = "ge1";
-			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 028003e12111..5d412e71b9fb 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -74,6 +74,39 @@
 		pinctrl: pin-controller at 10000 {
 			/* set compatible property in SoC file */
 			reg = <0x10000 0x20>;
+
+			pmx_ge1: pmx-ge1 {
+				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23",
+					       "mpp24", "mpp25", "mpp26", "mpp27",
+					       "mpp30", "mpp31", "mpp32", "mpp33";
+				marvell,function = "ge1";
+			};
+
+			pmx_nand: pmx-nand {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+					       "mpp4", "mpp5", "mpp18", "mpp19";
+				marvell,function = "nand";
+			};
+
+			pmx_spi: pmx-spi {
+				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
+				marvell,function = "spi";
+			};
+
+			pmx_twsi0: pmx-twsi0 {
+				marvell,pins = "mpp8", "mpp9";
+				marvell,function = "twsi0";
+			};
+
+			pmx_uart0: pmx-uart0 {
+				marvell,pins = "mpp10", "mpp11";
+				marvell,function = "uart0";
+			};
+
+			pmx_uart1: pmx-uart1 {
+				marvell,pins = "mpp13", "mpp14";
+				marvell,function = "uart1";
+			};
 		};
 
 		core_clk: core-clocks at 10030 {
-- 
1.9.1
