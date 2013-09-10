From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Sep 2013 10:51:10 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2 page fault
Message-ID: <1378806670-2467-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Anup Patel recently brought up the fact that when we run a guest
with cache disabled, we don't flush the cache to the Point of
Coherency, hence possibly missing bits of data that have been
written in the cache, but have not reached memory.

There are several approaches to this issue:
- Using the DC bit when caches are off: this breaks guests assuming
  caches off while doing DMA operations. Bootloaders, for example.
- Fetch the memory attributes on translation fault, and flush the
  cache while handling the fault. This relies on using the PAR_EL1
  register to obtain the Stage-1 memory attributes.

While this second solution is clearly not ideal (it duplicates what
the HW already does to generate HPFAR_EL2), it is more correct than
not doing anything.

Cc: Anup Patel <anup@brainfault.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---

 arch/arm/include/asm/kvm_mmu.h    |  4 ++--
 arch/arm/kvm/mmu.c                |  2 +-
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/include/asm/kvm_mmu.h  |  9 +++++++--
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kvm/hyp.S              | 28 ++++++++++++----------------
 6 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 472ac70..faffdf0 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -105,7 +105,7 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	/*
 	 * If we are going to insert an instruction page and the icache is
@@ -120,7 +120,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
 	 * need any kind of flushing (DDI 0406C.b - Page B3-1392).
 	 */
 	if (icache_is_pipt()) {
-		unsigned long hva = gfn_to_hva(kvm, gfn);
+		unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
 		__cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
 	} else if (!icache_is_vivt_asid_tagged()) {
 		/* any kind of VIPT cache */
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 0988d9e..ffb3cc4 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -547,7 +547,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 
 	new_pte = pfn_pte(pfn, PAGE_S2);
-	coherent_icache_guest_page(vcpu->kvm, gfn);
+	coherent_icache_guest_page(vcpu, gfn);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq))
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 331a852..2530f92 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -79,6 +79,7 @@ struct kvm_mmu_memory_cache {
 struct kvm_vcpu_fault_info {
 	u32 esr_el2;		/* Hyp Syndrom Register */
 	u64 far_el2;		/* Hyp Fault Address Register */
+	u64 par_el2;		/* Result of FAR_EL2 translation */
 	u64 hpfar_el2;		/* Hyp IPA Fault Address Register */
 };
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index efe609c..84baddd 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -118,11 +118,16 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	if (!icache_is_aliasing()) {		/* PIPT */
-		unsigned long hva = gfn_to_hva(kvm, gfn);
+		unsigned long hva = gfn_to_hva(vcpu->kvm, gfn);
+		u8 attr;
 		flush_icache_range(hva, hva + PAGE_SIZE);
+		attr = vcpu->arch.fault.par_el2 >> 56;
+		/* Check for non-device, non-cacheable access */
+		if ((attr & 0xf0) && (attr & 0x0f) == 4)
+			__flush_dcache_area((void *)hva, PAGE_SIZE);
 	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
 		/* any kind of VIPT cache */
 		__flush_icache_all();
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1f3a39d..e67dcac 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -117,6 +117,7 @@ int main(void)
   DEFINE(CPU_SYSREGS,		offsetof(struct kvm_cpu_context, sys_regs));
   DEFINE(VCPU_ESR_EL2,		offsetof(struct kvm_vcpu, arch.fault.esr_el2));
   DEFINE(VCPU_FAR_EL2,		offsetof(struct kvm_vcpu, arch.fault.far_el2));
+  DEFINE(VCPU_PAR_EL2,		offsetof(struct kvm_vcpu, arch.fault.par_el2));
   DEFINE(VCPU_HPFAR_EL2,	offsetof(struct kvm_vcpu, arch.fault.hpfar_el2));
   DEFINE(VCPU_HCR_EL2,		offsetof(struct kvm_vcpu, arch.hcr_el2));
   DEFINE(VCPU_IRQ_LINES,	offsetof(struct kvm_vcpu, arch.irq_lines));
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 20a58fe..417636b 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -671,24 +671,16 @@ el1_trap:
 	ccmp	x2, x0, #4, ne
 	b.ne	1f		// Not an abort we care about
 
-	/* This is an abort. Check for permission fault */
-	and	x2, x1, #ESR_EL2_FSC_TYPE
-	cmp	x2, #FSC_PERM
-	b.ne	1f		// Not a permission fault
-
-	/*
-	 * Check for Stage-1 page table walk, which is guaranteed
-	 * to give a valid HPFAR_EL2.
-	 */
-	tbnz	x1, #7, 1f	// S1PTW is set
-
 	/* Preserve PAR_EL1 */
 	mrs	x3, par_el1
 	push	x3, xzr
 
 	/*
-	 * Permission fault, HPFAR_EL2 is invalid.
-	 * Resolve the IPA the hard way using the guest VA.
+	 * Two cases:
+	 * - S2 translation fault, we need the memory attributes.
+	 * - S2 permission fault, HPFAR_EL2 is invalid.
+	 *
+	 * In both cases, resolve the IPA the hard way using the guest VA.
 	 * Stage-1 translation already validated the memory access rights.
 	 * As such, we can use the EL1 translation regime, and don't have
 	 * to distinguish between EL0 and EL1 access.
@@ -702,15 +694,19 @@ el1_trap:
 	pop	x0, xzr			// Restore PAR_EL1 from the stack
 	msr	par_el1, x0
 	tbnz	x3, #0, 3f		// Bail out if we failed the translation
+
+	mrs	x0, tpidr_el2
+	str	x3, [x0, #VCPU_PAR_EL2]
 	ubfx	x3, x3, #12, #36	// Extract IPA
 	lsl	x3, x3, #4		// and present it like HPFAR
+
 	b	2f
 
-1:	mrs	x3, hpfar_el2
+1:	mrs	x0, tpidr_el2
 	mrs	x2, far_el2
+	mrs	x3, hpfar_el2
 
-2:	mrs	x0, tpidr_el2
-	str	x1, [x0, #VCPU_ESR_EL2]
+2:	str	x1, [x0, #VCPU_ESR_EL2]
 	str	x2, [x0, #VCPU_FAR_EL2]
 	str	x3, [x0, #VCPU_HPFAR_EL2]
 
-- 
1.8.2.3
