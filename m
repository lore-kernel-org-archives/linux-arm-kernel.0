From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 25 Feb 2014 11:38:51 +0000
Subject: [PATCH V2 0/3] PTE fixes for arm and arm64
Message-ID: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a couple of problems that I have come across:
 1) Some pte accessors for arm and arm64 can have their results
    cancelled out by a downcast. This is addressed by the first two
    patches.

 2) On arm with LPAE it is impossible to distinguish between clean
    writable ptes and read only ptes. This is addressed by the third
    patch.

As the third patch depends on the first patch, all three patches are
bundled together in the same series.

I have reviewed Will and Russell's patch:
 b6ccb9803e90 ("ARM: 7954/1: mm: remove remaining domain support
	from ARMv6")
And I believe that the L_PTE_WRITE logic should be compatible with this
patch. It applies cleanly and compiles; but I would be greatful if
someone could please give it a test.

Cheers,
-- 
Steve

Steve Capper (3):
  arm: mm: Double logical invert for pte accessors
  arm64: mm: Add double logical invert to pte accessors
  arm: mm: Switch back to L_PTE_WRITE

 arch/arm/include/asm/pgtable-2level.h |  2 +-
 arch/arm/include/asm/pgtable-3level.h |  1 +
 arch/arm/include/asm/pgtable.h        | 42 +++++++++++++++++------------------
 arch/arm/mm/dump.c                    |  8 +++----
 arch/arm/mm/mmu.c                     | 25 +++++++++++----------
 arch/arm/mm/proc-macros.S             | 16 ++++++-------
 arch/arm/mm/proc-v7-2level.S          |  6 ++---
 arch/arm/mm/proc-v7-3level.S          |  4 +++-
 arch/arm/mm/proc-xscale.S             |  4 ++--
 arch/arm64/include/asm/pgtable.h      | 10 ++++-----
 10 files changed, 61 insertions(+), 57 deletions(-)

-- 
1.8.1.4
