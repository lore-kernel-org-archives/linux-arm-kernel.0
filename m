From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 30 Apr 2017 09:54:00 -0500
Subject: [PATCH RESEND] irqchip: gicv3-its: Don't assume GICv3 hardware
 supports 16bit INTID
Message-ID: <1493564040-24019-1-git-send-email-shankerd@codeaurora.org>
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
taking this opportunity to increase number of LPI/MSI(x) to 128K if
the hardware is capable, and show log message that reflects the
correct number of LPI chunks.

ITS at 0xff7efe0000: allocated 524288 Devices @3c0400000 (indirect, esz 8, psz 64K, shr 1)
ITS at 0xff7efe0000: allocated 8192 Interrupt Collections @3c0130000 (flat, esz 8, psz 64K, shr 1)
ITS at 0xff7efe0000: allocated 8192 Virtual CPUs @3c0140000 (flat, esz 8, psz 64K, shr 1)
ITS: Allocated 524032 chunks for LPIs
PCI/MSI: ITS at 0xff7efe0000 domain created
Platform MSI: ITS at 0xff7efe0000 domain created

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 72e56f03..6c24e3c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -687,9 +687,11 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
  */
 #define IRQS_PER_CHUNK_SHIFT	5
 #define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define ITS_MAX_LPI_NRBITS	(17) /* 128K LPIs */
 
 static unsigned long *lpi_bitmap;
 static u32 lpi_chunks;
+static u32 lpi_nrbits;
 static DEFINE_SPINLOCK(lpi_lock);
 
 static int its_lpi_to_chunk(int lpi)
@@ -785,26 +787,19 @@ static void its_lpi_free(struct event_lpi_map *map)
 }
 
 /*
- * We allocate 64kB for PROPBASE. That gives us@most 64K LPIs to
+ * We allocate memory for PROPBASE to cover 2 ^ lpi_nrbits LPIs to
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
 
 #define LPI_PROP_DEFAULT_PRIO	0xa0
 
 static int __init its_alloc_lpi_tables(void)
 {
+	u32 size = ALIGN(BIT(lpi_nrbits), SZ_64K);
 	phys_addr_t paddr;
 
-	gic_rdists->prop_page = alloc_pages(GFP_NOWAIT,
-					   get_order(LPI_PROPBASE_SZ));
+	gic_rdists->prop_page = alloc_pages(GFP_NOWAIT, get_order(size));
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
 		return -ENOMEM;
@@ -816,10 +811,10 @@ static int __init its_alloc_lpi_tables(void)
 	/* Priority 0xa0, Group-1, disabled */
 	memset(page_address(gic_rdists->prop_page),
 	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
-	       LPI_PROPBASE_SZ);
+	       size);
 
 	/* Make sure the GIC will observe the written configuration */
-	gic_flush_dcache_to_poc(page_address(gic_rdists->prop_page), LPI_PROPBASE_SZ);
+	gic_flush_dcache_to_poc(page_address(gic_rdists->prop_page), size);
 
 	return 0;
 }
@@ -1091,12 +1086,14 @@ static void its_cpu_init_lpis(void)
 	pend_page = gic_data_rdist()->pend_page;
 	if (!pend_page) {
 		phys_addr_t paddr;
+		u32 size;
 		/*
-		 * The pending pages have to be at least 64kB aligned,
-		 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
+		 * The pending pages have to be at least 64kB aligned
+		 * hence the 'ALIGN(BIT(lpi_nrbits)/8, SZ_64K)' below.
 		 */
+		size = ALIGN(BIT(lpi_nrbits)/8, SZ_64K);
 		pend_page = alloc_pages(GFP_NOWAIT | __GFP_ZERO,
-					get_order(max(LPI_PENDBASE_SZ, SZ_64K)));
+					get_order(size));
 		if (!pend_page) {
 			pr_err("Failed to allocate PENDBASE for CPU%d\n",
 			       smp_processor_id());
@@ -1104,7 +1101,7 @@ static void its_cpu_init_lpis(void)
 		}
 
 		/* Make sure the GIC will observe the zero-ed page */
-		gic_flush_dcache_to_poc(page_address(pend_page), LPI_PENDBASE_SZ);
+		gic_flush_dcache_to_poc(page_address(pend_page), size);
 
 		paddr = page_to_phys(pend_page);
 		pr_info("CPU%d: using LPI pending table @%pa\n",
@@ -1126,7 +1123,7 @@ static void its_cpu_init_lpis(void)
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
 	       GICR_PROPBASER_RaWaWb |
-	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
+	       ((lpi_nrbits - 1) & GICR_PROPBASER_IDBITS_MASK));
 
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
@@ -1897,9 +1894,10 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return -ENXIO;
 	}
 
+	lpi_nrbits = min_t(u32, rdists->id_bits, ITS_MAX_LPI_NRBITS);
 	gic_rdists = rdists;
 	its_alloc_lpi_tables();
-	its_lpi_init(rdists->id_bits);
+	its_lpi_init(lpi_nrbits);
 
 	return 0;
 }
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
