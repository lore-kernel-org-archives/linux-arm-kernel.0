From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed,  9 Mar 2016 22:10:49 -0600
Subject: [PATCH v4] irqchip/gicv3-its: Don't allow devices whose ID is outside
 range
Message-ID: <1457583049-5474-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are not checking whether the requested device identifier fits into
the device table memory or not. The function its_create_device()
assumes that enough memory has been allocated for whole DevID space
(reported by ITS_TYPER.Devbits) during the ITS probe() and continues
to initialize ITS hardware.

This assumption is not perfect, sometimes we reduce memory size either
because of its size crossing MAX_ORDER-1 or BASERn max size limit. The
MAPD command fails if 'Device ID' is outside of device table range.

Add a simple validation check to avoid MAPD failures since we are
not handling ITS command errors. This change also helps to return an
error -ENOMEM instead of success to caller.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
[v3]->[v4]
   Cleanup code based on Marc's comments, remove the variable
   'device_table' and extend validation check to cover case ITS
   HW with on-chip device table memory.

[v2]->[v3]
   Fix typo.

[v1]->[v2]
  Rebase to v4.5-rc6, edit commit text and simplify code changes.

 drivers/irqchip/irq-gic-v3-its.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 43dfd15..d50d837 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -55,6 +55,16 @@ struct its_collection {
 };
 
 /*
+ * The ITS_BASER structure - contains memory information and cached
+ * value of BASER register configuration.
+ */
+struct its_baser {
+	void		*base;
+	u64		val;
+	u32		order;
+};
+
+/*
  * The ITS structure - contains most of the infrastructure, with the
  * top-level MSI domain, the command queue, the collections, and the
  * list of devices writing to it.
@@ -66,14 +76,12 @@ struct its_node {
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
-	struct {
-		void		*base;
-		u32		order;
-	} tables[GITS_BASER_NR_REGS];
+	struct its_baser	tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
 	u32			ite_size;
+	u32			device_ids;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -839,6 +847,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		ids	= GITS_TYPER_DEVBITS(typer);
 	}
 
+	its->device_ids = ids;
+
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
 		u64 type = GITS_BASER_TYPE(val);
@@ -914,6 +924,7 @@ retry_baser:
 		}
 
 		val |= alloc_pages - 1;
+		its->tables[i].val = val;
 
 		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
 		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -1139,9 +1150,22 @@ static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
 	return its_dev;
 }
 
+static struct its_baser *its_get_baser(struct its_node *its, u32 type)
+{
+	int i;
+
+	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
+		if (GITS_BASER_TYPE(its->tables[i].val) == type)
+			return &its->tables[i];
+	}
+
+	return NULL;
+}
+
 static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 					    int nvecs)
 {
+	struct its_baser *baser;
 	struct its_device *dev;
 	unsigned long *lpi_map;
 	unsigned long flags;
@@ -1152,6 +1176,16 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	int nr_ites;
 	int sz;
 
+	baser = its_get_baser(its, GITS_BASER_TYPE_DEVICE);
+
+	/* Don't allow 'dev_id' that exceeds single, flat table limit */
+	if (baser) {
+		if (dev_id >= (PAGE_ORDER_TO_SIZE(baser->order) /
+			      GITS_BASER_ENTRY_SIZE(baser->val)))
+			return NULL;
+	} else if (ilog2(dev_id) >= its->device_ids)
+		return NULL;
+
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
 	 * At least one bit of EventID is being used, hence a minimum
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
