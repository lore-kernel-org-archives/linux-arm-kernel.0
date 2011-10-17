From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 22:21:14 +0100
Subject: [PATCH] SAMSUNG: S3C64XX: Fix SoC identification for S3C64xx devices
Message-ID: <1318886474-2194-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IS_SAMSUNG_CPU() macro works by comparing the CPU ID mask exactly with
the CPU ID. This was failing for S3C64xx SoCs as in order to support
identification of the exact device the mask covers both variants of the
chip, meaning that the test would always fail on S3C6410 devices. This in
turn caused the core GPIO subsystem to fail to identify the CPU and not
support any GPIOs, crippling the system.

As a minimally invasive fix change the test for the class to be done by
checking each implementation and oring them together.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Arnd, this fixes the issue I had with Kukjin's GPIO pull request - with
this applied my systems boot much more happily.

 arch/arm/plat-samsung/include/plat/cpu.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 54f370f..40fd7b6 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -25,7 +25,6 @@ extern unsigned long samsung_cpu_id;
 
 #define S3C6400_CPU_ID		0x36400000
 #define S3C6410_CPU_ID		0x36410000
-#define S3C64XX_CPU_ID		(S3C6400_CPU_ID & S3C6410_CPU_ID)
 #define S3C64XX_CPU_MASK	0xFFFFF000
 
 #define S5P6440_CPU_ID		0x56440000
@@ -50,7 +49,8 @@ static inline int is_samsung_##name(void)	\
 }
 
 IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
-IS_SAMSUNG_CPU(s3c64xx, S3C64XX_CPU_ID, S3C64XX_CPU_MASK)
+IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
+IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
@@ -69,7 +69,7 @@ IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
-# define soc_is_s3c64xx()	is_samsung_s3c64xx()
+# define soc_is_s3c64xx()	(is_samsung_s3c6400() || is_samsung_s3c6410())
 #else
 # define soc_is_s3c64xx()	0
 #endif
-- 
1.7.6.3
