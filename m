From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 13 Feb 2013 16:13:14 +0530
Subject: [PATCH] DMA: PL330: allow submitting 2 requests at a time
Message-ID: <1360752194-6506-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the logic to allow mc programming of second transfer after first
has been done, by removing immediate return upon success and iterating
until we detect QFull or DMAC dying.

Reported-by: Alvaro Moran <dirac3000@gmail.com>
Tested-by: Alvaro Moran <dirac3000@gmail.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/dma/pl330.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 80680ee..c1a867e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2282,13 +2282,12 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 
 		/* If already submitted */
 		if (desc->status == BUSY)
-			break;
+			continue;
 
 		ret = pl330_submit_req(pch->pl330_chid,
 						&desc->req);
 		if (!ret) {
 			desc->status = BUSY;
-			break;
 		} else if (ret == -EAGAIN) {
 			/* QFull or DMAC Dying */
 			break;
-- 
1.7.10.4
