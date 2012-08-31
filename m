From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 31 Aug 2012 11:26:59 +0200
Subject: [PATCH v2 4/9] iram_alloc: store the virt and phys mem address in
 gen_pool chunks
In-Reply-To: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
References: <1346405224-20399-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1346405224-20399-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This improves the symmetry of iram_alloc and iram_free in that
iram_free has to be called with the virtual address now.
Also, gen_pool_virt_to_phys is now functional.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/plat-mxc/iram_alloc.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-mxc/iram_alloc.c b/arch/arm/plat-mxc/iram_alloc.c
index 673deb4..343e96d 100644
--- a/arch/arm/plat-mxc/iram_alloc.c
+++ b/arch/arm/plat-mxc/iram_alloc.c
@@ -26,25 +26,22 @@
 #include <linux/platform_device.h>
 #include <mach/iram.h>
 
-static unsigned long iram_phys_base;
-static void __iomem *iram_virt_base;
 static struct gen_pool *iram_pool;
 
-static inline void __iomem *iram_phys_to_virt(unsigned long p)
-{
-	return iram_virt_base + (p - iram_phys_base);
-}
-
 void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
 {
+	unsigned long virt;
+
 	if (!iram_pool)
 		return NULL;
 
-	*dma_addr = gen_pool_alloc(iram_pool, size);
+	virt = gen_pool_alloc(iram_pool, size);
 	pr_debug("iram alloc - %dB at 0x%lX\n", size, *dma_addr);
-	if (!*dma_addr)
+	if (!virt)
 		return NULL;
-	return iram_phys_to_virt(*dma_addr);
+
+	*dma_addr = gen_pool_virt_to_phys(iram_pool, virt);
+	return (void __iomem *)virt;
 }
 EXPORT_SYMBOL(iram_alloc);
 
@@ -59,29 +56,37 @@ EXPORT_SYMBOL(iram_free);
 
 static int __devinit iram_probe(struct platform_device *pdev)
 {
+	void __iomem *virt_base;
 	struct resource *res;
 	unsigned long size;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
 
-	if (iram_phys_base)
+	if (iram_pool)
 		return -EBUSY;
 
-	iram_phys_base = res->start;
 	size = resource_size(res);
 
+	virt_base = devm_ioremap(&pdev->dev, res->start, size);
+	if (!virt_base)
+		return -ENOMEM;
+
 	iram_pool = gen_pool_create(PAGE_SHIFT, -1);
 	if (!iram_pool)
 		return -ENOMEM;
 
-	gen_pool_add(iram_pool, res->start, size, -1);
-	iram_virt_base = ioremap(iram_phys_base, size);
-	if (!iram_virt_base)
-		return -EIO;
+	ret = gen_pool_add_virt(iram_pool, (unsigned long)virt_base,
+				res->start, size, -1);
+	if (ret < 0) {
+		gen_pool_destroy(iram_pool);
+		iram_pool = NULL;
+		return ret;
+	}
 
-	pr_debug("i.MX IRAM pool: %ld KB at 0x%p\n", size / 1024, iram_virt_base);
+	pr_debug("i.MX IRAM pool: %ld KB@0x%p\n", size / 1024, virt_base);
 	return 0;
 }
 
-- 
1.7.10.4
