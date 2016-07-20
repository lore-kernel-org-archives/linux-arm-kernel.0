From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 20 Jul 2016 11:50:31 +0300
Subject: [PATCH v2 5/6] dmaengine: omap-dma: Use pointer to omap_sg in
 slave_sg setup's loop
In-Reply-To: <20160720085032.2955-1-peter.ujfalusi@ti.com>
References: <20160720085032.2955-1-peter.ujfalusi@ti.com>
Message-ID: <20160720085032.2955-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of accessing the array via index, take the pointer first and use
it to set up the omap_sg struct.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 072fff7164dd..9f1cfac16f92 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -819,9 +819,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	en = burst;
 	frame_bytes = es_bytes[es] * en;
 	for_each_sg(sgl, sgent, sglen, i) {
-		d->sg[i].addr = sg_dma_address(sgent);
-		d->sg[i].en = en;
-		d->sg[i].fn = sg_dma_len(sgent) / frame_bytes;
+		struct omap_sg *osg = &d->sg[i];
+
+		osg->addr = sg_dma_address(sgent);
+		osg->en = en;
+		osg->fn = sg_dma_len(sgent) / frame_bytes;
 	}
 
 	d->sglen = sglen;
-- 
2.9.2
