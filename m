From: guohanjun@huawei.com (Hanjun Guo)
Date: Sun, 19 Aug 2018 14:27:37 +0800
Subject: [PATCH 4.4 2/6] irqchip/gic-v3-its: Recompute the number of pages on
 page size change
In-Reply-To: <1534660061-51980-1-git-send-email-guohanjun@huawei.com>
References: <1534660061-51980-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1534660061-51980-3-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit 18aa60ce2751c95d3412ed06a58b8b6cfb6f88f2 upstream.

When the programming of a GITS_BASERn register fails because of
an unsupported ITS page size, we retry it with a smaller page size.
Unfortunately, we don't recompute the number of allocated ITS pages,
indicating the wrong value computed in the original allocation.

A convenient fix is to free the pages we allocated, update the
page size, and restart the allocation. This will ensure that
we always allocate the right amount in the case of a device
table, specially if we have to reduce the allocation order
to stay within the boundaries of the ITS maximum allocation.

Reported-and-tested-by: Ma Jun <majun258@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>
Link: http://lkml.kernel.org/r/1453818255-1289-1-git-send-email-marc.zyngier at arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 82e00e3..af61a2f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -884,6 +884,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+retry_alloc_baser:
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
 			alloc_pages = GITS_BASER_PAGES_MAX;
@@ -947,13 +948,16 @@ retry_baser:
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
1.7.12.4
