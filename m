From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Tue,  2 Oct 2018 17:45:27 +0530
Subject: [PATCH 0/4] arm64/mm: Enable HugeTLB migration
Message-ID: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables HugeTLB migration support for all supported
huge page sizes at all levels including contiguous bit implementation.
Following HugeTLB migration support matrix has been enabled with this
patch series. All permutations have been tested except for the 16GB.

         CONT PTE    PMD    CONT PMD    PUD
         --------    ---    --------    ---
4K:         64K     2M         32M     1G
16K:         2M    32M          1G
64K:         2M   512M         16G

First the series adds migration support for PUD based huge pages. It
then adds a platform specific hook to query an architecture if a
given huge page size is supported for migration while also providing
a default fallback option preserving the existing semantics which just
checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
HugeTLB migration on arm64 and subscribe to this new platform specific
hook by defining an override.

Anshuman Khandual (4):
  mm/hugetlb: Enable PUD level huge page migration
  mm/hugetlb: Enable arch specific huge page size support for migration
  arm64/mm: Enable HugeTLB migration
  arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages

 arch/arm64/Kconfig               |  4 ++++
 arch/arm64/include/asm/hugetlb.h |  5 +++++
 arch/arm64/mm/hugetlbpage.c      | 20 ++++++++++++++++++++
 include/linux/hugetlb.h          | 18 +++++++++++++++---
 4 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.7.4
