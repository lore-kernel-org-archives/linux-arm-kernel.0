From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:26 +0100
Subject: [PATCH 06/12] ARM: mxc: Setup consistent dma size at boot time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-7-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Sascha Hauer <kernel@pengutronix.de>
CC: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 arch/arm/plat-mxc/include/mach/memory.h |   15 ---------------
 arch/arm/mach-imx/mm-imx1.c             |    1 +
 arch/arm/mach-imx/mm-imx21.c            |    1 +
 arch/arm/mach-imx/mm-imx25.c            |    1 +
 arch/arm/mach-imx/mm-imx27.c            |    1 +
 arch/arm/mach-imx/mm-imx31.c            |    1 +
 arch/arm/mach-imx/mm-imx35.c            |    1 +
 arch/arm/mach-mx5/mm-mx50.c             |    1 +
 arch/arm/mach-mx5/mm.c                  |    2 ++
 arch/arm/plat-mxc/system.c              |   16 ++++++++++++++++
 11 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..40fb4d8 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,4 +72,5 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void __init mxc_init_consistent_dma_size(void);
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 11be5cd..3ec84b9 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -40,19 +40,4 @@
 # endif
 #endif
 
-#if defined(CONFIG_MX3_VIDEO)
-/*
- * Increase size of DMA-consistent memory region.
- * This is required for mx3 camera driver to capture at least two QXGA frames.
- */
-#define CONSISTENT_DMA_SIZE SZ_8M
-
-#elif defined(CONFIG_MX1_VIDEO) || defined(CONFIG_VIDEO_MX2_HOSTSUPPORT)
-/*
- * Increase size of DMA-consistent memory region.
- * This is required for i.MX camera driver to capture at least four VGA frames.
- */
-#define CONSISTENT_DMA_SIZE SZ_4M
-#endif /* CONFIG_MX1_VIDEO || CONFIG_VIDEO_MX2_HOSTSUPPORT */
-
 #endif /* __ASM_ARCH_MXC_MEMORY_H__ */
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 2bded59..f70e318 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -33,6 +33,7 @@ static struct map_desc imx_io_desc[] __initdata = {
 void __init mx1_map_io(void)
 {
 	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx1_init_early(void)
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index 3f05dfe..440816a 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -60,6 +60,7 @@ static struct map_desc imx21_io_desc[] __initdata = {
 void __init mx21_map_io(void)
 {
 	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx21_init_early(void)
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index cc4d152..12f5759 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -48,6 +48,7 @@ static struct map_desc mx25_io_desc[] __initdata = {
 void __init mx25_map_io(void)
 {
 	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx25_init_early(void)
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 96dd1f5..8799265 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -60,6 +60,7 @@ static struct map_desc imx27_io_desc[] __initdata = {
 void __init mx27_map_io(void)
 {
 	iotable_init(imx27_io_desc, ARRAY_SIZE(imx27_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx27_init_early(void)
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index b7c55e7..b2331cf 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -45,6 +45,7 @@ static struct map_desc mx31_io_desc[] __initdata = {
 void __init mx31_map_io(void)
 {
 	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx31_init_early(void)
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index f49bac7..eb60521 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -41,6 +41,7 @@ static struct map_desc mx35_io_desc[] __initdata = {
 void __init mx35_map_io(void)
 {
 	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx35_init_early(void)
diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
index 77e374c..04a02cc 100644
--- a/arch/arm/mach-mx5/mm-mx50.c
+++ b/arch/arm/mach-mx5/mm-mx50.c
@@ -46,6 +46,7 @@ static struct map_desc mx50_io_desc[] __initdata = {
 void __init mx50_map_io(void)
 {
 	iotable_init(mx50_io_desc, ARRAY_SIZE(mx50_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx50_init_early(void)
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index baea6e5..e0ca2b5 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -49,6 +49,7 @@ static struct map_desc mx53_io_desc[] __initdata = {
 void __init mx51_map_io(void)
 {
 	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx51_init_early(void)
@@ -61,6 +62,7 @@ void __init imx51_init_early(void)
 void __init mx53_map_io(void)
 {
 	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
+	mxc_init_consistent_dma_size();
 }
 
 void __init imx53_init_early(void)
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 8024f2a..75d1592 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
@@ -74,3 +75,18 @@ void mxc_arch_reset_init(void __iomem *base)
 {
 	wdog_base = base;
 }
+
+void __init mxc_init_consistent_dma_size(void)
+{
+#if defined(CONFIG_MX3_VIDEO)
+
+	/* Required for mx3 camera driver to capture at least two QXGA frames */
+	init_consistent_dma_size(SZ_8M);
+
+#elif defined(CONFIG_MX1_VIDEO) || defined(CONFIG_VIDEO_MX2_HOSTSUPPORT)
+
+	/* Required for i.MX camera driver to capture at least 4 VGA frames */
+	init_consistent_dma_size(SZ_4M);
+
+#endif
+}
-- 
1.7.2.5
