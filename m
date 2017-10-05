From: james.morse@arm.com (James Morse)
Date: Thu,  5 Oct 2017 20:18:10 +0100
Subject: [PATCH v3 18/20] KVM: arm64: Handle RAS SErrors from EL1 on guest exit
In-Reply-To: <20171005191812.5678-1-james.morse@arm.com>
References: <20171005191812.5678-1-james.morse@arm.com>
Message-ID: <20171005191812.5678-19-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We expect to have firmware-first handling of RAS SErrors, with errors
notified via an APEI method. For systems without firmware-first, add
some minimal handling to KVM.

There are two ways KVM can take an SError due to a guest, either may be a
RAS error: we exit the guest due to an SError routed to EL2 by HCR_EL2.AMO,
or we take an SError from EL2 when we unmask PSTATE.A from __guest_exit.

For SError that interrupt a guest and are routed to EL2 the existing
behaviour is to inject an impdef SError into the guest.

Add code to handle RAS SError based on the ESR. For uncontained errors
arm64_is_blocking_ras_serror() will panic(), these errors compromise
the host too. All other error types are contained: For the 'blocking'
errors the vCPU can't make progress, so we inject a virtual SError.
We ignore contained errors where we can make progress as if we're lucky,
we may not hit them again.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kvm/handle_exit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 7debb74843a0..345fdbba6c2e 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -28,12 +28,19 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
+#include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
 typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
 
+static void kvm_handle_guest_serror(struct kvm_vcpu *vcpu, u32 esr)
+{
+	if (!arm64_is_ras_serror(esr) || arm64_blocking_ras_serror(NULL, esr))
+		kvm_inject_vabt(vcpu);
+}
+
 static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int ret;
@@ -211,7 +218,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case ARM_EXCEPTION_IRQ:
 		return 1;
 	case ARM_EXCEPTION_EL1_SERROR:
-		kvm_inject_vabt(vcpu);
+		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_hsr(vcpu));
 		return 1;
 	case ARM_EXCEPTION_TRAP:
 		/*
-- 
2.13.3
