From: ian.arkver.dev@gmail.com (Ian Arkver)
Date: Mon, 12 Sep 2016 13:50:55 +0100
Subject: [PATCH] arm: imx-dma: Don't change desc pointer before calling
 callback
Message-ID: <c1cd4d97-a8e2-0459-9f72-4d3f25e13bfb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit...
fcaaba6 dmaengine: imx-dma: fix callback path in tasklet
moved the test and call of the DMA completion callback function
into the tasklet exit path which is after the manipulation of ld_queue
and ld_active. This manipulation changes the desc pointer and can result
in the wrong descriptor being checked for the callback function.

One fix is to use a temporary variable to do the queue update.

Signed-off-by: Ian Jamison <ian.dev@arkver.com>
---
I found the bug and tested this patch on kernel 3.10.103 which has the
original patch backported. It was found using m2m_deinterlacer which issues
several DMAs with a callback on the last one. When the callback is called
early there is a race between the v4l2 framework returning the buffers
which invalidates the buffer pointers and the next DMA completion. This
resulted in intermittent NULL pointer dereferences. I believe the fix is
relevant to current mainline kernel as this code fragment has not changed.

  drivers/dma/imx-dma.c | 6 +++---

  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index a960608..335c2d0 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -653,10 +653,10 @@ static void imxdma_tasklet(unsigned long data)
         list_move_tail(imxdmac->ld_active.next, &imxdmac->ld_free);

         if (!list_empty(&imxdmac->ld_queue)) {
-               desc = list_first_entry(&imxdmac->ld_queue, struct 
imxdma_desc,
-                                       node);
+               struct imxdma_desc *tmpdesc = list_first_entry(
+                       &imxdmac->ld_queue, struct imxdma_desc, node);
                 list_move_tail(imxdmac->ld_queue.next, 
&imxdmac->ld_active);
-               if (imxdma_xfer_desc(desc) < 0)
+               if (imxdma_xfer_desc(tmpdesc) < 0)
                         dev_warn(imxdma->dev, "%s: channel: %d couldn't 
xfer desc\n",
                                  __func__, imxdmac->channel);
         }
--
2.9.3
