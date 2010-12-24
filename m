From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:09:05 +0000
Subject: [PATCH 09/11] ARM: PL08x: fix locking in tasklet
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4a9-0006Dm-MU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tasklets are run from an interruptible context.  The slave DMA functions
can be called from within IRQ handlers.  Taking the spinlock without
disabling interrupts allows an interrupt handler to run, which may try
to take the spinlock again, resulting in deadlock.  Fix this by using
the irqsave spinlocks.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 79a8679..c0cf46f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1626,11 +1626,12 @@ static void pl08x_tasklet(unsigned long data)
 	struct pl08x_dma_chan *plchan = (struct pl08x_dma_chan *) data;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
 	struct pl08x_driver_data *pl08x = plchan->host;
+	unsigned long flags;
 
 	if (!plchan)
 		BUG();
 
-	spin_lock(&plchan->lock);
+	spin_lock_irqsave(&plchan->lock, flags);
 
 	if (plchan->at) {
 		dma_async_tx_callback callback =
@@ -1728,7 +1729,7 @@ static void pl08x_tasklet(unsigned long data)
 		}
 	}
 
-	spin_unlock(&plchan->lock);
+	spin_unlock_irqrestore(&plchan->lock, flags);
 }
 
 static irqreturn_t pl08x_irq(int irq, void *dev)
-- 
1.6.2.5
