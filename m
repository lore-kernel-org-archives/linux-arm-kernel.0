From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:36:38 +0100
Subject: [RFC 04/34] dmaengine: PL08x: remove runtime PM support
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIr0-0006yy-98@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The runtime PM support conflicts with the generic AMBA bus PM, and also
causes a potential deadlock with the PL011 driver as it results in
interrupts being enabled beneath a spinlock.

I don't presently see any solution to this other than by removing the
runtime PM support entirely from the DMA engine driver.  Alternative
suggestions welcome.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 3d704ab..8931682 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -400,7 +400,6 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 		return NULL;
 	}
 
-	pm_runtime_get_sync(&pl08x->adev->dev);
 	return ch;
 }
 
@@ -414,8 +413,6 @@ static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 	/* Stop the channel and clear its interrupts */
 	pl08x_terminate_phy_chan(pl08x, ch);
 
-	pm_runtime_put(&pl08x->adev->dev);
-
 	/* Mark it as free */
 	ch->serving = NULL;
 	spin_unlock_irqrestore(&ch->lock, flags);
@@ -1842,9 +1839,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_pl08x;
 	}
 
-	pm_runtime_set_active(&adev->dev);
-	pm_runtime_enable(&adev->dev);
-
 	/* Initialize memcpy engine */
 	dma_cap_set(DMA_MEMCPY, pl08x->memcpy.cap_mask);
 	pl08x->memcpy.dev = &adev->dev;
@@ -1983,7 +1977,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		 amba_part(adev), amba_rev(adev),
 		 (unsigned long long)adev->res.start, adev->irq[0]);
 
-	pm_runtime_put(&adev->dev);
 	return 0;
 
 out_no_slave_reg:
@@ -2002,9 +1995,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	dma_pool_destroy(pl08x->pool);
 out_no_lli_pool:
 out_no_platdata:
-	pm_runtime_put(&adev->dev);
-	pm_runtime_disable(&adev->dev);
-
 	kfree(pl08x);
 out_no_pl08x:
 	amba_release_regions(adev);
-- 
1.7.4.4
