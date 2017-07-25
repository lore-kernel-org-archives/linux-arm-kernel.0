From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jul 2017 14:53:02 +0100
Subject: [PATCH 0/6] Rework the pte handling for hardware AF/DBM
Message-ID: <20170725135308.18173-1-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in the series fixes a potential race with hardware DBM
in ptep_set_access_flags(). This patch is aimed at 4.13.

The second and third patches convert the inline asm in the pte accessors
to (cmp)xchg so that we can take advantage of the LSE atomics if
available (also making the code cleaner).

The fourth patch aims to simplify the PTE_RDONLY handling by moving it
out of set_pte_at().

The fifth patch is a further simplification of ptep_set_wrprotect()
under the assumption (correct, IMHO) that ptep_set_wrprotect() and the
huge_* equivalent are called only for CoW pages and therefore not racy
with hardware dirty bit updates (only access flag).

The last patch gets rid of the CONFIG_ARM64_HW_AFDBM option since the
code works even when the hardware feature is not present.

Thanks.

Catalin Marinas (6):
  arm64: Fix potential race with hardware DBM in ptep_set_access_flags()
  arm64: Convert pte handling from inline asm to using (cmp)xchg
  kvm: arm64: Convert kvm_set_s2pte_readonly() from inline asm to
    cmpxchg()
  arm64: Move PTE_RDONLY bit handling out of set_pte_at()
  arm64: Ignore hardware dirty bit updates in ptep_set_wrprotect()
  arm64: Remove the CONFIG_ARM64_HW_AFDBM option

 arch/arm64/Kconfig                    | 17 ------
 arch/arm64/include/asm/kvm_mmu.h      | 20 +++----
 arch/arm64/include/asm/pgtable-prot.h | 12 ++---
 arch/arm64/include/asm/pgtable.h      | 99 +++++++++++++----------------------
 arch/arm64/kernel/hibernate.c         |  4 +-
 arch/arm64/kvm/hyp/s2-setup.c         |  2 +-
 arch/arm64/mm/fault.c                 | 36 +++++--------
 arch/arm64/mm/proc.S                  |  3 +-
 8 files changed, 69 insertions(+), 124 deletions(-)
