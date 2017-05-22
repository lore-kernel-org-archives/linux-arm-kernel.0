From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 22 May 2017 14:35:58 +0100
Subject: [PATCH v3 0/6] Support for contiguous pte hugepages
Message-ID: <20170522133604.11392-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset updates the hugetlb code to fix issues arising from
contiguous pte hugepages (such as on arm64). These are the generic
code changes and the arm64 support based on these patches will be
posted separately. The patches are based on v4.12-rc2. Previous
related postings can be found at [0], [1] and [2].

The patches fall into two categories -

* Patches 1-2 address issues with gup

* Patches 3-6 relate to passing a size argument to hugepage helpers to
  disambiguate the size of the referred page. These changes are
  required to enable arch code to properly handle swap entries for
  contiguous pte hugepages.

  The changes to huge_pte_offset() (patch 3) touch multiple
  architectures but I've managed to minimise these changes for the
  other affected functions - huge_pte_clear() and set_huge_pte_at().

These patches gate the enabling of contiguous hugepages support on
arm64 which has been requested for systems using !4k page granule.

Feedback welcome.

Thanks,
Punit

v2 -> v3
* Added gup fixes

v1 -> v2

* switch huge_pte_offset() to use size instead of hstate for
  consistency with the rest of the api
* Expand the series to address huge_pte_clear() and set_huge_pte_at()

RFC -> v1

* Fixed a missing conversion of huge_pte_offset() prototype to add
  hstate parameter. Reported by 0-day.

[0] https://lkml.org/lkml/2017/3/23/293
[1] https://lkml.org/lkml/2017/3/30/770
[2] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1370686.html

Punit Agrawal (5):
  mm, gup: Ensure real head page is ref-counted when using hugepages
  mm/hugetlb: add size parameter to huge_pte_offset()
  mm/hugetlb: Allow architectures to override huge_pte_clear()
  mm/hugetlb: Introduce set_huge_swap_pte_at() helper
  mm: rmap: Use correct helper when poisoning hugepages

Will Deacon (1):
  mm, gup: Remove broken VM_BUG_ON_PAGE compound check for hugepages

 arch/arm64/mm/hugetlbpage.c     |  3 ++-
 arch/ia64/mm/hugetlbpage.c      |  4 ++--
 arch/metag/mm/hugetlbpage.c     |  3 ++-
 arch/mips/mm/hugetlbpage.c      |  3 ++-
 arch/parisc/mm/hugetlbpage.c    |  3 ++-
 arch/powerpc/mm/hugetlbpage.c   |  2 +-
 arch/s390/include/asm/hugetlb.h | 10 ++-------
 arch/s390/mm/hugetlbpage.c      | 12 ++++++++++-
 arch/sh/mm/hugetlbpage.c        |  3 ++-
 arch/sparc/mm/hugetlbpage.c     |  3 ++-
 arch/tile/mm/hugetlbpage.c      |  3 ++-
 arch/x86/mm/hugetlbpage.c       |  2 +-
 fs/userfaultfd.c                |  7 +++++--
 include/asm-generic/hugetlb.h   |  7 ++-----
 include/linux/hugetlb.h         |  7 +++++--
 mm/gup.c                        | 15 ++++++--------
 mm/hugetlb.c                    | 45 +++++++++++++++++++++++++++++------------
 mm/page_vma_mapped.c            |  3 ++-
 mm/pagewalk.c                   |  3 ++-
 mm/rmap.c                       |  7 +++++--
 20 files changed, 90 insertions(+), 55 deletions(-)

-- 
2.11.0
