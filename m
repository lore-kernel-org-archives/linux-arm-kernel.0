From: rabin@rab.in (Rabin Vincent)
Date: Sat,  1 Jan 2011 16:06:08 +0530
Subject: [PATCH] mmci: call flush_dcache_page() outside of atomic kmap
Message-ID: <1293878168-12741-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While booting a QEMU Versatile/PB system with the root file system on
SD, the following WARN_ON hits:

------------[ cut here ]------------
WARNING: at /home/rabin/kernel/arm/lib/scatterlist.c:426 sg_miter_stop+0x64/0x9c()
Modules linked in:
[<c0031da4>] (unwind_backtrace+0x0/0xe4) from [<c003d5c0>] (warn_slowpath_common+0x4c/0x64)
[<c003d5c0>] (warn_slowpath_common+0x4c/0x64) from [<c003d5f0>] (warn_slowpath_null+0x18/0x1c)
[<c003d5f0>] (warn_slowpath_null+0x18/0x1c) from [<c0148338>] (sg_miter_stop+0x64/0x9c)
[<c0148338>] (sg_miter_stop+0x64/0x9c) from [<c01a892c>] (mmci_pio_irq+0x1fc/0x270)
[<c01a892c>] (mmci_pio_irq+0x1fc/0x270) from [<c0065928>] (handle_IRQ_event+0x24/0xf0)
[<c0065928>] (handle_IRQ_event+0x24/0xf0) from [<c0067930>] (handle_level_irq+0xa4/0x114)
[<c0067930>] (handle_level_irq+0xa4/0x114) from [<c0036258>] (sic_handle_irq+0x50/0x60)
[<c0036258>] (sic_handle_irq+0x50/0x60) from [<c0022070>] (asm_do_IRQ+0x70/0x94)
[<c0022070>] (asm_do_IRQ+0x70/0x94) from [<c002c0b4>] (__irq_svc+0x34/0xa0)

It's the WARN_ON(!irqs_disabled()) in sg_miter_stop():

                if (miter->__flags & SG_MITER_ATOMIC) {
                        WARN_ON(!irqs_disabled());
                        kunmap_atomic(miter->addr, KM_BIO_SRC_IRQ);
                }

This is because if the cache is VIVT, flush_dcache_page() calls
__flush_dcache_aliases() when a user space mapping exists.  That
function uses flush_dcache_mmap_unlock() which is spin_unlock_irq(),
which enables interrupts.   Fix this by calling flush_dcache_page() only
after the sg_miter is stopped.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 drivers/mmc/host/mmci.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0814b88..84a49ec 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -291,14 +291,18 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 */
 		if (data->flags & MMC_DATA_READ) {
 			struct sg_mapping_iter *sg_miter = &host->sg_miter;
+			struct page *page = NULL;
 			unsigned long flags;
 
 			local_irq_save(flags);
 			if (sg_miter_next(sg_miter)) {
-				flush_dcache_page(sg_miter->page);
+				page = sg_miter->page;
 				sg_miter_stop(sg_miter);
 			}
 			local_irq_restore(flags);
+
+			if (page)
+				flush_dcache_page(page);
 		}
 	}
 
@@ -487,17 +491,16 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	struct sg_mapping_iter *sg_miter = &host->sg_miter;
 	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
-	unsigned long flags;
 	u32 status;
 
 	status = readl(base + MMCISTATUS);
 
 	dev_dbg(mmc_dev(host->mmc), "irq1 (pio) %08x\n", status);
 
-	local_irq_save(flags);
-
 	do {
 		unsigned int remain, len;
+		unsigned long flags;
+		struct page *page;
 		char *buffer;
 
 		/*
@@ -510,9 +513,13 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (!(status & (MCI_TXFIFOHALFEMPTY|MCI_RXDATAAVLBL)))
 			break;
 
-		if (!sg_miter_next(sg_miter))
+		local_irq_save(flags);
+		if (!sg_miter_next(sg_miter)) {
+			local_irq_restore(flags);
 			break;
+		}
 
+		page = sg_miter->page;
 		buffer = sg_miter->addr;
 		remain = sg_miter->length;
 
@@ -527,18 +534,18 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		host->size -= len;
 		remain -= len;
 
+		sg_miter_stop(sg_miter);
+		local_irq_restore(flags);
+
 		if (remain)
 			break;
 
 		if (status & MCI_RXACTIVE)
-			flush_dcache_page(sg_miter->page);
+			flush_dcache_page(page);
 
 		status = readl(base + MMCISTATUS);
 	} while (1);
 
-	sg_miter_stop(sg_miter);
-
-	local_irq_restore(flags);
 
 	/*
 	 * If we're nearing the end of the read, switch to
-- 
1.7.2.3
