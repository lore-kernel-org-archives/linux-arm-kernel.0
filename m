From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 17:18:02 +0100
Subject: [PATCH 2/3] ARM: dts: exynos4x12: Fix definition of MSHC device tree
 nodes
In-Reply-To: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
References: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
Message-ID: <1386865083-20082-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SoCs from Exynos4x12 series contain the MSHC block, so its node can
be located in exynos4x12.dtsi. In addition, missing clock specifiers
are added, generic SoC attributes are moved from board dts files
to common dtsi file of SoC family and the node is renamed to a more
generic name to follow node naming recommendations.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |  5 +----
 arch/arm/boot/dts/exynos4412-origen.dts  |  5 +----
 arch/arm/boot/dts/exynos4412.dtsi        |  8 --------
 arch/arm/boot/dts/exynos4x12.dtsi        | 13 +++++++++++++
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 46c678e..8aad5f7 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -38,9 +38,7 @@
 		};
 	};
 
-	mshc at 12550000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
+	mmc at 12550000 {
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		vmmc-supply = <&ldo20_reg &buck8_reg>;
@@ -49,7 +47,6 @@
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
-		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index d65984c..0fe0161 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -122,9 +122,7 @@
 		status = "okay";
 	};
 
-	mshc at 12550000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
+	mmc at 12550000 {
 		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
 		pinctrl-names = "default";
 		status = "okay";
@@ -132,7 +130,6 @@
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
-		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e743e67..7a0c871 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -34,7 +34,6 @@
 			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
 			     <0 107 0>, <0 108 0>, <0 48 0>, <0 42 0>;
 	};
-
 	mct at 10050000 {
 		compatible = "samsung,exynos4412-mct";
 		reg = <0x10050000 0x800>;
@@ -61,11 +60,4 @@
 		};
 	};
 
-	mshc at 12550000 {
-		compatible = "samsung,exynos4412-dw-mshc";
-		reg = <0x12550000 0x1000>;
-		interrupts = <0 77 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index ad531fe..1917c82 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -28,6 +28,7 @@
 		pinctrl3 = &pinctrl_3;
 		fimc-lite0 = &fimc_lite_0;
 		fimc-lite1 = &fimc_lite_1;
+		mshc0 = &mshc_0;
 	};
 
 	pd_isp: isp-power-domain at 10023CA0 {
@@ -176,4 +177,16 @@
 			};
 		};
 	};
+
+	mshc_0: mmc at 12550000 {
+		compatible = "samsung,exynos4412-dw-mshc";
+		reg = <0x12550000 0x1000>;
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		fifo-depth = <0x80>;
+		clocks = <&clock 301>, <&clock 149>;
+		clock-names = "biu", "ciu";
+		status = "disabled";
+	};
 };
-- 
1.8.4.3
