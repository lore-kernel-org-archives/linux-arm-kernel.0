From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:00:46 +0100
Subject: [PATCH 2/4] dmaengine i.MX dma: check sg entries for valid addresses
	and lengths
In-Reply-To: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
References: <1296475248-29095-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296475248-29095-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-dma.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index a46e1d9..a1eac99 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -243,6 +243,21 @@ static struct dma_async_tx_descriptor *imxdma_prep_slave_sg(
 	else
 		dmamode = DMA_MODE_WRITE;
 
+	switch (imxdmac->word_size) {
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		if (sgl->length & 3 || sgl->dma_address & 3)
+			return NULL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		if (sgl->length & 1 || sgl->dma_address & 1)
+			return NULL;
+		break;
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		break;
+	default:
+		return NULL;
+	}
+
 	ret = imx_dma_setup_sg(imxdmac->imxdma_channel, sgl, sg_len,
 		 dma_length, imxdmac->per_address, dmamode);
 	if (ret)
-- 
1.7.2.3
