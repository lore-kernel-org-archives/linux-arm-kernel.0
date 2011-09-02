From: boojin.kim@samsung.com (Boojin Kim)
Date: Fri,  2 Sep 2011 09:44:34 +0900
Subject: [PATCH v8 06/16] ARM: SAMSUNG: Update to use PL330-DMA driver
In-Reply-To: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <1314924284-25554-7-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds to support PL330-DMA driver on DMADEVICE for S5P SoCs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/dma.h           |    4 ++--
 arch/arm/mach-s5p64x0/include/mach/dma.h           |    2 +-
 arch/arm/mach-s5pc100/include/mach/dma.h           |    2 +-
 arch/arm/mach-s5pv210/include/mach/dma.h           |    2 +-
 arch/arm/plat-samsung/Kconfig                      |    9 +++++++++
 .../include/plat/{s3c-dma-pl330.h => dma-pl330.h}  |    8 ++++----
 .../plat-samsung/include/plat/s3c-pl330-pdata.h    |    2 +-
 7 files changed, 19 insertions(+), 10 deletions(-)
 rename arch/arm/plat-samsung/include/plat/{s3c-dma-pl330.h => dma-pl330.h} (93%)

diff --git a/arch/arm/mach-exynos4/include/mach/dma.h b/arch/arm/mach-exynos4/include/mach/dma.h
index 81209eb..201842a 100644
--- a/arch/arm/mach-exynos4/include/mach/dma.h
+++ b/arch/arm/mach-exynos4/include/mach/dma.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_DMA_H
 #define __MACH_DMA_H
 
-/* This platform uses the common S3C DMA API driver for PL330 */
-#include <plat/s3c-dma-pl330.h>
+/* This platform uses the common DMA API driver for PL330 */
+#include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/dma.h b/arch/arm/mach-s5p64x0/include/mach/dma.h
index 81209eb..1beae2c 100644
--- a/arch/arm/mach-s5p64x0/include/mach/dma.h
+++ b/arch/arm/mach-s5p64x0/include/mach/dma.h
@@ -21,6 +21,6 @@
 #define __MACH_DMA_H
 
 /* This platform uses the common S3C DMA API driver for PL330 */
-#include <plat/s3c-dma-pl330.h>
+#include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/dma.h b/arch/arm/mach-s5pc100/include/mach/dma.h
index 81209eb..1beae2c 100644
--- a/arch/arm/mach-s5pc100/include/mach/dma.h
+++ b/arch/arm/mach-s5pc100/include/mach/dma.h
@@ -21,6 +21,6 @@
 #define __MACH_DMA_H
 
 /* This platform uses the common S3C DMA API driver for PL330 */
-#include <plat/s3c-dma-pl330.h>
+#include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/dma.h b/arch/arm/mach-s5pv210/include/mach/dma.h
index 81209eb..1beae2c 100644
--- a/arch/arm/mach-s5pv210/include/mach/dma.h
+++ b/arch/arm/mach-s5pv210/include/mach/dma.h
@@ -21,6 +21,6 @@
 #define __MACH_DMA_H
 
 /* This platform uses the common S3C DMA API driver for PL330 */
-#include <plat/s3c-dma-pl330.h>
+#include <plat/dma-pl330.h>
 
 #endif /* __MACH_DMA_H */
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b3e1065..e6f01ab 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -306,6 +306,15 @@ config S3C_PL330_DMA
 	help
 	  S3C DMA API Driver for PL330 DMAC.
 
+config SAMSUNG_DMADEV
+	bool
+	select DMADEVICES
+	select PL330_DMA if (CPU_EXYNOS4210 || CPU_S5PV210 || CPU_S5PC100 || \
+					CPU_S5P6450 || CPU_S5P6440)
+	select ARM_AMBA
+	help
+	  Use DMA device engine for PL330 DMAC.
+
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
diff --git a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
similarity index 93%
rename from arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
rename to arch/arm/plat-samsung/include/plat/dma-pl330.h
index 8107442..0a5dade 100644
--- a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -8,8 +8,8 @@
  * (at your option) any later version.
  */
 
-#ifndef	__S3C_DMA_PL330_H_
-#define	__S3C_DMA_PL330_H_
+#ifndef __DMA_PL330_H_
+#define __DMA_PL330_H_ __FILE__
 
 #define S3C2410_DMAF_AUTOSTART		(1 << 0)
 #define S3C2410_DMAF_CIRCULAR		(1 << 1)
@@ -20,7 +20,7 @@
  * For the sake of consistency across client drivers,
  * We keep the channel names unchanged and only add
  * missing peripherals are added.
- * Order is not important since S3C PL330 API driver
+ * Order is not important since DMA PL330 API driver
  * use these just as IDs.
  */
 enum dma_ch {
@@ -95,4 +95,4 @@ static inline bool s3c_dma_has_circular(void)
 
 #include <plat/dma.h>
 
-#endif	/* __S3C_DMA_PL330_H_ */
+#endif	/* __DMA_PL330_H_ */
diff --git a/arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h b/arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
index bf5e2a9..64fdf66 100644
--- a/arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
+++ b/arch/arm/plat-samsung/include/plat/s3c-pl330-pdata.h
@@ -12,7 +12,7 @@
 #ifndef __S3C_PL330_PDATA_H
 #define __S3C_PL330_PDATA_H
 
-#include <plat/s3c-dma-pl330.h>
+#include <plat/dma-pl330.h>
 
 /*
  * Every PL330 DMAC has max 32 peripheral interfaces,
-- 
1.7.1
