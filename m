From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 10 Jan 2017 11:38:48 +0000
Subject: [PATCH v3 1/9] arm64/kvm: hyp: tlb: use __tlbi() helper
In-Reply-To: <20170110113856.7183-1-punit.agrawal@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
Message-ID: <20170110113856.7183-2-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we have a __tlbi() helper, make use of this in the arm64 KVM hyp
code to get rid of asm() boilerplate. At the same time, we simplify
__tlb_flush_vm_context by using __flush_icache_all(), as this has the
appropriate instruction cache maintenance and barrier.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
[ rename tlbi -> __tlbi, convert additional sites, update commit log ]
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/tlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 88e2f2b938f0..b2cfbedea582 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -16,6 +16,7 @@
  */
 
 #include <asm/kvm_hyp.h>
+#include <asm/tlbflush.h>
 
 void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
@@ -32,7 +33,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	 * whole of Stage-1. Weep...
 	 */
 	ipa >>= 12;
-	asm volatile("tlbi ipas2e1is, %0" : : "r" (ipa));
+	__tlbi(ipas2e1is, ipa);
 
 	/*
 	 * We have to ensure completion of the invalidation at Stage-2,
@@ -41,7 +42,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	 * the Stage-1 invalidation happened first.
 	 */
 	dsb(ish);
-	asm volatile("tlbi vmalle1is" : : );
+	__tlbi(vmalle1is);
 	dsb(ish);
 	isb();
 
@@ -57,7 +58,7 @@ void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
 	isb();
 
-	asm volatile("tlbi vmalls12e1is" : : );
+	__tlbi(vmalls12e1is);
 	dsb(ish);
 	isb();
 
@@ -82,7 +83,6 @@ void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 void __hyp_text __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
-	asm volatile("tlbi alle1is	\n"
-		     "ic ialluis	  ": : );
-	dsb(ish);
+	__tlbi(alle1is);
+	__flush_icache_all(); /* contains a dsb(ish) */
 }
-- 
2.11.0
