From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu, 22 Jun 2017 18:19:14 -0500
Subject: [PATCH v3] irqchip: gicv3-its: Don't assume GICv3 hardware supports
 16bit INTID
Message-ID: <1498173554-27718-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ITS driver is assuming every ITS hardware implementation
supports minimum of 16bit INTID. But this is not true, as per GICv3
specification, INTID field is IMPLEMENTATION DEFINED in the range of
14-24 bits. We might see an unpredictable system behavior on systems
where hardware support less than 16bits and software tries to use
64K LPI interrupts.

On Qualcomm Datacenter Technologies QDF2400 platform, boot log shows
confusing information about number of LPI chunks as shown below. The
QDF2400 ITS hardware supports 24bit INTID.

This patch allocates the memory resources for PEND/PROP tables based
on discoverable value which is specified in GITS_TYPER.IDbits. Also
it fixes the log message that reflects the correct number of LPI
chunks were allocated.

ITS at 0xff7efe0000: allocated 524288 Devices @3c0400000 (indirect, esz 8, psz 64K, shr 1)
ITS at 0xff7efe0000: allocated 8192 Interrupt Collections @3c0130000 (flat, esz 8, psz 64K, shr 1)
ITS at 0xff7efe0000: allocated 8192 Virtual CPUs @3c0140000 (flat, esz 8, psz 64K, shr 1)
ITS: Allocated 524032 chunks for LPIs
PCI/MSI: ITS at 0xff7efe0000 domain created
Platform MSI: ITS at 0xff7efe0000 domain created

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v2:
  Keep maximum LPIs to 64K.
  Incorporated Marc's review suggestion.
  Renamed the varibale lpi_nrbits to lpi_id_bits to avoid confusion with LPI_NRBITS.
Changes since v1:
  No code changes, just rebase on tip of the Marc's branch and tested on QDF2400 platform.
  https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/irqchip-4.13

 drivers/irqchip/irq-gic-v3-its.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 63cd0f2..fed99c5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -691,9 +691,11 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
  */
 #define IRQS_PER_CHUNK_SHIFT	5
 #define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static unsigned long *lpi_bitmap;
 static u32 lpi_chunks;
+static u32 lpi_id_bits;
 static DEFINE_SPINLOCK(lpi_lock);
 
 static int its_lpi_to_chunk(int lpi)
@@ -789,17 +791,13 @@ static void its_lpi_free(struct event_lpi_map *map)
 }
 
 /*
- * We allocate 64kB for PROPBASE. That gives us@most 64K LPIs to
+ * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
  * deal with (one configuration byte per interrupt). PENDBASE has to
  * be 64kB aligned (one bit per LPI, plus 8192 bits for SPI/PPI/SGI).
  */
-#define LPI_PROPBASE_SZ		SZ_64K
-#define LPI_PENDBASE_SZ		(LPI_PROPBASE_SZ / 8 + SZ_1K)
-
-/*
- * This is how many bits of ID we need, including the useless ones.
- */
-#define LPI_NRBITS		ilog2(LPI_PROPBASE_SZ + SZ_8K)
+#define LPI_NRBITS		lpi_id_bits
+#define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
+#define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
 #define LPI_PROP_DEFAULT_PRIO	0xa0
 
@@ -807,6 +805,7 @@ static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
 
+	lpi_id_bits = min_t(u32, gic_rdists->id_bits, ITS_MAX_LPI_NRBITS);
 	gic_rdists->prop_page = alloc_pages(GFP_NOWAIT,
 					   get_order(LPI_PROPBASE_SZ));
 	if (!gic_rdists->prop_page) {
@@ -825,7 +824,7 @@ static int __init its_alloc_lpi_tables(void)
 	/* Make sure the GIC will observe the written configuration */
 	gic_flush_dcache_to_poc(page_address(gic_rdists->prop_page), LPI_PROPBASE_SZ);
 
-	return 0;
+	return its_lpi_init(lpi_id_bits);
 }
 
 static const char *its_base_type_string[] = {
@@ -1100,7 +1099,7 @@ static void its_cpu_init_lpis(void)
 		 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 		 */
 		pend_page = alloc_pages(GFP_NOWAIT | __GFP_ZERO,
-					get_order(max(LPI_PENDBASE_SZ, SZ_64K)));
+					get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 		if (!pend_page) {
 			pr_err("Failed to allocate PENDBASE for CPU%d\n",
 			       smp_processor_id());
@@ -1975,8 +1974,5 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	its_alloc_lpi_tables();
-	its_lpi_init(rdists->id_bits);
-
-	return 0;
+	return its_alloc_lpi_tables();
 }
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
