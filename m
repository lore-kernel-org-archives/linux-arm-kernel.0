From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat,  7 Oct 2017 15:43:48 -0500
Subject: [PATCH] irqchip/gicv3-its: Fix the incorrect parsing of VCPU table
 size
Message-ID: <1507409028-19778-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCPU table consists of vPE entries, and its size provides the number
of VPEs supported by GICv4 hardware. Unfortunately the maximum size of
the VPE table is not discoverable like Device table. All VLPI commands
limits the number of bits to 16 to hold VPEID, which is index into VCPU
table. Don't apply DEVID bits for VCPU table instead assume maximum bits
to 16.

ITS log messages on QDF2400 without fix:
  allocated 524288 Devices (indirect, esz 8, psz 64K, shr 1)
  allocated 8192 Interrupt Collections (flat, esz 8, psz 64K, shr 1)
  Virtual CPUs Table too large, reduce ids 32->26
  Virtual CPUs too large, reduce ITS pages 8192->256
  allocated 2097152 Virtual CPUs (flat, esz 8, psz 64K, shr 1)

ITS log messages on QDF2400 with fix:
  allocated 524288 Devices (indirect, esz 8, psz 64K, shr 1)
  allocated 8192 Interrupt Collections (flat, esz 8, psz 64K, shr 1)
  allocated 65536 Virtual CPUs (flat, esz 8, psz 64K, shr 1)

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cc7c8f6..7b98313 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -108,6 +108,10 @@ struct its_node {
 
 #define ITS_ITT_ALIGN		SZ_256
 
+/* The maximum number of VPEID bits supported by VLPI commands */
+#define ITS_MAX_VPEID_BITS	(16)
+#define ITS_MAX_VPEID		(1 << (ITS_MAX_VPEID_BITS))
+
 /* Convert page order to size in bytes */
 #define PAGE_ORDER_TO_SIZE(o)	(PAGE_SIZE << (o))
 
@@ -1610,13 +1614,12 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 
 static bool its_parse_indirect_baser(struct its_node *its,
 				     struct its_baser *baser,
-				     u32 psz, u32 *order)
+				     u32 psz, u32 *order, u32 ids)
 {
 	u64 tmp = its_read_baser(its, baser);
 	u64 type = GITS_BASER_TYPE(tmp);
 	u64 esz = GITS_BASER_ENTRY_SIZE(tmp);
 	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
-	u32 ids = its->device_ids;
 	u32 new_order = *order;
 	bool indirect = false;
 
@@ -1708,9 +1711,13 @@ static int its_alloc_tables(struct its_node *its)
 			continue;
 
 		case GITS_BASER_TYPE_DEVICE:
+			indirect = its_parse_indirect_baser(its, baser,
+							    psz, &order,
+							    its->device_ids);
 		case GITS_BASER_TYPE_VCPU:
 			indirect = its_parse_indirect_baser(its, baser,
-							    psz, &order);
+							    psz, &order,
+							    ITS_MAX_VPEID_BITS);
 			break;
 		}
 
@@ -2579,7 +2586,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 
 static int its_vpe_id_alloc(void)
 {
-	return ida_simple_get(&its_vpeid_ida, 0, 1 << 16, GFP_KERNEL);
+	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
 }
 
 static void its_vpe_id_free(u16 id)
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
