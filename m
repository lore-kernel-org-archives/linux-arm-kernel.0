From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 17 Oct 2015 18:58:05 -0700
Subject: [PATCH 4.2 172/258] irqchip/gic-v3-its: Add missing cache flushes
In-Reply-To: <20151018014729.976101177@linuxfoundation.org>
References: <20151018014729.976101177@linuxfoundation.org>
Message-ID: <20151018014738.222522905@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 5a9a8915c8888b615521b17d70a4342187eae60b upstream.

When the ITS is configured for non-cacheable transactions, make sure
that the allocated, zeroed memory is flushed to the Point of
Coherency, allowing the ITS to observe the zeros instead of random
garbage (or even get its own data overwritten by zeros being evicted
from the cache...).

Fixes: 241a386c7dbb "irqchip: gicv3-its: Use non-cacheable accesses when no shareability"
Reported-and-tested-by: Stuart Yoder <stuart.yoder@freescale.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Pavel Fedin <p.fedin@samsung.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Link: http://lkml.kernel.org/r/1442142873-20213-3-git-send-email-marc.zyngier at arm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -921,8 +921,10 @@ retry_baser:
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
 
@@ -1163,6 +1165,8 @@ static struct its_device *its_create_dev
 		return NULL;
 	}
 
+	__flush_dcache_area(itt, sz);
+
 	dev->its = its;
 	dev->itt = itt;
 	dev->nr_ites = nr_ites;
