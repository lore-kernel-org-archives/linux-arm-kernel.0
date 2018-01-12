From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 12 Jan 2018 13:33:33 +0100
Subject: [PULL 1/2] KVM: arm/arm64: Check pagesize when allocating a hugepage
 at Stage 2
In-Reply-To: <20180112123334.28687-1-christoffer.dall@linaro.org>
References: <20180112123334.28687-1-christoffer.dall@linaro.org>
Message-ID: <20180112123334.28687-2-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Punit Agrawal <punit.agrawal@arm.com>

KVM only supports PMD hugepages at stage 2 but doesn't actually check
that the provided hugepage memory pagesize is PMD_SIZE before populating
stage 2 entries.

In cases where the backing hugepage size is smaller than PMD_SIZE (such
as when using contiguous hugepages), KVM can end up creating stage 2
mappings that extend beyond the supplied memory.

Fix this by checking for the pagesize of userspace vma before creating
PMD hugepage at stage 2.

Fixes: 66b3923a1a0f77a ("arm64: hugetlb: add support for PTE contiguous bit")
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: <stable@vger.kernel.org> # v4.5+
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index b4b69c2d1012..9dea96380339 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1310,7 +1310,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma) && !logging_active) {
+	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
-- 
2.14.2
