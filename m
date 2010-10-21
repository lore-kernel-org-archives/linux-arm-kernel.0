From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 09:58:33 +0900
Subject: [PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
In-Reply-To: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287622713-1657-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwhan Youn <sw.youn@samsung.com>

This patch adds to enable/disable DMA operation clock on S3C-PL330
DMA controller driver.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Acked-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/s3c-pl330.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/s3c-pl330.c b/arch/arm/plat-samsung/s3c-pl330.c
index a91305a..b4ff8d7 100644
--- a/arch/arm/plat-samsung/s3c-pl330.c
+++ b/arch/arm/plat-samsung/s3c-pl330.c
@@ -15,6 +15,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <asm/hardware/pl330.h>
 
@@ -27,6 +29,7 @@
  * @node: To attach to the global list of DMACs.
  * @pi: PL330 configuration info for the DMAC.
  * @kmcache: Pool to quickly allocate xfers for all channels in the dmac.
+ * @clk: Pointer of DMAC operation clock.
  */
 struct s3c_pl330_dmac {
 	unsigned		busy_chan;
@@ -34,6 +37,7 @@ struct s3c_pl330_dmac {
 	struct list_head	node;
 	struct pl330_info	*pi;
 	struct kmem_cache	*kmcache;
+	struct clk		*clk;
 };
 
 /**
@@ -1072,16 +1076,25 @@ static int pl330_probe(struct platform_device *pdev)
 	if (ret)
 		goto probe_err4;
 
-	ret = pl330_add(pl330_info);
-	if (ret)
-		goto probe_err5;
-
 	/* Allocate a new DMAC */
 	s3c_pl330_dmac = kmalloc(sizeof(*s3c_pl330_dmac), GFP_KERNEL);
 	if (!s3c_pl330_dmac) {
 		ret = -ENOMEM;
+		goto probe_err5;
+	}
+
+	/* Get operation clock and enable it */
+	s3c_pl330_dmac->clk = clk_get(&pdev->dev, "pdma");
+	if (IS_ERR(s3c_pl330_dmac->clk)) {
+		dev_err(&pdev->dev, "Cannot get operation clock.\n");
+		ret = -EINVAL;
 		goto probe_err6;
 	}
+	clk_enable(s3c_pl330_dmac->clk);
+
+	ret = pl330_add(pl330_info);
+	if (ret)
+		goto probe_err7;
 
 	/* Hook the info */
 	s3c_pl330_dmac->pi = pl330_info;
@@ -1094,7 +1107,7 @@ static int pl330_probe(struct platform_device *pdev)
 
 	if (!s3c_pl330_dmac->kmcache) {
 		ret = -ENOMEM;
-		goto probe_err7;
+		goto probe_err8;
 	}
 
 	/* Get the list of peripherals */
@@ -1120,10 +1133,13 @@ static int pl330_probe(struct platform_device *pdev)
 
 	return 0;
 
+probe_err8:
+	pl330_del(pl330_info);
 probe_err7:
-	kfree(s3c_pl330_dmac);
+	clk_disable(s3c_pl330_dmac->clk);
+	clk_put(s3c_pl330_dmac->clk);
 probe_err6:
-	pl330_del(pl330_info);
+	kfree(s3c_pl330_dmac);
 probe_err5:
 	free_irq(irq, pl330_info);
 probe_err4:
@@ -1188,6 +1204,10 @@ static int pl330_remove(struct platform_device *pdev)
 		}
 	}
 
+	/* Disable operation clock */
+	clk_disable(dmac->clk);
+	clk_put(dmac->clk);
+
 	/* Remove the DMAC */
 	list_del(&dmac->node);
 	kfree(dmac);
-- 
1.6.2.5
