From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 10 Feb 2014 15:55:58 +0000
Subject: [PATCH 01/26] dmaengine: omap-dma: use devm_kzalloc() to allocate
 omap_dmadev.
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Message-ID: <E1WCtDC-0006W6-Bu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_kzalloc() to allocate omap_dmadev() so that we don't need
complex error cleanup paths.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 362e7c49f2e1..98034e8c558f 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -594,7 +594,6 @@ static void omap_dma_free(struct omap_dmadev *od)
 		tasklet_kill(&c->vc.task);
 		kfree(c);
 	}
-	kfree(od);
 }
 
 static int omap_dma_probe(struct platform_device *pdev)
@@ -602,7 +601,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	struct omap_dmadev *od;
 	int rc, i;
 
-	od = kzalloc(sizeof(*od), GFP_KERNEL);
+	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
 		return -ENOMEM;
 
-- 
1.8.3.1
