From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:05:05 +0100
Subject: [PATCH 27/30] dma: mv_xor: add missing free_irq() call
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-28-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though the driver cannot be unloaded at the moment, it is still
good to properly free the IRQ handlers in the channel removal function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    5 ++++-
 drivers/dma/mv_xor.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index ec741b4..d48245c 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1082,6 +1082,8 @@ static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 		list_del(&chan->device_node);
 	}
 
+	free_irq(mv_chan->irq, mv_chan);
+
 	return 0;
 }
 
@@ -1101,6 +1103,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	}
 
 	mv_chan->idx = idx;
+	mv_chan->irq = irq;
 
 	dma_dev = &mv_chan->dmadev;
 
@@ -1147,7 +1150,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	/* clear errors before enabling interrupts */
 	mv_xor_device_clear_err_status(mv_chan);
 
-	ret = devm_request_irq(&pdev->dev, irq,
+	ret = devm_request_irq(&pdev->dev, mv_chan->irq,
 			       mv_xor_interrupt_handler,
 			       0, dev_name(&pdev->dev), mv_chan);
 	if (ret)
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 698b448..1704328 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -81,6 +81,7 @@ struct mv_xor_chan {
 	spinlock_t		lock; /* protects the descriptor slot pool */
 	void __iomem		*mmr_base;
 	unsigned int		idx;
+	int                     irq;
 	enum dma_transaction_type	current_type;
 	struct list_head	chain;
 	struct list_head	completed_slots;
-- 
1.7.9.5
