From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:54:28 +0530
Subject: [PATCH v2 4/4] dmaengine: zynqmp_dma: Fix race condition in the probe
In-Reply-To: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
References: <1512624268-13944-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624268-13944-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
--> New patch.

 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index a297a26..f146458 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -851,7 +851,8 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_chan *chan)
 	if (!chan)
 		return;
 
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 }
-- 
2.7.4
