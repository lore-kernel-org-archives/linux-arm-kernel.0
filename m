From: stefan@agner.ch (Stefan Agner)
Date: Wed,  3 Dec 2014 01:12:02 +0100
Subject: [PATCH 03/12] irqchip: gic: define register_routable_domain_ops
 conditional
In-Reply-To: <1417565531-4507-1-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
Message-ID: <1417565531-4507-4-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inline function register_routable_domain_ops is only usable if
CONFIG_ARM_GIC is set. Make it depend on this configuration. This
also allows other SoC interrupt controller to provide such a
function.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/irqchip/arm-gic.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 13eed92..3b1baf1 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -111,11 +111,14 @@ int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 unsigned long gic_get_sgir_physaddr(void);
 
+#ifdef CONFIG_ARM_GIC
 extern const struct irq_domain_ops *gic_routable_irq_domain_ops;
 static inline void __init register_routable_domain_ops
 					(const struct irq_domain_ops *ops)
 {
 	gic_routable_irq_domain_ops = ops;
 }
+#endif /* CONFIG_ARM_GIC */
+
 #endif /* __ASSEMBLY */
 #endif
-- 
2.1.3
