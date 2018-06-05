From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Tue,  5 Jun 2018 16:43:45 +0200
Subject: [PATCH v2 2/2] arm64: dts: marvell: armada-37xx: add nodes to support
 watchdog
In-Reply-To: <20180605144345.2021-1-marek.behun@nic.cz>
References: <20180605144345.2021-1-marek.behun@nic.cz>
Message-ID: <20180605144345.2021-2-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the system controller node for CPU Miscellaneous Registers
(which is needed for the watchdog node) and the watchdog node.

Signed-off-by: Marek Behun <marek.behun@nic.cz>

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 8cd43ce38571..8388793f10ac 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -101,6 +101,11 @@
 			/* 32M internal register @ 0xd000_0000 */
 			ranges = <0x0 0x0 0xd0000000 0x2000000>;
 
+			cpu_misc: system-controller at d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0xd000 0x1000>;
+			};
+
 			spi0: spi at 10600 {
 				compatible = "marvell,armada-3700-spi";
 				#address-cells = <1>;
@@ -142,6 +147,13 @@
 				status = "disabled";
 			};
 
+			wdt: watchdog-timer at 8300 {
+				compatible = "marvell,armada-3700-wdt";
+				reg = <0x8300 0x40>;
+				marvell,system-controller = <&cpu_misc>;
+				clocks = <&xtalclk>;
+			};
+
 			nb_periph_clk: nb-periph-clk at 13000 {
 				compatible = "marvell,armada-3700-periph-clock-nb";
 				reg = <0x13000 0x100>;
-- 
2.16.4
