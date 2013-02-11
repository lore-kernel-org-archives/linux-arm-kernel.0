From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 11 Feb 2013 14:08:23 +0530
Subject: [PATCH V4 3/5] DMA: PL330: Register the DMA controller with the
 generic DMA helpers
In-Reply-To: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
References: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
Message-ID: <1360571905-15285-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the pl330 dma controller driver with the generic
device tree dma helper functions.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/pl330.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e68c83b..3fca247 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2999,6 +2999,14 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		pi->pcfg.data_bus_width / 8, pi->pcfg.num_chan,
 		pi->pcfg.num_peri, pi->pcfg.num_events);
 
+	ret = of_dma_controller_register(adev->dev.of_node,
+					 of_dma_pl330_xlate, pdmac);
+	if (ret) {
+		dev_err(&adev->dev,
+		"unable to register DMA to the generic DT DMA helpers\n");
+		goto probe_err2;
+	}
+
 	return 0;
 
 probe_err4:
@@ -3025,6 +3033,8 @@ static int pl330_remove(struct amba_device *adev)
 	if (!pdmac)
 		return 0;
 
+	of_dma_controller_free(adev->dev.of_node);
+
 	amba_set_drvdata(adev, NULL);
 
 	/* Idle the DMAC */
-- 
1.7.4.4
