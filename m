From: steve.capper@arm.com (Steve Capper)
Date: Fri, 21 Sep 2018 16:34:03 +0100
Subject: [PATCH V2 0/2] Fixes for contiguous hugetlb
Message-ID: <20180921153405.10090-1-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series addresses a couple of issues found with contiguous hugetlb.

1) It is possible for old hugetlb's to be created by remove_migration_pte, the
   first patch adjusts the code to capture any young ptes that could have been
   created by hardware dirty bit management.

2) huge_ptep_set_access_flags has been changed in the second patch to prevent it
   from unnecessarily invalidating contiguous hugetlb mappings (which also stops
   it from potentially evoking back-to-back page faults).

These patches have not yet been tested on hardware. 

Steve Capper (2):
  arm64: hugetlb: Fix handling of young ptes
  arm64: hugetlb: Avoid unnecessary clearing in
    huge_ptep_set_access_flags

 arch/arm64/mm/hugetlbpage.c | 50 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

-- 
2.11.0
