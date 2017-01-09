From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:45 -0500
Subject: [RFC 49/55] KVM: arm64: Fixes to toggle_cache for nesting
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-50-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

So far we were flushing almost the entire universe whenever a VM would
load/unload the SCTLR_EL1 and the two versions of that register had
different MMU enabled settings.  This turned out to be so slow that it
prevented forward progress for a nested VM, because a scheduler timer
tick interrupt would always be pending when we reached the nested VM.

To avoid this problem, we consider the SCTLR_EL2 when evaluating if
caches are on or off when entering virtual EL2 (because this is the
value that we end up shadowing onto the hardware EL1 register).

We also reduce the scope of the flush operation to only flush shadow
stage 2 page table state of the particular VCPU toggling the caches
instead of the shadow stage 2 state of all possible VCPUs.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm/kvm/mmu.c               | 31 ++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/kvm_mmu.h |  7 ++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 68fc8e8..344bc01 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -422,6 +422,35 @@ static void stage2_flush_vm(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
+/**
+ * Same as above but only flushed shadow state for specific vcpu
+ */
+static void stage2_flush_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int idx;
+	struct kvm_nested_s2_mmu __maybe_unused *nested_mmu;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	spin_lock(&kvm->mmu_lock);
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots)
+		stage2_flush_memslot(&kvm->arch.mmu, memslot);
+
+#ifdef CONFIG_KVM_ARM_NESTED_HYP
+	list_for_each_entry_rcu(nested_mmu, &vcpu->kvm->arch.nested_mmu_list,
+				list) {
+		kvm_stage2_flush_range(&nested_mmu->mmu, 0, KVM_PHYS_SIZE);
+	}
+#endif
+
+	spin_unlock(&kvm->mmu_lock);
+	srcu_read_unlock(&kvm->srcu, idx);
+}
+
 static void clear_hyp_pgd_entry(pgd_t *pgd)
 {
 	pud_t *pud_table __maybe_unused = pud_offset(pgd, 0UL);
@@ -2074,7 +2103,7 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 	 * Clean + invalidate does the trick always.
 	 */
 	if (now_enabled != was_enabled)
-		stage2_flush_vm(vcpu->kvm);
+		stage2_flush_vcpu(vcpu);
 
 	/* Caches are now on, stop trapping VM ops (until a S/W op) */
 	if (now_enabled)
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 2086296..7754f3e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -241,7 +241,12 @@ static inline bool kvm_page_empty(void *ptr)
 
 static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
+	u32 mode = vcpu->arch.ctxt.gp_regs.regs.pstate & PSR_MODE_MASK;
+
+	if (mode != PSR_MODE_EL2h && mode != PSR_MODE_EL2t)
+		return (vcpu_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
+	else
+		return (vcpu_el2_reg(vcpu, SCTLR_EL2) & 0b101) == 0b101;
 }
 
 static inline void __coherent_cache_guest_page(struct kvm_vcpu *vcpu,
-- 
1.9.1
