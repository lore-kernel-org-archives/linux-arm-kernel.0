From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:17 +0700
Subject: [RFCv2 PATCH 1/8] irqdomain: Introduce irq_domain_ops.init_alloc_info
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-2-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when calling irq_domain_alloc_irqs() on ARM64, it uses
struct of_phandle_args to pass irq information. However, this is not
appropriate for ACPI since of_phandle_args is specific to DT.

Therefore, this patch introduces a new function pointer,
irq_domain_ops.init_alloc_info, which can be used by irqchips to provide
a way to initialize irqchip-specific data-structure for allocating IRQ.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
NOTE:
Similarly, x86 is currently using struct irq_alloc_info
(see arch/x86/include/asm/hw_irq.h) and each irq_domain has different
way of initializing this structure.

Patch 2 also has an example of how I am planning to use this new op.

Alternative would be to keep re-using of_phandle_args for ACPI as done
currently. Any suggestions / feedbacks here are appreciated.

Thanks,

Suravee

 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b4a74f7..1e51369 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -86,6 +86,8 @@ struct irq_domain_ops {
 	/* extended V2 interfaces to support hierarchy irq_domains */
 	int (*alloc)(struct irq_domain *d, unsigned int virq,
 		     unsigned int nr_irqs, void *arg);
+	int (*init_alloc_info)(uint32_t *data, int nr, void *ref,
+			       void **info);
 	void (*free)(struct irq_domain *d, unsigned int virq,
 		     unsigned int nr_irqs);
 	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 995d217..54434d2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -478,6 +478,7 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
+	void *info;
 
 	domain = irq_data->np ? irq_find_host(irq_data->np) : irq_default_domain;
 	if (!domain) {
@@ -504,7 +505,14 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 		if (virq)
 			return virq;
 
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
+		if (domain->ops->init_alloc_info)
+			if (domain->ops->init_alloc_info(irq_data->args,
+							 irq_data->args_count,
+							 irq_data->np,
+							 &info))
+				return 0;
+
+		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, info);
 		if (virq <= 0)
 			return 0;
 	} else {
-- 
2.1.0
