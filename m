From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:26:08 +0100
Subject: [PATCH v3 30/59] irqchip/gic-v4: Add per-VM VPE domain creation
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-31-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating a VM, it is very convenient to have an irq domain
containing all the doorbell interrupts associated with that VM
(each interrupt representing a VPE).

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v4.c       | 73 ++++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  3 ++
 2 files changed, 76 insertions(+)
 create mode 100644 drivers/irqchip/irq-gic-v4.c

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
new file mode 100644
index 000000000000..f7fe6181ec8d
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2016,2017 ARM Limited, All Rights Reserved.
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
+	vm->fwnode = irq_domain_alloc_named_id_fwnode("GICv4-vpe",
+						      task_pid_nr(current));
+	if (!vm->fwnode)
+		goto err;
+
+	vm->domain = irq_domain_create_hierarchy(gic_domain, 0, vm->nr_vpes,
+						 vm->fwnode, vpe_domain_ops,
+						 vm);
+	if (!vm->domain)
+		goto err;
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
+		goto err;
+
+	for (i = 0; i < vm->nr_vpes; i++)
+		vm->vpes[i]->irq = vpe_base_irq + i;
+
+	return 0;
+
+err:
+	if (vm->domain)
+		irq_domain_remove(vm->domain);
+	if (vm->fwnode)
+		irq_domain_free_fwnode(vm->fwnode);
+
+	return -ENOMEM;
+}
+
+void its_free_vcpu_irqs(struct its_vm *vm)
+{
+	irq_domain_free_irqs(vm->vpes[0]->irq, vm->nr_vpes);
+	irq_domain_remove(vm->domain);
+	irq_domain_free_fwnode(vm->fwnode);
+}
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 5ba0fb6b094d..b31fb8aeba03 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -89,4 +89,7 @@ struct its_cmd_info {
 	};
 };
 
+int its_alloc_vcpu_irqs(struct its_vm *vm);
+void its_free_vcpu_irqs(struct its_vm *vm);
+
 #endif
-- 
2.11.0
