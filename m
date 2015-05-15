From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 15 May 2015 16:58:59 +0300
Subject: [PATCH v2 0/5] KASan for arm64
Message-ID: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second iteration of kasan for arm64.

Patches available in git:
	git://github.com/aryabinin/linux.git kasan/arm64v2

Changes since v1:
 - Address feedback from Catalin.
 - Generalize some kasan init code from arch/x86/mm/kasan_init_64.c
    and reuse it for arm64.
 - Some bugfixes, including:
   	add missing arm64/include/asm/kasan.h
	add tlb flush after changing ttbr1
 - Add code comments.

Andrey Ryabinin (5):
  kasan, x86: move KASAN_SHADOW_OFFSET to the arch Kconfig
  x86: kasan: fix types in kasan page tables declarations
  x86: kasan: generalize populate_zero_shadow() code
  kasan, x86: move populate_zero_shadow() out of arch directory
  arm64: add KASan support

 arch/arm64/Kconfig                   |   7 ++
 arch/arm64/include/asm/kasan.h       |  24 ++++++
 arch/arm64/include/asm/pgtable.h     |   7 ++
 arch/arm64/include/asm/string.h      |  16 ++++
 arch/arm64/include/asm/thread_info.h |   8 ++
 arch/arm64/kernel/head.S             |   3 +
 arch/arm64/kernel/module.c           |  16 +++-
 arch/arm64/kernel/setup.c            |   2 +
 arch/arm64/lib/memcpy.S              |   3 +
 arch/arm64/lib/memmove.S             |   7 +-
 arch/arm64/lib/memset.S              |   3 +
 arch/arm64/mm/Makefile               |   3 +
 arch/arm64/mm/kasan_init.c           | 143 +++++++++++++++++++++++++++++++++++
 arch/x86/Kconfig                     |   4 +
 arch/x86/include/asm/kasan.h         |  10 +--
 arch/x86/mm/kasan_init_64.c          | 110 ++-------------------------
 include/linux/kasan.h                |   8 ++
 lib/Kconfig.kasan                    |   4 -
 mm/kasan/Makefile                    |   2 +-
 mm/kasan/kasan_init.c                | 136 +++++++++++++++++++++++++++++++++
 20 files changed, 396 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan.h
 create mode 100644 arch/arm64/mm/kasan_init.c
 create mode 100644 mm/kasan/kasan_init.c

-- 
2.4.0
