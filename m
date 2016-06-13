From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Jun 2016 15:00:44 +0100
Subject: [PATCH 0/5] arm/arm64: KVM: Tighten memory protection flags
Message-ID: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, the HYP mappings have been fairly relaxed: everything is
RWX. Oddly enough, not everybody is fond of this kind of permissions
at the highest exception level.

This small series tightens it a bit by making:
- the text mapping read-only
- the rodata mapping read-only + no-exec
- everything else read-write + no-exec

Of course, that's only valid when VHE is not in action. Tested on
Seattle and Cubietruck, based on 4.7-rc2.

Thanks,

	M.

Marc Zyngier (5):
  arm/arm64: KVM: Add a protection parameter to create_hyp_mappings
  arm64: Add PTE_HYP_XN page table flag
  arm/arm64: KVM: Enforce HYP read-only mapping of the kernel's rodata
    section
  arm/arm64: KVM: Map the HYP text as read-only
  arm/arm64: KVM: Make default HYP mappings non-excutable

 arch/arm/include/asm/kvm_mmu.h         |  2 +-
 arch/arm/include/asm/pgtable.h         |  4 +++-
 arch/arm/kvm/arm.c                     | 13 +++++++------
 arch/arm/kvm/mmu.c                     |  7 ++++---
 arch/arm64/include/asm/kvm_mmu.h       |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pgtable-prot.h  |  4 +++-
 7 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.1.4
