From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Fri, 21 Nov 2014 11:23:26 +0800
Subject: [Patch irqdomain: Enhance irq_domain_free_irqs_common() to support
 parentless irqdomain
Message-ID: <1416540206-18103-1-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally irq_domain_free_irqs_common() is designed to be used by
irqdomains with parent. But there are desires to reuse for parentless
irqdomains for code reduction.
So check domain->parent before invoking irq_domain_free_irqs_parent().

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi Thomas,
	This patch applies to tip/irq/irqdomain, it helps to reduce code
size on ARM. Seems we still have chance to merge it into tip/irq/irqdomain:)
Regards!
Gerry
---
 kernel/irq/irqdomain.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 029acf11efed..0449d2869e17 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -975,7 +975,8 @@ void irq_domain_free_irqs_common(struct irq_domain *domain, unsigned int virq,
 		if (irq_data)
 			irq_domain_reset_irq_data(irq_data);
 	}
-	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	if (domain->parent)
+		irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
 /**
-- 
1.7.10.4
