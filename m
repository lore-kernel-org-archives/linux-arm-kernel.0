From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 15 Aug 2016 14:45:43 +0800
Subject: [PATCH v4 0/3] arm64: put objects into proper sections
Message-ID: <1471243546-3090-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to put some objects into proper sections.

patch1 puts alloc_vectors_page() into .init section. This is a clean up
patch.
patch2 constify vm_special_mapping used for aarch32 vectors page.
patch3 apply __ro_after_init to some objects

Previously I only want to mark vdso_pages, vdso_spec, vectors_page and
cpu_ops as __read_mostly for performance reason. Then inspired by
Kees's patch[1], I think __ro_after_init is better.

[1] http://www.spinics.net/lists/arm-kernel/msg523188.html

Changes since v3:
  - add <linux/cache.h> for remaining .c files. Thank Mark.
  - make vdso.c headers sorted. Suggested by Mark.
  - remove patch3 in v2 which turns out a style issue, the usage is
    correct.

Changes since v2:
  - include <linux/cache.h> for __ro_after_init, thank Mark's suggestions
  - make vdso_spec[0].pages and vdso_spec[1].pages assignment style
    consistent, thank Mark for pointing it out.

Changes since v1:
  - use __ro_after_init instead of __read_mostly
  - find more objects to be suitable for __ro_after_init
  - add one more patch to fix the incorrect placement of __initdata and
    __read_mostly



Jisheng Zhang (3):
  arm64: vdso: add __init section marker to alloc_vectors_page
  arm64: vdso: constify vm_special_mapping used for aarch32 vectors page
  arm64: apply __ro_after_init to some objects

 arch/arm64/kernel/cpu_ops.c |  3 ++-
 arch/arm64/kernel/kaslr.c   |  3 ++-
 arch/arm64/kernel/vdso.c    | 34 +++++++++++++++++-----------------
 arch/arm64/mm/dma-mapping.c |  3 ++-
 arch/arm64/mm/init.c        |  5 +++--
 arch/arm64/mm/mmu.c         |  3 ++-
 6 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.8.1
