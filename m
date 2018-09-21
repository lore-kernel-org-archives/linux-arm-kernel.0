From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:52 +0100
Subject: [PATCH 08/10] irqchip/gic-v3-its: Check that all RDs have the same
 property table
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If booting with LPIs enabled, all the redistributors must have the
exact same property table. No ifs, no buts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0b3e76cdde26..4d9604dd6fb1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2029,6 +2029,15 @@ static void its_cpu_init_lpis(void)
 	val = readl_relaxed(rbase + GICR_CTLR);
 	if ((gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) &&
 	    (val & GICR_CTLR_ENABLE_LPIS)) {
+		/*
+		 * Check that we get the same property table on all
+		 * RDs. If we don't, this is hopeless.
+		 */
+		paddr = gicr_read_propbaser(rbase + GICR_PROPBASER);
+		paddr &= GENMASK_ULL(51, 12);
+		if (WARN_ON(gic_rdists->prop_table_pa != paddr))
+			add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+
 		paddr = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 		paddr &= GENMASK_ULL(51, 16);
 
-- 
2.18.0
