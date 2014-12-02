From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Dec 2014 16:58:13 +0000
Subject: [PATCH 12/16] irqchip: gic: add an entry point to set up irqchip flags
In-Reply-To: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417539497-20101-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common use of gic_arch_extn is to set up additional flags
to the GIC irqchip. It looks like a benign enough hack that
doesn't really require the users of that feature to be converted
to stacked domains.

Add a gic_set_irqchip_flags() function that platform code can
call instead of using the dreaded gic_arch_extn.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 5 +++++
 include/linux/irqchip/arm-gic.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5a71be7..91de85d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -919,6 +919,11 @@ static const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
 const struct irq_domain_ops *gic_routable_irq_domain_ops =
 					&gic_default_routable_irq_domain_ops;
 
+void gic_set_irqchip_flags(unsigned long flags)
+{
+	gic_chip.flags |= flags;
+}
+
 void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct device_node *node)
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 71d706d..3bca864 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -97,6 +97,7 @@ struct device_node;
 
 extern struct irq_chip gic_arch_extn;
 
+void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-- 
2.1.3
