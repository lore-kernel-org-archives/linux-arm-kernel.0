From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon,  4 Jul 2011 21:18:32 +0900
Subject: [PATCH 4/7] ARM: SAMSUNG: Update to use PL330-DMA driver
In-Reply-To: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309781915-31549-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support PL330-DMA driver on DMADEVICE. Currently
S3C-DMA(PL080) is used for S3C24XX and S3C64XX and S3C-PL330-DMA has
been used for S5P SoCs. So this patch changes S3C-PL330-DMA to just
PL330-DMA for use generic DMA driver for S5P SoCs.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/dma.h           |    4 ++--
 arch/arm/mach-s5p64x0/include/mach/dma.h           |    2 +-
 arch/arm/mach-s5pc100/include/mach/dma.h           |    2 +-
 arch/arm/mach-s5pv210/include/mach/dma.h           |    2 +-
 arch/arm/plat-samsung/Kconfig                      |    7 +++++++
 .../include/plat/{s3c-dma-pl330.h => dma-pl330.h}  |   18 +++++++++++++++---
 .../plat-samsung/include/plat/s3c-pl330-pdata.h    |    2 +-
 7 files changed, 28 insertions(+), 9 deletions(-)
 rename arch/arm/plat-samsung/include/plat/{s3c-dma-pl330.h => dma-pl330.h} (87%)

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
index 4d79519..4dc914e 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -300,6 +300,13 @@ config S3C_PL330_DMA
 	help
 	  S3C DMA API Driver for PL330 DMAC.
 
+config DMADEV_PL330
+	bool
+	select DMADEVICES
+	select PL330_DMA
+	help
+	  Use DMA device engine for PL330 DMAC.
+
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
diff --git a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h b/arch/arm/plat-samsung/include/plat/dma-pl330.h
similarity index 87%
rename from arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
rename to arch/arm/plat-samsung/include/plat/dma-pl330.h
index 8107442..1122c8b 100644
--- a/arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
+++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
@@ -8,11 +8,13 @@
  * (at your option) any later version.
  */
 
-#ifndef	__S3C_DMA_PL330_H_
-#define	__S3C_DMA_PL330_H_
+#ifndef __DMA_PL330_H_
+#define __DMA_PL330_H_ __FILE__
 
+#if !defined(CONFIG_DMADEV_PL330)
 #define S3C2410_DMAF_AUTOSTART		(1 << 0)
 #define S3C2410_DMAF_CIRCULAR		(1 << 1)
+#endif
 
 /*
  * PL330 can assign any channel to communicate with
@@ -84,6 +86,14 @@ enum dma_ch {
 	DMACH_SLIMBUS4_TX,
 	DMACH_SLIMBUS5_RX,
 	DMACH_SLIMBUS5_TX,
+	DMACH_MTOM_0,
+	DMACH_MTOM_1,
+	DMACH_MTOM_2,
+	DMACH_MTOM_3,
+	DMACH_MTOM_4,
+	DMACH_MTOM_5,
+	DMACH_MTOM_6,
+	DMACH_MTOM_7,
 	/* END Marker, also used to denote a reserved channel */
 	DMACH_MAX,
 };
@@ -93,6 +103,8 @@ static inline bool s3c_dma_has_circular(void)
 	return true;
 }
 
+#if !defined(CONFIG_DMADEV_PL330)
 #include <plat/dma.h>
+#endif
 
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
