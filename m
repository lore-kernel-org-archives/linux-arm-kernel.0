From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu, 28 Jan 2016 22:42:58 -0600
Subject: [PATCH v2] irqchip: gicv3-its: Fix memory leak in its_free_tables()
Message-ID: <1454042578-13933-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ITS driver has a memory leak in its_free_tables(). It
happens on tear down path of the driver when its_probe() call fails.
its_free_tables() should free the exact number of pages that have
been allocated, not just a single page as current code does.

This patch records the memory size for each ITS_BASERn at the time of
page allocation and uses the same size information when freeing pages
to fix the issue.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 [v1]->[v2]: 
    -rebase on tip of https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/its-fixes-4.5&id=25ffe003bdc24492204e099fca0a467641d0fe1a
    -refresh alloc_size value whenever page order changes.     

 drivers/irqchip/irq-gic-v3-its.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3447549..fc1a34f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -66,7 +66,10 @@ struct its_node {
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
-	void			*tables[GITS_BASER_NR_REGS];
+	struct {
+		void		*base;
+		u32		size;
+	} tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
@@ -807,9 +810,10 @@ static void its_free_tables(struct its_node *its)
 	int i;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		if (its->tables[i]) {
-			free_page((unsigned long)its->tables[i]);
-			its->tables[i] = NULL;
+		if (its->tables[i].base) {
+			free_pages((unsigned long)its->tables[i].base,
+				   get_order(its->tables[i].size));
+			its->tables[i].base = NULL;
 		}
 	}
 }
@@ -880,6 +884,7 @@ retry_alloc_baser:
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
 			order = get_order(GITS_BASER_PAGES_MAX * psz);
+			alloc_size = (1 << order) * PAGE_SIZE;
 			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
 				node_name, order, alloc_pages);
 		}
@@ -890,7 +895,8 @@ retry_alloc_baser:
 			goto out_free;
 		}
 
-		its->tables[i] = base;
+		its->tables[i].base = base;
+		its->tables[i].size = alloc_size;
 
 retry_baser:
 		val = (virt_to_phys(base) 				 |
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
