From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:48 +0100
Subject: [PATCH v2 29/52] irqchip/gic-v4: Add per-VM VPE domain creation
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-30-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating a VM, it is very convenient to have an irq domain
containing all the doorbell interrupts associated with that VM
(each interrupt representing a VPE).

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v4.c       | 58 ++++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  3 ++
 2 files changed, 61 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v4.c

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
new file mode 100644
index 000000000000..2ea12baf2e53
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2016 ARM Limited, All Rights Reserved.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#include <linux/irqchip/arm-gic-v4.h>
+
+static struct irq_domain *gic_domain;
+static const struct irq_domain_ops *vpe_domain_ops;
+
+int its_alloc_vcpu_irqs(struct its_vm *vm)
+{
+	int vpe_base_irq, i;
+
+	vm->domain = irq_domain_create_hierarchy(gic_domain, 0, vm->nr_vpes,
+						 NULL, vpe_domain_ops, vm);
+	if (!vm->domain)
+		return -ENOMEM;
+
+	for (i = 0; i < vm->nr_vpes; i++) {
+		vm->vpes[i]->its_vm = vm;
+		vm->vpes[i]->idai = true;
+	}
+
+	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
+					       NUMA_NO_NODE, vm,
+					       false, NULL);
+	if (vpe_base_irq <= 0)
+		return -ENOMEM;
+
+	for (i = 0; i < vm->nr_vpes; i++)
+		vm->vpes[i]->irq = vpe_base_irq + i;
+
+	return 0;
+}
+
+void its_free_vcpu_irqs(struct its_vm *vm)
+{
+	irq_domain_free_irqs(vm->vpes[0]->irq, vm->nr_vpes);
+	irq_domain_remove(vm->domain);
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 4cac48e220da..7474a981ed6d 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -88,4 +88,7 @@ struct its_cmd_info {
 	};
 };
 
+int its_alloc_vcpu_irqs(struct its_vm *vm);
+void its_free_vcpu_irqs(struct its_vm *vm);
+
 #endif
-- 
2.11.0
