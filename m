From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:25:42 +0100
Subject: [PATCH v3 04/59] irqchip/gic-v3-its: Move LPI definitions around
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various LPI definitions are in the middle of the code, and
would be better placed at the beginning, given that we're going
to use some of them much earlier.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 68932873eebc..ae6b2cee09fa 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -48,6 +48,19 @@
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
+static u32 lpi_id_bits;
+
+/*
+ * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
+ * deal with (one configuration byte per interrupt). PENDBASE has to
+ * be 64kB aligned (one bit per LPI, plus 8192 bits for SPI/PPI/SGI).
+ */
+#define LPI_NRBITS		lpi_id_bits
+#define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
+#define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
+
+#define LPI_PROP_DEFAULT_PRIO	0xa0
+
 /*
  * Collection structure - just an ID, and a redistributor address to
  * ping. We use one per CPU as a bag of interrupts assigned to this
@@ -695,7 +708,6 @@ static struct irq_chip its_irq_chip = {
 
 static unsigned long *lpi_bitmap;
 static u32 lpi_chunks;
-static u32 lpi_id_bits;
 static DEFINE_SPINLOCK(lpi_lock);
 
 static int its_lpi_to_chunk(int lpi)
@@ -790,17 +802,6 @@ static void its_lpi_free(struct event_lpi_map *map)
 	kfree(map->col_map);
 }
 
-/*
- * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
- * deal with (one configuration byte per interrupt). PENDBASE has to
- * be 64kB aligned (one bit per LPI, plus 8192 bits for SPI/PPI/SGI).
- */
-#define LPI_NRBITS		lpi_id_bits
-#define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
-#define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
-
-#define LPI_PROP_DEFAULT_PRIO	0xa0
-
 static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
-- 
2.11.0
