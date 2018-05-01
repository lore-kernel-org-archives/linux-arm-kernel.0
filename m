From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue,  1 May 2018 11:26:55 +0100
Subject: [PATCH v2 0/4] KVM: Support PUD hugepages at stage 2
Message-ID: <20180501102659.13188-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for PUD hugepages at stage 2. This feature
is useful on cores that have support for large sized TLB mappings
(e.g., 1GB for 4K granule). Previous postings can be found at [0][1].

Support is added to code that is shared between arm and arm64. Dummy
helpers for arm are provided as the port does not support PUD hugepage
sizes.

There is a small conflict with the series to add support for 52 bit
IPA[2]. The patches have been functionally tested on an A57 based
system. The patchset is based on v4.17-rc3 and incorporates feedback
received on the previous version.

Thanks,
Punit

Changes v2:
* Create helper to check if the page should have exec permission [1/4]
* Fix broken condition to detect THP hugepage [1/4]
* Fix in-correct hunk resulting from a rebase [4/4]

[0] https://www.spinics.net/lists/arm-kernel/msg628053.html
[1] https://lkml.org/lkml/2018/4/20/566
[2] https://lwn.net/Articles/750176/

Punit Agrawal (4):
  KVM: arm/arm64: Share common code in user_mem_abort()
  KVM: arm/arm64: Introduce helpers to manupulate page table entries
  KVM: arm64: Support dirty page tracking for PUD hugepages
  KVM: arm64: Add support for PUD hugepages at stage 2

 arch/arm/include/asm/kvm_mmu.h         |  40 +++++++++
 arch/arm64/include/asm/kvm_mmu.h       |  30 +++++++
 arch/arm64/include/asm/pgtable-hwdef.h |   4 +
 arch/arm64/include/asm/pgtable.h       |   2 +
 virt/kvm/arm/mmu.c                     | 120 +++++++++++++++++--------
 5 files changed, 161 insertions(+), 35 deletions(-)

-- 
2.17.0
