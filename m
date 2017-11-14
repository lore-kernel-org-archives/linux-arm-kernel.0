From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Nov 2017 16:32:12 +0200
Subject: [PATCH 10/10] dmaengine: s3c24xx-dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171114143212.8311-11-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

CC: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/s3c24xx-dma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index f04c4702d98b..cd92d696bcf9 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -732,7 +732,7 @@ static int s3c24xx_dma_terminate_all(struct dma_chan *chan)
 
 	/* Dequeue current job */
 	if (s3cchan->at) {
-		s3c24xx_dma_desc_free(&s3cchan->at->vd);
+		vchan_terminate_vdesc(&s3cchan->at->vd);
 		s3cchan->at = NULL;
 	}
 
@@ -744,6 +744,13 @@ static int s3c24xx_dma_terminate_all(struct dma_chan *chan)
 	return ret;
 }
 
+static void s3c24xx_dma_synchronize(struct dma_chan *chan)
+{
+	struct s3c24xx_dma_chan *s3cchan = to_s3c24xx_dma_chan(chan);
+
+	vchan_synchronize(&s3cchan->vc);
+}
+
 static void s3c24xx_dma_free_chan_resources(struct dma_chan *chan)
 {
 	/* Ensure all queued descriptors are freed */
@@ -1282,6 +1289,7 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 	s3cdma->memcpy.device_issue_pending = s3c24xx_dma_issue_pending;
 	s3cdma->memcpy.device_config = s3c24xx_dma_set_runtime_config;
 	s3cdma->memcpy.device_terminate_all = s3c24xx_dma_terminate_all;
+	s3cdma->memcpy.device_synchronize = s3c24xx_dma_synchronize;
 
 	/* Initialize slave engine for SoC internal dedicated peripherals */
 	dma_cap_set(DMA_SLAVE, s3cdma->slave.cap_mask);
@@ -1296,6 +1304,7 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 	s3cdma->slave.device_prep_dma_cyclic = s3c24xx_dma_prep_dma_cyclic;
 	s3cdma->slave.device_config = s3c24xx_dma_set_runtime_config;
 	s3cdma->slave.device_terminate_all = s3c24xx_dma_terminate_all;
+	s3cdma->slave.device_synchronize = s3c24xx_dma_synchronize;
 	s3cdma->slave.filter.map = pdata->slave_map;
 	s3cdma->slave.filter.mapcnt = pdata->slavecnt;
 	s3cdma->slave.filter.fn = s3c24xx_dma_filter;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
