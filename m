From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 Aug 2010 14:12:04 +0200
Subject: [PATCH 02/12] DMAENGINE: safeguard PL08X from missing platform data
In-Reply-To: <1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL08X needs some platform data with channel assignments etc to
work properly, bail out of this is not supplied.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/amba-pl08x.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 2afb4f6..506749b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1819,6 +1819,13 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 		goto out_no_pl08x;
 	}
 
+	/* Get the platform data */
+	pl08x->pd = dev_get_platdata(&adev->dev);
+	if (!pl08x->pd) {
+		dev_err(&adev->dev, "no platform data supplied\n");
+		goto out_no_platdata;
+	}
+
 	/* Assign useful pointers to the driver state */
 	pl08x->adev = adev;
 	pl08x->vd = vd;
@@ -1879,9 +1886,6 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
 	}
 
-	/* Get the platform data */
-	pl08x->pd = dev_get_platdata(&adev->dev);
-
 	/* Set caps */
 	dma_cap_set(DMA_MEMCPY, dmac_memcpy.cap_mask);
 	dma_cap_set(DMA_SLAVE, dmac_slave.cap_mask);
@@ -1947,6 +1951,7 @@ out_no_irq:
 out_no_ioremap:
 	dma_pool_destroy(pl08x->pool);
 out_no_lli_pool:
+out_no_platdata:
 	kfree(pl08x);
 out_no_pl08x:
 	amba_release_regions(adev);
-- 
1.6.3.3
