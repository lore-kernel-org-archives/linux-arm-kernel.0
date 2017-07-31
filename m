From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:25:49 +0100
Subject: [PATCH v3 11/59] irqchip/gic-v3-its: Rework LPI freeing
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework LPI deallocation so that it can be reused by the v4 support
code.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ebdb1603b95d..1298a9bca56a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -875,16 +875,15 @@ static unsigned long *its_lpi_alloc_chunks(int nr_irqs, int *base, int *nr_ids)
 	return bitmap;
 }
 
-static void its_lpi_free(struct event_lpi_map *map)
+static void its_lpi_free_chunks(unsigned long *bitmap, int base, int nr_ids)
 {
-	int base = map->lpi_base;
-	int nr_ids = map->nr_lpis;
 	int lpi;
 
 	spin_lock(&lpi_lock);
 
 	for (lpi = base; lpi < (base + nr_ids); lpi += IRQS_PER_CHUNK) {
 		int chunk = its_lpi_to_chunk(lpi);
+
 		BUG_ON(chunk > lpi_chunks);
 		if (test_bit(chunk, lpi_bitmap)) {
 			clear_bit(chunk, lpi_bitmap);
@@ -895,8 +894,7 @@ static void its_lpi_free(struct event_lpi_map *map)
 
 	spin_unlock(&lpi_lock);
 
-	kfree(map->lpi_map);
-	kfree(map->col_map);
+	kfree(bitmap);
 }
 
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
@@ -1668,7 +1666,10 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	/* If all interrupts have been freed, start mopping the floor */
 	if (bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
-		its_lpi_free(&its_dev->event_map);
+		its_lpi_free_chunks(its_dev->event_map.lpi_map,
+				    its_dev->event_map.lpi_base,
+				    its_dev->event_map.nr_lpis);
+		kfree(its_dev->event_map.col_map);
 
 		/* Unmap device/itt */
 		its_send_mapd(its_dev, 0);
-- 
2.11.0
