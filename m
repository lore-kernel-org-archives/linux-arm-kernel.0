From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 13:06:29 +0000
Subject: [PATCH 1/3] dmaengine: at_hdmac: use endian agnostic IO accesors
In-Reply-To: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427375191-1467-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the at_hdmac driver to use readl_relaxed and writel_relaxed
to ensure it is properly taking into account the CPU versius the
bus endian-ness.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Vinod Koul <vinod.koul@intel.com>
CC: linux-arm-kernel at lists.infradead.org
CC: dmaengine at vger.kernel.org
---
 drivers/dma/at_hdmac_regs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index d6bba6c..b4d0a54 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -264,10 +264,10 @@ struct at_dma_chan {
 };
 
 #define	channel_readl(atchan, name) \
-	__raw_readl((atchan)->ch_regs + ATC_##name##_OFFSET)
+	readl_relaxed((atchan)->ch_regs + ATC_##name##_OFFSET)
 
 #define	channel_writel(atchan, name, val) \
-	__raw_writel((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
+	writel_relaxed((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
 
 static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
 {
@@ -332,9 +332,9 @@ struct at_dma {
 };
 
 #define	dma_readl(atdma, name) \
-	__raw_readl((atdma)->regs + AT_DMA_##name)
+	readl_relaxed((atdma)->regs + AT_DMA_##name)
 #define	dma_writel(atdma, name, val) \
-	__raw_writel((val), (atdma)->regs + AT_DMA_##name)
+	writel_relaxed((val), (atdma)->regs + AT_DMA_##name)
 
 static inline struct at_dma *to_at_dma(struct dma_device *ddev)
 {
-- 
2.1.4
