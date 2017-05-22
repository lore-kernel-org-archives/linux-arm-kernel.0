From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 22 May 2017 15:39:46 +0100
Subject: [PATCH v3 00/11] arm64: Enable contiguous pte hugepage support
Message-ID: <20170522143958.12867-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset addresses all the known issues with contiguous hugetlb
pages. Support for contiguous hugepages is useful on systems where the
PMD hugepage size is too large (512MB hugepage when using 64k page
granule) and contiguous hugepages can be used to provide reasonable
hugepage sizes to the user.

The patches can be split as 

* Patches 1-5, 11 cleanups and improvements

* Patch 6 addresses the break-before-make requirement of the
  architecture for contiguous hugepages. These patches depend on
  enabling memory failure handling on arm64[2].

* Patch 7-9 add support for handling swap entries for contiguous pte
  hugepages. These patches depend on fixes to core code required to
  support contiguous hugepages[3].

* Patch 10 enables contiguous hugepage support for arm64

The patches are based on v4.12-rc2. Previous postings can be found at
[0], [1].

All feedback welcome.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg570422.html
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/497027.html
[2] https://www.spinics.net/lists/arm-kernel/msg581657.html
[3] https://www.spinics.net/lists/arm-kernel/msg582682.html

Changes v2 -> v3
* Rebased on v4.12-rc2
* Included swap related fixes in this series
* Enable contiguous pte hugepages

Changes v1 -> v2:
* Marked patch 2 for stable
* Fixed comment issues in patch 7
* Added tags

Punit Agrawal (4):
  arm64: hugetlbpages: Handle swap entries in huge_pte_offset() for
    contiguous hugepages
  arm64: hugetlb: Override huge_pte_clear() to support contiguous
    hugepages
  arm64: hugetlb: Override set_huge_swap_pte_at() to support contiguous
    hugepages
  arm64: Re-enable support for contiguous hugepages

Steve Capper (7):
  arm64: hugetlb: set_huge_pte_at Add WARN_ON on !pte_present
  arm64: hugetlb: Refactor find_num_contig
  arm64: hugetlb: Introduce pte_pgprot helper
  arm64: hugetlb: Remove spurious calls to huge_ptep_offset
  arm64: hugetlb: Spring clean huge pte accessors
  arm64: hugetlb: Add break-before-make logic for contiguous entries
  arm64: hugetlb: Cleanup setup_hugepagesz

 arch/arm64/mm/hugetlbpage.c | 305 ++++++++++++++++++++++++++++++--------------
 1 file changed, 209 insertions(+), 96 deletions(-)

-- 
2.11.0
