From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  8 Jan 2014 14:47:29 -0800
Subject: [PATCH 4/5] arm/arm64: KVM: relax the requirements of VMA alignment
 for THP
In-Reply-To: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
References: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1389221250-30034-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The THP code in KVM/ARM is a bit restrictive in not allowing a THP
to be used if the VMA is not 2MB aligned. Actually, it is not so much
the VMA that matters, but the associated memslot:

A process can perfectly mmap a region with no particular alignment
restriction, and then pass a 2MB aligned address to KVM. In this
case, KVM will only use this 2MB aligned region, and will ignore
the range between vma->vm_start and memslot->userspace_addr.

It can also choose to place this memslot at whatever alignment it
wants in the IPA space. In the end, what matters is the relative
alignment of the user space and IPA mappings with respect to a
2M page. They absolutely must be the same if you want to use THP.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/mmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 659db0e..7789857 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -667,14 +667,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
 		/*
-		 * Pages belonging to VMAs not aligned to the PMD mapping
-		 * granularity cannot be mapped using block descriptors even
-		 * if the pages belong to a THP for the process, because the
-		 * stage-2 block descriptor will cover more than a single THP
-		 * and we loose atomicity for unmapping, updates, and splits
-		 * of the THP or other pages in the stage-2 block range.
+		 * Pages belonging to memslots that don't have the same
+		 * alignment for userspace and IPA cannot be mapped using
+		 * block descriptors even if the pages belong to a THP for
+		 * the process, because the stage-2 block descriptor will
+		 * cover more than a single THP and we loose atomicity for
+		 * unmapping, updates, and splits of the THP or other pages
+		 * in the stage-2 block range.
 		 */
-		if (vma->vm_start & ~PMD_MASK)
+		if ((memslot->userspace_addr & ~PMD_MASK) !=
+		    ((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK))
 			force_pte = true;
 	}
 	up_read(&current->mm->mmap_sem);
-- 
1.8.5.2
