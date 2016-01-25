From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jan 2016 11:44:54 +0000
Subject: [PATCHv3 00/18] arm64: mm: rework page table creation
Message-ID: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series reworks the arm64 early page table code. This avoids issues with
conflicting TLB entries, ensures we can always create page tables provided
there is available memory in the system (even if not covered by the early
linear map), and allows for fine-grained table creation early on.

With this series, we will create a new set of fine-grained page tables,
temporarily mapping the tables themselves using a new set of fixmap slots.
Subsequently we safely switch over to these tables using some idmapped code
that avoids the allocation of conflicting TLB entries.

This series is based on v4.5-rc1, and this version is tagged as
arm64-pagetable-rework-20160125 while the latest version should be in the
unstable branch arm64/pagetable-rework in my git repo [1], though I'm hoping
that this won't need another spin.

Since v1 [2] (tagged arm64-pagetable-rework-20151209):
* Drop patches taken into the arm64 tree.
* Rebase to arm64 for-next/core.
* Copy early KASAN tables.
* Fix KASAN pgd manipulation.
* Specialise allocators for page tables, in function and naming.
* Update comments.

Since v2 [3] (tagged arm64-pagetable-rework-20160104)
* Rebase to v4.5-rc1.
* Rename fixmap functions to p??_set_fixmap{,_offset}, p??_clear_fixmap.
* Restore a barrier lost to a rebase.
* Fix typos in commit messages.
* Collected Acks.

As there's at least one other series depending on this, I'd like to keep my
arm64/pagetable-rework branch stable.

Catalin, how do you want to take this? Are you happy to merge my
arm64/pagetable-rework branch, or would you prefer to pick the patches? Arnd
has acked the asm-generic patch [4] and is happy for it to go via the arm64
tree, and everything else is your domain.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/392292.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397095.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400396.html

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
 arch/arm64/include/asm/mmu_context.h |  62 ++++++-
 arch/arm64/include/asm/pgalloc.h     |  26 ++-
 arch/arm64/include/asm/pgtable.h     |  87 +++++++---
 arch/arm64/kernel/head.S             |   1 +
 arch/arm64/kernel/setup.c            |   7 +
 arch/arm64/kernel/smp.c              |   4 +-
 arch/arm64/kernel/suspend.c          |  20 +--
 arch/arm64/kernel/vmlinux.lds.S      |   5 +-
 arch/arm64/mm/kasan_init.c           |  32 ++--
 arch/arm64/mm/mmu.c                  | 313 ++++++++++++++++++-----------------
 arch/arm64/mm/proc.S                 |  28 ++++
 include/asm-generic/fixmap.h         |  14 +-
 14 files changed, 383 insertions(+), 229 deletions(-)

-- 
1.9.1
