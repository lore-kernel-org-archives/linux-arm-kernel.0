From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:43:22 +0000
Subject: [PATCH 28/29] ARM: KVM: change kvm_tlb_flush_vmid to
 kvm_tlb_flush_vmid_ipa
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362451403-23460-29-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v8 is capable of invalidating Stage-2 by IPA, but v7 is not.
Change kvm_tlb_flush_vmid() to take an IPA parameter, which is
then ignored by the invalidation code (and nuke the whole TLB
as it always did).

This allows v8 to implement a more optimized strategy.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h | 2 +-
 arch/arm/kvm/interrupts.S      | 9 ++++++---
 arch/arm/kvm/mmu.c             | 8 ++++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index e4956f4..18d5032 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -75,7 +75,7 @@ extern char __kvm_hyp_code_end[];
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 
 extern void __kvm_flush_vm_context(void);
-extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
+extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 #endif
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 8ca87ab..941aabc 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -35,15 +35,18 @@ __kvm_hyp_code_start:
 /********************************************************************
  * Flush per-VMID TLBs
  *
- * void __kvm_tlb_flush_vmid(struct kvm *kvm);
+ * void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
  *
  * We rely on the hardware to broadcast the TLB invalidation to all CPUs
  * inside the inner-shareable domain (which is the case for all v7
  * implementations).  If we come across a non-IS SMP implementation, we'll
  * have to use an IPI based mechanism. Until then, we stick to the simple
  * hardware assisted version.
+ *
+ * As v7 does not support flushing per IPA, just nuke the whole TLB
+ * instead, ignoring the ipa value.
  */
-ENTRY(__kvm_tlb_flush_vmid)
+ENTRY(__kvm_tlb_flush_vmid_ipa)
 	push	{r2, r3}
 
 	add	r0, r0, #KVM_VTTBR
@@ -60,7 +63,7 @@ ENTRY(__kvm_tlb_flush_vmid)
 
 	pop	{r2, r3}
 	bx	lr
-ENDPROC(__kvm_tlb_flush_vmid)
+ENDPROC(__kvm_tlb_flush_vmid_ipa)
 
 /********************************************************************
  * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index b694f58..2f12e40 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -34,9 +34,9 @@ extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
-static void kvm_tlb_flush_vmid(struct kvm *kvm)
+static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	kvm_call_hyp(__kvm_tlb_flush_vmid, kvm);
+	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
 static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
@@ -457,7 +457,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	old_pte = *pte;
 	kvm_set_pte(pte, *new_pte);
 	if (pte_present(old_pte))
-		kvm_tlb_flush_vmid(kvm);
+		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	else
 		get_page(virt_to_page(pte));
 
@@ -674,7 +674,7 @@ static void handle_hva_to_gpa(struct kvm *kvm,
 static void kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, void *data)
 {
 	unmap_stage2_range(kvm, gpa, PAGE_SIZE);
-	kvm_tlb_flush_vmid(kvm);
+	kvm_tlb_flush_vmid_ipa(kvm, gpa);
 }
 
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
-- 
1.7.12.4
