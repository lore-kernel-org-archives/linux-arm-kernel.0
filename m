From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 11:16:12 +0200
Subject: [PATCH 6/6] arm64: dts: marvell: enable GICP and ICU
In-Reply-To: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1496135772-20694-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit modifies the Marvell EBU Armada 7K and 8K Device Tree files
to describe the ICU and GICP units, and use ICU interrupts for all
devices in the CP110 blocks.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  5 ++
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 60 +++++++++++++---------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 54 ++++++++++---------
 3 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index fe41bf9..cb87831 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -146,6 +146,11 @@
 				marvell,spi-base = <128>, <136>, <144>, <152>;
 			};
 
+			gicp: gicp at 3f0040 {
+				compatible = "marvell,gicp";
+				reg = <0x3f0040 0x10>;
+			};
+
 			pic: interrupt-controller at 3f0100 {
 				compatible = "marvell,armada-8k-pic";
 				reg = <0x3f0100 0x10>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index ac8df52..fe899e8 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -44,19 +44,20 @@
  * Device Tree file for Marvell Armada CP110 Master.
  */
 
+#include <dt-bindings/interrupt-controller/mvebu-icu.h>
+
 / {
 	cp110-master {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
+		interrupt-parent = <&cpm_icu>;
 		ranges;
 
 		config-space at f2000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
 			ranges = <0x0 0x0 0xf2000000 0x2000000>;
 
 			cpm_ethernet: ethernet at 0 {
@@ -68,21 +69,21 @@
 				dma-coherent;
 
 				cpm_eth0: eth0 {
-					interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cpm_eth1: eth1 {
-					interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cpm_eth2: eth2 {
-					interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
@@ -96,6 +97,15 @@
 				reg = <0x12a200 0x10>;
 			};
 
+			cpm_icu: interrupt-controller at 1e0000 {
+				compatible = "marvell,icu";
+				reg = <0x1e0000 0x10>;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				gicp = <&gicp>;
+			};
+
 			cpm_syscon0: system-controller at 440000 {
 				compatible = "marvell,cp110-system-controller0",
 					     "syscon";
@@ -120,14 +130,14 @@
 				compatible = "marvell,armada-8k-rtc";
 				reg = <0x284000 0x20>, <0x284080 0x24>;
 				reg-names = "rtc", "rtc-soc";
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			cpm_sata0: sata at 540000 {
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
 				reg = <0x540000 0x30000>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 15>;
 				status = "disabled";
 			};
@@ -137,7 +147,7 @@
 					     "generic-xhci";
 				reg = <0x500000 0x4000>;
 				dma-coherent;
-				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 22>;
 				status = "disabled";
 			};
@@ -147,7 +157,7 @@
 					     "generic-xhci";
 				reg = <0x510000 0x4000>;
 				dma-coherent;
-				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 23>;
 				status = "disabled";
 			};
@@ -195,7 +205,7 @@
 				reg = <0x701000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 21>;
 				status = "disabled";
 			};
@@ -205,7 +215,7 @@
 				reg = <0x701100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 21>;
 				status = "disabled";
 			};
@@ -213,7 +223,7 @@
 			cpm_trng: trng at 760000 {
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
-				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cpm_syscon0 1 25>;
 				status = "okay";
 			};
@@ -221,7 +231,7 @@
 			cpm_sdhci0: sdhci at 780000 {
 				compatible = "marvell,armada-cp110-sdhci";
 				reg = <0x780000 0x300>;
-				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "core";
 				clocks = <&cpm_syscon0 1 4>;
 				dma-coherent;
@@ -231,13 +241,13 @@
 			cpm_crypto: crypto at 800000 {
 				compatible = "inside-secure,safexcel-eip197";
 				reg = <0x800000 0x200000>;
-				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
+				interrupts = <ICU_GRP_NSR 87 (IRQ_TYPE_EDGE_RISING
 				| IRQ_TYPE_LEVEL_HIGH)>,
-					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+					     <ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "mem", "ring0", "ring1",
 				"ring2", "ring3", "eip";
 				clocks = <&cpm_syscon0 1 26>;
@@ -264,8 +274,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 			num-lanes = <1>;
 			clocks = <&cpm_syscon0 1 13>;
 			status = "disabled";
@@ -290,8 +300,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xf7000000 0  0xf7000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
 			clocks = <&cpm_syscon0 1 11>;
@@ -317,8 +327,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xf8000000 0  0xf8000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
 			clocks = <&cpm_syscon0 1 12>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 7740a75..f9cf4f3 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -49,14 +49,13 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
+		interrupt-parent = <&cps_icu>;
 		ranges;
 
 		config-space at f4000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
 			ranges = <0x0 0x0 0xf4000000 0x2000000>;
 
 			cps_rtc: rtc at 284000 {
@@ -75,21 +74,21 @@
 				dma-coherent;
 
 				cps_eth0: eth0 {
-					interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <0>;
 					gop-port-id = <0>;
 					status = "disabled";
 				};
 
 				cps_eth1: eth1 {
-					interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <1>;
 					gop-port-id = <2>;
 					status = "disabled";
 				};
 
 				cps_eth2: eth2 {
-					interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>;
 					port-id = <2>;
 					gop-port-id = <3>;
 					status = "disabled";
@@ -103,6 +102,15 @@
 				reg = <0x12a200 0x10>;
 			};
 
+			cps_icu: interrupt-controller at 1e0000 {
+				compatible = "marvell,icu";
+				reg = <0x1e0000 0x10>;
+				#interrupt-cells = <3>;
+				interrupt-controller;
+				interrupt-parent = <&gic>;
+				gicp = <&gicp>;
+			};
+
 			cps_syscon0: system-controller at 440000 {
 				compatible = "marvell,cp110-system-controller0",
 					     "syscon";
@@ -127,7 +135,7 @@
 				compatible = "marvell,armada-8k-ahci",
 					     "generic-ahci";
 				reg = <0x540000 0x30000>;
-				interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 15>;
 				status = "disabled";
 			};
@@ -137,7 +145,7 @@
 					     "generic-xhci";
 				reg = <0x500000 0x4000>;
 				dma-coherent;
-				interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 22>;
 				status = "disabled";
 			};
@@ -147,7 +155,7 @@
 					     "generic-xhci";
 				reg = <0x510000 0x4000>;
 				dma-coherent;
-				interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 23>;
 				status = "disabled";
 			};
@@ -195,7 +203,7 @@
 				reg = <0x701000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 21>;
 				status = "disabled";
 			};
@@ -205,7 +213,7 @@
 				reg = <0x701100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 21>;
 				status = "disabled";
 			};
@@ -213,7 +221,7 @@
 			cps_trng: trng at 760000 {
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
-				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cps_syscon0 1 25>;
 				status = "okay";
 			};
@@ -221,13 +229,13 @@
 			cps_crypto: crypto at 800000 {
 				compatible = "inside-secure,safexcel-eip197";
 				reg = <0x800000 0x200000>;
-				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
+				interrupts = <ICU_GRP_NSR 87 (IRQ_TYPE_EDGE_RISING
 				| IRQ_TYPE_LEVEL_HIGH)>,
-					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>;
+					     <ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
+					     <ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "mem", "ring0", "ring1",
 						  "ring2", "ring3", "eip";
 				clocks = <&cps_syscon0 1 26>;
@@ -254,8 +262,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfa000000 0  0xfa000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
 			num-lanes = <1>;
 			clocks = <&cps_syscon0 1 13>;
 			status = "disabled";
@@ -280,8 +288,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfb000000 0  0xfb000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
 			clocks = <&cps_syscon0 1 11>;
@@ -307,8 +315,8 @@
 				/* non-prefetchable memory */
 				0x82000000 0 0xfc000000 0  0xfc000000 0 0xf00000>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map = <0 0 0 0 &cps_icu 0 ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
 			clocks = <&cps_syscon0 1 12>;
-- 
2.7.4
