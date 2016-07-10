From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 10 Jul 2016 23:50:49 +0200
Subject: [PATCH] dmaengine: pxa_dma: implement device_synchronize
Message-ID: <1468187449-19466-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the function which wait until a dma channel is stopped to have
a synchronization point.

This also protects the pxad_remove() from races, such as spurious
interrupts while removing the driver, because :
 - as long as there is one dma channel requested, ie. dma_chan_get() but
   no dma_chan_put(), the try_module_get() of dma_chan_get() prevents
   the remove() routine from running
 - when the last channel is released, ie. the last dma_chan_put() is
   called, if there is a running DMA, pxad_synchronize() is called
 - pxad_synchronize() waits for the channel to stop, which in turn
   ensures on pxa architecture that the interrupt cannot be fired anymore

Reported-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e756a30ccba2..cbd96038cfd0 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
+#include <linux/wait.h>
 #include <linux/dma/pxa-dma.h>
 
 #include "dmaengine.h"
@@ -118,6 +119,8 @@ struct pxad_chan {
 	struct pxad_phy		*phy;
 	struct dma_pool		*desc_pool;	/* Descriptors pool */
 	dma_cookie_t		bus_error;
+
+	wait_queue_head_t	wq_state;
 };
 
 struct pxad_device {
@@ -572,6 +575,7 @@ static void pxad_launch_chan(struct pxad_chan *chan,
 	 */
 	phy_writel(chan->phy, desc->first, DDADR);
 	phy_enable(chan->phy, chan->misaligned);
+	wake_up(&chan->wq_state);
 }
 
 static void set_updater_desc(struct pxad_desc_sw *sw_desc,
@@ -717,6 +721,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 		}
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	wake_up(&chan->wq_state);
 
 	return IRQ_HANDLED;
 }
@@ -1268,6 +1273,14 @@ static enum dma_status pxad_tx_status(struct dma_chan *dchan,
 	return ret;
 }
 
+static void pxad_synchronize(struct dma_chan *dchan)
+{
+	struct pxad_chan *chan = to_pxad_chan(dchan);
+
+	wait_event(chan->wq_state, !is_chan_running(chan));
+	vchan_synchronize(&chan->vc);
+}
+
 static void pxad_free_channels(struct dma_device *dmadev)
 {
 	struct pxad_chan *c, *cn;
@@ -1372,6 +1385,7 @@ static int pxad_init_dmadev(struct platform_device *op,
 	pdev->slave.device_tx_status = pxad_tx_status;
 	pdev->slave.device_issue_pending = pxad_issue_pending;
 	pdev->slave.device_config = pxad_config;
+	pdev->slave.device_synchronize = pxad_synchronize;
 	pdev->slave.device_terminate_all = pxad_terminate_all;
 
 	if (op->dev.coherent_dma_mask)
@@ -1389,6 +1403,7 @@ static int pxad_init_dmadev(struct platform_device *op,
 			return -ENOMEM;
 		c->vc.desc_free = pxad_free_desc;
 		vchan_init(&c->vc, &pdev->slave);
+		init_waitqueue_head(&c->wq_state);
 	}
 
 	return dma_async_device_register(&pdev->slave);
-- 
2.1.4
