From: john.ogness@linutronix.de (John Ogness)
Date: Thu, 15 Oct 2015 12:46:26 +0200
Subject: [PATCH] ARM: edma: fix residue race for cyclic
Message-ID: <87io68s931.fsf@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When retrieving the residue value for cyclic transfers, the DST
field of the active PaRAM is read. However, the AM335x Technical
Reference Manual states:

  11.3.3.6 Parameter Set Updates

  After the TR is read from the PaRAM (and is in the process of
  being submitted to the EDMA3TC), the following fields are
  updated as needed: ... DST

This means the DST is incremented even though the DMA transfer
may not have started yet or is in progress. Thus if the reader
of the residue accesses the DMA buffer too quickly, the CPU
will read where data is not yet written.

The CCSTAT.ACTV register is a boolean that is set if any TR is
being processed by either the EMDA3CC or EDMA3TC. By polling
this register it is possible to ensure that the residue value
returned is valid for immediate processing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/arm/common/edma.c             |   17 +++++++++++++++++
 drivers/dma/edma.c                 |    8 ++++++++
 include/linux/platform_data/edma.h |    1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 873dbfc..86ce980 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -995,6 +995,23 @@ void edma_set_dest(unsigned slot, dma_addr_t dest_port,
 }
 EXPORT_SYMBOL(edma_set_dest);
 
+#define EDMA_CCSTAT_ACTV (1 << 4)
+
+/**
+ * edma_is_actv - report if any transfer requests are active
+ * @slot: parameter RAM slot being examined
+ *
+ * Returns true if any transfer requests are active on the slot
+ */
+bool edma_is_actv(unsigned slot)
+{
+	u32 ctlr = EDMA_CTLR(slot);
+	unsigned int ccstat;
+
+	ccstat = edma_read(ctlr, EDMA_CCSTAT);
+	return (ccstat & EDMA_CCSTAT_ACTV);
+}
+
 /**
  * edma_get_position - returns the current transfer point
  * @slot: parameter RAM slot being examined
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3e5d4f1..493c774 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -891,6 +891,14 @@ static u32 edma_residue(struct edma_desc *edesc)
 	pos = edma_get_position(edesc->echan->slot[0], dst);
 
 	/*
+	 * "pos" may represent a transfer request that is still being
+	 * processed by the EDMACC or EDMATC. Wait until all transfer
+	 * requests on the active slot are finished before proceeding.
+	 */
+	while (edma_is_actv(edesc->echan->slot[0]))
+		cpu_relax();
+
+	/*
 	 * Cyclic is simple. Just subtract pset[0].addr from pos.
 	 *
 	 * We never update edesc->residue in the cyclic case, so we
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index bdb2710..20c50e2 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -130,6 +130,7 @@ void edma_set_src(unsigned slot, dma_addr_t src_port,
 				enum address_mode mode, enum fifo_width);
 void edma_set_dest(unsigned slot, dma_addr_t dest_port,
 				 enum address_mode mode, enum fifo_width);
+bool edma_is_actv(unsigned slot);
 dma_addr_t edma_get_position(unsigned slot, bool dst);
 void edma_set_src_index(unsigned slot, s16 src_bidx, s16 src_cidx);
 void edma_set_dest_index(unsigned slot, s16 dest_bidx, s16 dest_cidx);
-- 
1.7.10.4
