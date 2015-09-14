From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 14 Sep 2015 17:29:03 +0800
Subject: [RFC PATCH v2 1/3] irqchip: GICv3: set non-percpu irqs status with
 IRQ_MOVE_PCNTXT
In-Reply-To: <1442222945-10628-1-git-send-email-yangyingliang@huawei.com>
References: <1442222945-10628-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442222945-10628-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_set_status_flags() helper set irqs status with
IRQ_MOVE_PCNTXT. So that it can do set affinity when
calling irq_set_affinity_locked().

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7deed6e..3d8f400 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -761,6 +761,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
 	}
 	/* LPIs */
 	if (hw >= 8192 && hw < GIC_ID_NR) {
@@ -769,6 +770,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID);
+		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
 	}
 
 	return 0;
-- 
2.5.0
