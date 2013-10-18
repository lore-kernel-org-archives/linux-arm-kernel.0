From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 18 Oct 2013 22:13:14 +0200
Subject: [PATCH 5/6] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
In-Reply-To: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1382127195-15261-6-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
 drivers/iommu/arm-smmu.c          |    2 +-
 include/linux/of.h                |    2 +-
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 139b40c..e979e8e 100644
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
+			mmu-masters = <&mac0 0 1>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_mac1: smmu at 920080000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20080000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 108 4 0 108 4>;
+			mmu-masters = <&mac1 0 1>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_sata: smmu at 920180000 {
+			compatible = "arm,mmu-400";
+			reg = <0x00000009 0x20180000 0x10000>;
+			mmu-masters = <&sata 0 1 2 3 4 5 6 7 8 9>;
+			#global-interrupts = <1>;
+			interrupts = <0 114 4 0 114 4>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+	};
+
 };
 
 /include/ "ecx-common.dtsi"
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index e8559b7..961dc5b 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -25,7 +25,7 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&intc>;
 
-		sata at ffe08000 {
+		sata: sata at ffe08000 {
 			compatible = "calxeda,hb-ahci";
 			reg = <0xffe08000 0x10000>;
 			interrupts = <0 83 4>;
@@ -35,6 +35,7 @@
 					     &combophy0 3>;
 			calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
 			calxeda,led-order = <4 0 1 2 3>;
+			#stream-id-cells = <10>;
 		};
 
 		sdhci at ffe0e000 {
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
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5f585fc..9fc34d1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -55,7 +55,7 @@
 #define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 1)
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		8
+#define MAX_MASTER_STREAMIDS		10
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
diff --git a/include/linux/of.h b/include/linux/of.h
index f95aee3..47f4857 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -67,7 +67,7 @@ struct device_node {
 #endif
 };
 
-#define MAX_PHANDLE_ARGS 8
+#define MAX_PHANDLE_ARGS 10
 struct of_phandle_args {
 	struct device_node *np;
 	int args_count;
-- 
1.7.9.5
