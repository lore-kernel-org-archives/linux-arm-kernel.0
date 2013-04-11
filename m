From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 23:37:19 +0200
Subject: [PATCH v3 04/10] ARM: samsung: move mfc device definition to
 s5p-dev-mfc.c
In-Reply-To: <1365716245-99231-1-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
Message-ID: <1365716245-99231-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a DT-only build we don't want to compile devs.c, but we do need
the mfc device, which is also referenced by the DT based platforms,
so move it all into one place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-samsung/devs.c        | 45 -------------------------------------
 arch/arm/plat-samsung/s5p-dev-mfc.c | 42 +++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 51afedd..de9ad27 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -878,51 +878,6 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 }
 #endif /* CONFIG_PLAT_S3C24XX */
 
-/* MFC */
-
-#ifdef CONFIG_S5P_DEV_MFC
-static struct resource s5p_mfc_resource[] = {
-	[0] = DEFINE_RES_MEM(S5P_PA_MFC, SZ_64K),
-	[1] = DEFINE_RES_IRQ(IRQ_MFC),
-};
-
-struct platform_device s5p_device_mfc = {
-	.name		= "s5p-mfc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s5p_mfc_resource),
-	.resource	= s5p_mfc_resource,
-};
-
-/*
- * MFC hardware has 2 memory interfaces which are modelled as two separate
- * platform devices to let dma-mapping distinguish between them.
- *
- * MFC parent device (s5p_device_mfc) must be registered before memory
- * interface specific devices (s5p_device_mfc_l and s5p_device_mfc_r).
- */
-
-struct platform_device s5p_device_mfc_l = {
-	.name		= "s5p-mfc-l",
-	.id		= -1,
-	.dev		= {
-		.parent			= &s5p_device_mfc.dev,
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-struct platform_device s5p_device_mfc_r = {
-	.name		= "s5p-mfc-r",
-	.id		= -1,
-	.dev		= {
-		.parent			= &s5p_device_mfc.dev,
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-#endif /* CONFIG_S5P_DEV_MFC */
-
 /* MIPI CSIS */
 
 #ifdef CONFIG_S5P_DEV_CSIS0
diff --git a/arch/arm/plat-samsung/s5p-dev-mfc.c b/arch/arm/plat-samsung/s5p-dev-mfc.c
index 5ec104b..a93fb6f 100644
--- a/arch/arm/plat-samsung/s5p-dev-mfc.c
+++ b/arch/arm/plat-samsung/s5p-dev-mfc.c
@@ -18,10 +18,50 @@
 #include <linux/of.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <plat/devs.h>
-#include <plat/irqs.h>
 #include <plat/mfc.h>
 
+static struct resource s5p_mfc_resource[] = {
+	[0] = DEFINE_RES_MEM(S5P_PA_MFC, SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_MFC),
+};
+
+struct platform_device s5p_device_mfc = {
+	.name		= "s5p-mfc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_mfc_resource),
+	.resource	= s5p_mfc_resource,
+};
+
+/*
+ * MFC hardware has 2 memory interfaces which are modelled as two separate
+ * platform devices to let dma-mapping distinguish between them.
+ *
+ * MFC parent device (s5p_device_mfc) must be registered before memory
+ * interface specific devices (s5p_device_mfc_l and s5p_device_mfc_r).
+ */
+
+struct platform_device s5p_device_mfc_l = {
+	.name		= "s5p-mfc-l",
+	.id		= -1,
+	.dev		= {
+		.parent			= &s5p_device_mfc.dev,
+		.dma_mask		= &s5p_device_mfc_l.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+struct platform_device s5p_device_mfc_r = {
+	.name		= "s5p-mfc-r",
+	.id		= -1,
+	.dev		= {
+		.parent			= &s5p_device_mfc.dev,
+		.dma_mask		= &s5p_device_mfc_r.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
 struct s5p_mfc_reserved_mem {
 	phys_addr_t	base;
 	unsigned long	size;
-- 
1.8.1.2
