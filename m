From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 13 Jan 2012 11:09:59 +0800
Subject: [PATCH v2 4/6] dma/imx-sdma: move clk_enable out of
 sdma_request_channel
In-Reply-To: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
References: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1326424201-20056-5-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes clk_enable/disable pair more readable, and fix one bug:
sdma_init calls sdma_request_channel, but seems don't know
sdma_request_channel enabled the clok.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/imx-sdma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b40f630..015d93f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -802,8 +802,6 @@ static int sdma_request_channel(struct sdma_channel *sdmac)
 	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
 	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
 
-	clk_enable(sdma->clk);
-
 	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
 
 	init_completion(&sdmac->done);
@@ -875,6 +873,9 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 
 	sdmac->peripheral_type = data->peripheral_type;
 	sdmac->event_id0 = data->dma_request;
+
+	clk_enable(sdmac->sdma->clk);
+
 	ret = sdma_request_channel(sdmac);
 	if (ret)
 		return ret;
-- 
1.7.5.4
