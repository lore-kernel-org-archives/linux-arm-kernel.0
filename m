From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon,  7 Dec 2015 12:00:28 +0100
Subject: [PATCH v2] dmaengine: stm32-dma: Fix unchecked deference of chan->desc
Message-ID: <1449486028-29344-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'commit d8b468394fb7 ("dmaengine: Add STM32 DMA driver")' leads to the
following Smatch complaint:

drivers/dma/stm32-dma.c:562 stm32_dma_issue_pending()
    error: we previously assumed 'chan->desc' could be null (see line 560)

So, this patch fixes the unchecked dereference of chan->desc by returning
operation not permitted error when stm32_dma_start_transfer() does not
succeed to allocate a virtual channel descriptor.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

---
Changes since v1:
Explain what the patch fixes in the title (Vinod)
Add Dan as reporter using Reported-by tag (Vinod)
---
---
 drivers/dma/stm32-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 12f3a3e..047476a 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -437,7 +437,7 @@ static int stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	if (!chan->desc) {
 		vdesc = vchan_next_desc(&chan->vchan);
 		if (!vdesc)
-			return 0;
+			return -EPERM;
 
 		chan->desc = to_stm32_dma_desc(vdesc);
 		chan->next_sg = 0;
@@ -559,7 +559,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 	if (!chan->busy) {
 		if (vchan_issue_pending(&chan->vchan) && !chan->desc) {
 			ret = stm32_dma_start_transfer(chan);
-			if ((chan->desc->cyclic) && (!ret))
+			if ((!ret) && (chan->desc->cyclic))
 				stm32_dma_configure_next_sg(chan);
 		}
 	}
-- 
1.9.1
