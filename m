From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 24 Nov 2015 09:52:35 +0100
Subject: [PATCH] dmaengine: stm32-dma: Fix static checker warning
Message-ID: <1448355155-31283-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix an unchecked dereference warning by returning operation
not permitted when stm32_dma_start_transfer() does not succeed to allocate
a virtual channel descriptor.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 drivers/dma/stm32-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 12f3a3e..0214bcf 100644
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
-- 
1.9.1
