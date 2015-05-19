From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:39 +0200
Subject: [PATCH v7 19/25] ARM: dts: exynos4: add sysmmu nodes
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-20-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds System MMU nodes that are specific to Exynos4210/4x12 series.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 118 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |  23 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi |  82 ++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e20cdc24c3bb..32593a8ac7c2 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -190,6 +190,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc0>;
 			status = "disabled";
 		};
 
@@ -201,6 +202,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc1>;
 			status = "disabled";
 		};
 
@@ -212,6 +214,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc2>;
 			status = "disabled";
 		};
 
@@ -223,6 +226,7 @@
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
 			samsung,sysreg = <&sys_reg>;
+			iommus = <&sysmmu_fimc3>;
 			status = "disabled";
 		};
 
@@ -418,6 +422,8 @@
 		clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
 		clock-names = "mfc", "sclk_mfc";
 		status = "disabled";
+		iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
+		iommu-names = "left", "right";
 	};
 
 	serial_0: serial at 13800000 {
@@ -683,6 +689,7 @@
 		power-domains = <&pd_lcd0>;
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
+		iommus = <&sysmmu_fimd0>;
 	};
 
 	tmu: tmu at 100C0000 {
@@ -709,6 +716,7 @@
 		interrupts = <0 91 0>;
 		reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
 		power-domains = <&pd_tv>;
+		iommus = <&sysmmu_tv>;
 		status = "disabled";
 	};
 
@@ -819,4 +827,114 @@
 		clock-names = "ppmu";
 		status = "disabled";
 	};
+
+	sysmmu_mfc_l: sysmmu at 13620000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13620000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		power-domains = <&pd_mfc>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_mfc_r: sysmmu at 13630000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x13630000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		power-domains = <&pd_mfc>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_tv: sysmmu at 12E20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_TV>, <&clock CLK_MIXER>;
+		power-domains = <&pd_tv>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc0: sysmmu at 11A20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC0>, <&clock CLK_FIMC0>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc1: sysmmu at 11A30000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 3>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC1>, <&clock CLK_FIMC1>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc2: sysmmu at 11A40000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC2>, <&clock CLK_FIMC2>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc3: sysmmu at 11A50000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC3>, <&clock CLK_FIMC3>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_jpeg: sysmmu at 11A60000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		power-domains = <&pd_cam>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_rotator: sysmmu at 12A30000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12A30000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_ROTATOR>, <&clock CLK_ROTATOR>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd0: sysmmu at 11E20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x11E20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD0>, <&clock CLK_FIMD0>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index be89f83f70e7..19a8e711e616 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -195,6 +195,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -244,4 +245,26 @@
 		clock-names = "ppmu";
 		status = "disabled";
 	};
+
+	sysmmu_g2d: sysmmu at 12A20000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12A20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		power-domains = <&pd_lcd0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimd1: sysmmu at 12220000 {
+		compatible = "samsung,exynos-sysmmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x12220000 0x1000>;
+		interrupts = <5 3>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMD1>, <&clock CLK_FIMD1>;
+		power-domains = <&pd_lcd1>;
+		#iommu-cells = <0>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 6a6abe14fd9b..6c664bae0d9f 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -165,6 +165,7 @@
 		interrupts = <0 89 0>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
+		iommus = <&sysmmu_g2d>;
 		status = "disabled";
 	};
 
@@ -214,6 +215,7 @@
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite0>;
 			status = "disabled";
 		};
 
@@ -224,6 +226,7 @@
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE1>;
 			clock-names = "flite";
+			iommus = <&sysmmu_fimc_lite1>;
 			status = "disabled";
 		};
 
@@ -252,6 +255,9 @@
 				      "mcuispdiv1", "uart", "aclk200",
 				      "div_aclk200", "aclk400mcuisp",
 				      "div_aclk400mcuisp";
+			iommus = <&sysmmu_fimc_isp>, <&sysmmu_fimc_drc>,
+				 <&sysmmu_fimc_fd>, <&sysmmu_fimc_mcuctl>;
+			iommu-names = "isp", "drc", "fd", "mcuctl";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -309,4 +315,80 @@
 		clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 			 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
 	};
+
+	sysmmu_g2d: sysmmu at 10A40000{
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 7>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_G2D>, <&clock CLK_G2D>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_isp: sysmmu at 12260000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 2>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISP>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_drc: sysmmu at 12270000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x12270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 3>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_DRC>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_fd: sysmmu at 122A0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x122A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 4>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FD>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu at 122B0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x122B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 5>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ISPCX>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu at 123B0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x123B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 0>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_LITE0>, <&clock CLK_FIMC_LITE0>;
+		#iommu-cells = <0>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu at 123C0000 {
+		compatible = "samsung,exynos-sysmmu";
+		reg = <0x123C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 1>;
+		power-domains = <&pd_isp>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_LITE1>, <&clock CLK_FIMC_LITE1>;
+		#iommu-cells = <0>;
+	};
 };
-- 
1.9.2
