From: kwizart@gmail.com (Nicolas Chauvet)
Date: Sat,  8 Aug 2015 15:58:12 +0200
Subject: [PATCH] [ARM][TEGRA] Fix AHB base address on tegra20,
 tegra30 and tegra114
Message-ID: <1439042292-19912-1-git-send-email-kwizart@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current base address is wrong by 0x04 bytes for AHB bus device as shown in dmesg:
 tegra-ahb 6000c004.ahb: incorrect AHB base address in DT data - enabling workaround

To correct old dtbs,  the commit ce7a10b0ff3db63 checks for the low bit
of the base address and removes theses 0x04 bytes at runtime.

This patch fix the original dts, so upstream version doesn't need
the workaround of the base address.

As both addresses are valid, this patch doesn't break compatibility

Tested on tegra20-paz00 (aka ac100)

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 4 ++--
 arch/arm/boot/dts/tegra20.dtsi  | 4 ++--
 arch/arm/boot/dts/tegra30.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index f58a3d9..4bdf8f9 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -214,9 +214,9 @@
 		#dma-cells = <1>;
 	};
 
-	ahb: ahb at 6000c004 {
+	ahb: ahb at 6000c000 {
 		compatible = "nvidia,tegra114-ahb", "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>;
+		reg = <0x6000c000 0x150>;
 	};
 
 	gpio: gpio at 6000d000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index f444b67..f6f1461 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -225,9 +225,9 @@
 		#dma-cells = <1>;
 	};
 
-	ahb at 6000c004 {
+	ahb at 6000c000 {
 		compatible = "nvidia,tegra20-ahb";
-		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
+		reg = <0x6000c000 0x110>; /* AHB Arbitration + Gizmo Controller */
 	};
 
 	gpio: gpio at 6000d000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 782b11b..559763e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -329,9 +329,9 @@
 		#dma-cells = <1>;
 	};
 
-	ahb: ahb at 6000c004 {
+	ahb: ahb at 6000c000 {
 		compatible = "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
+		reg = <0x6000c000 0x150>; /* AHB Arbitration + Gizmo Controller */
 	};
 
 	gpio: gpio at 6000d000 {
-- 
2.4.3
