From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri,  1 Nov 2013 10:13:28 +0000
Subject: [PATCH 1/2] arm: correct GIC cpu interface range for Cortex A15/GIC
 400
In-Reply-To: <1383300776.4332.3.camel@hastur.hellion.org.uk>
References: <1383300776.4332.3.camel@hastur.hellion.org.uk>
Message-ID: <1383300809-7527-1-git-send-email-ian.campbell@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICv2 (Cortex A15/GIC 400) have CPU interface registers up to offset 0x1004
(the 32-bit GICC_DIR register a 0x1000). The GIC 400 documentation specifies
the CPU interface region as being 0x2000 in size.

Update all DTS entries claiming "arm,cortex-a15-gic" compatibility. Of these I
only have personal experience with the vexpress a Calxeda (ecx) platforms and
annecdotal evidence for omap and exynos. For the others I'm just assuming.

Also update the example a15 binding in the documentation.

The "Texas Instruments Keystone 2 SoC" platform which claim to have an a15
compatible GIC but does not include the GICH/GICV registers. I've not touched
that here.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/arm/gic.txt | 2 +-
 arch/arm/boot/dts/ecx-2000.dts                | 2 +-
 arch/arm/boot/dts/exynos5.dtsi                | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi             | 2 +-
 arch/arm/boot/dts/omap5.dtsi                  | 2 +-
 arch/arm/boot/dts/tegra114.dtsi               | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts   | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts    | 2 +-
 arch/arm/boot/dts/xenvm-4.2.dts               | 2 +-
 arch/arm64/boot/dts/foundation-v8.dts         | 2 +-
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts        | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 3dfb0c0..ea215e8 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -83,7 +83,7 @@ Example:
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x2c001000 0x1000>,
-		      <0x2c002000 0x1000>,
+		      <0x2c002000 0x2000>,
 		      <0x2c004000 0x2000>,
 		      <0x2c006000 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 139b40c..61927de 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -93,7 +93,7 @@
 			interrupt-controller;
 			interrupts = <1 9 0xf04>;
 			reg = <0xfff11000 0x1000>,
-			      <0xfff12000 0x1000>,
+			      <0xfff12000 0x2000>,
 			      <0xfff14000 0x2000>,
 			      <0xfff16000 0x2000>;
 		};
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index f65e124..c72782f 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -44,7 +44,7 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg =	<0x10481000 0x1000>,
-			<0x10482000 0x1000>,
+			<0x10482000 0x2000>,
 			<0x10484000 0x2000>,
 			<0x10486000 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index ff7f5d8..19c9636 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -31,7 +31,7 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg =	<0x2E1000 0x1000>,
-			<0x2E2000 0x1000>,
+			<0x2E2000 0x2000>,
 			<0x2E4000 0x2000>,
 			<0x2E6000 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..6c4fe08 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -60,7 +60,7 @@
 		interrupt-controller;
 		#interrupt-cells = <3>;
 		reg = <0x48211000 0x1000>,
-		      <0x48212000 0x1000>,
+		      <0x48212000 0x2000>,
 		      <0x48214000 0x2000>,
 		      <0x48216000 0x2000>;
 	};
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index abf6c40..eb7a0c4 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -20,7 +20,7 @@
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x50041000 0x1000>,
-		      <0x50042000 0x1000>,
+		      <0x50042000 0x2000>,
 		      <0x50044000 0x2000>,
 		      <0x50046000 0x2000>;
 		interrupts = <GIC_PPI 9
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 9420053..f0ec2be 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -81,7 +81,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0x2c001000 0 0x1000>,
-		      <0 0x2c002000 0 0x1000>,
+		      <0 0x2c002000 0 0x2000>,
 		      <0 0x2c004000 0 0x2000>,
 		      <0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index d2803be..c2db05e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -98,7 +98,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0x2c001000 0 0x1000>,
-		      <0 0x2c002000 0 0x1000>,
+		      <0 0x2c002000 0 0x2000>,
 		      <0 0x2c004000 0 0x2000>,
 		      <0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm/boot/dts/xenvm-4.2.dts b/arch/arm/boot/dts/xenvm-4.2.dts
index 3369151..92e63eb 100644
--- a/arch/arm/boot/dts/xenvm-4.2.dts
+++ b/arch/arm/boot/dts/xenvm-4.2.dts
@@ -56,7 +56,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0x2c001000 0 0x1000>,
-		      <0 0x2c002000 0 0x100>;
+		      <0 0x2c002000 0 0x2000>;
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/foundation-v8.dts b/arch/arm64/boot/dts/foundation-v8.dts
index 84fcc50..3e63def 100644
--- a/arch/arm64/boot/dts/foundation-v8.dts
+++ b/arch/arm64/boot/dts/foundation-v8.dts
@@ -68,7 +68,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0x0 0x2c001000 0 0x1000>,
-		      <0x0 0x2c002000 0 0x1000>,
+		      <0x0 0x2c002000 0 0x2000>,
 		      <0x0 0x2c004000 0 0x2000>,
 		      <0x0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
index 572005e..0d271ce 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -73,7 +73,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0x0 0x2c001000 0 0x1000>,
-		      <0x0 0x2c002000 0 0x1000>,
+		      <0x0 0x2c002000 0 0x2000>,
 		      <0x0 0x2c004000 0 0x2000>,
 		      <0x0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-- 
1.8.4.rc3
