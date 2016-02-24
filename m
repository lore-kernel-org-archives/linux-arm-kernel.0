From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Feb 2016 17:21:27 +0100
Subject: [RFC PATCH 0/6] restrict virt_to_page to linear region (instead of
 __pa)
Message-ID: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another approach, and another bugfix in patch #1; this series supersedes the
__pa replacement series I sent out two days ago.

While looking into the [alleged] performance hit we are taking due to the
virt_to_phys() changes that are queued up, I noticed two things:

(a) I broke vmemmap in commit dd006da21646 ("arm64: mm: increase VA range of
    identity map"), since it results in the struct page array corresponding
    with the memory outside of the VA range to be mapped outside the vmemmap
    range as well. This can be worked around fairly easily by making the
    vmemmap range a projection of the virtual linear range rather than the
    physical range (patch #1). This is a bugfix, and should probably go to
    -stable?

(b) Once we have the fix for (a) in place, the relation between a page in the
    linear region and its struct page in the vmemmap region is no longer based
    on the placement of physical RAM, and we can reimplement virt_to_page()
    without regard for PHYS_OFFSET, and base it entirely on arithmetic involving
    build time constants only, which hopefully helps regain some performance we
    [allegedly] lost (patch #6)

In a couple of cases (#2 - #5), a fixup is needed similar to the fixups in my
__pa() replacement series, to prevent virt_to_page() being used on kernel
symbols. Other than that, the code does look somewhat cleaner, and it is
arguably more reasonable to restrict virt_to_page() to linear addresses than it
is to restrict __pa().

As far as the performance is concerned, I wonder how many __pa translations
remain on hot paths after eliminating it from virt_to_page(). Suggestions
for testing the performance gain/loss are appreciated. (hackbench?)

Ard Biesheuvel (6):
  arm64: vmemmap: use virtual projection of linear region
  arm64: vdso: avoid virt_to_page() translations on kernel symbols
  arm64: mm: free __init memory via the linear mapping
  arm64: mm: avoid virt_to_page() translation for the zero page
  kernel: insn: avoid virt_to_page() translations on core kernel symbols
  arm64: mm: restrict virt_to_page() to the linear mapping

 arch/arm64/include/asm/memory.h  | 9 ++++++++-
 arch/arm64/include/asm/pgtable.h | 9 +++++----
 arch/arm64/kernel/insn.c         | 2 +-
 arch/arm64/kernel/vdso.c         | 7 ++++---
 arch/arm64/mm/init.c             | 7 ++++---
 5 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.5.0
