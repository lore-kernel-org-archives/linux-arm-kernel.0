From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 14:15:04 +0000
Subject: [PATCH 3/4] irqchip: gicv3-its: Fix PROP/PEND and BASE/CBASE confusion
In-Reply-To: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
References: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427465705-17126-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ITS driver sometime mixes up the use of GICR_PROPBASE bitfields
for the GICR_PENDBASE register, and GITS_BASER for GICR_CBASE.

This does not lead to any observable bug because similar bits are
at the same location, but this just make the code even harder to
understand...

This patch provides the required #defines and fixes the mixup.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   |  6 +++---
 include/linux/irqchip/arm-gic-v3.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fa0c436..56353f6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -986,8 +986,8 @@ static void its_cpu_init_lpis(void)
 
 	/* set PENDBASE */
 	val = (page_to_phys(pend_page) |
-	       GICR_PROPBASER_InnerShareable |
-	       GICR_PROPBASER_WaWb);
+	       GICR_PENDBASER_InnerShareable |
+	       GICR_PENDBASER_WaWb);
 
 	writeq_relaxed(val, rbase + GICR_PENDBASER);
 
@@ -1425,7 +1425,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	if ((tmp ^ baser) & GITS_BASER_SHAREABILITY_MASK) {
+	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		pr_info("ITS: using cache flushing for cmd queue\n");
 		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
 	}
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 781974a..826a4bd 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -128,6 +128,19 @@
 #define GICR_PROPBASER_RaWaWb		(7U << 7)
 #define GICR_PROPBASER_IDBITS_MASK	(0x1f)
 
+#define GICR_PENDBASER_NonShareable	(0U << 10)
+#define GICR_PENDBASER_InnerShareable	(1U << 10)
+#define GICR_PENDBASER_OuterShareable	(2U << 10)
+#define GICR_PENDBASER_SHAREABILITY_MASK (3UL << 10)
+#define GICR_PENDBASER_nCnB		(0U << 7)
+#define GICR_PENDBASER_nC		(1U << 7)
+#define GICR_PENDBASER_RaWt		(2U << 7)
+#define GICR_PENDBASER_RaWb		(3U << 7)
+#define GICR_PENDBASER_WaWt		(4U << 7)
+#define GICR_PENDBASER_WaWb		(5U << 7)
+#define GICR_PENDBASER_RaWaWt		(6U << 7)
+#define GICR_PENDBASER_RaWaWb		(7U << 7)
+
 /*
  * Re-Distributor registers, offsets from SGI_base
  */
-- 
2.1.4
