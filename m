From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 25 Mar 2016 02:05:07 +0000
Subject: [RFC PATCH 44/45] KVM: arm/arm64: vgic-new: Add dummy MSI
 implementation
In-Reply-To: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1458871508-17279-45-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although we don't provide any virtual MSI functionality yet, we
need to implement the functions required by the KVM interface.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 virt/kvm/arm/vgic/vgic_irqfd.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 virt/kvm/arm/vgic/vgic_irqfd.c

diff --git a/virt/kvm/arm/vgic/vgic_irqfd.c b/virt/kvm/arm/vgic/vgic_irqfd.c
new file mode 100644
index 0000000..3eee1bd
--- /dev/null
+++ b/virt/kvm/arm/vgic/vgic_irqfd.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2015, 2016 ARM Ltd.
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
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <trace/events/kvm.h>
+
+int kvm_irq_map_gsi(struct kvm *kvm,
+		    struct kvm_kernel_irq_routing_entry *entries,
+		    int gsi)
+{
+	return 0;
+}
+
+int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
+{
+	return pin;
+}
+
+int kvm_set_irq(struct kvm *kvm, int irq_source_id,
+		u32 irq, int level, bool line_status)
+{
+	unsigned int spi = irq + VGIC_NR_PRIVATE_IRQS;
+
+	trace_kvm_set_irq(irq, level, irq_source_id);
+
+	BUG_ON(!vgic_initialized(kvm));
+
+	return kvm_vgic_inject_irq(kvm, 0, spi, level);
+}
+
+/* MSI not implemented yet */
+int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
+		struct kvm *kvm, int irq_source_id,
+		int level, bool line_status)
+{
+	return 0;
+}
-- 
2.7.3
