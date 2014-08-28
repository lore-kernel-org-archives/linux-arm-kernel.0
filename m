From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 28 Aug 2014 15:45:01 +0100
Subject: [PATCH V3 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Message-ID: <1409237107-24228-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This series implements general forms of get_user_pages_fast and
__get_user_pages_fast and activates them for arm and arm64.

These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).

Unfortunately, a futex on THP tail can be quite common for certain
workloads; thus THP is unreliable without a __get_user_pages_fast
implementation.

This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.

Changes since PATCH V2 are:
 * spelt `PATCH' correctly in the subject prefix this time. :-(
 * Added acks, tested-bys and reviewed-bys.
 * Cleanup of patch #6 with pud_pte and pud_pmd helpers.
 * Switched config option from HAVE_RCU_GUP to HAVE_GENERIC_RCU_GUP.

Changes since PATCH V1 are:
 * Rebase to 3.17-rc1
 * Switched to kick_all_cpus_sync as suggested by Mark Rutland.

The main changes since RFC V5 are:
 * Rebased against 3.16-rc1.
 * pmd_present no longer tested for by gup_huge_pmd and gup_huge_pud,
   because the entry must be present for these leaf functions to be
   called. 
 * Rather than assume puds can be re-cast as pmds, a separate
   function pud_write is instead used by the core gup.
 * ARM activation logic changed, now it will only activate
   RCU_TABLE_FREE and RCU_GUP when running with LPAE.

The main changes since RFC V4 are:
 * corrected the arm64 logic so it now correctly rcu-frees page
   table backing pages.
 * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
   invalidate TLBs anyway.
 * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
 * dropped Catalin's mmu_gather patch as that's been merged already.

This series has been tested with LTP mm tests and some custom futex tests
that exacerbate the futex on THP tail case; on both an Arndale board and
a Juno board. Also debug counters were temporarily employed to ensure that
the RCU_TABLE_FREE logic was behaving as expected.

I would like to get this series into 3.18 as it fixes quite a big problem
with THP on arm and arm64. This series is split into a core mm part, an
arm part and an arm64 part.

Could somebody please take patch #1 (if it looks okay)?
Russell, would you be happy with patches #2, #3, #4? (if we get #1 merged)
Catalin, would you be happy taking patches #5, #6? (if we get #1 merged)

Cheers,
--
Steve

Steve Capper (6):
  mm: Introduce a general RCU get_user_pages_fast.
  arm: mm: Introduce special ptes for LPAE
  arm: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm: mm: Enable RCU fast_gup
  arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm64: mm: Enable RCU fast_gup

 arch/arm/Kconfig                      |   5 +
 arch/arm/include/asm/pgtable-2level.h |   2 +
 arch/arm/include/asm/pgtable-3level.h |  15 ++
 arch/arm/include/asm/pgtable.h        |   6 +-
 arch/arm/include/asm/tlb.h            |  38 ++++-
 arch/arm/mm/flush.c                   |  15 ++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/include/asm/pgtable.h      |  21 ++-
 arch/arm64/include/asm/tlb.h          |  20 ++-
 arch/arm64/mm/flush.c                 |  15 ++
 mm/Kconfig                            |   3 +
 mm/gup.c                              | 278 ++++++++++++++++++++++++++++++++++
 12 files changed, 412 insertions(+), 10 deletions(-)

-- 
1.9.3
