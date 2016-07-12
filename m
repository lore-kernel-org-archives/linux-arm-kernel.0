From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 11 Jul 2016 22:36:48 -0500
Subject: [PATCH] irqchip/gicv3-its: Enable cacheable attribute Read-allocate
 hints
Message-ID: <1468294608-30619-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Read-allocation hints are not enabled for both the GIC-ITS and GICR
tables. This forces the hardware to always read the table contents
from an external memory (DDR) which is slow compared to cache memory.
Most of the tables are often read by hardware. So, it's better to
enable Read-allocate hints in addition to Write-allocate hints in
order to improve the GICR_PEND, GICR_PROP, Collection, Device, and
vCPU tables lookup time.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7ceaba8..6fc92a8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -954,7 +954,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 				   u32 psz, u32 *order)
 {
 	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
-	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
+	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
 	u32 ids = its->device_ids;
 	u32 new_order = *order;
 	bool indirect = false;
@@ -1019,7 +1019,7 @@ static int its_alloc_tables(struct its_node *its)
 	u64 typer = readq_relaxed(its->base + GITS_TYPER);
 	u32 ids = GITS_TYPER_DEVBITS(typer);
 	u64 shr = GITS_BASER_InnerShareable;
-	u64 cache = GITS_BASER_WaWb;
+	u64 cache = GITS_BASER_RaWaWb;
 	u32 psz = SZ_64K;
 	int err, i;
 
@@ -1116,7 +1116,7 @@ static void its_cpu_init_lpis(void)
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
-	       GICR_PROPBASER_WaWb |
+	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
 
 	writeq_relaxed(val, rbase + GICR_PROPBASER);
@@ -1141,7 +1141,7 @@ static void its_cpu_init_lpis(void)
 	/* set PENDBASE */
 	val = (page_to_phys(pend_page) |
 	       GICR_PENDBASER_InnerShareable |
-	       GICR_PENDBASER_WaWb);
+	       GICR_PENDBASER_RaWaWb);
 
 	writeq_relaxed(val, rbase + GICR_PENDBASER);
 	tmp = readq_relaxed(rbase + GICR_PENDBASER);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
