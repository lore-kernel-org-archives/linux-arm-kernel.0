From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:56:55 +0100
Subject: [PATCH 05/12] arm/arm64: KVM: add 'writable' parameter to
 kvm_phys_addr_ioremap
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Add support for read-only MMIO passthrough mappings by adding a
'writable' parameter to kvm_phys_addr_ioremap. For the moment,
mappings will be read-write even if 'writable' is false, but once
the definition of PAGE_S2_DEVICE gets changed, those mappings will
be created read-only.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   | 2 +-
 arch/arm/kvm/mmu.c               | 5 ++++-
 arch/arm64/include/asm/kvm_mmu.h | 2 +-
 virt/kvm/arm/vgic.c              | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 3f688b4..eaa6dea 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -50,7 +50,7 @@ void free_hyp_pgds(void);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size);
+			  phys_addr_t pa, unsigned long size, bool writable);
 
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index bb2e110..a7eabd1 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -674,7 +674,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
  * @size:	The size of the mapping
  */
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size)
+			  phys_addr_t pa, unsigned long size, bool writable)
 {
 	phys_addr_t addr, end;
 	int ret = 0;
@@ -687,6 +687,9 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
 		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
 
+		if (writable)
+			kvm_set_s2pte_writable(&pte);
+
 		ret = mmu_topup_memory_cache(&cache, 2, 2);
 		if (ret)
 			goto out;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a030d16..e361719 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -77,7 +77,7 @@ void free_hyp_pgds(void);
 int kvm_alloc_stage2_pgd(struct kvm *kvm);
 void kvm_free_stage2_pgd(struct kvm *kvm);
 int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
-			  phys_addr_t pa, unsigned long size);
+			  phys_addr_t pa, unsigned long size, bool writable);
 
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 8629678..382fb5a 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1899,7 +1899,8 @@ int kvm_vgic_init(struct kvm *kvm)
 	}
 
 	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
-				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE);
+				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
+				    true);
 	if (ret) {
 		kvm_err("Unable to remap VGIC CPU to VCPU\n");
 		goto out;
-- 
2.1.1
