From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu,  8 Jun 2017 18:25:25 +0100
Subject: [PATCH v3 0/4] arm64: Add support for handling memory corruption
Message-ID: <20170608172529.11986-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series enables memory failure handling for arm64. Previous
posting can be found at [0] and [1].

Changelog

v2 -> v3:

* Added a new patch to update the perf accounting for fault handling
  (patch 3)
* Added test and review tags

v1 -> v2:

* Reworked Patch 1 based on Catalin's feedbak to symmetrically deal
  with PUD and PMD hugepages in huge_pte_offset()
* Added Steve's acks

With support for contiguous hugepages being turned off[2], some of the
problems arising from swap entries go away[3]. This simplifies the
changes needed to enable memory corruption handling for arm64 (done in
this seris).

In this series, we updates huge_pte_offset() to correctly deal with
swap entries (Patch 1). This function will need to be updated when
contiguous hugepages are re-enabled.

Patch 2 adds support to send SIGBUS to processes that have their
memory corrupted.

Patch 3 updates the perf accounting for memory faults to exclude
hwpoison faults.

With the prerequisites in place, enable memory corruption handling for
arm64 (patch 4).

Thanks,
Punit

[0] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1376052.html
[1] https://www.spinics.net/lists/arm-kernel/msg581657.html
[1] https://lkml.org/lkml/2017/4/7/486
[2] https://lkml.org/lkml/2017/4/5/402

Jonathan (Zhixiong) Zhang (2):
  arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
  arm64: kconfig: allow support for memory failure handling

Punit Agrawal (2):
  arm64: hugetlb: Fix huge_pte_offset to return poisoned page table
    entries
  arm64: mm: Update perf accounting to handle poison faults

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/mm/fault.c            | 90 ++++++++++++++++++++++++----------------
 arch/arm64/mm/hugetlbpage.c      | 29 +++++--------
 4 files changed, 67 insertions(+), 55 deletions(-)

-- 
2.11.0
