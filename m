From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:09 +0000
Subject: [PATCH 15/29] ARM: KVM: move exit handler selection to a separate file
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exit handler selection code cannot be shared with arm64
(two different modes, more exception classes...).

Move it to a separate file (handle_exit.c).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h |   3 +
 arch/arm/kvm/Makefile           |   2 +-
 arch/arm/kvm/arm.c              | 113 --------------------------------
 arch/arm/kvm/handle_exit.c      | 140 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/kvm/handle_exit.c

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index eb836e6..24f457a 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -183,4 +183,7 @@ struct kvm_one_reg;
 int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 
+int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		int exception_index);
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index fc96ce6..8dc5e76 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -17,7 +17,7 @@ AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
 kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-y += kvm-arm.o init.o interrupts.o
-obj-y += arm.o guest.o mmu.o emulate.o reset.o
+obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
 obj-y += coproc.o coproc_a15.o mmio.o psci.o
 obj-$(CONFIG_KVM_ARM_VGIC) += vgic.o
 obj-$(CONFIG_KVM_ARM_TIMER) += arch_timer.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 93aaba6..de783ee 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -30,7 +30,6 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#include <asm/unified.h>
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
 #include <asm/mman.h>
@@ -480,118 +479,6 @@ static void update_vttbr(struct kvm *kvm)
 	spin_unlock(&kvm_vmid_lock);
 }
 
-static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	/* SVC called from Hyp mode should never get here */
-	kvm_debug("SVC called from Hyp mode shouldn't go here\n");
-	BUG();
-	return -EINVAL; /* Squash warning */
-}
-
-static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
-		      vcpu->arch.hsr & HSR_HVC_IMM_MASK);
-
-	if (kvm_psci_call(vcpu))
-		return 1;
-
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
-static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	if (kvm_psci_call(vcpu))
-		return 1;
-
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
-static int handle_pabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	/* The hypervisor should never cause aborts */
-	kvm_err("Prefetch Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
-		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
-	return -EFAULT;
-}
-
-static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	/* This is either an error in the ws. code or an external abort */
-	kvm_err("Data Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
-		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
-	return -EFAULT;
-}
-
-typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
-static exit_handle_fn arm_exit_handlers[] = {
-	[HSR_EC_WFI]		= kvm_handle_wfi,
-	[HSR_EC_CP15_32]	= kvm_handle_cp15_32,
-	[HSR_EC_CP15_64]	= kvm_handle_cp15_64,
-	[HSR_EC_CP14_MR]	= kvm_handle_cp14_access,
-	[HSR_EC_CP14_LS]	= kvm_handle_cp14_load_store,
-	[HSR_EC_CP14_64]	= kvm_handle_cp14_access,
-	[HSR_EC_CP_0_13]	= kvm_handle_cp_0_13_access,
-	[HSR_EC_CP10_ID]	= kvm_handle_cp10_id,
-	[HSR_EC_SVC_HYP]	= handle_svc_hyp,
-	[HSR_EC_HVC]		= handle_hvc,
-	[HSR_EC_SMC]		= handle_smc,
-	[HSR_EC_IABT]		= kvm_handle_guest_abort,
-	[HSR_EC_IABT_HYP]	= handle_pabt_hyp,
-	[HSR_EC_DABT]		= kvm_handle_guest_abort,
-	[HSR_EC_DABT_HYP]	= handle_dabt_hyp,
-};
-
-/*
- * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
- * proper exit to QEMU.
- */
-static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
-		       int exception_index)
-{
-	unsigned long hsr_ec;
-
-	switch (exception_index) {
-	case ARM_EXCEPTION_IRQ:
-		return 1;
-	case ARM_EXCEPTION_UNDEFINED:
-		kvm_err("Undefined exception in Hyp mode at: %#08lx\n",
-			kvm_vcpu_get_hyp_pc(vcpu));
-		BUG();
-		panic("KVM: Hypervisor undefined exception!\n");
-	case ARM_EXCEPTION_DATA_ABORT:
-	case ARM_EXCEPTION_PREF_ABORT:
-	case ARM_EXCEPTION_HVC:
-		hsr_ec = kvm_vcpu_trap_get_class(vcpu);
-
-		if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers)
-		    || !arm_exit_handlers[hsr_ec]) {
-			kvm_err("Unkown exception class: %#08lx, "
-				"hsr: %#08x\n", hsr_ec,
-				(unsigned int)kvm_vcpu_get_hsr(vcpu));
-			BUG();
-		}
-
-		/*
-		 * See ARM ARM B1.14.1: "Hyp traps on instructions
-		 * that fail their condition code check"
-		 */
-		if (!kvm_condition_valid(vcpu)) {
-			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-			return 1;
-		}
-
-		return arm_exit_handlers[hsr_ec](vcpu, run);
-	default:
-		kvm_pr_unimpl("Unsupported exception type: %d",
-			      exception_index);
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		return 0;
-	}
-}
-
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 {
 	if (likely(vcpu->arch.has_run_once))
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
new file mode 100644
index 0000000..f1cc3a8
--- /dev/null
+++ b/arch/arm/kvm/handle_exit.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
+#include <asm/kvm_mmu.h>
+#include <asm/kvm_psci.h>
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
+
+static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* SVC called from Hyp mode should never get here */
+	kvm_debug("SVC called from Hyp mode shouldn't go here\n");
+	BUG();
+	return -EINVAL; /* Squash warning */
+}
+
+static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	if (kvm_psci_call(vcpu))
+		return 1;
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	if (kvm_psci_call(vcpu))
+		return 1;
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static int handle_pabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* The hypervisor should never cause aborts */
+	kvm_err("Prefetch Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
+		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
+	return -EFAULT;
+}
+
+static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* This is either an error in the ws. code or an external abort */
+	kvm_err("Data Abort taken from Hyp mode at %#08lx (HSR: %#08x)\n",
+		kvm_vcpu_get_hfar(vcpu), kvm_vcpu_get_hsr(vcpu));
+	return -EFAULT;
+}
+
+static exit_handle_fn arm_exit_handlers[] = {
+	[HSR_EC_WFI]		= kvm_handle_wfi,
+	[HSR_EC_CP15_32]	= kvm_handle_cp15_32,
+	[HSR_EC_CP15_64]	= kvm_handle_cp15_64,
+	[HSR_EC_CP14_MR]	= kvm_handle_cp14_access,
+	[HSR_EC_CP14_LS]	= kvm_handle_cp14_load_store,
+	[HSR_EC_CP14_64]	= kvm_handle_cp14_access,
+	[HSR_EC_CP_0_13]	= kvm_handle_cp_0_13_access,
+	[HSR_EC_CP10_ID]	= kvm_handle_cp10_id,
+	[HSR_EC_SVC_HYP]	= handle_svc_hyp,
+	[HSR_EC_HVC]		= handle_hvc,
+	[HSR_EC_SMC]		= handle_smc,
+	[HSR_EC_IABT]		= kvm_handle_guest_abort,
+	[HSR_EC_IABT_HYP]	= handle_pabt_hyp,
+	[HSR_EC_DABT]		= kvm_handle_guest_abort,
+	[HSR_EC_DABT_HYP]	= handle_dabt_hyp,
+};
+
+static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
+{
+	u8 hsr_ec = kvm_vcpu_trap_get_class(vcpu);
+
+	if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers) ||
+	    !arm_exit_handlers[hsr_ec]) {
+		kvm_err("Unkown exception class: hsr: %#08x\n",
+			(unsigned int)kvm_vcpu_get_hsr(vcpu));
+		BUG();
+	}
+
+	return arm_exit_handlers[hsr_ec];
+}
+
+/*
+ * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
+ * proper exit to userspace.
+ */
+int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		       int exception_index)
+{
+	exit_handle_fn exit_handler;
+
+	switch (exception_index) {
+	case ARM_EXCEPTION_IRQ:
+		return 1;
+	case ARM_EXCEPTION_UNDEFINED:
+		kvm_err("Undefined exception in Hyp mode at: %#08lx\n",
+			kvm_vcpu_get_hyp_pc(vcpu));
+		BUG();
+		panic("KVM: Hypervisor undefined exception!\n");
+	case ARM_EXCEPTION_DATA_ABORT:
+	case ARM_EXCEPTION_PREF_ABORT:
+	case ARM_EXCEPTION_HVC:
+		/*
+		 * See ARM ARM B1.14.1: "Hyp traps on instructions
+		 * that fail their condition code check"
+		 */
+		if (!kvm_condition_valid(vcpu)) {
+			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+			return 1;
+		}
+
+		exit_handler = kvm_get_exit_handler(vcpu);
+
+		return exit_handler(vcpu, run);
+	default:
+		kvm_pr_unimpl("Unsupported exception type: %d",
+			      exception_index);
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return 0;
+	}
+}
-- 
1.7.12.4
