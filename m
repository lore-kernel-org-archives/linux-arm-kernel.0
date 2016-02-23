From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 22 Feb 2016 21:57:48 -0600
Subject: [PATCH] irqchip/gicv3-its: Don't allow devices whose ID is outside
 range
Message-ID: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are not checking whether the requested device identifier fits into
table or not. The ITS MAPD command fails if 'Device ID' is outside of
device table range.

Add a simple validation check to avoid MAPD failures since we are
not handling ITS command errors. This change also helps to return an
error -ENOMEM instead of success to caller.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
This patch depends on https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-4.5-fixes&id=2eca0d6ceea1f108b2d3ac81fb34698c4fd41006

 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c0f227a..9bdcdf5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -70,6 +70,7 @@ struct its_node {
 	struct {
 		void		*base;
 		u32		order;
+		u32		entry_size;
 	} tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
@@ -880,6 +881,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 					node_name, order);
 			}
 		}
+		its->tables[type].entry_size = entry_size;
 
 retry_alloc_baser:
 		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
@@ -896,8 +898,8 @@ retry_alloc_baser:
 			goto out_free;
 		}
 
-		its->tables[i].base = base;
-		its->tables[i].order = order;
+		its->tables[type].base = base;
+		its->tables[type].order = order;
 
 retry_baser:
 		val = (virt_to_phys(base) 				 |
@@ -947,7 +949,7 @@ retry_baser:
 			 * something is horribly wrong...
 			 */
 			free_pages((unsigned long)base, order);
-			its->tables[i].base = NULL;
+			its->tables[type].base = NULL;
 
 			switch (psz) {
 			case SZ_16K:
@@ -1152,12 +1154,22 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	unsigned long *lpi_map;
 	unsigned long flags;
 	u16 *col_map = NULL;
+	u8 type = GITS_BASER_TYPE_DEVICE;
+	u32 entry_size;
+	u32 order;
 	void *itt;
 	int lpi_base;
 	int nr_lpis;
 	int nr_ites;
 	int sz;
 
+	entry_size = its->tables[type].entry_size;
+	order = its->tables[type].order;
+
+	/* Don't allow 'dev_id' that exceeds single, flat table limit */
+	if (dev_id >= (PAGE_ORDER_TO_SIZE(order) / entry_size))
+		return NULL;
+
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
 	 * At least one bit of EventID is being used, hence a minimum
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
