From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:56:54 +0100
Subject: [PATCH 04/12] arm/arm64: KVM: fix potential NULL dereference in
 user_mem_abort()
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Handle the potential NULL return value of find_vma_intersection()
before dereferencing it.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 8f0c7a4..bb2e110 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -776,6 +776,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	down_read(&current->mm->mmap_sem);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
+	if (unlikely(!vma)) {
+		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
+		up_read(&current->mm->mmap_sem);
+		return -EFAULT;
+	}
+
 	if (is_vm_hugetlb_page(vma)) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
-- 
2.1.1
