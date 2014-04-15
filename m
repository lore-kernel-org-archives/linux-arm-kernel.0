From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:36 +0200
Subject: [PATCH 5/6] dma: mmp_pdma: Add support for fly-by transfers
In-Reply-To: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397574817-15559-6-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable fly-by mode when the DMA_SLAVE_FLAG_FLY_BY flag is set in the
slave configuration.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 7ed7850..849bf75 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -63,6 +63,8 @@
 #define DCMD_FLOWTRG	BIT(28)	/* Flow Control by the target. */
 #define DCMD_STARTIRQEN	BIT(22)	/* Start Interrupt Enable */
 #define DCMD_ENDIRQEN	BIT(21)	/* End Interrupt Enable */
+#define DCMD_FLYBYS	BIT(20)	/* Fly-By Source */
+#define DCMD_FLYBYT	BIT(19)	/* Fly-By Target */
 #define DCMD_ENDIAN	BIT(18)	/* Device Endian-ness. */
 #define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
 #define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
@@ -708,11 +710,15 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 	case DMA_SLAVE_CONFIG:
 		if (cfg->direction == DMA_DEV_TO_MEM) {
 			chan->dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
+			if (cfg->flags & DMA_SLAVE_FLAG_FLY_BY)
+				chan->dcmd |= DCMD_FLYBYT;
 			maxburst = cfg->src_maxburst;
 			width = cfg->src_addr_width;
 			addr = cfg->src_addr;
 		} else if (cfg->direction == DMA_MEM_TO_DEV) {
 			chan->dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
+			if (cfg->flags & DMA_SLAVE_FLAG_FLY_BY)
+				chan->dcmd |= DCMD_FLYBYS;
 			maxburst = cfg->dst_maxburst;
 			width = cfg->dst_addr_width;
 			addr = cfg->dst_addr;
-- 
1.8.3.2
