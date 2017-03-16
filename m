From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 16 Mar 2017 17:05:41 +0000
Subject: [PATCH 1/2] irqchip/gic-v3-its: bail out on already enabled LPIs
In-Reply-To: <20170316170542.3568-1-andre.przywara@arm.com>
References: <20170316170542.3568-1-andre.przywara@arm.com>
Message-ID: <20170316170542.3568-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 spec says that once LPIs have been enabled, they can't be
disabled anymore:
"When a write changes this bit from 0 to 1, this bit becomes RES1 ..."
As we can't setup the pending and property table registers when LPIs are
enabled, we have to bail out here in this case.
But first try to disable LPIs anyway, to check whether this actually works.
If not, return an error.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f77f840..b777c57 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1082,12 +1082,30 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static void its_cpu_init_lpis(void)
+static int its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
 	u64 val, tmp;
 
+	/*
+	 * Architecturally, once LPIs have been enabled on a specific
+	 * redistributor, they can't be disabled anymore (the enable
+	 * bit becomes RES1).
+	 * But as we can't setup the pending and property table registers
+	 * while LPIs are enabled, we are basically screwed in this case.
+	 * But be slightly more optimistic here, and actually check whether
+	 * this is really implemented like this.
+	 */
+	val = readl_relaxed(rbase + GICR_CTLR);
+	val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel_relaxed(val, rbase + GICR_CTLR);
+	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
+		pr_warn("CPU%d: LPIs already enabled, cannot initialize redistributor\n",
+			smp_processor_id());
+		return -EBUSY;
+	}
+
 	/* If we didn't allocate the pending table yet, do it now */
 	pend_page = gic_data_rdist()->pend_page;
 	if (!pend_page) {
@@ -1101,7 +1119,7 @@ static void its_cpu_init_lpis(void)
 		if (!pend_page) {
 			pr_err("Failed to allocate PENDBASE for CPU%d\n",
 			       smp_processor_id());
-			return;
+			return -ENOMEM;
 		}
 
 		/* Make sure the GIC will observe the zero-ed page */
@@ -1113,11 +1131,6 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
 	/*
 	 * Make sure any change to the table is observable by the GIC.
 	 */
@@ -1174,6 +1187,8 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+
+	return 0;
 }
 
 static void its_cpu_init_collection(void)
@@ -1789,12 +1804,17 @@ static bool gic_rdists_supports_plpis(void)
 
 int its_cpu_init(void)
 {
+	int ret;
+
 	if (!list_empty(&its_nodes)) {
 		if (!gic_rdists_supports_plpis()) {
 			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 			return -ENXIO;
 		}
-		its_cpu_init_lpis();
+		ret = its_cpu_init_lpis();
+		if (ret)
+			return ret;
+
 		its_cpu_init_collection();
 	}
 
-- 
2.9.0
