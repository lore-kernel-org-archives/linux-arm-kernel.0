From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  4 Jan 2016 17:56:33 +0000
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
Message-ID: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series reworks the arm64 early page table code, in order to:

(a) Avoid issues with potentially-conflicting TTBR1 TLB entries (as raised in
    Jeremy's thread [1]). This can happen when splitting/merging sections or
    contiguous ranges, and per a pessimistic reading of the ARM ARM may happen
    for changes to other fields in translation table entries.
    
(b) Allow for more complex page table creation early on, with tables created
    with fine-grained permissions as early as possible. In the cases where we
    currently use fine-grained permissions (e.g. DEBUG_RODATA and marking .init
    as non-executable), this is required for the same reasons as (a), as we
    must ensure that changes to page tables do not split/merge sections or
    contiguous regions for memory in active use.

(c) Avoid edge cases where we need to allocate memory before a sufficient
    proportion of the early linear map is in place to accommodate allocations.

This series:

* Introduces the necessary infrastructure to safely swap TTBR1_EL1 (i.e.
  without risking conflicting TLB entries being allocated). The arm64 KASAN
  code is migrated to this.

* Adds helpers to walk page tables by physical address, independent of the
  linear mapping, and modifies __create_mapping and friends to relying on a new
  set of FIX_{PGD,PUD,PMD,PTE} to map tables as required for modification.

* Removes the early memblock limit, now that create_mapping does not rely on the
  early linear map. This solves (c), and allows for (b).

* Generates an entirely new set of kernel page tables with fine-grained (i.e.
  page-level) permission boundaries, which can then be safely installed. These
  are created with sufficient granularity such that later changes (currently
  only fixup_init) will not split/merge sections or contiguous regions, and can
  follow a break-before-make approach without affecting the rest of the page
  tables.

There are still opportunities for improvement:

* BUG() when splitting sections or creating overlapping entries in
  create_mapping, as these both indicate serious bugs in kernel page table
  creation.
  
  This will require rework to the EFI runtime services pagetable creation, as
  for >4K page kernels EFI memory descriptors may share pages (and currently
  such overlap is assumed to be benign).

* Use ROX mappings for the kernel text and rodata when creating the new tables.
  This avoiding potential conflicts from changes to translation tables, and
  giving us better protections earlier.

  Currently the alternatives patching code relies on being able to use the
  kernel mapping to update the text. We cannot rely on any text which itself
  may be patched, and updates may straddle page boundaries, so this is
  non-trivial.

* Clean up usage of swapper_pg_dir so we can switch to the new tables without
  having to reuse the existing pgd. This will allow us to free the original
  pgd (i.e. we can free all the initial tables in one go).

Any and all feedback is welcome.

This series is based on today's arm64 [2] for-next/core branch (commit
c9cd0ed925c0b927), and this version is tagged as
arm64-pagetable-rework-20160104 while the latest version should be in the
unstable branch arm64/pagetable-rework in my git repo [3].

Since v1 [4] (tagged arm64-pagetable-rework-20151209):
* Drop patches taken into the arm64 tree.
* Rebase to arm64 for-next/core.
* Copy early KASAN tables.
* Fix KASAN pgd manipulation.
* Specialise allocators for page tables, in function and naming.
* Update comments.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386178.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/392292.html

Mark Rutland (18):
  asm-generic: make __set_fixmap_offset a static inline
  arm64: mm: specialise pagetable allocators
  arm64: mm: place empty_zero_page in bss
  arm64: unify idmap removal
  arm64: unmap idmap earlier
  arm64: add function to install the idmap
  arm64: mm: add code to safely replace TTBR1_EL1
  arm64: kasan: avoid TLB conflicts
  arm64: mm: move pte_* macros
  arm64: mm: add functions to walk page tables by PA
  arm64: mm: avoid redundant __pa(__va(x))
  arm64: mm: add __{pud,pgd}_populate
  arm64: mm: add functions to walk tables in fixmap
  arm64: mm: use fixmap when creating page tables
  arm64: mm: allocate pagetables anywhere
  arm64: mm: allow passing a pgdir to alloc_init_*
  arm64: ensure _stext and _etext are page-aligned
  arm64: mm: create new fine-grained mappings at boot

 arch/arm64/include/asm/fixmap.h      |  10 ++
 arch/arm64/include/asm/kasan.h       |   3 +
 arch/arm64/include/asm/mmu_context.h |  63 ++++++-
 arch/arm64/include/asm/pgalloc.h     |  26 ++-
 arch/arm64/include/asm/pgtable.h     |  87 +++++++---
 arch/arm64/kernel/head.S             |   1 +
 arch/arm64/kernel/setup.c            |   7 +
 arch/arm64/kernel/smp.c              |   4 +-
 arch/arm64/kernel/suspend.c          |  20 +--
 arch/arm64/kernel/vmlinux.lds.S      |   5 +-
 arch/arm64/mm/kasan_init.c           |  32 ++--
 arch/arm64/mm/mmu.c                  | 311 ++++++++++++++++++-----------------
 arch/arm64/mm/proc.S                 |  27 +++
 include/asm-generic/fixmap.h         |  14 +-
 14 files changed, 381 insertions(+), 229 deletions(-)

-- 
1.9.1
