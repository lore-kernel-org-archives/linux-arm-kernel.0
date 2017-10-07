From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat,  7 Oct 2017 13:34:04 -0500
Subject: [PATCH v2] irqchip/gicv3-its: Add missing changes to support 52bit
 physical address
Message-ID: <1507401244-12070-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ITS driver works fine as long as normal memory and GICR
regions are located within the lower 48bit (>=0 && <2^48) physical
address space. Some of the registers GICR_PEND/PROP, GICR_VPEND/VPROP
and GITS_CBASER are handled properly but not all when configuring
the hardware with 52bit physical address.

This patch does the following changes to support 52bit PA.
  -Handle 52bit PA in GITS_BASERn.
  -Fix ITT_addr width to 52bits, bits[51:8].
  -Fix RDbase width to 52bits, bits[51:16].
  -Fix VPT_addr width to 52bits, bits[51:16].

Definition of the GITS_BASERn register when ITS PageSize is 64KB:
  -Bits[47:16] of the register provide bits[47:16] of the table PA.
  -Bits[15:12] of the register provide bits[51:48] of the table PA.
  -Bits[15:00] of the base physical address are 0.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v1:
  -Included Marc's suggestion and warn in case of not supporting 52bit PA.

 drivers/irqchip/irq-gic-v3-its.c   | 26 +++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h |  3 +++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d8934..48805f5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -308,7 +308,7 @@ static void its_encode_size(struct its_cmd_block *cmd, u8 size)
 
 static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
 {
-	its_mask_encode(&cmd->raw_cmd[2], itt_addr >> 8, 50, 8);
+	its_mask_encode(&cmd->raw_cmd[2], itt_addr >> 8, 51, 8);
 }
 
 static void its_encode_valid(struct its_cmd_block *cmd, int valid)
@@ -318,7 +318,7 @@ static void its_encode_valid(struct its_cmd_block *cmd, int valid)
 
 static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
 {
-	its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 50, 16);
+	its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 51, 16);
 }
 
 static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
@@ -358,7 +358,7 @@ static void its_encode_its_list(struct its_cmd_block *cmd, u16 its_list)
 
 static void its_encode_vpt_addr(struct its_cmd_block *cmd, u64 vpt_pa)
 {
-	its_mask_encode(&cmd->raw_cmd[3], vpt_pa >> 16, 50, 16);
+	its_mask_encode(&cmd->raw_cmd[3], vpt_pa >> 16, 51, 16);
 }
 
 static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
@@ -1478,9 +1478,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 val = its_read_baser(its, baser);
 	u64 esz = GITS_BASER_ENTRY_SIZE(val);
 	u64 type = GITS_BASER_TYPE(val);
+	u64 baser_phys, tmp;
 	u32 alloc_pages;
 	void *base;
-	u64 tmp;
 
 retry_alloc_baser:
 	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
@@ -1496,8 +1496,24 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	if (!base)
 		return -ENOMEM;
 
+	baser_phys = virt_to_phys(base);
+
+	/* Check if the physical address of the memory is above 48bits */
+	if (baser_phys & (~GITS_BASER_PHYS_MASK)) {
+
+		/* 52bit PA is supported only when PageSize=64K */
+		if ((!IS_ENABLED(CONFIG_ARM64_64K_PAGES)) || (psz != SZ_64K)) {
+			pr_err("ITS: no 52bit PA support when psz=%d\n", psz);
+			free_pages((unsigned long)base, order);
+			return -EFAULT;
+		}
+
+		/* Convert 52bit PA to 48bit field */
+		baser_phys = GITS_BASER_64K_PHYS(baser_phys);
+	}
+
 retry_baser:
-	val = (virt_to_phys(base)				 |
+	val = (baser_phys					 |
 		(type << GITS_BASER_TYPE_SHIFT)			 |
 		((esz - 1) << GITS_BASER_ENTRY_SIZE_SHIFT)	 |
 		((alloc_pages - 1) << GITS_BASER_PAGES_SHIFT)	 |
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b8b5998..4e82f73 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -373,6 +373,9 @@
 #define GITS_BASER_ENTRY_SIZE_SHIFT		(48)
 #define GITS_BASER_ENTRY_SIZE(r)	((((r) >> GITS_BASER_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
 #define GITS_BASER_ENTRY_SIZE_MASK	GENMASK_ULL(52, 48)
+#define GITS_BASER_PHYS_MASK		GENMASK_ULL(47, 12)
+#define GITS_BASER_64K_PHYS(phys)					\
+	(((phys) | ((((phys) >> 48) & 0xF) << 12)) & GITS_BASER_PHYS_MASK)
 #define GITS_BASER_SHAREABILITY_SHIFT	(10)
 #define GITS_BASER_InnerShareable					\
 	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
