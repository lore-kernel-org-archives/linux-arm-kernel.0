From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 16:48:19 +0100
Subject: [PATCH 05/12] mxc: mx1/mx2 DMA: add a possibility to create an
	endless DMA transfer
In-Reply-To: <1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useful for audio where we do not want to setup a new scatterlist
after playing 4GB of audio data. This would cause skips in the playback.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/dma-mx1-mx2.c              |    3 ++-
 arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
index 7764643..9c1b3f9 100644
--- a/arch/arm/plat-mxc/dma-mx1-mx2.c
+++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
@@ -156,7 +156,8 @@ static inline int imx_dma_sg_next(int channel, struct scatterlist *sg)
 	}
 
 	now = min(imxdma->resbytes, sg->length);
-	imxdma->resbytes -= now;
+	if (imxdma->resbytes != IMX_DMA_LENGTH_LOOP)
+		imxdma->resbytes -= now;
 
 	if ((imxdma->dma_mode & DMA_MODE_MASK) == DMA_MODE_READ)
 		__raw_writel(sg->dma_address, DMA_BASE + DMA_DAR(channel));
diff --git a/arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h b/arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h
index b3876cc..07be8ad 100644
--- a/arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h
+++ b/arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h
@@ -58,6 +58,14 @@ imx_dma_setup_single(int channel, dma_addr_t dma_address,
 		unsigned int dma_length, unsigned int dev_addr,
 		unsigned int dmamode);
 
+
+/*
+ * Use this flag as the dma_length argument to imx_dma_setup_sg()
+ * to create an endless running dma loop. The end of the scatterlist
+ * must be linked to the beginning for this to work.
+ */
+#define IMX_DMA_LENGTH_LOOP	((unsigned int)-1)
+
 int
 imx_dma_setup_sg(int channel, struct scatterlist *sg,
 		unsigned int sgcount, unsigned int dma_length,
-- 
1.6.5.2
