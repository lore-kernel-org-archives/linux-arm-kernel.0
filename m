From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 16:29:07 +0200
Subject: [PATCH v4 2/5] ARM: dts: mvebu: move all peripherals inside soc
In-Reply-To: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365776950-30094-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

reorganize the .dts and .dtsi files so that all devices are under the
soc { } node (currently some devices such as the interrupt controller,
the L2 cache and a few others are outside).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   26 +++++++++++++-------------
 arch/arm/boot/dts/armada-370.dtsi    |   23 ++++++++++++-----------
 arch/arm/boot/dts/armada-xp.dtsi     |   32 ++++++++++++++++----------------
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 9693f79..972448c 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -28,19 +28,6 @@
 		};
 	};
 
-	mpic: interrupt-controller at d0020000 {
-	      compatible = "marvell,mpic";
-	      #interrupt-cells = <1>;
-	      #size-cells = <1>;
-	      interrupt-controller;
-	};
-
-	coherency-fabric at d0020200 {
-		compatible = "marvell,coherency-fabric";
-		reg = <0xd0020200 0xb0>,
-		      <0xd0021810 0x1c>;
-	};
-
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -48,6 +35,19 @@
 		interrupt-parent = <&mpic>;
 		ranges;
 
+		mpic: interrupt-controller at d0020000 {
+			compatible = "marvell,mpic";
+			#interrupt-cells = <1>;
+			#size-cells = <1>;
+			interrupt-controller;
+		};
+
+		coherency-fabric at d0020200 {
+			compatible = "marvell,coherency-fabric";
+			reg = <0xd0020200 0xb0>,
+			      <0xd0021810 0x1c>;
+		};
+
 		serial at d0012000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xd0012000 0x100>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 18f6eb4..209caeb 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -20,12 +20,6 @@
 / {
 	model = "Marvell Armada 370 family SoC";
 	compatible = "marvell,armada370", "marvell,armada-370-xp";
-	L2: l2-cache {
-		compatible = "marvell,aurora-outer-cache";
-		reg = <0xd0008000 0x1000>;
-		cache-id-part = <0x100>;
-		wt-override;
-	};
 
 	aliases {
 		gpio0 = &gpio0;
@@ -33,17 +27,24 @@
 		gpio2 = &gpio2;
 	};
 
-	mpic: interrupt-controller at d0020000 {
-	      reg = <0xd0020a00 0x1d0>,
-		    <0xd0021870 0x58>;
-	};
-
 	soc {
+		mpic: interrupt-controller at d0020000 {
+			reg = <0xd0020a00 0x1d0>,
+			      <0xd0021870 0x58>;
+		};
+
 		system-controller at d0018200 {
 				compatible = "marvell,armada-370-xp-system-controller";
 				reg = <0xd0018200 0x100>;
 		};
 
+		L2: l2-cache {
+			compatible = "marvell,aurora-outer-cache";
+			reg = <0xd0008000 0x1000>;
+			cache-id-part = <0x100>;
+			wt-override;
+		};
+
 		pinctrl {
 			compatible = "marvell,mv88f6710-pinctrl";
 			reg = <0xd0018000 0x38>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 29dfeb6..ef3d413 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -22,25 +22,25 @@
 	model = "Marvell Armada XP family SoC";
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
-	L2: l2-cache {
-		compatible = "marvell,aurora-system-cache";
-		reg = <0xd0008000 0x1000>;
-		cache-id-part = <0x100>;
-		wt-override;
-	};
+	soc {
+		L2: l2-cache {
+			compatible = "marvell,aurora-system-cache";
+			reg = <0xd0008000 0x1000>;
+			cache-id-part = <0x100>;
+			wt-override;
+		};
 
-	mpic: interrupt-controller at d0020000 {
-	      reg = <0xd0020a00 0x2d0>,
-		    <0xd0021070 0x58>;
-	};
+		mpic: interrupt-controller at d0020000 {
+		      reg = <0xd0020a00 0x2d0>,
+			    <0xd0021070 0x58>;
+		};
 
-	armada-370-xp-pmsu at d0022000 {
-		compatible = "marvell,armada-370-xp-pmsu";
-		reg = <0xd0022100 0x430>,
-		      <0xd0020800 0x20>;
-	};
+		armada-370-xp-pmsu at d0022000 {
+			compatible = "marvell,armada-370-xp-pmsu";
+			reg = <0xd0022100 0x430>,
+			      <0xd0020800 0x20>;
+		};
 
-	soc {
 		serial at d0012200 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xd0012200 0x100>;
-- 
1.7.9.5
