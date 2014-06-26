From: kim.phillips@freescale.com (Kim Phillips)
Date: Wed, 25 Jun 2014 19:45:51 -0500
Subject: [PATCH 2/2 v2] ARM: KVM: user_mem_abort: support stage 2 MMIO page
 mapping
In-Reply-To: <53A9556D.3000003@arm.com>
References: <1395785294-2545-1-git-send-email-kim.phillips@linaro.org>
 <1395785294-2545-2-git-send-email-kim.phillips@linaro.org>
 <20140506180448.GH3066@lvm>	<87bnvaotei.fsf@approximate.cambridge.arm.com>
 <20140507145557.GJ3066@lvm>	<20140624102327.GA9121@arm.com>
 <53A9556D.3000003@arm.com>
Message-ID: <20140625194551.a6443252bf913023159d25fd@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kim Phillips <kim.phillips@linaro.org>

A userspace process can map device MMIO memory via VFIO or /dev/mem,
e.g., for platform device passthrough support in QEMU.

During early development, we found the PAGE_S2 memory type being used
for MMIO mappings.  This patch corrects that by using the more strongly
ordered memory type for device MMIO mappings: PAGE_S2_DEVICE.

Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Hi, here's a v2, upon request:

- rebased onto today's mainline ToT
- mmu.o-build tested only (ToT build doesn't complete)
- made commit text less terse
- added Christoffer's ack

Cheers,

Kim

 arch/arm/kvm/mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 16f8049..69af021 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -748,6 +748,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
 	struct vm_area_struct *vma;
 	pfn_t pfn;
+	pgprot_t mem_type = PAGE_S2;
 
 	write_fault = kvm_is_write_fault(kvm_vcpu_get_hsr(vcpu));
 	if (fault_status == FSC_PERM && !write_fault) {
@@ -798,6 +799,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (is_error_pfn(pfn))
 		return -EFAULT;
 
+	if (kvm_is_mmio_pfn(pfn))
+		mem_type = PAGE_S2_DEVICE;
+
 	spin_lock(&kvm->mmu_lock);
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
@@ -805,7 +809,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
 
 	if (hugetlb) {
-		pmd_t new_pmd = pfn_pmd(pfn, PAGE_S2);
+		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
 		new_pmd = pmd_mkhuge(new_pmd);
 		if (writable) {
 			kvm_set_s2pmd_writable(&new_pmd);
@@ -814,13 +818,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		coherent_cache_guest_page(vcpu, hva & PMD_MASK, PMD_SIZE);
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
-		pte_t new_pte = pfn_pte(pfn, PAGE_S2);
+		pte_t new_pte = pfn_pte(pfn, mem_type);
 		if (writable) {
 			kvm_set_s2pte_writable(&new_pte);
 			kvm_set_pfn_dirty(pfn);
 		}
 		coherent_cache_guest_page(vcpu, hva, PAGE_SIZE);
-		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, false);
+		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte,
+				     mem_type == PAGE_S2_DEVICE);
 	}
 
 
-- 
2.0.0
