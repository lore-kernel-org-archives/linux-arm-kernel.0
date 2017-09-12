From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 12 Sep 2017 13:44:23 +0300
Subject: [PATCH 4/5] dmaengine: edma: Implement device_get_max_len callback
In-Reply-To: <20170912104424.18495-1-peter.ujfalusi@ti.com>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
Message-ID: <20170912104424.18495-5-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?eDMA can support maximum of 65535 number of bursts in one transfer.
The limitation is because the CCNT counter is 16bit unsigned.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 6970355abdc9..14c52574262c 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -900,6 +900,28 @@ static int edma_slave_config(struct dma_chan *chan,
 	return 0;
 }
 
+static u32 edma_get_max_len(struct dma_chan *chan,
+			    enum dma_transfer_direction dir)
+{
+	struct edma_chan *echan = to_edma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	u32 burst;
+
+	if (!is_slave_direction(dir))
+		return 0;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_width = echan->cfg.src_addr_width;
+		burst = echan->cfg.src_maxburst;
+	} else {
+		burst = echan->cfg.dst_maxburst;
+		dev_width = echan->cfg.dst_addr_width;
+	}
+
+	/* CCNT: 16bit unsigned. Number of bursts */
+	return dev_width * burst * (SZ_64K - 1);
+}
+
 static int edma_dma_pause(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
@@ -1850,6 +1872,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 	s_ddev->device_issue_pending = edma_issue_pending;
 	s_ddev->device_tx_status = edma_tx_status;
 	s_ddev->device_config = edma_slave_config;
+	s_ddev->device_get_max_len = edma_get_max_len;
 	s_ddev->device_pause = edma_dma_pause;
 	s_ddev->device_resume = edma_dma_resume;
 	s_ddev->device_terminate_all = edma_terminate_all;
-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
