From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:57:47 +0200
Subject: [PATCH 04/10] dma: mv_xor_v2: enable XOR engine after its
 configuration
In-Reply-To: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1493978274-12805-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1493978274-12805-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

The engine was enabled prior to its configuration, which isn't
correct. This patch relocates the activation of the XOR engine, to be
after the configuration of the XOR engine.

Fixes: 19a340b1a820 ("dmaengine: mv_xor_v2: new driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index cb60e7c..211b8c0 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -653,9 +653,6 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
 	writel((xor_dev->hw_desq & 0xFFFF00000000) >> 32,
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BAHR_OFF);
 
-	/* enable the DMA engine */
-	writel(0, xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_STOP_OFF);
-
 	/*
 	 * This is a temporary solution, until we activate the
 	 * SMMU. Set the attributes for reading & writing data buffers
@@ -699,6 +696,9 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
 	reg |= MV_XOR_V2_GLOB_PAUSE_AXI_TIME_DIS_VAL;
 	writel(reg, xor_dev->glob_base + MV_XOR_V2_GLOB_PAUSE);
 
+	/* enable the DMA engine */
+	writel(0, xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_STOP_OFF);
+
 	return 0;
 }
 
-- 
2.7.4
