From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 14 Jun 2016 09:45:15 -0500
Subject: [PATCH V6 1/5] irqchip/gicv3-its: Introduce two helper functions for
 accessing BASERn
Message-ID: <1465915519-10807-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the two handy helper functions for reading and writing
ITS BASERn register.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Changes since v5:
  Marc suggested to fold its_write_baser_cache into its_write_baser.

Changes since v1:
  baser->val is consistent with hardware register contents.

 drivers/irqchip/irq-gic-v3-its.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5eb1f9e..924f836 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -824,6 +824,22 @@ static const char *its_base_type_string[] = {
 	[GITS_BASER_TYPE_RESERVED7] 	= "Reserved (7)",
 };
 
+static u64 its_read_baser(struct its_node *its, struct its_baser *baser)
+{
+	u32 idx = baser - its->tables;
+
+	return readq_relaxed(its->base + GITS_BASER + (idx << 3));
+}
+
+static void its_write_baser(struct its_node *its, struct its_baser *baser,
+			    u64 val)
+{
+	u32 idx = baser - its->tables;
+
+	writeq_relaxed(val, its->base + GITS_BASER + (idx << 3));
+	baser->val = its_read_baser(its, baser);
+}
+
 static void its_free_tables(struct its_node *its)
 {
 	int i;
@@ -863,7 +879,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 	its->device_ids = ids;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
+		struct its_baser *baser = its->tables + i;
+		u64 val = its_read_baser(its, baser);
 		u64 type = GITS_BASER_TYPE(val);
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
 		int order = get_order(psz);
@@ -937,10 +954,9 @@ retry_baser:
 		}
 
 		val |= alloc_pages - 1;
-		its->tables[i].val = val;
 
-		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
-		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
+		its_write_baser(its, baser, val);
+		tmp = baser->val;
 
 		if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 			/*
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
