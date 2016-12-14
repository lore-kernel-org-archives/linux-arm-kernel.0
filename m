From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Dec 2016 09:11:45 +0000
Subject: [PATCH 0/2] arm64: numa: fix spurious BUG() on NOMAP regions
Message-ID: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the issue reported by Robert Richter where the fact that
the node id of struct pages covered by NOMAP regions is not initialized,
triggering a VM_BUG_ON() in the mm code.

I know that this approach is the least preferred option by Robert, but it
has been used successfully in the downstream Linaro Enterprise kernel,
running on HiSilicon D05, which suffered from the same issue as Cavium
ThunderX where it was originally reported.

Given that the other proposed solutions either fail to solve the issue
completely, or cause regressions in other code (hibernate), I think this
issue is appropriate for merging now, and backported to -stable. If there
are performance concerns, we can try to improve on this solution, which
could include reverting patch #2 altogether, for all I care.

Patch #1 fixes a bug in the generic mm code where a struct page is
dereferenced before pfn_valid() is called. This should probably go to
stable regardless of where the arm64 discussion goes.

Patch #2 enables CONFIG_HOLES_IN_ZONE for arm64 numa, causing the kernel
to no longer assume that all pages in a zone have valid struct pages
associated with them.

Ard Biesheuvel (2):
  mm: don't dereference struct page fields of invalid pages
  arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA

 arch/arm64/Kconfig | 4 ++++
 mm/page_alloc.c    | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.7.4
