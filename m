From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 12 Aug 2016 16:01:07 +0800
Subject: [PATCH v3 0/4] arm64: put objects into proper sections
Message-ID: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to put some objects into proper sections.

patch1 puts alloc_vectors_page() into .init section. This is a clean up
patch.
patch2 constify vm_special_mapping used for aarch32 vectors page.
patch3 fix the incorrect placement of __initdata and __read_mostly
patch4 apply __ro_after_init to some objects

Previously I only want to mark vdso_pages, vdso_spec, vectors_page and
cpu_ops as __read_mostly for performance reason. Then inspired by
Kees's patch[1], I think __ro_after_init is better.

[1] http://www.spinics.net/lists/arm-kernel/msg523188.html

Changes since v2:
  - include <linux/cache.h> for __ro_after_init, thank Mark's suggestions
  - make vdso_spec[0].pages and vdso_spec[1].pages assignment style
    consistent, thank Mark for pointing it out.

Changes since v1:
  - use __ro_after_init instead of __read_mostly
  - find more objects to be suitable for __ro_after_init
  - add one more patch to fix the incorrect placement of __initdata and
    __read_mostly


Jisheng Zhang (4):
  arm64: vdso: add __init section marker to alloc_vectors_page
  arm64: vdso: constify vm_special_mapping used for aarch32 vectors page
  arm64: kaslr: Fix incorrect placement of __initdata and __read_mostly
  arm64: apply __ro_after_init to some objects

 arch/arm64/kernel/cpu_ops.c |  2 +-
 arch/arm64/kernel/kaslr.c   |  4 ++--
 arch/arm64/kernel/vdso.c    | 32 ++++++++++++++++----------------
 arch/arm64/mm/dma-mapping.c |  2 +-
 arch/arm64/mm/init.c        |  4 ++--
 arch/arm64/mm/mmu.c         |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.8.1
