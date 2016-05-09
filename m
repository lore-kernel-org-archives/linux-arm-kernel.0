From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  9 May 2016 15:58:25 -0500
Subject: [PATCH V3 1/2] irqchip/gicv3-its: split its_alloc_tables() into two
 functions
In-Reply-To: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
References: <1462827506-23570-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1462827506-23570-2-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function is getting out of control, it has too many goto
statements and would be too complicated for adding a feature
two-level device table. So, it is time for us to cleanup and
move some of the logic to a separate function without affecting
the existing functionality.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 256 ++++++++++++++++++++-----------------
 include/linux/irqchip/arm-gic-v3.h |   3 +
 2 files changed, 144 insertions(+), 115 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6bd881b..b23e00c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -55,13 +55,15 @@ struct its_collection {
 };
 
 /*
- * The ITS_BASER structure - contains memory information and cached
- * value of BASER register configuration.
+ * The ITS_BASER structure - contains memory information, cached value
+ * of BASER register configuration, ioremaped address and page size.
  */
 struct its_baser {
+	void __iomem	*hwreg;
 	void		*base;
 	u64		val;
 	u32		order;
+	u32		psz;
 };
 
 /*
@@ -823,27 +825,135 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
+static int its_baser_setup(struct its_node *its, struct its_baser *baser,
+				  u32 order, u64 indirect)
+{
+	u64 val = readq_relaxed(baser->hwreg);
+	u64 type = GITS_BASER_TYPE(val);
+	u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
+	int psz, alloc_pages;
+	u64 cache, shr, tmp;
+	void *base;
+
+	/* Do first attempt with the requested attributes */
+	cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
+	shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
+	psz = baser->psz;
+
+retry_alloc_baser:
+	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
+	if (alloc_pages > GITS_BASER_PAGES_MAX) {
+		pr_warn("ITS@%lx: %s too large, reduce ITS pages %u->%u\n",
+			its->phys_base, its_base_type_string[type],
+			alloc_pages, GITS_BASER_PAGES_MAX);
+		alloc_pages = GITS_BASER_PAGES_MAX;
+		order = get_order(GITS_BASER_PAGES_MAX * psz);
+	}
+
+	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!base)
+		return -ENOMEM;
+
+retry_baser:
+	val = (virt_to_phys(base)				 |
+		(type << GITS_BASER_TYPE_SHIFT)			 |
+		((entry_size - 1) << GITS_BASER_ENTRY_SIZE_SHIFT) |
+		((alloc_pages - 1) << GITS_BASER_PAGES_SHIFT)	 |
+		cache						 |
+		shr						 |
+		indirect					 |
+		GITS_BASER_VALID);
+
+	switch (psz) {
+	case SZ_4K:
+		val |= GITS_BASER_PAGE_SIZE_4K;
+		break;
+	case SZ_16K:
+		val |= GITS_BASER_PAGE_SIZE_16K;
+		break;
+	case SZ_64K:
+		val |= GITS_BASER_PAGE_SIZE_64K;
+		break;
+	}
+
+	writeq_relaxed(val, baser->hwreg);
+	tmp = readq_relaxed(baser->hwreg);
+
+	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
+		/*
+		 * Shareability didn't stick. Just use
+		 * whatever the read reported, which is likely
+		 * to be the only thing this redistributor
+		 * supports. If that's zero, make it
+		 * non-cacheable as well.
+		 */
+		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
+		if (!shr) {
+			cache = GITS_BASER_nC;
+			__flush_dcache_area(base, PAGE_ORDER_TO_SIZE(order));
+		}
+		goto retry_baser;
+	}
+
+	if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
+		/*
+		 * Page size didn't stick. Let's try a smaller
+		 * size and retry. If we reach 4K, then
+		 * something is horribly wrong...
+		 */
+		free_pages((unsigned long)base, order);
+		baser->base = NULL;
+
+		switch (psz) {
+		case SZ_16K:
+			psz = SZ_4K;
+			goto retry_alloc_baser;
+		case SZ_64K:
+			psz = SZ_16K;
+			goto retry_alloc_baser;
+		}
+	}
+
+	if (val != tmp) {
+		pr_err("ITS@%lx: %s doesn't stick: %lx %lx\n",
+		       its->phys_base, its_base_type_string[type],
+		       (unsigned long) val, (unsigned long) tmp);
+		free_pages((unsigned long)base, order);
+		return -ENXIO;
+	}
+
+	baser->base = base;
+	baser->order = order;
+	baser->psz = psz;
+	baser->val = val;
+	tmp = indirect ? GITS_LVL1_ENTRY_SIZE : entry_size;
+
+	pr_info("ITS@%lx: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
+		its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / tmp),
+		its_base_type_string[type],
+		(unsigned long)virt_to_phys(base),
+		indirect ? "indirect" : "flat", (int)entry_size,
+		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
+
+	return 0;
+}
+
 static int its_alloc_tables(const char *node_name, struct its_node *its)
 {
-	int err;
-	int i;
-	int psz = SZ_64K;
+	u64 typer = readq_relaxed(its->base + GITS_TYPER);
+	u32 ids = GITS_TYPER_DEVBITS(typer);
 	u64 shr = GITS_BASER_InnerShareable;
-	u64 cache;
-	u64 typer;
-	u32 ids;
+	u64 cache = GITS_BASER_WaWb;
+	int psz = SZ_64K;
+	int err, i;
 
 	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375) {
 		/*
 		 * erratum 22375: only alloc 8MB table size
 		 * erratum 24313: ignore memory access type
 		 */
-		cache	= 0;
+		cache	= GITS_BASER_nCnB;
 		ids	= 0x14;			/* 20 bits, 8MB */
-	} else {
-		cache	= GITS_BASER_WaWb;
-		typer	= readq_relaxed(its->base + GITS_TYPER);
-		ids	= GITS_TYPER_DEVBITS(typer);
 	}
 
 	its->device_ids = ids;
@@ -853,13 +963,16 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		u64 type = GITS_BASER_TYPE(val);
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
 		int order = get_order(psz);
-		int alloc_pages;
-		u64 tmp;
-		void *base;
+		struct its_baser *baser = its->tables + i;
 
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
 
+		/* Set preferred settings for this BASERn */
+		baser->hwreg = its->base + GITS_BASER + i * 8;
+		baser->val = cache | shr;
+		baser->psz = psz;
+
 		/*
 		 * Allocate as many entries as required to fit the
 		 * range of device IDs that the ITS can grok... The ID
@@ -875,115 +988,28 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 			 * smaller than that.  If the requested allocation
 			 * is smaller, round up to the default page granule.
 			 */
-			order = max(get_order((1UL << ids) * entry_size),
-				    order);
+			order = max(get_order(entry_size << ids), order);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
-				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
-					node_name, order);
-			}
-		}
-
-retry_alloc_baser:
-		alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
-		if (alloc_pages > GITS_BASER_PAGES_MAX) {
-			alloc_pages = GITS_BASER_PAGES_MAX;
-			order = get_order(GITS_BASER_PAGES_MAX * psz);
-			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
-				node_name, order, alloc_pages);
-		}
-
-		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-		if (!base) {
-			err = -ENOMEM;
-			goto out_free;
-		}
-
-		its->tables[i].base = base;
-		its->tables[i].order = order;
-
-retry_baser:
-		val = (virt_to_phys(base) 				 |
-		       (type << GITS_BASER_TYPE_SHIFT)			 |
-		       ((entry_size - 1) << GITS_BASER_ENTRY_SIZE_SHIFT) |
-		       cache						 |
-		       shr						 |
-		       GITS_BASER_VALID);
-
-		switch (psz) {
-		case SZ_4K:
-			val |= GITS_BASER_PAGE_SIZE_4K;
-			break;
-		case SZ_16K:
-			val |= GITS_BASER_PAGE_SIZE_16K;
-			break;
-		case SZ_64K:
-			val |= GITS_BASER_PAGE_SIZE_64K;
-			break;
-		}
-
-		val |= alloc_pages - 1;
-		its->tables[i].val = val;
-
-		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
-		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
-
-		if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
-			/*
-			 * Shareability didn't stick. Just use
-			 * whatever the read reported, which is likely
-			 * to be the only thing this redistributor
-			 * supports. If that's zero, make it
-			 * non-cacheable as well.
-			 */
-			shr = tmp & GITS_BASER_SHAREABILITY_MASK;
-			if (!shr) {
-				cache = GITS_BASER_nC;
-				__flush_dcache_area(base, PAGE_ORDER_TO_SIZE(order));
+				ids = ilog2(PAGE_ORDER_TO_SIZE(order) / entry_size);
+				pr_warn("ITS@%lx:: Device Table too large, reduce ids %u->%u\n",
+					its->phys_base, its->device_ids, ids);
 			}
-			goto retry_baser;
 		}
 
-		if ((val ^ tmp) & GITS_BASER_PAGE_SIZE_MASK) {
-			/*
-			 * Page size didn't stick. Let's try a smaller
-			 * size and retry. If we reach 4K, then
-			 * something is horribly wrong...
-			 */
-			free_pages((unsigned long)base, order);
-			its->tables[i].base = NULL;
-
-			switch (psz) {
-			case SZ_16K:
-				psz = SZ_4K;
-				goto retry_alloc_baser;
-			case SZ_64K:
-				psz = SZ_16K;
-				goto retry_alloc_baser;
-			}
-		}
-
-		if (val != tmp) {
-			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
-			       node_name, i,
-			       (unsigned long) val, (unsigned long) tmp);
-			err = -ENXIO;
-			goto out_free;
+		err = its_baser_setup(its, baser, order, 0);
+		if (err < 0) {
+			its_free_tables(its);
+			return err;
 		}
 
-		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
-			(int)(PAGE_ORDER_TO_SIZE(order) / entry_size),
-			its_base_type_string[type],
-			(unsigned long)virt_to_phys(base),
-			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
+		/* Update settings which will be used for next BASERn */
+		psz = baser->psz;
+		cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
+		shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
 	}
 
 	return 0;
-
-out_free:
-	its_free_tables(its);
-
-	return err;
 }
 
 static int its_alloc_collections(struct its_node *its)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9e6fdd3..7f917b9 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -204,6 +204,7 @@
 #define GITS_BASER_NR_REGS		8
 
 #define GITS_BASER_VALID		(1UL << 63)
+#define GITS_BASER_INDIRECT		(1UL << 62)
 #define GITS_BASER_nCnB			(0UL << 59)
 #define GITS_BASER_nC			(1UL << 59)
 #define GITS_BASER_RaWt			(2UL << 59)
@@ -228,6 +229,7 @@
 #define GITS_BASER_PAGE_SIZE_64K	(2UL << GITS_BASER_PAGE_SIZE_SHIFT)
 #define GITS_BASER_PAGE_SIZE_MASK	(3UL << GITS_BASER_PAGE_SIZE_SHIFT)
 #define GITS_BASER_PAGES_MAX		256
+#define GITS_BASER_PAGES_SHIFT		(0)
 
 #define GITS_BASER_TYPE_NONE		0
 #define GITS_BASER_TYPE_DEVICE		1
@@ -238,6 +240,7 @@
 #define GITS_BASER_TYPE_RESERVED6	6
 #define GITS_BASER_TYPE_RESERVED7	7
 
+#define GITS_LVL1_ENTRY_SIZE		(8UL)
 /*
  * ITS commands
  */
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
