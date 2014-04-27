From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Sun, 27 Apr 2014 13:08:02 +0530
Subject: [PATCH v12 30/31] ARM: dts: add System MMU nodes of exynos5250
In-Reply-To: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398584283-22846-31-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cho KyongHo <pullip.cho@samsung.com>

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |  270 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3742331..eebd397 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -82,6 +82,16 @@
 		reg = <0x10044040 0x20>;
 	};
 
+	pd_isp: isp-power-domain at 0x10044020 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x10044020 0x20>;
+	};
+
+	pd_disp1: disp1-power-domain at 0x100440A0 {
+		compatible = "samsung,exynos4210-pd";
+		reg = <0x100440A0 0x20>;
+	};
+
 	clock: clock-controller at 10010000 {
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
@@ -192,7 +202,7 @@
 		clock-names = "fimg2d";
 	};
 
-	codec at 11000000 {
+	mfc: codec at 11000000 {
 		compatible = "samsung,mfc-v6";
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
@@ -692,7 +702,7 @@
 				"sclk_hdmiphy", "mout_hdmi";
 	};
 
-	mixer {
+	mixer: mixer {
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
@@ -713,7 +723,7 @@
 		phy-names = "dp";
 	};
 
-	fimd at 14400000 {
+	fimd: fimd at 14400000 {
 		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
@@ -736,4 +746,258 @@
 		clocks = <&clock 348>;
 		clock-names = "secss";
 	};
+
+	sysmmu_g2d: sysmmu at 10A60000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A60000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 5>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_2D>;
+	};
+
+	sysmmu_mfc_r: sysmmu at 11200000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11200000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <6 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCR>, <&clock CLK_MFC>;
+		mmu-masters = <&mfc>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_mfc_l: sysmmu at 11210000 {
+		compatible = "samsung,sysmmu-v2";
+		reg = <0x11210000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <8 5>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MFCL>, <&clock CLK_MFC>;
+		mmu-masters = <&mfc>;
+		samsung,power-domain = <&pd_mfc>;
+	};
+
+	sysmmu_rotator: sysmmu at 11D40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_ROTATOR>;
+	};
+
+	sysmmu_fimc_isp: sysmmu at 13260000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13260000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ISP>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_drc: sysmmu at 13270000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13270000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DRC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scc: sysmmu at 13280000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13280000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_scp: sysmmu at 13290000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13290000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_SCP>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_fd: sysmmu at 132A0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132A0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_FD>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_mcuctl: sysmmu at 132B0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132B0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_MCU>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_odc: sysmmu at 132C0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132C0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <11 0>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_ODC>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis0: sysmmu at 132D0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132D0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <10 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS0>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_dis1: sysmmu at 132E0000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132E0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <9 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_DIS1>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_3dnr: sysmmu at 132F0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x132F0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <5 6>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMC_3DNR>;
+		samsung,power-domain = <&pd_isp>;
+	};
+
+	sysmmu_fimc_lite0: sysmmu at 13C40000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE0>, <&clock CLK_CAMIF_TOP>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_fimc_lite1: sysmmu at 13C50000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13C50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <24 1>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_FIMC_LITE1>, <&clock CLK_CAMIF_TOP>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_gsc0: sysmmu at 13E80000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_0>;
+	};
+
+	sysmmu_gsc1: sysmmu at 13E90000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13E90000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL1>, <&clock CLK_GSCL1>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_1>;
+	};
+
+	sysmmu_gsc2: sysmmu at 13EA0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13EA0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 4>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL2>, <&clock CLK_GSCL2>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_2>;
+	};
+
+	sysmmu_gsc3: sysmmu at 13EB0000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x13EB0000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 6>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL3>, <&clock CLK_GSCL3>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_3>;
+	};
+
+	sysmmu_fimd1: sysmmu at 14640000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x14640000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <3 2>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_FIMD1>;
+		samsung,power-domain = <&pd_disp1>;
+		mmu-masters = <&fimd>;
+	};
+
+	sysmmu_tv: sysmmu at 14650000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x14650000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 4>;
+		clock-names = "sysmmu";
+		clocks = <&clock CLK_SMMU_TV>;
+		samsung,power-domain = <&pd_disp1>;
+		mmu-masters = <&mixer>;
+	};
+
+	sysmmu_jpeg: sysmmu at 11F20000 {
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11F20000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <4 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_JPEG>, <&clock CLK_JPEG>;
+		samsung,power-domain = <&pd_gsc>;
+	};
+
+	sysmmu_mdma0: sysmmu at 10A40000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x10A40000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MDMA0>, <&clock CLK_MDMA0>;
+	};
+
+	sysmmu_mdma1: sysmmu at 11D50000{
+		compatible = "samsung,sysmmu-v1";
+		reg = <0x11D50000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <7 2>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_MDMA1>, <&clock CLK_MDMA1>;
+	};
 };
-- 
1.7.9.5
