From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:51:42 -0400
Subject: [PATCH v3 04/13] ARM: KVM: Initial VGIC MMIO support code
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065142.18672.75805.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Wire the initial in-kernel MMIO support code for the VGIC, used
for the distributor emulation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_vgic.h |    6 +-
 arch/arm/kvm/Makefile           |    1 
 arch/arm/kvm/vgic.c             |  138 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kvm/vgic.c

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index d75540a..b444ecf 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -30,7 +30,11 @@ struct kvm_vcpu;
 struct kvm_run;
 struct kvm_exit_mmio;
 
-#ifndef CONFIG_KVM_ARM_VGIC
+#ifdef CONFIG_KVM_ARM_VGIC
+bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		      struct kvm_exit_mmio *mmio);
+
+#else
 static inline int kvm_vgic_hyp_init(void)
 {
 	return 0;
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 574c67c..3370c09 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_KVM_ARM_HOST) += $(addprefix ../../../virt/kvm/, kvm_main.o coalesc
 
 obj-$(CONFIG_KVM_ARM_HOST) += arm.o guest.o mmu.o emulate.o reset.o
 obj-$(CONFIG_KVM_ARM_HOST) += coproc.o coproc_a15.o mmio.o
+obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
new file mode 100644
index 0000000..26ada3b
--- /dev/null
+++ b/arch/arm/kvm/vgic.c
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <asm/kvm_emulate.h>
+
+#define ACCESS_READ_VALUE	(1 << 0)
+#define ACCESS_READ_RAZ		(0 << 0)
+#define ACCESS_READ_MASK(x)	((x) & (1 << 0))
+#define ACCESS_WRITE_IGNORED	(0 << 1)
+#define ACCESS_WRITE_SETBIT	(1 << 1)
+#define ACCESS_WRITE_CLEARBIT	(2 << 1)
+#define ACCESS_WRITE_VALUE	(3 << 1)
+#define ACCESS_WRITE_MASK(x)	((x) & (3 << 1))
+
+/**
+ * vgic_reg_access - access vgic register
+ * @mmio:   pointer to the data describing the mmio access
+ * @reg:    pointer to the virtual backing of the vgic distributor struct
+ * @offset: least significant 2 bits used for word offset
+ * @mode:   ACCESS_ mode (see defines above)
+ *
+ * Helper to make vgic register access easier using one of the access
+ * modes defined for vgic register access
+ * (read,raz,write-ignored,setbit,clearbit,write)
+ */
+static void vgic_reg_access(struct kvm_exit_mmio *mmio, u32 *reg,
+			    u32 offset, int mode)
+{
+	int word_offset = offset & 3;
+	int shift = word_offset * 8;
+	u32 mask;
+	u32 regval;
+
+	/*
+	 * Any alignment fault should have been delivered to the guest
+	 * directly (ARM ARM B3.12.7 "Prioritization of aborts").
+	 */
+
+	mask = (~0U) >> (word_offset * 8);
+	if (reg)
+		regval = *reg;
+	else {
+		BUG_ON(mode != (ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED));
+		regval = 0;
+	}
+
+	if (mmio->is_write) {
+		u32 data = (*((u32 *)mmio->data) & mask) << shift;
+		switch (ACCESS_WRITE_MASK(mode)) {
+		case ACCESS_WRITE_IGNORED:
+			return;
+
+		case ACCESS_WRITE_SETBIT:
+			regval |= data;
+			break;
+
+		case ACCESS_WRITE_CLEARBIT:
+			regval &= ~data;
+			break;
+
+		case ACCESS_WRITE_VALUE:
+			regval = (regval & ~(mask << shift)) | data;
+			break;
+		}
+		*reg = regval;
+	} else {
+		switch (ACCESS_READ_MASK(mode)) {
+		case ACCESS_READ_RAZ:
+			regval = 0;
+			/* fall through */
+
+		case ACCESS_READ_VALUE:
+			*((u32 *)mmio->data) = (regval >> shift) & mask;
+		}
+	}
+}
+
+/* All this should be handled by kvm_bus_io_*()... FIXME!!! */
+struct mmio_range {
+	unsigned long base;
+	unsigned long len;
+	bool (*handle_mmio)(struct kvm_vcpu *vcpu, struct kvm_exit_mmio *mmio,
+			    u32 offset);
+};
+
+static const struct mmio_range vgic_ranges[] = {
+	{}
+};
+
+static const
+struct mmio_range *find_matching_range(const struct mmio_range *ranges,
+				       struct kvm_exit_mmio *mmio,
+				       unsigned long base)
+{
+	const struct mmio_range *r = ranges;
+	unsigned long addr = mmio->phys_addr - base;
+
+	while (r->len) {
+		if (addr >= r->base &&
+		    (addr + mmio->len) <= (r->base + r->len))
+			return r;
+		r++;
+	}
+
+	return NULL;
+}
+
+/**
+ * vgic_handle_mmio - handle an in-kernel MMIO access
+ * @vcpu:	pointer to the vcpu performing the access
+ * @mmio:	pointer to the data describing the access
+ *
+ * returns true if the MMIO access has been performed in kernel space,
+ * and false if it needs to be emulated in user space.
+ */
+bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run, struct kvm_exit_mmio *mmio)
+{
+	return KVM_EXIT_MMIO;
+}
