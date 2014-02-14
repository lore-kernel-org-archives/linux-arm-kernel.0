From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 14 Feb 2014 16:55:11 +0000
Subject: [RFC PATCH 0/2] ARM: Switch back to L_PTE_WRITE
Message-ID: <1392396913-13570-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This RFC switches both the short and long descriptors back to using
L_PTE_WRITE to represent a writable pte, rather than !L_PTE_RDONLY.

This allows us, for long descriptors, to distinguish between writable
clean ptes and read only ptes; fixing a few problems with huge pages,
and possibly other areas of code.
(For short descriptors the distinction was possible already due to the
separate Linux/hardware ptes).

I originally attempted to leave the short descriptor code alone and
only modify the long descriptors to use L_PTE_WRITE. This turned out
to be both overly complicated and confusing. So, I have instead
reverted:
    36bb94b ARM: pgtable: provide RDONLY page table bit rather than WRITE bit
And introduced a separate L_PTE_WRITE software bit for long descriptors.

This series has been tested on an Arndale board running 3.14-rc2, and
both short and long descriptors. The libhugetlbfs tests have passed for
LPAE. I am currently running a barrage of ltp tests for both short and
long descriptors.

Whilst testing this patch with libhugetlbfs, I came across a horrible
bug in the handling of huge_pte_write(). For LPAE, both L_PTE_DIRTY and
L_PTE_WRITE are in the upper 32 bits of the ptes. The huge_pte_write()
function downcasts the result of pte_write() to 32-bits, meaning that
huge_pte_write() always returned false! I've noticed this downcasting
to 32-bits taking place in the following functions:
  o gather_stats
  o huge_pte_dirty
  o huge_pte_write
  o make_migration_entry
(under arm64, the downcasting doesn't take place on the huge_pte_
functions as they use long, but the others use int....)

To fix this issue, I have added a double logical invert to pte_write()
and pte_dirty() when LPAE is enabled (in the second patch in this
series). This fixes the problem, but it's leaving me feeling rather
filthy. Any suggestions on a cleaner way around this would be very
welcome.

Cheers,
--
Steve

Steve Capper (2):
  arm: mm: Switch back to L_PTE_WRITE
  arm: mm: Double logical invert for LPAE pte_write(), pte_dirty()

 arch/arm/include/asm/pgtable-2level.h |  4 +++-
 arch/arm/include/asm/pgtable-3level.h | 18 ++++++++++++++++--
 arch/arm/include/asm/pgtable.h        | 36 +++++++++++++++++------------------
 arch/arm/mm/dump.c                    |  8 ++++----
 arch/arm/mm/mmu.c                     | 25 ++++++++++++------------
 arch/arm/mm/proc-macros.S             | 16 ++++++++--------
 arch/arm/mm/proc-v7-2level.S          |  6 +++---
 arch/arm/mm/proc-v7-3level.S          |  6 ++++--
 arch/arm/mm/proc-xscale.S             |  4 ++--
 9 files changed, 70 insertions(+), 53 deletions(-)

-- 
1.8.1.4
