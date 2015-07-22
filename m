From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 22 Jul 2015 13:30:32 +0300
Subject: [PATCH v3 0/5] KASAN for arm64
Message-ID: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For git users patches are available in git:
 	git://github.com/aryabinin/linux.git kasan/arm64v3

Changes since v2:
 - Rebase on top of v4.2-rc3
 - Address feedback from Catalin.
 - Print memory assignment fro Linus
 - Add message about KASAN being initialized

Changes since v1:
 - Address feedback from Catalin.
 - Generalize some kasan init code from arch/x86/mm/kasan_init_64.c
    and reuse it for arm64.
 - Some bugfixes, including:
   	add missing arm64/include/asm/kasan.h
	add tlb flush after changing ttbr1
 - Add code comments.


Andrey Ryabinin (4):
  mm: kasan: introduce generic kasan_populate_zero_shadow()
  arm64: introduce VA_START macro - the first kernel virtual address.
  arm64: move PGD_SIZE definition to pgalloc.h
  arm64: add KASAN support

Linus Walleij (1):
  ARM64: kasan: print memory assignment

 arch/arm64/Kconfig               |  17 ++++
 arch/arm64/include/asm/kasan.h   |  24 ++++++
 arch/arm64/include/asm/memory.h  |   2 +
 arch/arm64/include/asm/pgalloc.h |   1 +
 arch/arm64/include/asm/pgtable.h |   9 +-
 arch/arm64/include/asm/string.h  |  16 ++++
 arch/arm64/kernel/arm64ksyms.c   |   3 +
 arch/arm64/kernel/head.S         |   3 +
 arch/arm64/kernel/module.c       |  16 +++-
 arch/arm64/kernel/setup.c        |   2 +
 arch/arm64/lib/memcpy.S          |   3 +
 arch/arm64/lib/memmove.S         |   7 +-
 arch/arm64/lib/memset.S          |   3 +
 arch/arm64/mm/Makefile           |   3 +
 arch/arm64/mm/init.c             |   6 ++
 arch/arm64/mm/kasan_init.c       | 176 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/pgd.c              |   2 -
 arch/x86/mm/kasan_init_64.c      |   8 +-
 include/linux/kasan.h            |   8 ++
 mm/kasan/Makefile                |   2 +-
 mm/kasan/kasan_init.c            | 142 +++++++++++++++++++++++++++++++
 21 files changed, 440 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan.h
 create mode 100644 arch/arm64/mm/kasan_init.c
 create mode 100644 mm/kasan/kasan_init.c

-- 
2.4.5
