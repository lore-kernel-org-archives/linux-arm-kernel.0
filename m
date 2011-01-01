From: rabin@rab.in (Rabin Vincent)
Date: Sat, 1 Jan 2011 15:42:34 +0530
Subject: [PATCH] mmci: don't flush the dcache
Message-ID: <mailman.101.1293945649.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since freshly created page cache pages are considered dirty and are
always flushed before they are mapped into userspace, and an
already-mapped page will never be passed to be read into by the mmci
driver, remove the flush_dcache_page() calls.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 drivers/mmc/host/mmci.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0814b88..ccbbc18 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -284,22 +284,6 @@ mmci_data_irq(struct mmci_host *host, struct
mmc_data *data,
 		/* Force-complete the transaction */
 		host->blockend =3D true;
 		host->dataend =3D true;
-
-		/*
-		 * We hit an error condition.  Ensure that any data
-		 * partially written to a page is properly coherent.
-		 */
-		if (data->flags & MMC_DATA_READ) {
-			struct sg_mapping_iter *sg_miter =3D &host->sg_miter;
-			unsigned long flags;
-
-			local_irq_save(flags);
-			if (sg_miter_next(sg_miter)) {
-				flush_dcache_page(sg_miter->page);
-				sg_miter_stop(sg_miter);
-			}
-			local_irq_restore(flags);
-		}
 	}

 	/*
@@ -530,9 +514,6 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (remain)
 			break;

-		if (status & MCI_RXACTIVE)
-			flush_dcache_page(sg_miter->page);
-
 		status =3D readl(base + MMCISTATUS);
 	} while (1);

--=20
1.7.2.3
