From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  2 Aug 2017 10:48:55 +0100
Subject: [PATCH v5 0/9] arm64: Enable contiguous pte hugepage support
Message-ID: <20170802094904.27749-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series re-enables contiguous hugepage support for arm64. Support
for contiguous hugepages is useful on systems where the PMD hugepage
size is too large (512MB hugepage when using 64k page granule) and
contiguous hugepages can be used to provide reasonable hugepage sizes
to the user.

Previous postings can be found at [0], [1], [4], [5].

The patches can be split as

* Patches 1-3, 9 cleanups and improvements

* Patch 4 addresses the break-before-make requirement of the
  architecture for contiguous hugepages.

* Patch 5-7 add support for handling swap entries for contiguous pte
  hugepages.

* Patch 8 enables contiguous hugepage support for arm64

All the dependent series ([2], [3]) for enabling contiguous hugepage
support have been merged in the previous cycle. Additionally, a patch
to clarify the semantics of huge_pte_offset() in generic code[6] is
currently in the -mm tree.

The patches are based on v4.13-rc3. If there are no further comments
please consider merging for the next release cycle.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg570422.html
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/497027.html
[2] https://www.spinics.net/lists/arm-kernel/msg581657.html
[3] https://www.spinics.net/lists/arm-kernel/msg583342.html
[4] https://www.spinics.net/lists/arm-kernel/msg583367.html
[5] https://www.spinics.net/lists/arm-kernel/msg582758.html
[6] https://lkml.org/lkml/2017/7/25/536

Changes v4 -> v5
* Rebased on v4.13-rc3

Changes v3 -> v4
* Moved Patches 2 and 4 to [3] due to dependencies

Changes v2 -> v3
* Rebased on v4.12-rc2
* Included swap related fixes in this series
* Enable contiguous pte hugepages

Changes v1 -> v2:
* Marked patch 2 for stable
* Fixed comment issues in patch 7
* Added tags
  
Punit Agrawal (4):
  arm64: hugetlb: Handle swap entries in huge_pte_offset() for
    contiguous hugepages
  arm64: hugetlb: Override huge_pte_clear() to support contiguous
    hugepages
  arm64: hugetlb: Override set_huge_swap_pte_at() to support contiguous
    hugepages
  arm64: Re-enable support for contiguous hugepages

Steve Capper (5):
  arm64: hugetlb: set_huge_pte_at Add WARN_ON on !pte_present
  arm64: hugetlb: Introduce pte_pgprot helper
  arm64: hugetlb: Spring clean huge pte accessors
  arm64: hugetlb: Add break-before-make logic for contiguous entries
  arm64: hugetlb: Cleanup setup_hugepagesz

 arch/arm64/include/asm/hugetlb.h |   9 +-
 arch/arm64/mm/hugetlbpage.c      | 287 ++++++++++++++++++++++++++++-----------
 2 files changed, 213 insertions(+), 83 deletions(-)

-- 
2.11.0
