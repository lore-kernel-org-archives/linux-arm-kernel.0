From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 12:59:28 +0100
Subject: [PATCH 1/5] dmaengine i.MX sdma: set maximum segment size for our
	device
In-Reply-To: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475172-23900-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475172-23900-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5a5d4d..c503050 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -301,6 +301,7 @@ struct sdma_firmware_header {
 
 struct sdma_engine {
 	struct device			*dev;
+	struct device_dma_parameters	dma_parms;
 	struct sdma_channel		channel[MAX_DMA_CHANNELS];
 	struct sdma_channel_control	*channel_control;
 	void __iomem			*regs;
@@ -1317,6 +1318,8 @@ static int __init sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_control = sdma_control;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
+	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
+	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
 
 	ret = dma_async_device_register(&sdma->dma_device);
 	if (ret) {
-- 
1.7.2.3
