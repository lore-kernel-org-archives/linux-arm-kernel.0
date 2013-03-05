From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:08 +0000
Subject: [PATCH 14/29] ARM: KVM: move kvm_condition_valid to emulate.c
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is really hardware emulation, and as such it better be with
its little friends.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h |  1 +
 arch/arm/kvm/arm.c                 | 45 --------------------------------------
 arch/arm/kvm/emulate.c             | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 2f5cc48..88c43df 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -28,6 +28,7 @@ unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
 
 int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
+bool kvm_condition_valid(struct kvm_vcpu *vcpu);
 void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 4e83d57..93aaba6 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,7 +44,6 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_psci.h>
-#include <asm/opcodes.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -546,50 +545,6 @@ static exit_handle_fn arm_exit_handlers[] = {
 };
 
 /*
- * A conditional instruction is allowed to trap, even though it
- * wouldn't be executed.  So let's re-implement the hardware, in
- * software!
- */
-static bool kvm_condition_valid(struct kvm_vcpu *vcpu)
-{
-	unsigned long cpsr, cond, insn;
-
-	/*
-	 * Exception Code 0 can only happen if we set HCR.TGE to 1, to
-	 * catch undefined instructions, and then we won't get past
-	 * the arm_exit_handlers test anyway.
-	 */
-	BUG_ON(!kvm_vcpu_trap_get_class(vcpu));
-
-	/* Top two bits non-zero?  Unconditional. */
-	if (kvm_vcpu_get_hsr(vcpu) >> 30)
-		return true;
-
-	cpsr = *vcpu_cpsr(vcpu);
-
-	/* Is condition field valid? */
-	if ((kvm_vcpu_get_hsr(vcpu) & HSR_CV) >> HSR_CV_SHIFT)
-		cond = (kvm_vcpu_get_hsr(vcpu) & HSR_COND) >> HSR_COND_SHIFT;
-	else {
-		/* This can happen in Thumb mode: examine IT state. */
-		unsigned long it;
-
-		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
-
-		/* it == 0 => unconditional. */
-		if (it == 0)
-			return true;
-
-		/* The cond for this insn works out as the top 4 bits. */
-		cond = (it >> 4);
-	}
-
-	/* Shift makes it look like an ARM-mode instruction */
-	insn = cond << 28;
-	return arm_check_condition(insn, cpsr) != ARM_OPCODE_CONDTEST_FAIL;
-}
-
-/*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to QEMU.
  */
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index d3094eb..04dbac6 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -20,6 +20,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/opcodes.h>
 #include <trace/events/kvm.h>
 
 #include "trace.h"
@@ -176,6 +177,50 @@ int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+/*
+ * A conditional instruction is allowed to trap, even though it
+ * wouldn't be executed.  So let's re-implement the hardware, in
+ * software!
+ */
+bool kvm_condition_valid(struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr, cond, insn;
+
+	/*
+	 * Exception Code 0 can only happen if we set HCR.TGE to 1, to
+	 * catch undefined instructions, and then we won't get past
+	 * the arm_exit_handlers test anyway.
+	 */
+	BUG_ON(!kvm_vcpu_trap_get_class(vcpu));
+
+	/* Top two bits non-zero?  Unconditional. */
+	if (kvm_vcpu_get_hsr(vcpu) >> 30)
+		return true;
+
+	cpsr = *vcpu_cpsr(vcpu);
+
+	/* Is condition field valid? */
+	if ((kvm_vcpu_get_hsr(vcpu) & HSR_CV) >> HSR_CV_SHIFT)
+		cond = (kvm_vcpu_get_hsr(vcpu) & HSR_COND) >> HSR_COND_SHIFT;
+	else {
+		/* This can happen in Thumb mode: examine IT state. */
+		unsigned long it;
+
+		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
+
+		/* it == 0 => unconditional. */
+		if (it == 0)
+			return true;
+
+		/* The cond for this insn works out as the top 4 bits. */
+		cond = (it >> 4);
+	}
+
+	/* Shift makes it look like an ARM-mode instruction */
+	insn = cond << 28;
+	return arm_check_condition(insn, cpsr) != ARM_OPCODE_CONDTEST_FAIL;
+}
+
 /**
  * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
  * @vcpu:	The VCPU pointer
-- 
1.7.12.4
