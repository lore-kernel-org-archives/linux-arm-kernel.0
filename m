From: Dave.Martin@arm.com (Dave P Martin)
Date: Wed,  1 May 2013 17:49:28 +0100
Subject: [PATCH] ARM: KVM: Don't handle PSCI calls via SMC
Message-ID: <1367426968-5577-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, kvmtool unconditionally declares that HVC should be used
to call PSCI, so the function numbers in the DT tell the guest
nothing about the function ID namespace or calling convention for
SMC.

We already assume that the guest will examine and honour the DT,
since there is no way it could possibly guess the KVM-specific PSCI
function IDs otherwise.  So let's not encourage guests to violate
what's specified in the DT by using SMC to make the call.

Signed-off-by: Dave P Martin <Dave.Martin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c  |    3 ---
 arch/arm/kvm/psci.c |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5a93698..32a3495 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -503,9 +503,6 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_psci_call(vcpu))
-		return 1;
-
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 7ee5bb7..86a693a 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -75,7 +75,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
  * kvm_psci_call - handle PSCI call if r0 value is in range
  * @vcpu: Pointer to the VCPU struct
  *
- * Handle PSCI calls from guests through traps from HVC or SMC instructions.
+ * Handle PSCI calls from guests through traps from HVC instructions.
  * The calling convention is similar to SMC calls to the secure world where
  * the function number is placed in r0 and this function returns true if the
  * function number specified in r0 is withing the PSCI range, and false
-- 
1.7.9.5
