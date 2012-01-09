From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 9 Jan 2012 16:48:59 +0800
Subject: [PATCH 1/2] dma/imx-sdma: call sdma_set_channel_priority after
 sdma_request_channel
Message-ID: <1326098940-3697-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdma_request_channel sets the default priority. sdma_alloc_chan_resources
should call sdma_set_channel_priority thereafter to over write it.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 2cc96c4..6376009 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -875,11 +875,11 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 
 	sdmac->peripheral_type = data->peripheral_type;
 	sdmac->event_id0 = data->dma_request;
-	ret = sdma_set_channel_priority(sdmac, prio);
+	ret = sdma_request_channel(sdmac);
 	if (ret)
 		return ret;
 
-	ret = sdma_request_channel(sdmac);
+	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		return ret;
 
-- 
1.7.5.4
