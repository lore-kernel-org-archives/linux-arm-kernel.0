From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 14 Dec 2011 22:39:57 +0000
Subject: [PATCH 1/2] irqdomain: export irq_domain_simple_ops for !CONFIG_OF
Message-ID: <1323902398-10072-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqdomain support is used in interrupt controller drivers that may not
have device tree support but only need the basic HW->Linux irq
translation.  Rather than having each of these implement their own IRQ
domain, allow them to use the simple ops.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 include/linux/irqdomain.h |    3 ++-
 kernel/irq/irqdomain.c    |   12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 99834e58..bd4272b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -91,10 +91,11 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
 
 extern void irq_domain_add(struct irq_domain *domain);
 extern void irq_domain_del(struct irq_domain *domain);
+
+extern struct irq_domain_ops irq_domain_simple_ops;
 #endif /* CONFIG_IRQ_DOMAIN */
 
 #if defined(CONFIG_IRQ_DOMAIN) && defined(CONFIG_OF_IRQ)
-extern struct irq_domain_ops irq_domain_simple_ops;
 extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 200ce83..7ca523b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -143,11 +143,6 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
 	return 0;
 }
 
-struct irq_domain_ops irq_domain_simple_ops = {
-	.dt_translate = irq_domain_simple_dt_translate,
-};
-EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
-
 /**
  * irq_domain_create_simple() - Set up a 'simple' translation range
  */
@@ -182,3 +177,10 @@ void irq_domain_generate_simple(const struct of_device_id *match,
 }
 EXPORT_SYMBOL_GPL(irq_domain_generate_simple);
 #endif /* CONFIG_OF_IRQ */
+
+struct irq_domain_ops irq_domain_simple_ops = {
+#ifdef CONFIG_OF_IRQ
+	.dt_translate = irq_domain_simple_dt_translate,
+#endif /* CONFIG_OF_IRQ */
+};
+EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
-- 
1.7.5.4
