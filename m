From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:37:08 -0400
Subject: [PATCH 02/10] ARM: KVM: Initial VGIC infrastructure support
In-Reply-To: <20120915153657.21545.3972.stgit@ubuntu>
References: <20120915153657.21545.3972.stgit@ubuntu>
Message-ID: <20120915153708.21545.98140.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Wire the basic framework code for VGIC support. Nothing to enable
yet.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_host.h |    8 +++++
 arch/arm/include/asm/kvm_vgic.h |   65 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/arm.c              |   20 +++++++++++-
 arch/arm/kvm/interrupts.S       |   18 +++++++++++
 arch/arm/kvm/mmu.c              |    3 ++
 virt/kvm/kvm_main.c             |    5 ++-
 6 files changed, 116 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 2e3ac1c..97e0e5a 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -28,6 +28,8 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
 
+#include <asm/kvm_vgic.h>
+
 #define NUM_FEATURES 0
 
 /* We don't currently support large pages. */
@@ -52,6 +54,9 @@ struct kvm_arch {
 
 	/* VTTBR value associated with above pgd and vmid */
 	u64    vttbr;
+
+	/* Interrupt controller */
+	struct vgic_dist	vgic;
 };
 
 #define EXCEPTION_NONE      0
@@ -144,6 +149,9 @@ struct kvm_vcpu_arch {
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
index 0000000..e1fd530
--- /dev/null
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -0,0 +1,65 @@
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
index e6c3743..665c6bd 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -185,6 +185,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 {
 	int r;
 	switch (ext) {
+#ifdef CONFIG_KVM_ARM_VGIC
+	case KVM_CAP_IRQCHIP:
+#endif
 	case KVM_CAP_USER_MEMORY:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_ONE_REG:
@@ -298,6 +301,9 @@ int __attribute_const__ kvm_target_cpu(void)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	/* Set up VGIC */
+	kvm_vgic_vcpu_init(vcpu);
+
 	return 0;
 }
 
@@ -357,7 +363,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
  */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return !!v->arch.irq_lines;
+	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
 }
 
 int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
@@ -625,6 +631,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		cond_resched();
 		update_vttbr(vcpu->kvm);
 
+		kvm_vgic_sync_to_cpu(vcpu);
+
 		local_irq_disable();
 
 		/*
@@ -637,6 +645,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
+			kvm_vgic_sync_from_cpu(vcpu);
 			continue;
 		}
 
@@ -677,6 +686,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/
 
+		kvm_vgic_sync_from_cpu(vcpu);
+
 		ret = handle_exit(vcpu, run, ret);
 	}
 
@@ -949,6 +960,13 @@ static int init_hyp_mode(void)
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
index ab78477..dad9df7 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -311,6 +311,20 @@ ENDPROC(__kvm_flush_vm_context)
 	mcr	p15, 2, r12, c0, c0, 0	@ CSSELR
 .endm
 
+/*
+ * Save the VGIC CPU state into memory
+ * @vcpup: Register pointing to VCPU struct
+ */
+.macro save_vgic_state	vcpup
+.endm
+
+/*
+ * Restore the VGIC CPU state from memory
+ * @vcpup: Register pointing to VCPU struct
+ */
+.macro restore_vgic_state	vcpup
+.endm
+
 /* Configures the HSTR (Hyp System Trap Register) on entry/return
  * (hardware reset value is 0) */
 .macro set_hstr entry
@@ -388,6 +402,8 @@ ENTRY(__kvm_vcpu_run)
 	store_mode_state sp, irq
 	store_mode_state sp, fiq
 
+	restore_vgic_state r0
+
 	@ Store hardware CP15 state and load guest state
 	read_cp15_state
 	write_cp15_state 1, r0
@@ -505,6 +521,8 @@ after_vfp_restore:
 	read_cp15_state 1, r1
 	write_cp15_state
 
+	save_vgic_state	r1
+
 	load_mode_state sp, fiq
 	load_mode_state sp, irq
 	load_mode_state sp, und
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index dc760bb..82d0edf 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -845,6 +845,9 @@ static int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (mmio.is_write)
 		memcpy(mmio.data, vcpu_reg(vcpu, rd), mmio.len);
 
+	if (vgic_handle_mmio(vcpu, run, &mmio))
+		return 1;
+
 	kvm_prepare_mmio(run, &mmio);
 	return 0;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 35885b2..dd8b115 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1881,12 +1881,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
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
 
