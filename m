From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jan 2016 14:24:15 +0000
Subject: [PATCH] irqchip/gic-v3-its: Recompute the number of pages on page
 size change
Message-ID: <1453818255-1289-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the programming of a GITS_BASERn register fails because of
an unsupported ITS page size, we retry it with a smaller page size.
Unfortunately, we don't recompute the number of allocated ITS pages,
indicating the wrong value computed in the original allocation.

A convenient fix is to free the pages we allocated, update the
page size, and restart the allocation. This will ensure that
we always allocate the right amount in the case of a device
table, specially if we have to reduce the allocation order
to stay within the boundaries of the ITS maximum allocation.

Reported-by: Ma Jun <majun258@huawei.com>
Tested-by: Ma Jun <majun258@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e23d1d1..3447549 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -875,6 +875,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+retry_alloc_baser:
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
@@ -938,13 +939,16 @@ retry_baser:
 			 * size and retry. If we reach 4K, then
 			 * something is horribly wrong...
 			 */
+			free_pages((unsigned long)base, order);
+			its->tables[i] = NULL;
+
 			switch (psz) {
 			case SZ_16K:
 				psz = SZ_4K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			case SZ_64K:
 				psz = SZ_16K;
-				goto retry_baser;
+				goto retry_alloc_baser;
 			}
 		}
 
-- 
2.1.4
