From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 18:25:57 +0100
Subject: [PATCH v2 0/5] Rework the pte handling for hardware AF/DBM
Message-ID: <20170818172602.7624-1-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

That's the second version of the pte accessors reworking series (first
version at [1]).

Changes since v1:

- READ_ONCE moved out of the cmpxchg loops since cmpxchg already returns
  the old value (probably more efficient with LSE atomics)

- The first patch from the first series has been merged upstream (cc
  stable)

- Kconfig entry kept just to disable the hardware feature but the code
  paths all assume hardware AF/DBM

- PAGE_COPY(_EXEC) removed as they just duplicate PAGE_READONLY(_EXEC)

I kept the review-by tags in place as the logic is unchanged but feel
free to look at the patches again.

Thanks.

[1] http://lkml.kernel.org/r/20170725135308.18173-1-catalin.marinas at arm.com

Catalin Marinas (5):
  arm64: Convert pte handling from inline asm to using (cmp)xchg
  kvm: arm64: Convert kvm_set_s2pte_readonly() from inline asm to
    cmpxchg()
  arm64: Move PTE_RDONLY bit handling out of set_pte_at()
  arm64: Ignore hardware dirty bit updates in ptep_set_wrprotect()
  arm64: Remove the !CONFIG_ARM64_HW_AFDBM alternative code paths

 arch/arm64/include/asm/kvm_mmu.h      |  21 +++----
 arch/arm64/include/asm/pgtable-prot.h |  18 +++---
 arch/arm64/include/asm/pgtable.h      | 103 ++++++++++++++--------------------
 arch/arm64/kernel/hibernate.c         |   4 +-
 arch/arm64/kvm/hyp/s2-setup.c         |   2 +-
 arch/arm64/mm/fault.c                 |  30 ++++------
 6 files changed, 72 insertions(+), 106 deletions(-)
