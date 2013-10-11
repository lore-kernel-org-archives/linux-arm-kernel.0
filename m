From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 11 Oct 2013 11:00:35 +0200
Subject: [PATCH RESEND 1/3] ARM: S3C24XX: Fix possible dma selection warning
In-Reply-To: <201310111059.19791.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
Message-ID: <201310111100.35396.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the s3c sound support selects CONFIG_S3C2410_DMA on s3c24xx
architectures while the generic dma config is enabled by CONFIG_S3C24XX_DMA.

With the way the Kconfig options are layed out currently it is possible
to enable Samsung sound support without enabling the necessary dma support
resulting in warnings like
  warning: (SND_SOC_SAMSUNG && SND_S3C24XX_I2S && SND_S3C2412_SOC_I2S &&
       SND_SOC_SAMSUNG_SMDK2443_WM9710 && SND_SOC_SAMSUNG_LN2440SBC_ALC650)
  selects S3C2410_DMA which has unmet direct dependencies (ARCH_S3C24XX &&
       S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442))

Therefore bring the s3c2410 dma support in line with the way the other
s3c24xx SoCs handle this by having the SoC dma-support selected if the generic
s3c dma support is enabled and have the sound support depend on S3C24XX_DMA
on these arches. The s3c2442 is using the same dma descriptors and therefore
also selected S3C2410_DMA.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig |    3 ++-
 sound/soc/samsung/Kconfig     |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index dba2173..8f1d327 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -28,6 +28,7 @@ config CPU_S3C2410
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2410
 	select S3C2410_CLOCK
+	select S3C2410_DMA if S3C24XX_DMA
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 	select S3C2410_PM if PM
 	select SAMSUNG_WDT_RESET
@@ -70,6 +71,7 @@ config CPU_S3C2442
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
+	select S3C2410_DMA if S3C24XX_DMA
 	select S3C2410_PM if PM
 	help
 	  Support for S3C2442 Samsung Mobile CPU based systems.
@@ -148,7 +150,6 @@ config S3C2410_DMA_DEBUG
 config S3C2410_DMA
 	bool
 	depends on S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442)
-	default y if CPU_S3C2410 || CPU_S3C2442
 	help
 	  DMA device selection for S3C2410 and compatible CPUs
 
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 2eea184..37459df 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -2,7 +2,7 @@ config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on PLAT_SAMSUNG
 	select S3C64XX_DMA if ARCH_S3C64XX
-	select S3C2410_DMA if ARCH_S3C24XX
+	select S3C24XX_DMA if ARCH_S3C24XX
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Samsung SoCs' Audio interfaces. You will also need to
-- 
1.7.10.4
