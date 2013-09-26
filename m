From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 00:36:21 +0200
Subject: [PATCH 9/9] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380234982-1677-10-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 139b40c..d60beb0 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -76,10 +76,11 @@
 	};
 
 	soc {
-		ranges = <0x00000000 0x00000000 0x00000000 0xffffffff>;
+		ranges = <0x0 0x0 0x0 0xffffffff>;
 
 		timer {
-			compatible = "arm,cortex-a15-timer", "arm,armv7-timer"; 			interrupts = <1 13 0xf08>,
+			compatible = "arm,cortex-a15-timer", "arm,armv7-timer";
+			interrupts = <1 13 0xf08>,
 				<1 14 0xf08>,
 				<1 11 0xf08>,
 				<1 10 0xf08>;
@@ -103,6 +104,45 @@
 			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
 		};
 	};
+
+	soc at 920000000 {
+		ranges = <0x9 0x20000000 0x9 0x20000000 0x290000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+
+		smmu_mac0: smmu at 920000000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20000000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 106 4 0 106 4>;
+			mmu-masters = <&mac0 0x0 0x1>;
+			calxeda,smmu-secure-cfg-access;
+			linux,arm-smmu-isolate-devices;
+		};
+
+		smmu_mac1: smmu at 920080000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20080000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 108 4 0 108 4>;
+			mmu-masters = <&mac1 0x0 0x1>;
+			calxeda,smmu-secure-cfg-access;
+			linux,arm-smmu-isolate-devices;
+		};
+
+		smmu_sata: smmu at 920180000 {
+			compatible = "arm,mmu-400";
+			reg = <0x00000009 0x20180000 0x10000>;
+			mmu-masters = <&sata 0x0 0x1>;
+			#global-interrupts = <1>;
+			interrupts = <0 114 4 0 114 4>;
+			calxeda,smmu-secure-cfg-access;
+			linux,arm-smmu-isolate-devices;
+		};
+	};
+
 };
 
 /include/ "ecx-common.dtsi"
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index e8559b7..6658710 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -25,11 +25,12 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&intc>;
 
-		sata at ffe08000 {
+		sata: sata at ffe08000 {
 			compatible = "calxeda,hb-ahci";
 			reg = <0xffe08000 0x10000>;
 			interrupts = <0 83 4>;
 			dma-coherent;
+			#stream-id-cells = <2>;
 			calxeda,port-phys = <&combophy5 0 &combophy0 0
 					     &combophy0 1 &combophy0 2
 					     &combophy0 3>;
@@ -208,18 +209,20 @@
 			clock-names = "apb_pclk";
 		};
 
-		ethernet at fff50000 {
+		mac0: ethernet at fff50000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff50000 0x1000>;
 			interrupts = <0 77 4  0 78 4  0 79 4>;
 			dma-coherent;
+			#stream-id-cells = <2>;
 		};
 
-		ethernet at fff51000 {
+		mac1: ethernet at fff51000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff51000 0x1000>;
 			interrupts = <0 80 4  0 81 4  0 82 4>;
 			dma-coherent;
+			#stream-id-cells = <2>;
 		};
 
 		combophy0: combo-phy at fff58000 {
-- 
1.7.9.5
