From: labbott@fedoraproject.org (Laura Abbott)
Date: Mon, 25 Jan 2016 08:52:11 -0800
Subject: [RFC][PATCH 0/4] ARCH_SUPPORTS_DEBUG_PAGEALLOC for arm64
Message-ID: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This series implements proper debug page alloc support for arm64.
Pages are unmapped on free. This series is based on top of Mark
Rutland's work to TLB conflicts in early MMU mapping
(lkml.kernel.org/g/<1451930211-22460-1-git-send-email-mark.rutland@arm.com>)
and Ard Biesheuvel's patch to allow set_memory_* to work on vmalloc
regions (<1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>)

The most important part is to force all memory to be mapped with page
mappings. Once that happens it's trivial to use the existing page_attr
infrastructure to clear the valid bit and cause faults. I know there was
an attempt at this a while back (can't find it in my archives) but the
changes by Mark make this significantly easier and probably with fewer
TLB conflicts.

As always, comments are appreciated.

Laura Abbott (4):
  arm64: Drop alloc function from create_mapping
  arm64: Add option to force mapping with PAGE_SIZE pages
  arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
  arm64: ptdump: Indicate whether memory should be faulting

 arch/arm64/Kconfig       | 14 ++++++++++++++
 arch/arm64/mm/dump.c     |  5 +++++
 arch/arm64/mm/mmu.c      | 24 +++++++++++++++++-------
 arch/arm64/mm/pageattr.c | 40 +++++++++++++++++++++++++++++++++-------
 4 files changed, 69 insertions(+), 14 deletions(-)

-- 
2.5.0
