From: steve.capper@arm.com (Steve Capper)
Date: Thu, 18 Oct 2012 17:15:36 +0100
Subject: [RFC PATCH 0/6] ARM: mm: HugeTLB + THP support.
Message-ID: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
The following patches bring both HugeTLB support and Transparent HugePage (THP)
support to ARM.

Both short descriptors (non-LPAE) and long descriptors (LPAE) are supported.

The non-LPAE HugeTLB code is based on patches by Bill Carson [1], but instead of
allocating extra memory to store "Linux PTEs", it re-purposes the domain bits
of section descriptors and constructs huge Linux PTEs on demand.

As PMDs are walked directly by the kernel THP functions (there are no
huge_pmd_offset style functions), any "linux PMD"/"hardware PMD" distinction
would require some re-working of the ARM PMD/PTE code. Use of the domain bits
allows for a more straightforward THP implementation.

Some general HugeTLB code relating to huge page migration on memory failure
(CONFIG_MEMORY_FAILURE) de-references huge pte_t *s directly rather than use
the huge_ptep_get and set_huge_pte_at functions. Thus this config option is
incompatible with non-LPAE hugepages. At the moment I can only see x86 using
CONFIG_MEMORY_FAILURE though.

For non-LPAE, I make an assumption about how the memory type is mapped between
linux PTE and section descriptor. Ideally I would like to look this information
up, possibly from get_mem_types(MT_MEMORY). Comments on an elegant way of
achieving this are welcome.

Non-LPAE code was tested on a Versatile Express (V2P-CA15_A7 Cortex A15 tile),
Tegra 2 TrimSlice and RealView ARM11MPCore.

The LPAE code manipulates the hardware page tables directly as the long
descriptors are wide enough to contain all the Linux PTE information.

The LPAE code has been tested on a Versatile Express: V2F-2XV6 Cortex A15 and
V2P-CA15_A7 Cortex A15 tiles.

This patch set requires the following to be applied on top of 3.7-rc1:
"ARM: mm: introduce L_PTE_VALID for page table entries"
  (PROT_NONE series, posted by Will on linux-arm-kernel)
  - http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/126130.html

"mm: thp: Set the accessed flag for old pages on access fault."
  (posted by Will on linux-mm)
   - http://marc.info/?l=linux-kernel&m=135048927416117&w=2

Cheers,
-- 
Steve

[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084359.html

Catalin Marinas (2):
  ARM: mm: HugeTLB support for LPAE systems.
  ARM: mm: Transparent huge page support for LPAE systems.

Steve Capper (4):
  ARM: mm: correct pte_same behaviour for LPAE.
  ARM: mm: Add support for flushing HugeTLB pages.
  ARM: mm: HugeTLB support for non-LPAE systems.
  ARM: mm: Transparent huge page support for non-LPAE systems.

 arch/arm/Kconfig                            |    8 ++
 arch/arm/include/asm/hugetlb-2level.h       |   71 ++++++++++
 arch/arm/include/asm/hugetlb-3level.h       |   61 +++++++++
 arch/arm/include/asm/hugetlb.h              |   87 ++++++++++++
 arch/arm/include/asm/pgtable-2level.h       |  152 ++++++++++++++++++++-
 arch/arm/include/asm/pgtable-3level-hwdef.h |    2 +
 arch/arm/include/asm/pgtable-3level.h       |   77 +++++++++++
 arch/arm/include/asm/pgtable.h              |   34 ++++-
 arch/arm/include/asm/tlb.h                  |   16 ++-
 arch/arm/include/asm/tlbflush.h             |    2 +
 arch/arm/kernel/head.S                      |   10 +-
 arch/arm/mm/Makefile                        |    6 +
 arch/arm/mm/dma-mapping.c                   |    2 +-
 arch/arm/mm/fault.c                         |    6 +-
 arch/arm/mm/flush.c                         |   25 ++--
 arch/arm/mm/fsr-3level.c                    |    2 +-
 arch/arm/mm/hugetlbpage-2level.c            |  115 ++++++++++++++++
 arch/arm/mm/hugetlbpage-3level.c            |  190 +++++++++++++++++++++++++++
 arch/arm/mm/hugetlbpage.c                   |   65 +++++++++
 19 files changed, 909 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage-2level.c
 create mode 100644 arch/arm/mm/hugetlbpage-3level.c
 create mode 100644 arch/arm/mm/hugetlbpage.c

-- 
1.7.9.5
