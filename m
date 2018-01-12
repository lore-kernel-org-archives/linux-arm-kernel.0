From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 12 Jan 2018 13:07:24 +0100
Subject: [PATCH v3 18/41] KVM: arm64: Move userspace system registers into
 separate function
In-Reply-To: <20180112120747.27999-1-christoffer.dall@linaro.org>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
Message-ID: <20180112120747.27999-19-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a semantic difference between the EL1 registers that control
operation of a kernel running in EL1 and EL1 registers that only control
userspace execution in EL0.  Since we can defer saving/restoring the
latter, move them into their own function.

We also take this chance to rename the function saving/restoring the
remaining system register to make it clear this function deals with
the EL1 system registers.

No functional change.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/sysreg-sr.c | 46 +++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 848a46eb33bf..99dd50ce483b 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -34,18 +34,27 @@ static void __hyp_text __sysreg_do_nothing(struct kvm_cpu_context *ctxt) { }
 
 static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 {
-	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
-	ctxt->sys_regs[TPIDR_EL0]	= read_sysreg(tpidr_el0);
-	ctxt->sys_regs[TPIDRRO_EL0]	= read_sysreg(tpidrro_el0);
 	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
+
+	/*
+	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
+	 * therefore be saved/restored on every entry/exit to/from the guest.
+	 */
 	ctxt->gp_regs.regs.sp		= read_sysreg(sp_el0);
 }
 
-static void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
+static void __hyp_text __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt->sys_regs[TPIDR_EL0]	= read_sysreg(tpidr_el0);
+	ctxt->sys_regs[TPIDRRO_EL0]	= read_sysreg(tpidrro_el0);
+}
+
+static void __hyp_text __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt->sys_regs[MPIDR_EL1]	= read_sysreg(vmpidr_el2);
 	ctxt->sys_regs[CSSELR_EL1]	= read_sysreg(csselr_el1);
 	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(sctlr);
+	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
 	ctxt->sys_regs[CPACR_EL1]	= read_sysreg_el1(cpacr);
 	ctxt->sys_regs[TTBR0_EL1]	= read_sysreg_el1(ttbr0);
 	ctxt->sys_regs[TTBR1_EL1]	= read_sysreg_el1(ttbr1);
@@ -70,35 +79,46 @@ static void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 }
 
 static hyp_alternate_select(__sysreg_call_save_host_state,
-			    __sysreg_save_state, __sysreg_do_nothing,
+			    __sysreg_save_el1_state, __sysreg_do_nothing,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
 void __hyp_text __sysreg_save_host_state(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_call_save_host_state()(ctxt);
 	__sysreg_save_common_state(ctxt);
+	__sysreg_save_user_state(ctxt);
 }
 
 void __hyp_text __sysreg_save_guest_state(struct kvm_cpu_context *ctxt)
 {
-	__sysreg_save_state(ctxt);
+	__sysreg_save_el1_state(ctxt);
 	__sysreg_save_common_state(ctxt);
+	__sysreg_save_user_state(ctxt);
 }
 
 static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
-	write_sysreg(ctxt->sys_regs[ACTLR_EL1],	  actlr_el1);
-	write_sysreg(ctxt->sys_regs[TPIDR_EL0],	  tpidr_el0);
-	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0], tpidrro_el0);
 	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
+
+	/*
+	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
+	 * therefore be saved/restored on every entry/exit to/from the guest.
+	 */
 	write_sysreg(ctxt->gp_regs.regs.sp,	  sp_el0);
 }
 
-static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
+static void __hyp_text __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
+{
+	write_sysreg(ctxt->sys_regs[TPIDR_EL0],	  	tpidr_el0);
+	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0], 	tpidrro_el0);
+}
+
+static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
 	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
 	write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	sctlr);
+	write_sysreg(ctxt->sys_regs[ACTLR_EL1],	  	actlr_el1);
 	write_sysreg_el1(ctxt->sys_regs[CPACR_EL1],	cpacr);
 	write_sysreg_el1(ctxt->sys_regs[TTBR0_EL1],	ttbr0);
 	write_sysreg_el1(ctxt->sys_regs[TTBR1_EL1],	ttbr1);
@@ -123,19 +143,21 @@ static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 }
 
 static hyp_alternate_select(__sysreg_call_restore_host_state,
-			    __sysreg_restore_state, __sysreg_do_nothing,
+			    __sysreg_restore_el1_state, __sysreg_do_nothing,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
 void __hyp_text __sysreg_restore_host_state(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_call_restore_host_state()(ctxt);
 	__sysreg_restore_common_state(ctxt);
+	__sysreg_restore_user_state(ctxt);
 }
 
 void __hyp_text __sysreg_restore_guest_state(struct kvm_cpu_context *ctxt)
 {
-	__sysreg_restore_state(ctxt);
+	__sysreg_restore_el1_state(ctxt);
 	__sysreg_restore_common_state(ctxt);
+	__sysreg_restore_user_state(ctxt);
 }
 
 static void __hyp_text __fpsimd32_save_state(struct kvm_cpu_context *ctxt)
-- 
2.14.2
