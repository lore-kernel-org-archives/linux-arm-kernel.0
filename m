From: steve.capper@arm.com (Steve Capper)
Date: Tue,  2 Jan 2018 15:12:51 +0000
Subject: [PATCH V3 0/3] Map larger kernels at early init
Message-ID: <20180102151254.4063-1-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early pagetable creation code assumes that a single pgd, pud, pmd
and pte are sufficient to map the kernel text for MMU bringup. For 16KB
granules this is, unfortunately, rarely the case. Some kernels may be too
big even for a 64KB granule employing this scheme.

This patch series addresses the problem in three steps: 1) re-order the
reserved_ttbr0 to allow its address computation to be independent of
swapper_pg_dir size, 2) re-order the trampoline in a similar manner,
and 3) re-write the early pgtable code to allow for multiple page table
entries at each level.

Changes in v3: Series rebased on top of arm64/for-next/core branch. This
necessitated changes to accommodate kpti (mainly moving the trampiline page
table before the swapper, in patch #2); as well as 52-bit PA (some assembler
rebasing).

Changes in v2: Ack added to patch #1, KASLR space calculation redone
in patch #2.

Steve Capper (3):
  arm64: Re-order reserved_ttbr0 in linker script
  arm64: entry: Move the trampoline to be before PAN
  arm64: Extend early page table code to allow for larger kernels

 arch/arm64/include/asm/asm-uaccess.h    |   8 +-
 arch/arm64/include/asm/kernel-pgtable.h |  47 ++++++++++-
 arch/arm64/include/asm/pgtable.h        |   1 +
 arch/arm64/include/asm/uaccess.h        |   4 +-
 arch/arm64/kernel/entry.S               |   4 +-
 arch/arm64/kernel/head.S                | 145 +++++++++++++++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S         |  15 ++--
 arch/arm64/mm/mmu.c                     |   3 +-
 8 files changed, 172 insertions(+), 55 deletions(-)

-- 
2.11.0
