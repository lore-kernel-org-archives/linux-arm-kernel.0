From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun,  9 Nov 2014 23:10:24 +0800
Subject: [RFC Part4 v1 02/17] genirq: Introduce helper irq_domain_set_info()
 to reduce duplicated code
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415545839-28263-3-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce helper irq_domain_set_info() to reduce duplicated code.
We use "void *handler" instead of "irq_flow_handler_t handler" to solve
a recursive header file inclusion issue.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/htirq.c  |    5 ++---
 arch/x86/platform/uv/uv_irq.c |    5 ++---
 include/linux/irqdomain.h     |    4 ++++
 kernel/irq/irqdomain.c        |   10 ++++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/htirq.c b/arch/x86/kernel/apic/htirq.c
index 900f1401a452..1448df3f9e9f 100644
--- a/arch/x86/kernel/apic/htirq.c
+++ b/arch/x86/kernel/apic/htirq.c
@@ -96,9 +96,8 @@ static int htirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	ht_cfg->update = info->ht_update;
 	ht_cfg->pos = info->ht_pos;
 	ht_cfg->idx = 0x10 + (info->ht_idx * 2);
-	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &ht_irq_chip,
-				      ht_cfg);
-	__irq_set_handler(virq, handle_edge_irq, 0, "edge");
+	irq_domain_set_info(domain, virq, hwirq, &ht_irq_chip, ht_cfg,
+			    handle_edge_irq, NULL, "edge");
 
 	return 0;
 }
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 66d531e71c9a..b242e0aada19 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -102,9 +102,8 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		chip_data->pnode = uv_blade_to_pnode(info->uv_blade);
 		chip_data->offset = info->uv_offset;
-		irq_domain_set_hwirq_and_chip(domain, virq, virq,
-					      &uv_irq_chip, chip_data);
-		__irq_set_handler(virq, handle_percpu_irq, 0, info->uv_name);
+		irq_domain_set_info(domain, virq, virq, &uv_irq_chip, chip_data,
+				    handle_percpu_irq, NULL, info->uv_name);
 	} else {
 		kfree(chip_data);
 	}
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 50931e936149..fb7af45f9425 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -263,6 +263,10 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
+extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+				irq_hw_number_t hwirq, struct irq_chip *chip,
+				void *chip_data, void *handler,
+				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					int virq, int nr_irqs);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 4811bee1b8a7..1da30ae88665 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -882,6 +882,16 @@ int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
+void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 void *chip_data, void *handler, void *handler_data,
+			 const char *handler_name)
+{
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, chip_data);
+	__irq_set_handler(virq, handler, 0, handler_name);
+	irq_set_handler_data(virq, handler_data);
+}
+
 void irq_domain_reset_irq_data(struct irq_data *irq_data)
 {
 	irq_data->hwirq = 0;
-- 
1.7.10.4
