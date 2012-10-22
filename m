From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:53:22 -0400
Subject: [PATCH v3 2/5] ARM: KVM: arch_timers: Add minimal infrastructure
In-Reply-To: <20121022065301.18883.35308.stgit@ubuntu>
References: <20121022065301.18883.35308.stgit@ubuntu>
Message-ID: <20121022065322.18883.70911.stgit@ubuntu>
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
 arch/arm/kvm/interrupts.S             |    2 +
 arch/arm/kvm/interrupts_head.S        |   19 ++++++++++++++
 4 files changed, 71 insertions(+)
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
index 9bbccdf..7127fe7 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -23,6 +23,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/fpstate.h>
 #include <asm/kvm_vgic.h>
+#include <asm/kvm_arch_timer.h>
 
 #define KVM_MAX_VCPUS NR_CPUS
 #define KVM_MEMORY_SLOTS 32
@@ -47,6 +48,9 @@ struct kvm_arch {
 	/* VTTBR value associated with below pgd and vmid */
 	u64    vttbr;
 
+	/* Timer */
+	struct arch_timer_kvm	timer;
+
 	/*
 	 * Anything that is not used directly from assembly code goes
 	 * here.
@@ -97,6 +101,7 @@ struct kvm_vcpu_arch {
 
 	/* VGIC state */
 	struct vgic_cpu vgic_cpu;
+	struct arch_timer_cpu timer_cpu;
 
 	/*
 	 * Anything that is not used directly from assembly code goes
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index e418c9b..5a09e89 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -92,6 +92,7 @@ ENTRY(__kvm_vcpu_run)
 	save_host_regs
 
 	restore_vgic_state r0
+	restore_timer_state r0
 
 	@ Store hardware CP15 state and load guest state
 	read_cp15_state
@@ -186,6 +187,7 @@ after_vfp_restore:
 	read_cp15_state 1, r1
 	write_cp15_state
 
+	save_timer_state r1
 	save_vgic_state	r1
 
 	restore_host_regs
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index c2423d8..0003aab 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -418,6 +418,25 @@
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
