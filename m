From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:10 +0000
Subject: [PATCH 16/29] ARM: KVM: move kvm_handle_wfi to handle_exit.c
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has little to do in emulate.c these days...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_emulate.h |  1 -
 arch/arm/kvm/emulate.c             | 16 ----------------
 arch/arm/kvm/handle_exit.c         | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 88c43df..3965dc5 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -27,7 +27,6 @@
 unsigned long *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu);
 
-int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
 bool kvm_condition_valid(struct kvm_vcpu *vcpu);
 void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 04dbac6..bdede9e 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -161,22 +161,6 @@ unsigned long *vcpu_spsr(struct kvm_vcpu *vcpu)
 	}
 }
 
-/**
- * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
- * @vcpu:	the vcpu pointer
- * @run:	the kvm_run structure pointer
- *
- * Simply sets the wait_for_interrupts flag on the vcpu structure, which will
- * halt execution of world-switches and schedule other host processes until
- * there is an incoming IRQ or FIQ to the VM.
- */
-int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
-{
-	trace_kvm_wfi(*vcpu_pc(vcpu));
-	kvm_vcpu_block(vcpu);
-	return 1;
-}
-
 /*
  * A conditional instruction is allowed to trap, even though it
  * wouldn't be executed.  So let's re-implement the hardware, in
diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index f1cc3a8..c750398 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -22,6 +22,9 @@
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
+#include <trace/events/kvm.h>
+
+#include "trace.h"
 
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
@@ -67,6 +70,22 @@ static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return -EFAULT;
 }
 
+/**
+ * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
+ * @vcpu:	the vcpu pointer
+ * @run:	the kvm_run structure pointer
+ *
+ * Simply sets the wait_for_interrupts flag on the vcpu structure, which will
+ * halt execution of world-switches and schedule other host processes until
+ * there is an incoming IRQ or FIQ to the VM.
+ */
+static int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	trace_kvm_wfi(*vcpu_pc(vcpu));
+	kvm_vcpu_block(vcpu);
+	return 1;
+}
+
 static exit_handle_fn arm_exit_handlers[] = {
 	[HSR_EC_WFI]		= kvm_handle_wfi,
 	[HSR_EC_CP15_32]	= kvm_handle_cp15_32,
-- 
1.7.12.4
