From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed, 25 Jan 2017 21:51:41 -0600
Subject: [RESEND PATCH v2] irqchip/gicv3-its: Enable cacheable attribute
 Read-allocate hints
Message-ID: <1485402701-30650-1-git-send-email-shankerd@codeaurora.org>
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
This patch has been verified on Centriq 2400 server platform.

 drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69b040f..3cffcca 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -960,7 +960,7 @@ static bool its_parse_baser_device(struct its_node *its, struct its_baser *baser
 				   u32 psz, u32 *order)
 {
 	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
-	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
+	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
 	u32 ids = its->device_ids;
 	u32 new_order = *order;
 	bool indirect = false;
@@ -1025,7 +1025,7 @@ static int its_alloc_tables(struct its_node *its)
 	u64 typer = gic_read_typer(its->base + GITS_TYPER);
 	u32 ids = GITS_TYPER_DEVBITS(typer);
 	u64 shr = GITS_BASER_InnerShareable;
-	u64 cache = GITS_BASER_WaWb;
+	u64 cache = GITS_BASER_RaWaWb;
 	u32 psz = SZ_64K;
 	int err, i;
 
@@ -1122,7 +1122,7 @@ static void its_cpu_init_lpis(void)
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
-	       GICR_PROPBASER_WaWb |
+	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
 
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
@@ -1147,7 +1147,7 @@ static void its_cpu_init_lpis(void)
 	/* set PENDBASE */
 	val = (page_to_phys(pend_page) |
 	       GICR_PENDBASER_InnerShareable |
-	       GICR_PENDBASER_WaWb);
+	       GICR_PENDBASER_RaWaWb);
 
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
@@ -1711,7 +1711,7 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_tables;
 
 	baser = (virt_to_phys(its->cmd_base)	|
-		 GITS_CBASER_WaWb		|
+		 GITS_CBASER_RaWaWb		|
 		 GITS_CBASER_InnerShareable	|
 		 (ITS_CMD_QUEUE_SZ / SZ_4K - 1)	|
 		 GITS_CBASER_VALID);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
