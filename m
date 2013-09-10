From: zhangwm@marvell.com (Neil Zhang)
Date: Tue, 10 Sep 2013 13:20:48 +0800
Subject: [PATCH] ARM: pxa: use spinlock for dma channels
Message-ID: <1378790448-13468-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dma channels are managed by drivers, and it has the demux function to
handle irqs. So it is possible to occur conflick when request or free
dma channels; for example, when core 0 is handling the irq, while core 1
is going to free the dma channel at the same time. So we need use
spinlock to synchronise these two operations.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm/plat-pxa/dma.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 79ef102..7897dca 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -39,6 +39,8 @@ struct dma_channel {
 static struct dma_channel *dma_channels;
 static int num_dma_channels;
 
+static DEFINE_SPINLOCK(dma_lock);
+
 /*
  * Debug fs
  */
@@ -288,7 +290,7 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
 	if (!name || !irq_handler)
 		return -EINVAL;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);
 
 	do {
 		/* try grabbing a DMA channel with the requested priority */
@@ -312,7 +314,7 @@ int pxa_request_dma (char *name, pxa_dma_prio prio,
 		i = -ENODEV;
 	}
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 	return i;
 }
 EXPORT_SYMBOL(pxa_request_dma);
@@ -328,10 +330,10 @@ void pxa_free_dma (int dma_ch)
 		return;
 	}
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&dma_lock, flags);
 	DCSR(dma_ch) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
 	dma_channels[dma_ch].name = NULL;
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }
 EXPORT_SYMBOL(pxa_free_dma);
 
@@ -340,6 +342,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 	int i, dint = DINT;
 	struct dma_channel *channel;
 
+	spin_lock(&dma_lock);
 	while (dint) {
 		i = __ffs(dint);
 		dint &= (dint - 1);
@@ -355,6 +358,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 			DCSR(i) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;
 		}
 	}
+	spin_unlock(&dma_lock);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.9.5
