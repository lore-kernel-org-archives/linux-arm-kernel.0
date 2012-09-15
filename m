From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:39:13 -0400
Subject: [PATCH 2/5] ARM: KVM: arch_timers: Add minimal infrastructure
In-Reply-To: <20120915153902.21673.37552.stgit@ubuntu>
References: <20120915153902.21673.37552.stgit@ubuntu>
Message-ID: <20120915153913.21673.19228.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Add some very minimal architected timer related infrastructure.
For the moment, we just provide empty structures, and enable/disable
access to the physical timer across world switch.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arch_timer.h |   45 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/kvm_host.h       |    5 ++++
 arch/arm/kvm/interrupts.S             |   21 +++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 arch/arm/include/asm/kvm_arch_timer.h

diff --git a/arch/arm/include/asm/kvm_arch_timer.h b/arch/arm/include/asm/kvm_arch_timer.h
new file mode 100644
index 0000000..513b852
--- /dev/null
+++ b/arch/arm/include/asm/kvm_arch_timer.h
@@ -0,0 +1,45 @@
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
+#ifndef __ASM_ARM_KVM_ARCH_TIMER_H
+#define __ASM_ARM_KVM_ARCH_TIMER_H
+
+struct arch_timer_kvm {
+};
+
+struct arch_timer_cpu {
+};
+
+#ifndef CONFIG_KVM_ARM_TIMER
+static inline int kvm_timer_hyp_init(void)
+{
+	return 0;
+};
+
+static inline int kvm_timer_init(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu) {}
+static inline void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu) {}
+static inline void kvm_timer_sync_from_cpu(struct kvm_vcpu *vcpu) {}
+static inline void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu) {}
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 97e0e5a..dd40b7c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -29,6 +29,7 @@
 #define KVM_HAVE_ONE_REG
 
 #include <asm/kvm_vgic.h>
+#include <asm/kvm_arch_timer.h>
 
 #define NUM_FEATURES 0
 
@@ -57,6 +58,9 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+
+	/* Timer */
+	struct arch_timer_kvm	timer;
 };
 
 #define EXCEPTION_NONE      0
@@ -151,6 +155,7 @@ struct kvm_vcpu_arch {
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
+	struct arch_timer_cpu timer_cpu;
 
 	/*
 	 * Anything that is not used directly from assembly code goes
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index bf0f83f..d354bd8 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -393,6 +393,25 @@ ENDPROC(__kvm_flush_vm_context)
 #endif
 .endm
 
+#define CNTHCTL_PL1PCTEN	(1 << 0)
+#define CNTHCTL_PL1PCEN		(1 << 1)
+
+.macro save_timer_state	vcpup
+	@ Allow physical timer/counter access for the host
+	mrc	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+	orr	r2, r2, #(CNTHCTL_PL1PCEN | CNTHCTL_PL1PCTEN)
+	mcr	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+.endm
+
+.macro restore_timer_state vcpup
+	@ Disallow physical timer access for the guest
+	@ Physical counter access is allowed
+	mrc	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+	orr	r2, r2, #CNTHCTL_PL1PCTEN
+	bic	r2, r2, #CNTHCTL_PL1PCEN
+	mcr	p15, 4, r2, c14, c1, 0	@ CNTHCTL
+.endm
+
 /* Configures the HSTR (Hyp System Trap Register) on entry/return
  * (hardware reset value is 0) */
 .macro set_hstr entry
@@ -471,6 +490,7 @@ ENTRY(__kvm_vcpu_run)
 	store_mode_state sp, fiq
 
 	restore_vgic_state r0
+	restore_timer_state r0
 
 	@ Store hardware CP15 state and load guest state
 	read_cp15_state
@@ -589,6 +609,7 @@ after_vfp_restore:
 	read_cp15_state 1, r1
 	write_cp15_state
 
+	save_timer_state r1
 	save_vgic_state	r1
 
 	load_mode_state sp, fiq
