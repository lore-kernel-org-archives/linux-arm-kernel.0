From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 10:34:44 -0300
Subject: [PATCH 4/4] ARM: dts: Enable the reference clock for timer and
 watchdog on Armada 375 SoC
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the timer and watchdog drivers support the Armada 375 usage of
the reference clock, we can enable it in the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index de65714..4d89145 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -36,6 +36,12 @@
 			#clock-cells = <0>;
 			clock-frequency = <2000000000>;
 		};
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
 	};
 
 	cpus {
@@ -366,13 +372,15 @@
 						      <&gic  GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 						      <&mpic 5>,
 						      <&mpic 6>;
-				clocks = <&coreclk 0>;
+				clocks = <&refclk>;
+				clock-names = "fixed";
 			};
 
 			watchdog at 20300 {
 				compatible = "marvell,armada-375-wdt";
 				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
-				clocks = <&coreclk 0>;
+				clocks = <&refclk>;
+				clock-names = "fixed";
 			};
 
 			cpurst at 20800 {
-- 
2.1.0
