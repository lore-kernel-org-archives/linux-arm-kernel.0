From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:51:36 -0400
Subject: [PATCH v3 03/13] ARM: KVM: Initial VGIC infrastructure support
In-Reply-To: <20121022065104.18672.52989.stgit@ubuntu>
References: <20121022065104.18672.52989.stgit@ubuntu>
Message-ID: <20121022065136.18672.38447.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Wire the basic framework code for VGIC support. Nothing to enable
yet.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_host.h |    7 ++++
 arch/arm/include/asm/kvm_vgic.h |   70 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/arm.c              |   21 +++++++++++-
 arch/arm/kvm/interrupts.S       |    4 ++
 arch/arm/kvm/mmio.c             |    3 ++
 virt/kvm/kvm_main.c             |    5 ++-
 6 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index c6f1102..9bbccdf 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -22,6 +22,7 @@
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/fpstate.h>
+#include <asm/kvm_vgic.h>
 
 #define KVM_MAX_VCPUS NR_CPUS
 #define KVM_MEMORY_SLOTS 32
@@ -57,6 +58,9 @@ struct kvm_arch {
 
 	/* Stage-2 page table */
 	pgd_t *pgd;
+
+	/* Interrupt controller */
+	struct vgic_dist	vgic;
 };
 
 #define KVM_NR_MEM_OBJS     40
@@ -91,6 +95,9 @@ struct kvm_vcpu_arch {
 	struct vfp_hard_struct vfp_guest;
 	struct vfp_hard_struct *vfp_host;
 
+	/* VGIC state */
+	struct vgic_cpu vgic_cpu;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
new file mode 100644
index 0000000..d75540a
--- /dev/null
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -0,0 +1,70 @@
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
+#ifndef __ASM_ARM_KVM_VGIC_H
+#define __ASM_ARM_KVM_VGIC_H
+
+struct vgic_dist {
+};
+
+struct vgic_cpu {
+};
+
+struct kvm;
+struct kvm_vcpu;
+struct kvm_run;
+struct kvm_exit_mmio;
+
+#ifndef CONFIG_KVM_ARM_VGIC
+static inline int kvm_vgic_hyp_init(void)
+{
+	return 0;
+}
+
+static inline int kvm_vgic_init(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline int kvm_vgic_create(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline void kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu) {}
+
+static inline int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				    struct kvm_exit_mmio *mmio)
+{
+	return false;
+}
+
+static inline int irqchip_in_kernel(struct kvm *kvm)
+{
+	return 0;
+}
+#endif
+
+#endif
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 828b5af..a57b107 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -183,6 +183,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 {
 	int r;
 	switch (ext) {
+#ifdef CONFIG_KVM_ARM_VGIC
+	case KVM_CAP_IRQCHIP:
+#endif
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_ONE_REG:
@@ -304,6 +307,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	/* Force users to call KVM_ARM_VCPU_INIT */
 	vcpu->arch.target = -1;
+
+	/* Set up VGIC */
+	kvm_vgic_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -363,7 +370,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return !!v->arch.irq_lines;
+	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
 }
 
 int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
@@ -632,6 +639,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		update_vttbr(vcpu->kvm);
 
+		kvm_vgic_sync_to_cpu(vcpu);
+
 		local_irq_disable();
 
 		/*
@@ -644,6 +653,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
+			kvm_vgic_sync_from_cpu(vcpu);
 			continue;
 		}
 
@@ -682,6 +692,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
+		kvm_vgic_sync_from_cpu(vcpu);
+
 		ret = handle_exit(vcpu, run, ret);
 	}
 
@@ -964,6 +976,13 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	/*
+	 * Init HYP view of VGIC
+	 */
+	err = kvm_vgic_hyp_init();
+	if (err)
+		goto out_free_mappings;
+
 	return 0;
 out_free_vfp:
 	free_percpu(kvm_host_vfp_state);
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 7c89708..e418c9b 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -91,6 +91,8 @@ ENTRY(__kvm_vcpu_run)
 
 	save_host_regs
 
+	restore_vgic_state r0
+
 	@ Store hardware CP15 state and load guest state
 	read_cp15_state
 	write_cp15_state 1, r0
@@ -184,6 +186,8 @@ after_vfp_restore:
 	read_cp15_state 1, r1
 	write_cp15_state
 
+	save_vgic_state	r1
+
 	restore_host_regs
 	clrex				@ Clear exclusive monitor
 	bx	lr			@ return to IOCTL
diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 28bd5eb..beb7134 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -146,6 +146,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (mmio.is_write)
 		memcpy(mmio.data, vcpu_reg(vcpu, rd), mmio.len);
 
+	if (vgic_handle_mmio(vcpu, run, &mmio))
+		return 1;
+
 	kvm_prepare_mmio(run, &mmio);
 	return 0;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e59bb63..bef668b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1882,12 +1882,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	if (vcpu->kvm->mm != current->mm)
 		return -EIO;
 
-#if defined(CONFIG_S390) || defined(CONFIG_PPC)
+#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_ARM)
 	/*
 	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
 	 * so vcpu_load() would break it.
 	 */
-	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT)
+	if (ioctl == KVM_S390_INTERRUPT || ioctl == KVM_INTERRUPT ||
+	    ioctl == KVM_IRQ_LINE)
 		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 #endif
 
