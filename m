From: steve.capper@arm.com (Steve Capper)
Date: Thu, 23 Nov 2017 16:40:38 +0000
Subject: [PATCH V2 0/2] Map larger kernels at early init
Message-ID: <20171123164040.31551-1-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early pagetable creation code assumes that a single pgd, pud, pmd
and pte are sufficient to map the kernel text for MMU bringup. For 16KB
granules this is, unfortunately, rarely the case. Some kernels may be too
big even for a 64KB granule employing this scheme.

This patch series addresses the problem in two steps: 1) re-order the
reserved_ttbr0 to allow its address computation to be independent of
swapper_pg_dir size, 2) re-write the early pgtable code to allow for
multiple page table entries at each level.

Changes in v2: Ack added to patch #1, KASLR space calculation redone
in patch #2.

Steve Capper (2):
  arm64: Re-order reserved_ttbr0 in linker script
  arm64: Extend early page table code to allow for larger kernels

 arch/arm64/include/asm/asm-uaccess.h    |   6 +-
 arch/arm64/include/asm/kernel-pgtable.h |  47 +++++++++-
 arch/arm64/include/asm/pgtable.h        |   2 +-
 arch/arm64/include/asm/uaccess.h        |   2 +-
 arch/arm64/kernel/head.S                | 148 +++++++++++++++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S         |   6 +-
 arch/arm64/mm/mmu.c                     |   3 +-
 7 files changed, 164 insertions(+), 50 deletions(-)

-- 
2.11.0
