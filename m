From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 16 May 2017 10:34:53 +0100
Subject: [PATCH v3 0/2] kvm: arm/arm64: Fixes for race conditions
Message-ID: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches fixes race conditions in stage2 pgd accesses.

Patch 1 is a fix up for the patch which has already been pushed to
kvmarm/master.

Patch 2 fixes a case where stage2 PGD could be free'd when we release
the kvm->mmu_lock to prevent VCPU starvation.

Applies on kvmarm/master tree

Changes since V2:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/504401.html

 - Patch 1 in V2 has been pushed to kvmarm/master. Added a fixup to the
   original patch to make sure we don't use cached stage2 pgd.
 - Patch 2: Handle cases where unmap_stage2_range may be called without
   checking the validity of stage2 pgd.


Changes since v1:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/502867.html

 - Dropped patch for fixing mmu_notifier race condition, which couldn't be
   reproduced.
 - Added reviewed-by from Christoffer
 - Added new patch to fix another race condition

Suzuki K Poulose (2):
  kvm: arm/arm64: Force reading uncached stage2 PGD
  kvm: arm/arm64: Fix use after free of stage2 page table

 virt/kvm/arm/mmu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.7.4
