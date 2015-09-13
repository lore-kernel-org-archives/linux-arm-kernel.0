From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Sep 2015 12:14:32 +0100
Subject: [PATCH 2/3] irqchip/gic-v3-its: Add missing cache flushes
In-Reply-To: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
References: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442142873-20213-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the ITS is configured for non-cacheable transactions,
make sure that the allocated, zeroed memory is flushed to the
Point of Coherency, allowing the ITS to observe the zeros
instead of random garbage (or even get its own data overwritten
by zeros being evicted from the cache...).

This fixes an issue introduced by 241a386c7dbb ("irqchip:
gicv3-its: Use non-cacheable accesses when no shareability").

Reported-by: Stuart Yoder <stuart.yoder@freescale.com>
Tested-by: Stuart Yoder <stuart.yoder@freescale.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 26b55c5..ac7ae2b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -898,8 +898,10 @@ retry_baser:
 			 * non-cacheable as well.
 			 */
 			shr = tmp & GITS_BASER_SHAREABILITY_MASK;
-			if (!shr)
+			if (!shr) {
 				cache = GITS_BASER_nC;
+				__flush_dcache_area(base, alloc_size);
+			}
 			goto retry_baser;
 		}
 
@@ -1140,6 +1142,8 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 		return NULL;
 	}
 
+	__flush_dcache_area(itt, sz);
+
 	dev->its = its;
 	dev->itt = itt;
 	dev->nr_ites = nr_ites;
-- 
2.1.4
