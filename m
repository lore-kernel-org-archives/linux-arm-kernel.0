From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:16:30 +0530
Subject: [PATCH 4/6] ARM: Exynos5: Enable platform support for SPI controllers
In-Reply-To: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337334392-6441-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the platform bits which are required to support SPI controllers.
The OF based partition parsing is also enabled to allow usage of SPI
nor flash on smdk5250 board.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig            |    1 +
 arch/arm/mach-exynos/include/mach/map.h |    3 +++
 arch/arm/mach-exynos/mach-exynos5-dt.c  |    6 ++++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 9d07e3d..c050f1d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -406,6 +406,7 @@ config MACH_EXYNOS5_DT
 	select SOC_EXYNOS5250
 	select USE_OF
 	select ARM_AMBA
+	select MTD_OF_PARTS if (MTD && OF && SPI_S3C64XX)
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS4 SoC based board.
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72f808..06fa583 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -154,6 +154,9 @@
 #define EXYNOS4_PA_SPI0			0x13920000
 #define EXYNOS4_PA_SPI1			0x13930000
 #define EXYNOS4_PA_SPI2			0x13940000
+#define EXYNOS5_PA_SPI0			0x12D20000
+#define EXYNOS5_PA_SPI1			0x12D30000
+#define EXYNOS5_PA_SPI2			0x12D40000
 
 #define EXYNOS4_PA_GPIO1		0x11400000
 #define EXYNOS4_PA_GPIO2		0x11000000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index cf5d222..b63b0f0 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -47,6 +47,12 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"s3c2440-i2c.0", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
 				"s3c2440-i2c.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI0,
+				"exynos4210-spi.0", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI1,
+				"exynos4210-spi.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI2,
+				"exynos4210-spi.2", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-- 
1.6.6.rc2
