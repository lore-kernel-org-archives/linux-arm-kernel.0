From: majun258@huawei.com (MaJun)
Date: Tue, 22 Dec 2015 15:10:23 +0800
Subject: [RFC PATCH] irqchip/gic-v3-its:Fix the bug while calculating the page
 number of ITS table
Message-ID: <1450768223-10860-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Hi Marc, Robert:

Maybe there is a bug introduced by commit
"irqchip/gicv3-its: Add range check for number of allocated pages"
30f2136346cab91e1ffd9ee6370d76809f20487a

I think, before setting the page number, the variable "alloc_pages"
should be calculated and checked again. 
Or else, the page number programmed into GITS_BASER register is always
the number of 64KB even though the page size is 16KB or 4KB.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e23d1d1..100181b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -879,7 +879,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
 			order = get_order(GITS_BASER_PAGES_MAX * psz);
-			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
+			pr_warn("%s: Table too large, reduce its page order to %u (%u pages)\n",
 				node_name, order, alloc_pages);
 		}
 
@@ -911,6 +911,13 @@ retry_baser:
 			break;
 		}
 
+               alloc_pages = (alloc_size / psz);
+                if (alloc_pages > GITS_BASER_PAGES_MAX) {
+                        alloc_pages = GITS_BASER_PAGES_MAX;
+                        pr_warn("%s: Table too large, reduce its page number to %u pages\n",
+                                node_name, alloc_pages);
+                }
+
 		val |= alloc_pages - 1;
 
 		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
-- 
1.7.1
