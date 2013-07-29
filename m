From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:29:03 +0200
Subject: [PATCH 1/4] ARM: dove: add cpu device tree node
In-Reply-To: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1375100946-28521-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the Marvell Sheeva PJ4A CPU found on Dove SoCs.
While at it, also move the l2-cache node out of internal registers and
consistently name different nodes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi |   52 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 8d5be1e8..09d9710 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -10,6 +10,23 @@
 		gpio2 = &gpio2;
 	};
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "marvell,pj4a", "marvell,sheeva-v7";
+			device_type = "cpu";
+			next-level-cache = <&l2>;
+			reg = <0>;
+		};
+	};
+
+	l2: l2-cache {
+		compatible = "marvell,tauros2-cache";
+		marvell,tauros2-cache-features = <0>;
+	};
+
 	soc at f1000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -25,11 +42,6 @@
 		          0xf2100000 0xf2100000 0x0100000   /* PCIe0 I/O   1M */
 		          0xf8000000 0xf8000000 0x8000000>; /* BootROM   128M */
 
-		l2: l2-cache {
-			compatible = "marvell,tauros2-cache";
-			marvell,tauros2-cache-features = <0>;
-		};
-
 		timer: timer at 20300 {
 			compatible = "marvell,orion-timer";
 			reg = <0x20300 0x20>;
@@ -60,14 +72,14 @@
 			#clock-cells = <1>;
 		};
 
-		gate_clk: clock-gating-control at d0038 {
+		gate_clk: clock-gating-ctrl at d0038 {
 			compatible = "marvell,dove-gating-clock";
 			reg = <0xd0038 0x4>;
 			clocks = <&core_clk 0>;
 			#clock-cells = <1>;
 		};
 
-		thermal: thermal at d001c {
+		thermal: thermal-diode at d001c {
 			compatible = "marvell,dove-thermal";
 			reg = <0xd001c 0x0c>, <0xd005c 0x08>;
 		};
@@ -108,7 +120,7 @@
 			status = "disabled";
 		};
 
-		gpio0: gpio at d0400 {
+		gpio0: gpio-ctrl at d0400 {
 			compatible = "marvell,orion-gpio";
 			#gpio-cells = <2>;
 			gpio-controller;
@@ -119,7 +131,7 @@
 			interrupts = <12>, <13>, <14>, <60>;
 		};
 
-		gpio1: gpio at d0420 {
+		gpio1: gpio-ctrl at d0420 {
 			compatible = "marvell,orion-gpio";
 			#gpio-cells = <2>;
 			gpio-controller;
@@ -130,7 +142,7 @@
 			interrupts = <61>;
 		};
 
-		gpio2: gpio at e8400 {
+		gpio2: gpio-ctrl at e8400 {
 			compatible = "marvell,orion-gpio";
 			#gpio-cells = <2>;
 			gpio-controller;
@@ -138,13 +150,13 @@
 			ngpios = <8>;
 		};
 
-		pinctrl: pinctrl at d0200 {
+		pinctrl: pin-ctrl at d0200 {
 			compatible = "marvell,dove-pinctrl";
 			reg = <0xd0200 0x10>;
 			clocks = <&gate_clk 22>;
 		};
 
-		spi0: spi at 10600 {
+		spi0: spi-ctrl at 10600 {
 			compatible = "marvell,orion-spi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -155,7 +167,7 @@
 			status = "disabled";
 		};
 
-		spi1: spi at 14600 {
+		spi1: spi-ctrl at 14600 {
 			compatible = "marvell,orion-spi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -166,7 +178,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 11000 {
+		i2c0: i2c-ctrl at 11000 {
 			compatible = "marvell,mv64xxx-i2c";
 			reg = <0x11000 0x20>;
 			#address-cells = <1>;
@@ -194,7 +206,7 @@
 			status = "okay";
 		};
 
-		sdio0: sdio at 92000 {
+		sdio0: sdio-host at 92000 {
 			compatible = "marvell,dove-sdhci";
 			reg = <0x92000 0x100>;
 			interrupts = <35>, <37>;
@@ -202,7 +214,7 @@
 			status = "disabled";
 		};
 
-		sdio1: sdio at 90000 {
+		sdio1: sdio-host at 90000 {
 			compatible = "marvell,dove-sdhci";
 			reg = <0x90000 0x100>;
 			interrupts = <36>, <38>;
@@ -210,7 +222,7 @@
 			status = "disabled";
 		};
 
-		sata0: sata at a0000 {
+		sata0: sata-host at a0000 {
 			compatible = "marvell,orion-sata";
 			reg = <0xa0000 0x2400>;
 			interrupts = <62>;
@@ -219,12 +231,12 @@
 			status = "disabled";
 		};
 
-		rtc at d8500 {
+		rtc: real-time-clock at d8500 {
 			compatible = "marvell,orion-rtc";
 			reg = <0xd8500 0x20>;
 		};
 
-		crypto: crypto at 30000 {
+		crypto: crypto-engine at 30000 {
 			compatible = "marvell,orion-crypto";
 			reg = <0x30000 0x10000>,
 			      <0xc8000000 0x800>;
@@ -291,7 +303,7 @@
 			};
 		};
 
-		eth: ethernet-controller at 72000 {
+		eth: ethernet-ctrl at 72000 {
 			compatible = "marvell,orion-eth";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.10.4
