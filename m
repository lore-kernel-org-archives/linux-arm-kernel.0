From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 11 Jul 2012 15:12:19 +0530
Subject: [PATCH 5/7] ARM: EXYNOS5: add device tree based discovery support for
 FIMD
In-Reply-To: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
References: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1341999741-15578-6-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna <l.krishna@samsung.com>

This patch adds support for device tree based discovery for Samsung's
display controller. Adds DRM-Fimd plat data for smdk5250
evt1 to the corresponding dts file

Signed-off-by: Leela Krishna <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   16 ++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |    7 +++++++
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 ++
 4 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 49945cc..781f836 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -71,4 +71,20 @@
 	i2c at 12CD0000 {
 		status = "disabled";
 	};
+
+	lcd_fimd0: lcd_panel0 {
+			lcd-htiming = <4 4 4 1280>;
+			lcd-vtiming = <4 4 4 800>;
+			supports-mipi-panel;
+	};
+
+	fimd {
+		samsung,fimd-display = <&lcd_fimd0>;
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-vclk;
+		samsung,fimd-frame-rate = <60>;
+		samsung,default-window = <0>;
+		samsung,fimd-win-bpp = <32>;
+	};
+
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 4272b29..f9954fe 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -424,4 +424,11 @@
 			#gpio-cells = <4>;
 		};
 	};
+
+	fimd {
+		compatible = "samsung,exynos5-drm";
+		interrupt-parent = <&combiner>;
+		reg = <0x14400000 0x40000>;
+		interrupts = <18 5>, <18 4>, <18 6>;
+	};
 };
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index ca4aa89..731b56e 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -167,6 +167,7 @@
 #define EXYNOS4_PA_MIPI_CSIS1		0x11890000
 
 #define EXYNOS4_PA_FIMD0		0x11C00000
+#define EXYNOS5_PA_FIMD1		0x14400000
 
 #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 #define EXYNOS4_PA_DWMCI		0x12550000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index a91c928..9d5bccc 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -154,6 +154,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5-drm", EXYNOS5_PA_FIMD1,
+				"exynos5-fb", NULL),
 	{},
 };
 
-- 
1.7.0.4
