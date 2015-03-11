From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:43:01 +0000
Subject: [PATCH v6 4/6] ARM: tegra: update DTs to expose legacy interrupt
 controller
In-Reply-To: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
References: <1426088583-15097-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088583-15097-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the legacy interrupt controller in every tegra DTSI files,
and make it the parent of most interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 16 +++++++++++++++-
 arch/arm/boot/dts/tegra124.dtsi | 16 +++++++++++++++-
 arch/arm/boot/dts/tegra20.dtsi  | 15 ++++++++++++++-
 arch/arm/boot/dts/tegra30.dtsi  | 16 +++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 4296b53..f58a3d9 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "nvidia,tegra114";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&lic>;
 
 	host1x at 50000000 {
 		compatible = "nvidia,tegra114-host1x", "simple-bus";
@@ -134,6 +134,19 @@
 		      <0x50046000 0x2000>;
 		interrupts = <GIC_PPI 9
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	lic: interrupt-controller at 60004000 {
+		compatible = "nvidia,tegra114-ictlr", "nvidia,tegra30-ictlr";
+		reg = <0x60004000 0x100>,
+		      <0x60004100 0x50>,
+		      <0x60004200 0x50>,
+		      <0x60004300 0x50>,
+		      <0x60004400 0x50>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
 	};
 
 	timer at 60005000 {
@@ -766,5 +779,6 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			<GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 4be06c6..db85695 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -10,7 +10,7 @@
 
 / {
 	compatible = "nvidia,tegra124";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&lic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -173,6 +173,7 @@
 		      <0x0 0x50046000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
 	};
 
 	gpu at 0,57000000 {
@@ -190,6 +191,18 @@
 		status = "disabled";
 	};
 
+	lic: interrupt-controller at 60004000 {
+		compatible = "nvidia,tegra124-ictlr", "nvidia,tegra30-ictlr";
+		reg = <0x0 0x60004000 0x0 0x100>,
+		      <0x0 0x60004100 0x0 0x100>,
+		      <0x0 0x60004200 0x0 0x100>,
+		      <0x0 0x60004300 0x0 0x100>,
+		      <0x0 0x60004400 0x0 0x100>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+	};
+
 	timer at 0,60005000 {
 		compatible = "nvidia,tegra124-timer", "nvidia,tegra20-timer";
 		reg = <0x0 0x60005000 0x0 0x400>;
@@ -955,5 +968,6 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index e5527f7..adf6b04 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	compatible = "nvidia,tegra20";
-	interrupt-parent = <&intc>;
+	interrupt-parent = <&lic>;
 
 	host1x at 50000000 {
 		compatible = "nvidia,tegra20-host1x", "simple-bus";
@@ -142,6 +142,7 @@
 
 	timer at 50040600 {
 		compatible = "arm,cortex-a9-twd-timer";
+		interrupt-parent = <&intc>;
 		reg = <0x50040600 0x20>;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -154,6 +155,7 @@
 		       0x50040100 0x0100>;
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
 	};
 
 	cache-controller at 50043000 {
@@ -165,6 +167,17 @@
 		cache-level = <2>;
 	};
 
+	lic: interrupt-controller at 60004000 {
+		compatible = "nvidia,tegra20-ictlr";
+		reg = <0x60004000 0x100>,
+		      <0x60004100 0x50>,
+		      <0x60004200 0x50>,
+		      <0x60004300 0x50>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
+
 	timer at 60005000 {
 		compatible = "nvidia,tegra20-timer";
 		reg = <0x60005000 0x60>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index db4810d..60e205a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "nvidia,tegra30";
-	interrupt-parent = <&intc>;
+	interrupt-parent = <&lic>;
 
 	pcie-controller at 00003000 {
 		compatible = "nvidia,tegra30-pcie";
@@ -228,6 +228,7 @@
 	timer at 50040600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x50040600 0x20>;
+		interrupt-parent = <&intc>;
 		interrupts = <GIC_PPI 13
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clocks = <&tegra_car TEGRA30_CLK_TWD>;
@@ -239,6 +240,7 @@
 		       0x50040100 0x0100>;
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
 	};
 
 	cache-controller at 50043000 {
@@ -250,6 +252,18 @@
 		cache-level = <2>;
 	};
 
+	lic: interrupt-controller at 60004000 {
+		compatible = "nvidia,tegra30-ictlr";
+		reg = <0x60004000 0x100>,
+		      <0x60004100 0x50>,
+		      <0x60004200 0x50>,
+		      <0x60004300 0x50>,
+		      <0x60004400 0x50>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+	};
+
 	timer at 60005000 {
 		compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
 		reg = <0x60005000 0x400>;
-- 
2.1.4
