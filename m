From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  9 Jun 2013 00:56:28 +0400
Subject: [PATCH] ARM: dma: imx: Fix deadlock bug
Message-ID: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

=================================
[ INFO: inconsistent lock state ]
3.10.0-rc4-next-20130607-00006-gf5bbfe3-dirty #59 Not tainted
---------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
swapper/1 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&(&imxdma->lock)->rlock){?.-...}, at: [<c0230200>] imxdma_tasklet+0x1c/0x138
{IN-HARDIRQ-W} state was registered at:
 [<c004dbe8>] __lock_acquire+0xa74/0x1a64
 [<c004f0a4>] lock_acquire+0x64/0x78
 [<c0428d9c>] _raw_spin_lock+0x34/0x44
 [<c0230584>] dma_irq_handler+0x7c/0x250
 [<c005c520>] handle_irq_event_percpu+0x50/0x1c8
 [<c005c6d4>] handle_irq_event+0x3c/0x5c
 [<c005e944>] handle_level_irq+0x8c/0xe8
 [<c005bf34>] generic_handle_irq+0x20/0x30
 [<c000958c>] handle_IRQ+0x30/0x84
 [<c0008710>] avic_handle_irq+0x34/0x54
 [<c000bb24>] __irq_svc+0x44/0x74
 [<c01fbd78>] ida_get_new_above+0x74/0x1c4
 [<c00f4084>] sysfs_new_dirent+0x60/0xf8
 [<c00f454c>] create_dir+0x28/0xc0
 [<c00f48e4>] sysfs_create_dir+0x90/0xf4
 [<c01fc6cc>] kobject_add_internal+0x90/0x1d8
 [<c01fc858>] kobject_init_and_add+0x44/0x6c
 [<c025c9cc>] bus_add_driver+0x74/0x230
 [<c025e324>] driver_register+0x78/0x14c
 [<c054a7d4>] do_one_initcall+0x50/0x158
 [<c054a9c4>] kernel_init_freeable+0xe8/0x1ac
 [<c041f6e0>] kernel_init+0x8/0xe4
 [<c0008dc0>] ret_from_fork+0x14/0x34
irq event stamp: 232290
hardirqs last  enabled at (232290): [<c001cc08>] tasklet_action+0x30/0xdc
hardirqs last disabled at (232289): [<c001cbf0>] tasklet_action+0x18/0xdc
softirqs last  enabled at (232196): [<c001c548>] __do_softirq+0x174/0x1e0
softirqs last disabled at (232287): [<c001c9a0>] irq_exit+0xa0/0xdc

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&imxdma->lock)->rlock);
  <Interrupt>
    lock(&(&imxdma->lock)->rlock);

 *** DEADLOCK ***

1 lock held by swapper/1:
 #0:  (sysfs_ino_lock){+.+...}, at: [<c00f4074>] sysfs_new_dirent+0x50/0xf8

stack backtrace:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-rc4-next-20130607-00006-gf5bbfe3-dirty #59
[<c000c5f0>] (unwind_backtrace+0x0/0xf0) from [<c000b028>] (show_stack+0x10/0x14)
[<c000b028>] (show_stack+0x10/0x14) from [<c0422380>] (print_usage_bug.part.26+0x220/0x288)
[<c0422380>] (print_usage_bug.part.26+0x220/0x288) from [<c004b814>] (mark_lock+0x288/0x668)
[<c004b814>] (mark_lock+0x288/0x668) from [<c004d720>] (__lock_acquire+0x5ac/0x1a64)
[<c004d720>] (__lock_acquire+0x5ac/0x1a64) from [<c004f0a4>] (lock_acquire+0x64/0x78)
[<c004f0a4>] (lock_acquire+0x64/0x78) from [<c0428d9c>] (_raw_spin_lock+0x34/0x44)
[<c0428d9c>] (_raw_spin_lock+0x34/0x44) from [<c0230200>] (imxdma_tasklet+0x1c/0x138)
[<c0230200>] (imxdma_tasklet+0x1c/0x138) from [<c001cc50>] (tasklet_action+0x78/0xdc)
[<c001cc50>] (tasklet_action+0x78/0xdc) from [<c001c4c0>] (__do_softirq+0xec/0x1e0)
[<c001c4c0>] (__do_softirq+0xec/0x1e0) from [<c001c9a0>] (irq_exit+0xa0/0xdc)
[<c001c9a0>] (irq_exit+0xa0/0xdc) from [<c0009590>] (handle_IRQ+0x34/0x84)
[<c0009590>] (handle_IRQ+0x34/0x84) from [<c0008710>] (avic_handle_irq+0x34/0x54)
[<c0008710>] (avic_handle_irq+0x34/0x54) from [<c000bb24>] (__irq_svc+0x44/0x74)

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/dma/imx-dma.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ff2aab9..65fe00a 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -318,12 +318,9 @@ static void imxdma_enable_hw(struct imxdma_desc *d)
 	struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	int channel = imxdmac->channel;
-	unsigned long flags;
 
 	dev_dbg(imxdma->dev, "%s channel %d\n", __func__, channel);
 
-	local_irq_save(flags);
-
 	imx_dmav1_writel(imxdma, 1 << channel, DMA_DISR);
 	imx_dmav1_writel(imxdma, imx_dmav1_readl(imxdma, DMA_DIMR) &
 			 ~(1 << channel), DMA_DIMR);
@@ -342,27 +339,23 @@ static void imxdma_enable_hw(struct imxdma_desc *d)
 		}
 	}
 
-	local_irq_restore(flags);
 }
 
 static void imxdma_disable_hw(struct imxdma_channel *imxdmac)
 {
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	int channel = imxdmac->channel;
-	unsigned long flags;
 
 	dev_dbg(imxdma->dev, "%s channel %d\n", __func__, channel);
 
 	if (imxdma_hw_chain(imxdmac))
 		del_timer(&imxdmac->watchdog);
 
-	local_irq_save(flags);
 	imx_dmav1_writel(imxdma, imx_dmav1_readl(imxdma, DMA_DIMR) |
 			 (1 << channel), DMA_DIMR);
 	imx_dmav1_writel(imxdma, imx_dmav1_readl(imxdma, DMA_CCR(channel)) &
 			 ~CCR_CEN, DMA_CCR(channel));
 	imx_dmav1_writel(imxdma, 1 << channel, DMA_DISR);
-	local_irq_restore(flags);
 }
 
 static void imxdma_watchdog(unsigned long data)
@@ -519,7 +512,6 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(d->desc.chan);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
-	unsigned long flags;
 	int slot = -1;
 	int i;
 
@@ -527,7 +519,6 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 	switch (d->type) {
 	case IMXDMA_DESC_INTERLEAVED:
 		/* Try to get a free 2D slot */
-		spin_lock_irqsave(&imxdma->lock, flags);
 		for (i = 0; i < IMX_DMA_2D_SLOTS; i++) {
 			if ((imxdma->slots_2d[i].count > 0) &&
 			((imxdma->slots_2d[i].xsr != d->x) ||
@@ -537,10 +528,8 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 			slot = i;
 			break;
 		}
-		if (slot < 0) {
-			spin_unlock_irqrestore(&imxdma->lock, flags);
+		if (slot < 0)
 			return -EBUSY;
-		}
 
 		imxdma->slots_2d[slot].xsr = d->x;
 		imxdma->slots_2d[slot].ysr = d->y;
@@ -549,7 +538,6 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 
 		imxdmac->slot_2d = slot;
 		imxdmac->enabled_2d = true;
-		spin_unlock_irqrestore(&imxdma->lock, flags);
 
 		if (slot == IMX_DMA_2D_SLOT_A) {
 			d->config_mem &= ~CCR_MSEL_B;
@@ -625,8 +613,9 @@ static void imxdma_tasklet(unsigned long data)
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	struct imxdma_desc *desc;
+	unsigned long flags;
 
-	spin_lock(&imxdma->lock);
+	spin_lock_irqsave(&imxdma->lock, flags);
 
 	if (list_empty(&imxdmac->ld_active)) {
 		/* Someone might have called terminate all */
@@ -663,7 +652,7 @@ static void imxdma_tasklet(unsigned long data)
 				 __func__, imxdmac->channel);
 	}
 out:
-	spin_unlock(&imxdma->lock);
+	spin_unlock_irqrestore(&imxdma->lock, flags);
 }
 
 static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
@@ -677,11 +666,12 @@ static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
-		imxdma_disable_hw(imxdmac);
-
 		spin_lock_irqsave(&imxdma->lock, flags);
+
+		imxdma_disable_hw(imxdmac);
 		list_splice_tail_init(&imxdmac->ld_active, &imxdmac->ld_free);
 		list_splice_tail_init(&imxdmac->ld_queue, &imxdmac->ld_free);
+
 		spin_unlock_irqrestore(&imxdma->lock, flags);
 		return 0;
 	case DMA_SLAVE_CONFIG:
-- 
1.8.1.5
