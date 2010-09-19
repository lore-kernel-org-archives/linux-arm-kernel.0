From: awg@embtoolkit.org (Abdoulaye Walsimou Gaye)
Date: Sun, 19 Sep 2010 20:48:54 +0200
Subject: [PATCH V3 1/1] ARM: s3c2440: various fixes in Kconfig file
In-Reply-To: <4C86CBC8.7010503@fluff.org>
References: <4C86CBC8.7010503@fluff.org>
Message-ID: <1284922134-19952-1-git-send-email-awg@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* kconfig symbols defined in arch/arm/mach-s3c2440/Kconfig are only available
  when ARCH_S3C2410 is selected, so no need to make some of them depend
  on ARCH_S3C2410.
* fix CPU_S3C24405B typo in "config S3C2440_DMA".
* mini2440: remove unconditionally select of SND_S3C24XX_SOC_S3C24XX_UDA134X.
Those fixes avoid the following warnings at make time:

scripts/kconfig/qconf arch/arm/Kconfig
warning: (MACH_MINI2440 && ARCH_S3C2410) selects SND_S3C24XX_SOC_S3C24XX_UDA134X
which has unmet direct dependencies (SND_S3C24XX_SOC && ARCH_S3C2410)
warning: (CPU_S3C2440 && ARCH_S3C2410 && S3C2410_DMA) selects S3C2440_DMA which 
has unmet direct dependencies (ARCH_S3C2410 && CPU_S3C24405B)
warning: (CPU_S3C2440 && ARCH_S3C2410 || CPU_S3C2442 && ARCH_S3C2410)
selects CPU_S3C244X which has unmet direct dependencies (!ARCH_S3C2410)

Signed-off-by: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>
---
changes since v1:
include warnings observed without this patch
changes since v2:
take into account comments from Ben about unconditional select of some kconfig
symbols

 arch/arm/mach-s3c2440/Kconfig |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index cd8e7de..ff024a6 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -4,7 +4,6 @@
 
 config CPU_S3C2440
 	bool
-	depends on ARCH_S3C2410
 	select CPU_ARM920T
 	select S3C_GPIO_PULL_UP
 	select S3C2410_CLOCK
@@ -18,7 +17,6 @@ config CPU_S3C2440
 
 config CPU_S3C2442
 	bool
-	depends on ARCH_S3C2410
 	select CPU_ARM920T
 	select S3C2410_CLOCK
 	select S3C2410_GPIO
@@ -30,7 +28,7 @@ config CPU_S3C2442
 
 config CPU_S3C244X
 	bool
-	depends on ARCH_S3C2410 && (CPU_S3C2440 || CPU_S3C2442)
+	depends on CPU_S3C2440 || CPU_S3C2442
 	help
 	  Support for S3C2440 and S3C2442 Samsung Mobile CPU based systems.
 
@@ -72,7 +70,7 @@ config S3C2440_PLL_16934400
 
 config S3C2440_DMA
 	bool
-	depends on ARCH_S3C2410 && CPU_S3C24405B
+	depends on CPU_S3C2440
 	help
 	  Support for S3C2440 specific DMA code5A
 
@@ -181,7 +179,6 @@ config MACH_MINI2440
 	select CPU_S3C2440
 	select EEPROM_AT24
 	select LEDS_TRIGGER_BACKLIGHT
-	select SND_S3C24XX_SOC_S3C24XX_UDA134X
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
 	help
-- 
1.7.0.4
