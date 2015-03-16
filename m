From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 16 Mar 2015 11:52:45 +0000
Subject: [PATCH 3/3] dmaengine: pl330: fix return status on pending transfers
In-Reply-To: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426506765-10085-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pl330_tx_status() function returns the desc->status if the
dma_cookie_status() call does indicate the cookie completed,
however the desc->status is not look directly compatible. Sparse
throws the following warning:

pl330.c:2262:35: warning: mixing different enum types
pl330.c:2262:35:     int enum desc_status  versus
pl330.c:2262:35:     int enum dma_status

Attempt to fix this by adding a switch statement to turn the
desc->status into a dma_status.

Note, this has only been tested with the dmatest suite.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Vinod Koul <vinod.koul@intel.com>
Dan Williams <dan.j.williams@intel.com>
DMA List <dmaengine@vger.kernel.org>
Maxime Ripard <maxime.ripard@free-electrons.com>
Jassi Brar <jassisinghbrar@gmail.com>
Liviu Dudau <Liviu.Dudau@arm.com>
Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 drivers/dma/pl330.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index d6f677e..a7d9d30 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2259,7 +2259,17 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			transferred = 0;
 		residual += desc->bytes_requested - transferred;
 		if (desc->txd.cookie == cookie) {
-			ret = desc->status;
+			switch (desc->status) {
+			case DONE:
+				ret = DMA_COMPLETE;
+				break;
+			case PREP:
+			case BUSY:
+				ret = DMA_IN_PROGRESS;
+				break;
+			default:
+				WARN_ON(1);
+			}
 			break;
 		}
 		if (desc->last)
-- 
2.1.4
