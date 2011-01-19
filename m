From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 20 Jan 2011 05:50:39 +0800
Subject: [PATCH 5/6] dmaengine: imx-sdma: fix up param for the last BD in
	sdma_prep_slave_sg()
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295473840-17295-6-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the reference manual, bit "L" should be set while bit "C"
should be cleared for the last buffer descriptor in the non-cyclic
chain, so that sdma can stop trying to find the next BD and end
the transfer.

In case of sdma_prep_slave_sg(), BD_LAST needs to be set and BD_CONT
be cleared for the last BD.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e5af547..fa63ace 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -931,8 +931,11 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
 
-		if (i + 1 == sg_len)
+		if (i + 1 == sg_len) {
 			param |= BD_INTR;
+			param |= BD_LAST;
+			param &= ~BD_CONT;
+		}
 
 		dev_dbg(sdma->dev, "entry %d: count: %d dma: 0x%08x %s%s\n",
 				i, count, sg->dma_address,
-- 
1.7.1
