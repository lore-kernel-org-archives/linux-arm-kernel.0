From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:35 +0000
Subject: [RFC PATCH 00/20] arm64: mm: rework page table creation
Message-ID: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a first attempt at reworking the arm64 page table creation, which is
necessary to:

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

(c) Avoid (rare/theoretical) edge cases where we need to allocate memory before
    a sufficient proportion of the early linear map is in place.

This series:

* Introduces the necessary infrastructure to safely swap TTBR1_EL1 (i.e.
  without risking conflicting TLB entries being allocated).

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

There is still work to do:

* Implement the necessary page table copying and/or creation for KASAN.

* BUG() when splitting sections or creating overlapping entries in
  create_mapping, as these both indicate serious bugs in kernel page table
  creation.
  
  This will require rework to the EFI runtime services pagetable creation, as
  for >4K page kernels EFI memory descriptors may share pages (and currently
  such overlap is assumed to be benign).

* Solve ROX mapping the kernel text and rodata, as updating execute
  permissions may risk TLB conflicts.

  Ideally we'd map these separately as ROX and RO immediately, but the
  alternatives patching code relies on being able to use the kernel mapping to
  update the text. We cannot rely on any text which itself may be patched, and
  updates may straddle page boundaries, so this is non-trivial.

* Clean up usage of swapper_pg_dir so we can switch to the new tables without
  having to reuse the existing pgd. This will allow us to free the original
  pgd.

Any and all feedback is welcome.

The series is based on v4.4-rc4, and a can be found in my git repo [2] on
kernel.org. This version is tagged as arm64-pagetable-rework-20151209, while
the latest version should be in the unstable branch arm64/pagetable-rework.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386178.html
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

Mark Rutland (20):
  arm64: mm: remove pointless PAGE_MASKing
  arm64: Remove redundant padding from linker script
  arm64: mm: fold alternatives into .init
  arm64: mm: assume PAGE SIZE for page table allocator
  asm-generic: make __set_fixmap_offset a static inline
  arm64: mm: place empty_zero_page in bss
  arm64: unify idmap removal
  arm64: unmap idmap earlier
  arm64: add function to install the idmap
  arm64: mm: add code to safely replace TTBR1_EL1
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

 arch/arm64/include/asm/alternative.h |   1 -
 arch/arm64/include/asm/fixmap.h      |  10 ++
 arch/arm64/include/asm/mmu_context.h |  63 +++++++-
 arch/arm64/include/asm/pgalloc.h     |  26 ++-
 arch/arm64/include/asm/pgtable.h     |  87 +++++++----
 arch/arm64/kernel/alternative.c      |   6 -
 arch/arm64/kernel/setup.c            |   7 +
 arch/arm64/kernel/smp.c              |   4 +-
 arch/arm64/kernel/suspend.c          |  20 +--
 arch/arm64/kernel/vmlinux.lds.S      |  12 +-
 arch/arm64/mm/init.c                 |   1 -
 arch/arm64/mm/mmu.c                  | 295 +++++++++++++++++------------------
 arch/arm64/mm/proc.S                 |  27 ++++
 include/asm-generic/fixmap.h         |  14 +-
 14 files changed, 344 insertions(+), 229 deletions(-)

-- 
1.9.1
