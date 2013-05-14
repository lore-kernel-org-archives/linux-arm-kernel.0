From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:48 +0100
Subject: [PATCH v4 20/32] arm64: KVM: PSCI implementation
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire the PSCI backend into the exit handling code.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/kvm_psci.h | 23 +++++++++++++++++++++++
 arch/arm64/include/uapi/asm/kvm.h | 16 ++++++++++++++++
 arch/arm64/kvm/handle_exit.c      | 16 +++++++---------
 4 files changed, 47 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_psci.h

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2500eb6..2fdeb32 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 
-#define KVM_VCPU_MAX_FEATURES 0
+#define KVM_VCPU_MAX_FEATURES 1
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
new file mode 100644
index 0000000..e301a48
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_psci.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
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
+#ifndef __ARM64_KVM_PSCI_H__
+#define __ARM64_KVM_PSCI_H__
+
+bool kvm_psci_call(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM64_KVM_PSCI_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ebac919..fb60f90 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -69,6 +69,8 @@ struct kvm_regs {
 #define KVM_VGIC_V2_DIST_SIZE		0x1000
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
+#define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
+
 struct kvm_vcpu_init {
 	__u32 target;
 	__u32 features[7];
@@ -141,6 +143,20 @@ struct kvm_arch_memory_slot {
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
 #endif
 
 #endif /* __ARM_KVM_H__ */
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index c65d115..4766b7f 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -24,26 +24,24 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_psci.h>
 
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	/*
-	 * Guest called HVC instruction:
-	 * Let it know we don't want that by injecting an undefined exception.
-	 */
-	kvm_debug("hvc: %x (at %08lx)", kvm_vcpu_get_hsr(vcpu) & ((1 << 16) - 1),
-		  *vcpu_pc(vcpu));
-	kvm_debug("         HSR: %8x", kvm_vcpu_get_hsr(vcpu));
+	if (kvm_psci_call(vcpu))
+		return 1;
+
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	/* We don't support SMC; don't do that. */
-	kvm_debug("smc:@%08lx", *vcpu_pc(vcpu));
+	if (kvm_psci_call(vcpu))
+		return 1;
+
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
-- 
1.8.2.3
