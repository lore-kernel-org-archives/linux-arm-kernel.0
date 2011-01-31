From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:00:45 +0100
Subject: [PATCH 1/4] dmaengine i.MX dma: set maximum segment size for our
	device
In-Reply-To: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475248-29095-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-dma.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index e53d438..a46e1d9 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -49,6 +49,7 @@ struct imxdma_channel {
 
 struct imxdma_engine {
 	struct device			*dev;
+	struct device_dma_parameters	dma_parms;
 	struct dma_device		dma_device;
 	struct imxdma_channel		channel[MAX_DMA_CHANNELS];
 };
@@ -370,6 +371,9 @@ static int __init imxdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxdma);
 
+	imxdma->dma_device.dev->dma_parms = &imxdma->dma_parms;
+	dma_set_max_seg_size(imxdma->dma_device.dev, 0xffffff);
+
 	ret = dma_async_device_register(&imxdma->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register\n");
-- 
1.7.2.3
