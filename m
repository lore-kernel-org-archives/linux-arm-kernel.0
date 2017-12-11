From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 11 Dec 2017 21:39:11 +0100
Subject: [PATCH 2/3] irqchip: irq-bcm2836: add support for DT interrupt
 polarity
In-Reply-To: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1513024752-11246-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to properly define the polarity of the per-cpu interrupts,
we need to support for a second property cell. But this must be
optional to keep backward compatibility with old DT blobs.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/irqchip/irq-bcm2836.c | 46 ++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 667b9e1..dfe4a46 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -98,13 +98,35 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
 };
 
-static void bcm2836_arm_irqchip_register_irq(int hwirq, struct irq_chip *chip)
-{
-	int irq = irq_create_mapping(intc.domain, hwirq);
+static int bcm2836_map(struct irq_domain *d, unsigned int irq,
+		       irq_hw_number_t hw)
+{
+	struct irq_chip *chip;
+
+	switch (hw) {
+	case LOCAL_IRQ_CNTPSIRQ:
+	case LOCAL_IRQ_CNTPNSIRQ:
+	case LOCAL_IRQ_CNTHPIRQ:
+	case LOCAL_IRQ_CNTVIRQ:
+		chip = &bcm2836_arm_irqchip_timer;
+		break;
+	case LOCAL_IRQ_GPU_FAST:
+		chip = &bcm2836_arm_irqchip_gpu;
+		break;
+	case LOCAL_IRQ_PMU_FAST:
+		chip = &bcm2836_arm_irqchip_pmu;
+		break;
+	default:
+		pr_warn_once("Unexpected hw irq: %lu\n", hw);
+		return -EINVAL;
+	}
 
 	irq_set_percpu_devid(irq);
-	irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
+	irq_domain_set_info(d, irq, hw, chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+
+	return 0;
 }
 
 static void
@@ -165,7 +187,8 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 #endif
 
 static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
-	.xlate = irq_domain_xlate_onecell
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = bcm2836_map,
 };
 
 static void
@@ -218,19 +241,6 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTPSIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTPNSIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTHPIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTVIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_GPU_FAST,
-					 &bcm2836_arm_irqchip_gpu);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_PMU_FAST,
-					 &bcm2836_arm_irqchip_pmu);
-
 	bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
-- 
2.7.4
