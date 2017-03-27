From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 27 Mar 2017 10:27:19 +0100
Subject: [PATCH v2 0/7] arm64: hugetlb cleanup + break-before-make fixes
Message-ID: <20170327092726.31730-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Posting this series on behalf of Steve ]

Changes v1[0] -> v2:
* Marked patch 2 for stable
* Fixed comment issues in patch 7
* Added tags

It has become apparent that one has to take special care when
modifying attributes of memory mappings that employ the contiguous
bit.

Both the requirement and the architecturally correct
"Break-Before-Make" technique of updating contiguous entries can be
found described in: ARM DDI 0487A.k_iss10775, "Misprogramming of the
Contiguous bit", page D4-1762.

The huge pte accessors currently replace the attributes of contiguous
pte entries in place thus can, on certain platforms, lead to TLB
conflict aborts or even erroneous results returned from TLB lookups.

This patch series adds the required break-before-make logic to the
contiguous bit hugetlb accessors.

In order to simplify the break-before-make logic (and the patch
review), we first simplify the existing code.

During the course of this simplification I have found a bug whereby
spurious calls were being made to huge_ptep_offset by other accessors.
Also, a pre-emptive, WARN_ON is added to set_huge_pte_at in case it is
supplied with swp/migration entries unexpectedly (from
MEMORY_FAILURE).

[0] https://www.spinics.net/lists/arm-kernel/msg570422.html

Steve Capper (7):
  arm64: hugetlb: set_huge_pte_at Add WARN_ON on !pte_present
  arm64: hugetlb: Cleanup setup_hugepagesz
  arm64: hugetlb: Refactor find_num_contig
  arm64: hugetlb: Introduce pte_pgprot helper
  arm64: hugetlb: Remove spurious calls to huge_ptep_offset
  arm64: hugetlb: Spring clean huge pte accessors
  arm64: hugetlb: Add break-before-make logic for contiguous entries

 arch/arm64/mm/hugetlbpage.c | 236 ++++++++++++++++++++++++++------------------
 1 file changed, 138 insertions(+), 98 deletions(-)

-- 
2.11.0
