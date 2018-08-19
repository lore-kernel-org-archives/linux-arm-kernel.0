From: guohanjun@huawei.com (Hanjun Guo)
Date: Sun, 19 Aug 2018 14:27:38 +0800
Subject: [PATCH 4.4 3/6] irqchip/gicv3-its: Fix memory leak in
 its_free_tables()
In-Reply-To: <1534660061-51980-1-git-send-email-guohanjun@huawei.com>
References: <1534660061-51980-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1534660061-51980-4-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 1a485f4d2e28efd77075b2952926683d6c245633 upstream.

The current ITS driver has a memory leak in its_free_tables(). It
happens on tear down path of the driver when its_probe() call fails.
its_free_tables() should free the exact number of pages that have
been allocated, not just a single page as current code does.

This patch records the memory size for each ITS_BASERn at the time of
page allocation and uses the same size information when freeing pages
to fix the issue.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Vikram Sethi <vikrams@codeaurora.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1454379584-21772-1-git-send-email-shankerd at codeaurora.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index af61a2f..f0cbb76 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -67,7 +67,10 @@ struct its_node {
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
-	void			*tables[GITS_BASER_NR_REGS];
+	struct {
+		void		*base;
+		u32		order;
+	} tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
@@ -816,9 +819,10 @@ static void its_free_tables(struct its_node *its)
 	int i;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		if (its->tables[i]) {
-			free_page((unsigned long)its->tables[i]);
-			its->tables[i] = NULL;
+		if (its->tables[i].base) {
+			free_pages((unsigned long)its->tables[i].base,
+				   its->tables[i].order);
+			its->tables[i].base = NULL;
 		}
 	}
 }
@@ -899,7 +903,8 @@ retry_alloc_baser:
 			goto out_free;
 		}
 
-		its->tables[i] = base;
+		its->tables[i].base = base;
+		its->tables[i].order = order;
 
 retry_baser:
 		val = (virt_to_phys(base) 				 |
@@ -949,7 +954,7 @@ retry_baser:
 			 * something is horribly wrong...
 			 */
 			free_pages((unsigned long)base, order);
-			its->tables[i] = NULL;
+			its->tables[i].base = NULL;
 
 			switch (psz) {
 			case SZ_16K:
-- 
1.7.12.4
