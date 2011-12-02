From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  2 Dec 2011 14:53:17 +0100
Subject: [PATCH] irqdomain: protect macro variable in domain iterators
Message-ID: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Error found while using those iterators in an irq controller
initialization function.

May also need protection around irq and hwirq macro variables
but those values are usually plain "int" anyway... Tell me if you
feel that it should be done.

 include/linux/irqdomain.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 99834e58..a553004 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,12 +82,12 @@ static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
 }
 
 #define irq_domain_for_each_hwirq(d, hw) \
-	for (hw = d->hwirq_base; hw < d->hwirq_base + d->nr_irq; hw++)
+	for (hw = (d)->hwirq_base; hw < (d)->hwirq_base + (d)->nr_irq; hw++)
 
 #define irq_domain_for_each_irq(d, hw, irq) \
-	for (hw = d->hwirq_base, irq = irq_domain_to_irq(d, hw); \
-	     hw < d->hwirq_base + d->nr_irq; \
-	     hw++, irq = irq_domain_to_irq(d, hw))
+	for (hw = (d)->hwirq_base, irq = irq_domain_to_irq((d), hw); \
+	     hw < (d)->hwirq_base + (d)->nr_irq; \
+	     hw++, irq = irq_domain_to_irq((d), hw))
 
 extern void irq_domain_add(struct irq_domain *domain);
 extern void irq_domain_del(struct irq_domain *domain);
-- 
1.7.5.4
