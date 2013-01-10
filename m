From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Jan 2013 16:06:45 +0000
Subject: [PATCH v2 2/2] ARM: KVM: Power State Coordination Interface
 implementation
In-Reply-To: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the PSCI specification (ARM DEN 0022A) to control
virtual CPUs being "powered" on or off.

PSCI/KVM is detected using the KVM_CAP_ARM_PSCI capability.

A virtual CPU can now be initialized in a "powered off" state,
using the KVM_ARM_VCPU_POWER_OFF feature flag.

The guest can use either SMC or HVC to execute a PSCI function.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt  |  4 ++
 arch/arm/include/asm/kvm_emulate.h |  5 +++
 arch/arm/include/asm/kvm_host.h    |  2 +-
 arch/arm/include/asm/kvm_psci.h    | 23 ++++++++++
 arch/arm/include/uapi/asm/kvm.h    | 16 +++++++
 arch/arm/kvm/Makefile              |  2 +-
 arch/arm/kvm/arm.c                 | 26 +++++++----
 arch/arm/kvm/psci.c                | 90 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h           |  1 +
 9 files changed, 158 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_psci.h
 create mode 100644 arch/arm/kvm/psci.c

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 497fd48..e0fa0ea 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2185,6 +2185,10 @@ return ENOEXEC for that vcpu.
 Note that because some registers reflect machine topology, all vcpus
 should be created before this ioctl is invoked.
 
+Possible features:
+	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
+	  Depends on KVM_CAP_ARM_PSCI.
+
 
 4.78 KVM_GET_REG_LIST
 
diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 375795b..eb07342 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -34,6 +34,11 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
+static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
+{
+	return 1;
+}
+
 static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
 {
 	return (u32 *)&vcpu->arch.regs.usr_regs.ARM_pc;
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 14a71bb..b8eb3e0 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -31,7 +31,7 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HAVE_ONE_REG
 
-#define KVM_VCPU_MAX_FEATURES 0
+#define KVM_VCPU_MAX_FEATURES 1
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
new file mode 100644
index 0000000..992d7f1
--- /dev/null
+++ b/arch/arm/include/asm/kvm_psci.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 - ARM Ltd
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
+#ifndef __ARM_KVM_PSCI_H__
+#define __ARM_KVM_PSCI_H__
+
+int kvm_psci_call(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM_KVM_PSCI_H__ */
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 94e893b..972b90d 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -81,6 +81,8 @@ struct kvm_regs {
 #define KVM_VGIC_V2_DIST_SIZE		0x1000
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
+#define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
+
 struct kvm_vcpu_init {
 	__u32 target;
 	__u32 features[7];
@@ -161,4 +163,18 @@ struct kvm_arch_memory_slot {
 /* Highest supported SPI, from VGIC_NR_IRQS */
 #define KVM_ARM_IRQ_GIC_MAX		127
 
+/* PSCI interface */
+#define KVM_PSCI_FN_BASE		0x95c1ba5e
+#define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
+
+#define KVM_PSCI_FN_CPU_SUSPEND		KVM_PSCI_FN(0)
+#define KVM_PSCI_FN_CPU_OFF		KVM_PSCI_FN(1)
+#define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
+#define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
+
+#define KVM_PSCI_RET_SUCCESS		0
+#define KVM_PSCI_RET_NI			((unsigned long)-1)
+#define KVM_PSCI_RET_INVAL		((unsigned long)-2)
+#define KVM_PSCI_RET_DENIED		((unsigned long)-3)
+
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 43c4cad..6a2d571 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -18,6 +18,6 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o mmio.o decode.o
+obj-y += coproc.o coproc_a15.o mmio.o decode.o psci.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
 obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a28e49d..4d5ed244 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -43,6 +43,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_psci.h>
 #include <asm/opcodes.h>
 
 #ifdef REQUIRES_VIRT
@@ -192,6 +193,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_SYNC_MMU:
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_ONE_REG:
+	case KVM_CAP_ARM_PSCI:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
@@ -496,21 +498,18 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	/*
-	 * Guest called HVC instruction:
-	 * Let it know we don't want that by injecting an undefined exception.
-	 */
-	kvm_debug("hvc: %x (at %08x)", vcpu->arch.hsr & ((1 << 16) - 1),
-		  *vcpu_pc(vcpu));
-	kvm_debug("         HSR: %8x", vcpu->arch.hsr);
+	if (!kvm_psci_call(vcpu))
+		return 1;
+
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	/* We don't support SMC; don't do that. */
-	kvm_debug("smc: at %08x", *vcpu_pc(vcpu));
+	if (!kvm_psci_call(vcpu))
+		return 1;
+
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
@@ -660,6 +659,15 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
+	/*
+	 * Handle the "start in power-off" case by calling into the
+	 * PSCI code.
+	 */
+	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features)) {
+		*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
+		kvm_psci_call(vcpu);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
new file mode 100644
index 0000000..4a1c4f0
--- /dev/null
+++ b/arch/arm/kvm/psci.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2012 - ARM Ltd
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
+#include <linux/kvm_host.h>
+#include <linux/wait.h>
+
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_psci.h>
+
+static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
+{
+	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+
+	vcpu->arch.pause = true;
+
+	wait_event_interruptible(*wq, !vcpu->arch.pause);
+}
+
+static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
+{
+	struct kvm *kvm = source_vcpu->kvm;
+	struct kvm_vcpu *vcpu;
+	wait_queue_head_t *wq;
+	unsigned long cpu_id;
+	phys_addr_t target_pc;
+
+	cpu_id = *vcpu_reg(source_vcpu, 1);
+	if (vcpu_mode_is_32bit(source_vcpu))
+		cpu_id &= ~((u32) 0);
+
+	if (cpu_id >= atomic_read(&kvm->online_vcpus))
+		return KVM_PSCI_RET_INVAL;
+
+	target_pc = *vcpu_reg(source_vcpu, 2);
+
+	vcpu = kvm_get_vcpu(kvm, cpu_id);
+
+	wq = kvm_arch_vcpu_wq(vcpu);
+	if (!waitqueue_active(wq))
+		return KVM_PSCI_RET_INVAL;
+
+	kvm_reset_vcpu(vcpu);
+	*vcpu_pc(vcpu) = target_pc;
+	vcpu->arch.pause = false;
+	smp_mb();		/* Make sure the above is visible */
+
+	wake_up_interruptible(wq);
+
+	return KVM_PSCI_RET_SUCCESS;
+}
+
+int kvm_psci_call(struct kvm_vcpu *vcpu)
+{
+	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
+	unsigned long val;
+
+	switch (psci_fn) {
+	case KVM_PSCI_FN_CPU_OFF:
+		kvm_psci_vcpu_off(vcpu);
+		val = KVM_PSCI_RET_SUCCESS;
+		break;
+	case KVM_PSCI_FN_CPU_ON:
+		val = kvm_psci_vcpu_on(vcpu);
+		break;
+	case KVM_PSCI_FN_CPU_SUSPEND:
+	case KVM_PSCI_FN_MIGRATE:
+		val = KVM_PSCI_RET_NI;
+		break;
+
+	default:
+		return -1;
+	}
+
+	*vcpu_reg(vcpu, 0) = val;
+	return 0;
+}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1f68151..9ff7f70 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -637,6 +637,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_BOOKE_WATCHDOG 83
 #define KVM_CAP_PPC_HTAB_FD 84
 #define KVM_CAP_ARM_SET_DEVICE_ADDR 85
+#define KVM_CAP_ARM_PSCI 86
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.1
