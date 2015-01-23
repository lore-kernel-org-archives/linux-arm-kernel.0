From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:59 +0100
Subject: [GIT PULL 30/36] arm64: GICv3: introduce symbolic names for GICv3
 ICC_SGI1R_EL1 fields
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-31-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

The gic_send_sgi() function used hardcoded bit shift values to
generate the ICC_SGI1R_EL1 register value.
Replace this with symbolic names to allow reusing them later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c       | 14 +++++++++-----
 include/linux/irqchip/arm-gic-v3.h | 12 ++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1a146cc..2ab290b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -481,15 +481,19 @@ out:
 	return tlist;
 }
 
+#define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
+	(MPIDR_AFFINITY_LEVEL(cluster_id, level) \
+		<< ICC_SGI1R_AFFINITY_## level ##_SHIFT)
+
 static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 {
 	u64 val;
 
-	val = (MPIDR_AFFINITY_LEVEL(cluster_id, 3) << 48	|
-	       MPIDR_AFFINITY_LEVEL(cluster_id, 2) << 32	|
-	       irq << 24			    		|
-	       MPIDR_AFFINITY_LEVEL(cluster_id, 1) << 16	|
-	       tlist);
+	val = (MPIDR_TO_SGI_AFFINITY(cluster_id, 3)	|
+	       MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
+	       irq << ICC_SGI1R_SGI_ID_SHIFT		|
+	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
+	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
 
 	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
 	gic_write_sgi1r(val);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 3fb4d85..800544b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -280,6 +280,18 @@
 #define ICC_SRE_EL2_SRE			(1 << 0)
 #define ICC_SRE_EL2_ENABLE		(1 << 3)
 
+#define ICC_SGI1R_TARGET_LIST_SHIFT	0
+#define ICC_SGI1R_TARGET_LIST_MASK	(0xffff << ICC_SGI1R_TARGET_LIST_SHIFT)
+#define ICC_SGI1R_AFFINITY_1_SHIFT	16
+#define ICC_SGI1R_AFFINITY_1_MASK	(0xff << ICC_SGI1R_AFFINITY_1_SHIFT)
+#define ICC_SGI1R_SGI_ID_SHIFT		24
+#define ICC_SGI1R_SGI_ID_MASK		(0xff << ICC_SGI1R_SGI_ID_SHIFT)
+#define ICC_SGI1R_AFFINITY_2_SHIFT	32
+#define ICC_SGI1R_AFFINITY_2_MASK	(0xffULL << ICC_SGI1R_AFFINITY_1_SHIFT)
+#define ICC_SGI1R_IRQ_ROUTING_MODE_BIT	40
+#define ICC_SGI1R_AFFINITY_3_SHIFT	48
+#define ICC_SGI1R_AFFINITY_3_MASK	(0xffULL << ICC_SGI1R_AFFINITY_1_SHIFT)
+
 /*
  * System register definitions
  */
-- 
2.1.2.330.g565301e.dirty
