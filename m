From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Feb 2016 18:00:06 +0000
Subject: [PATCH v3 13/23] arm64: KVM: VHE: Enable minimal sysreg save/restore
In-Reply-To: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454522416-6874-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're now in a position where we can introduce VHE's minimal
save/restore, which is limited to the handful of shared sysregs.

Add the required alternative function calls that result in a
"do nothing" call on VHE, and the normal save/restore for non-VHE.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/sysreg-sr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 7d7d757..74b5f81 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -23,6 +23,9 @@
 
 #include "hyp.h"
 
+/* Yes, this does nothing, on purpose */
+static void __hyp_text __sysreg_do_nothing(struct kvm_cpu_context *ctxt) { }
+
 /*
  * Non-VHE: Both host and guest must save everything.
  *
@@ -67,9 +70,13 @@ static void __hyp_text __sysreg_save_state(struct kvm_cpu_context *ctxt)
 	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(spsr);
 }
 
+static hyp_alternate_select(__sysreg_call_save_host_state,
+			    __sysreg_save_state, __sysreg_do_nothing,
+			    ARM64_HAS_VIRT_HOST_EXTN);
+
 void __hyp_text __sysreg_save_host_state(struct kvm_cpu_context *ctxt)
 {
-	__sysreg_save_state(ctxt);
+	__sysreg_call_save_host_state()(ctxt);
 	__sysreg_save_common_state(ctxt);
 }
 
@@ -116,9 +123,13 @@ static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],spsr);
 }
 
+static hyp_alternate_select(__sysreg_call_restore_host_state,
+			    __sysreg_restore_state, __sysreg_do_nothing,
+			    ARM64_HAS_VIRT_HOST_EXTN);
+
 void __hyp_text __sysreg_restore_host_state(struct kvm_cpu_context *ctxt)
 {
-	__sysreg_restore_state(ctxt);
+	__sysreg_call_restore_host_state()(ctxt);
 	__sysreg_restore_common_state(ctxt);
 }
 
-- 
2.1.4
