From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Apr 2011 16:06:50 +0200
Subject: [PATCH 7/7] ARM: EXYNOS4: enable FIMC on Universal_C210
In-Reply-To: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
References: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1302012410-17984-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definitions to enable support for s5p-fimc driver
together with required power domains and sysmmu controller on Universal
C210 board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig               |    6 ++++++
 arch/arm/mach-exynos4/mach-universal_c210.c |   22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index e849f67..544a594 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -148,12 +148,18 @@ config MACH_ARMLEX4210
 config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_EXYNOS4210
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_FIMC3
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C5
 	select S5P_DEV_ONENAND
+	select EXYNOS4_DEV_PD
+	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 97d329f..7ff2f5f 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -27,9 +27,12 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/iic.h>
+#include <plat/pd.h>
 #include <plat/sdhci.h>
+#include <plat/sysmmu.h>
 
 #include <mach/map.h>
+#include <mach/regs-clock.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -613,6 +616,15 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
 	&s3c_device_i2c5,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
+	&s5p_device_fimc3,
+	&exynos4_device_pd[PD_CAM],
+	&exynos4_device_sysmmu[S5P_SYSMMU_FIMC0],
+	&exynos4_device_sysmmu[S5P_SYSMMU_FIMC1],
+	&exynos4_device_sysmmu[S5P_SYSMMU_FIMC2],
+	&exynos4_device_sysmmu[S5P_SYSMMU_FIMC3],
 
 	/* Universal Devices */
 	&universal_gpio_keys,
@@ -638,6 +650,16 @@ static void __init universal_machine_init(void)
 
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
+
+	s5p_device_fimc0.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc1.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc2.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	s5p_device_fimc3.dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	exynos4_device_sysmmu[S5P_SYSMMU_FIMC0].dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	exynos4_device_sysmmu[S5P_SYSMMU_FIMC1].dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	exynos4_device_sysmmu[S5P_SYSMMU_FIMC2].dev.parent = &exynos4_device_pd[PD_CAM].dev;
+	exynos4_device_sysmmu[S5P_SYSMMU_FIMC3].dev.parent = &exynos4_device_pd[PD_CAM].dev;
+
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.7.1.569.g6f426
