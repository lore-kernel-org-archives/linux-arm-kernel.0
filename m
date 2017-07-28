From: james.morse@arm.com (James Morse)
Date: Fri, 28 Jul 2017 15:10:17 +0100
Subject: [PATCH v2 14/16] KVM: arm64: Take pending SErrors on entry to the
 guest
In-Reply-To: <20170728141019.9084-1-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
Message-ID: <20170728141019.9084-15-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SErrors due to RAS are either taken as an SError, or deferred because
of an Error Synchronization Barrier (ESB). Systems that support the RAS
extensions are very likely to have firmware-first handling of these
errors, taking all SErrors to EL3.

Add {I,}ESB support to KVM and be prepared to handle any resulting SError
if we are notified directly. (i.e. no firmware-first handling). Do this
for the cases where we can take the SError instead of deferring it.

With VHE KVM is covered by the host's setting of SCTLR_EL1.IESB: unmask
SError when entering a guest. This will hyp-panic if there was an SError
pending during world switch (and we don't have firmware first). Make
sure this only happens when its KVM's 'fault' by adding an ESB to
__kvm_call_hyp().

On systems without the RAS extensions a pending SError triggered by KVM's
world switch will no longer be blamed on the guest, causing a panic
instead.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h |  1 +
 arch/arm64/kvm/hyp.S               |  1 +
 arch/arm64/kvm/hyp/entry.S         | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e2bb551f59f7..e440fba6d0fe 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -29,6 +29,7 @@
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 #include <asm/thread_info.h>
 
 	.macro save_and_disable_daif, flags
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 952f6cb9cf72..e96a5f6afecd 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -40,6 +40,7 @@
  * arch/arm64/kernel/hyp_stub.S.
  */
 ENTRY(__kvm_call_hyp)
+	esb
 alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
 	hvc	#0
 	ret
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 12ee62d6d410..cec18df5a324 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -49,6 +49,21 @@
 	ldp	x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
 .endm
 
+/* We have an implicit esb if we have VHE and IESB. */
+.macro kvm_explicit_esb
+	alternative_if_not ARM64_HAS_RAS_EXTN
+	b	998f
+	alternative_else_nop_endif
+	alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	esb
+	b	998f
+	alternative_else_nop_endif
+	alternative_if_not ARM64_HAS_IESB
+	esb
+	alternative_else_nop_endif
+998:
+.endm
+
 /*
  * u64 __guest_enter(struct kvm_vcpu *vcpu,
  *		     struct kvm_cpu_context *host_ctxt);
@@ -85,6 +100,9 @@ ENTRY(__guest_enter)
 	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
 
 	// Do not touch any register after this!
+
+	enable_serror		// Don't defer an IESB SError
+	kvm_explicit_esb
 	eret
 ENDPROC(__guest_enter)
 
-- 
2.13.2
