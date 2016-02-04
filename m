From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Feb 2016 11:00:40 +0000
Subject: [PATCH v2 23/28] ARM: KVM: Remove __weak attributes
In-Reply-To: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454583645-10144-24-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the old code is long gone, we can remove all the weak
attributes, as there is only one version of the code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/hyp/hyp-entry.S | 4 +---
 arch/arm/kvm/hyp/switch.c    | 2 +-
 arch/arm/kvm/hyp/tlb.c       | 6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index ca412ad..e2a45b8 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -58,10 +58,8 @@
  */
 
 	.align 5
-__hyp_vector:
-	.global	__hyp_vector
 __kvm_hyp_vector:
-	.weak __kvm_hyp_vector
+	.global __kvm_hyp_vector
 
 	@ Hyp-mode exception vector
 	W(b)	hyp_reset
diff --git a/arch/arm/kvm/hyp/switch.c b/arch/arm/kvm/hyp/switch.c
index 67f3944..7325ad3 100644
--- a/arch/arm/kvm/hyp/switch.c
+++ b/arch/arm/kvm/hyp/switch.c
@@ -187,7 +187,7 @@ again:
 	return exit_code;
 }
 
-__alias(__guest_run) int __weak __kvm_vcpu_run(struct kvm_vcpu *vcpu);
+__alias(__guest_run) int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
 static const char * const __hyp_panic_string[] = {
 	[ARM_EXCEPTION_RESET]      = "\nHYP panic: RST?? PC:%08x CPSR:%08x",
diff --git a/arch/arm/kvm/hyp/tlb.c b/arch/arm/kvm/hyp/tlb.c
index 993fe89..3854e31 100644
--- a/arch/arm/kvm/hyp/tlb.c
+++ b/arch/arm/kvm/hyp/tlb.c
@@ -50,14 +50,14 @@ static void __hyp_text __tlb_flush_vmid(struct kvm *kvm)
 	write_sysreg(0, VTTBR);
 }
 
-__alias(__tlb_flush_vmid) void __weak __kvm_tlb_flush_vmid(struct kvm *kvm);
+__alias(__tlb_flush_vmid) void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 static void __hyp_text __tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
 	__tlb_flush_vmid(kvm);
 }
 
-__alias(__tlb_flush_vmid_ipa) void __weak __kvm_tlb_flush_vmid_ipa(struct kvm *kvm,
+__alias(__tlb_flush_vmid_ipa) void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm,
 							    phys_addr_t ipa);
 
 static void __hyp_text __tlb_flush_vm_context(void)
@@ -68,4 +68,4 @@ static void __hyp_text __tlb_flush_vm_context(void)
 	dsb(ish);
 }
 
-__alias(__tlb_flush_vm_context) void __weak __kvm_flush_vm_context(void);
+__alias(__tlb_flush_vm_context) void __kvm_flush_vm_context(void);
-- 
2.1.4
