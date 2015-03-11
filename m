From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Mar 2015 15:45:34 +0000
Subject: [PATCH v6 1/4] irqchip: gic: add an entry point to set up irqchip
 flags
In-Reply-To: <1426088737-15817-1-git-send-email-marc.zyngier@arm.com>
References: <1426088737-15817-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426088737-15817-2-git-send-email-marc.zyngier@arm.com>
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
index e3ca6da..6004d84 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -880,6 +880,11 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
+void gic_set_irqchip_flags(unsigned long flags)
+{
+	gic_chip.flags |= flags;
+}
+
 void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct device_node *node)
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 3978c5b..36ec4ae 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -97,6 +97,7 @@ struct device_node;
 
 extern struct irq_chip gic_arch_extn;
 
+void gic_set_irqchip_flags(unsigned long flags);
 void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-- 
2.1.4
