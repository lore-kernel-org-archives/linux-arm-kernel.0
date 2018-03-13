From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Tue, 13 Mar 2018 17:55:35 +0100
Subject: [PATCH v1 1/1] dmaengine: stm32-dmamux: fix a potential buffer
 overflow
Message-ID: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bitfield dma_inuse is allocated of size dma_requests bits, thus a
valid bit address is from 0 to (dma_requests - 1).
When find_first_zero_bit() fails, it returns dma_requests as invalid
address.
Using such address for the following set_bit() is incorrect and, if
dma_requests is a multiple of BITS_PER_LONG, it will cause a buffer
overflow.
Currently this driver is only used in DT stm32h743.dtsi where a safe value
dma_requests=16 is not triggering the buffer overflow.

Fixed by checking the return value of find_first_zero_bit() _before_
using it.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dmamux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 4dbb30c..b922db9 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -118,14 +118,15 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	spin_lock_irqsave(&dmamux->lock, flags);
 	mux->chan_id = find_first_zero_bit(dmamux->dma_inuse,
 					   dmamux->dma_requests);
-	set_bit(mux->chan_id, dmamux->dma_inuse);
-	spin_unlock_irqrestore(&dmamux->lock, flags);
 
 	if (mux->chan_id == dmamux->dma_requests) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		ret = -ENOMEM;
-		goto error;
+		goto error_chan_id;
 	}
+	set_bit(mux->chan_id, dmamux->dma_inuse);
+	spin_unlock_irqrestore(&dmamux->lock, flags);
 
 	/* Look for DMA Master */
 	for (i = 1, min = 0, max = dmamux->dma_reqs[i];
@@ -173,6 +174,8 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 error:
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
+
+error_chan_id:
 	kfree(mux);
 	return ERR_PTR(ret);
 }
-- 
2.7.4
