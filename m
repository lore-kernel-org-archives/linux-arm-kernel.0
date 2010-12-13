From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 13 Dec 2010 13:48:41 +0100
Subject: [PATCH] dmaengine: at_hdmac: fix buffer transfer size specification
Message-ID: <1292244521-20756-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Buffer transfer size is the number of transfers to be performed in
relation with the width of the _source_ interface.
So in the DMA_FROM_DEVICE case, it should be the register width that
should be taken into account.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a0f3e6a..ea0ee81 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -722,7 +722,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			desc->lli.daddr = mem;
 			desc->lli.ctrla = ctrla
 					| ATC_DST_WIDTH(mem_width)
-					| len >> mem_width;
+					| len >> reg_width;
 			desc->lli.ctrlb = ctrlb;
 
 			if (!first) {
-- 
1.7.3
