From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 04 Mar 2011 10:01:14 +0100
Subject: [PATCH 7/7] ARM: S5PC210: enable FIMC on Universal_C210
In-Reply-To: <1299229274-9753-1-git-send-email-m.szyprowski@samsung.com>
References: <1299229274-9753-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1299229274-9753-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definitions to enable support for s5p-fimc driver
together with required power domains and sysmmu controller on Universal
C210 board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig               |    6 ++++++
 arch/arm/mach-s5pv310/mach-universal_c210.c |   20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index a8b0425..c850086 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -97,12 +97,18 @@ config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_S5PV310
 	select S5P_DEV_ONENAND
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_FIMC3
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S5PV310_SETUP_SDHCI
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C5
+	select S5PV310_DEV_PD
+	select S5PV310_DEV_SYSMMU
 	select S5PV310_SETUP_I2C1
 	select S5PV310_SETUP_I2C5
 	help
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
index eece381..f153895 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
@@ -24,7 +24,9 @@
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/pd.h>
 #include <plat/sdhci.h>
+#include <plat/sysmmu.h>
 
 #include <mach/map.h>
 #include <mach/gpio.h>
@@ -816,6 +818,15 @@ static struct platform_device *universal_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
+	&s5p_device_fimc0,
+	&s5p_device_fimc1,
+	&s5p_device_fimc2,
+	&s5p_device_fimc3,
+	&s5pv310_device_pd[PD_CAM],
+	&s5pv310_device_sysmmu[S5P_SYSMMU_FIMC0],
+	&s5pv310_device_sysmmu[S5P_SYSMMU_FIMC1],
+	&s5pv310_device_sysmmu[S5P_SYSMMU_FIMC2],
+	&s5pv310_device_sysmmu[S5P_SYSMMU_FIMC3],
 
 	/* Universal Devices */
 	&universal_gpio_keys,
@@ -842,6 +853,15 @@ static void __init universal_machine_init(void)
 
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
+
+	s5p_device_fimc0.dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5p_device_fimc1.dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5p_device_fimc2.dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5p_device_fimc3.dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5pv310_device_sysmmu[S5P_SYSMMU_FIMC0].dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5pv310_device_sysmmu[S5P_SYSMMU_FIMC1].dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5pv310_device_sysmmu[S5P_SYSMMU_FIMC2].dev.parent = &s5pv310_device_pd[PD_CAM].dev;
+	s5pv310_device_sysmmu[S5P_SYSMMU_FIMC3].dev.parent = &s5pv310_device_pd[PD_CAM].dev;
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.7.1.569.g6f426
