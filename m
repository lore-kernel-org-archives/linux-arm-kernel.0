From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 01 Jul 2013 17:22:28 +0200
Subject: [PATCH v3 06/13] ARM: dts: Add camera subsystem nodes to
 exynos4x12.dtsi
In-Reply-To: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1372692155-17653-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common camera node and Exynos4212/4412 specific nodes for
FIMC, MIPI-CSIS, FIMC-LITE and FIMC-IS devices.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v2:
 - fixed typo in exynos4x12 i2c_isp node reg property,
 - removed the clock properties which are now moved to exynos4.dtsi,
   "mux" and "parent" clock entries are dropped.
---
 arch/arm/boot/dts/exynos4x12.dtsi |   98 +++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 0e24d85..954628c 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -26,6 +26,8 @@
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
 		pinctrl3 = &pinctrl_3;
+		fimc-lite0 = &fimc_lite_0;
+		fimc-lite1 = &fimc_lite_1;
 	};
 
 	pd_isp: isp-power-domain at 10023CA0 {
@@ -78,4 +80,100 @@
 		clock-names = "sclk_fimg2d", "fimg2d";
 		status = "disabled";
 	};
+
+	camera {
+		clocks = <&clock 132>, <&clock 133>, <&clock 351>, <&clock 352>;
+		clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
+
+		fimc_0: fimc at 11800000 {
+			compatible = "samsung,exynos4212-fimc";
+			samsung,pix-limits = <4224 8192 1920 4224>;
+			samsung,mainscaler-ext;
+			samsung,isp-wb;
+			samsung,cam-if;
+		};
+
+		fimc_1: fimc at 11810000 {
+			compatible = "samsung,exynos4212-fimc";
+			samsung,pix-limits = <4224 8192 1920 4224>;
+			samsung,mainscaler-ext;
+			samsung,isp-wb;
+			samsung,cam-if;
+		};
+
+		fimc_2: fimc at 11820000 {
+			compatible = "samsung,exynos4212-fimc";
+			samsung,pix-limits = <4224 8192 1920 4224>;
+			samsung,mainscaler-ext;
+			samsung,isp-wb;
+			samsung,lcd-wb;
+			samsung,cam-if;
+		};
+
+		fimc_3: fimc at 11830000 {
+			compatible = "samsung,exynos4212-fimc";
+			samsung,pix-limits = <1920 8192 1366 1920>;
+			samsung,rotators = <0>;
+			samsung,mainscaler-ext;
+			samsung,isp-wb;
+			samsung,lcd-wb;
+		};
+
+		fimc_lite_0: fimc-lite at 12390000 {
+			compatible = "samsung,exynos4212-fimc-lite";
+			reg = <0x12390000 0x1000>;
+			interrupts = <0 105 0>;
+			samsung,power-domain = <&pd_isp>;
+			clocks = <&clock 353>;
+			clock-names = "flite";
+			status = "disabled";
+		};
+
+		fimc_lite_1: fimc-lite at 123A0000 {
+			compatible = "samsung,exynos4212-fimc-lite";
+			reg = <0x123A0000 0x1000>;
+			interrupts = <0 106 0>;
+			samsung,power-domain = <&pd_isp>;
+			clocks = <&clock 354>;
+			clock-names = "flite";
+			status = "disabled";
+		};
+
+		fimc_is: fimc-is at 12000000 {
+			compatible = "samsung,exynos4212-fimc-is", "simple-bus";
+			reg = <0x12000000 0x260000>;
+			interrupts = <0 90 0>, <0 95 0>;
+			samsung,power-domain = <&pd_isp>;
+			clocks = <&clock 353>, <&clock 354>, <&clock 355>,
+				<&clock 356>, <&clock 17>, <&clock 357>,
+				<&clock 358>, <&clock 359>, <&clock 360>,
+				<&clock 450>,<&clock 451>, <&clock 452>,
+				<&clock 453>, <&clock 176>, <&clock 13>,
+				<&clock 454>, <&clock 395>, <&clock 455>;
+			clock-names = "lite0", "lite1", "ppmuispx",
+				      "ppmuispmx", "mpll", "isp",
+				      "drc", "fd", "mcuisp",
+				      "ispdiv0", "ispdiv1", "mcuispdiv0",
+				      "mcuispdiv1", "uart", "aclk200",
+				      "div_aclk200", "aclk400mcuisp",
+				      "div_aclk400mcuisp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			pmu {
+				reg = <0x10020000 0x3000>;
+			};
+
+			i2c1_isp: i2c-isp at 12140000 {
+				compatible = "samsung,exynos4212-i2c-isp";
+				reg = <0x12140000 0x100>;
+				clocks = <&clock 370>;
+				clock-names = "i2c_isp";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
 };
-- 
1.7.9.5
