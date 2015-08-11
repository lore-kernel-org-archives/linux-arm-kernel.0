From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Tue, 11 Aug 2015 05:18:13 +0300
Subject: [PATCH v5 0/6]  KASAN for amr64
Message-ID: <1439259499-13913-1-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For git users patches are available in git:
        git://github.com/aryabinin/linux.git kasan/arm64v5

Changes since v4:
 - Generate KASAN_SHADOW_OFFSET using 32 bit arithmetic
 - merge patches x86/kasan: switch to generic kasan_populate_zero_shadow()
    and mm: introduce generic kasan_populate_zero_shadow() into one.
 - remove useless check for start != 0 in clear_pgds()
 - Don't generate KASAN_SHADOW_OFFSET in Makefile for x86,
   assign it in Makefile.kasan if CONFIG_KASAN_SHADOW_OFFSET was defined.
 
Changes since v3:
 - Generate KASAN_SHADOW_OFFSET in Makefile
 - zero_p*_populate() functions now return void
 - Switch x86 to generic kasan_populate_zero_shadow() too
 - Add license headers
 - fix memleak in kasan_populate_zero_shadow:
       Following code could leak memory when pgd_populate() is nop:
                void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
                pgd_populate(&init_mm, pgd, p);
        This was replaced by:
                 pgd_populate(&init_mm, pgd, early_alloc(PAGE_SIZE, NUMA_NO_NODE));

Changes since v2:
 - Rebase on top of v4.2-rc3
 - Address feedback from Catalin.
 - Print memory assignment from Linus
 - Add message about KASAN being initialized

Changes since v1:
 - Address feedback from Catalin.
 - Generalize some kasan init code from arch/x86/mm/kasan_init_64.c
    and reuse it for arm64.
 - Some bugfixes, including:
        add missing arm64/include/asm/kasan.h
        add tlb flush after changing ttbr1
 - Add code comments.

Andrey Ryabinin (5):
  x86/kasan: define KASAN_SHADOW_OFFSET per architecture
  x86/kasan, mm: introduce generic kasan_populate_zero_shadow()
  arm64: introduce VA_START macro - the first kernel virtual address.
  arm64: move PGD_SIZE definition to pgalloc.h
  arm64: add KASAN support

Linus Walleij (1):
  ARM64: kasan: print memory assignment

 arch/arm64/Kconfig               |   1 +
 arch/arm64/Makefile              |   7 ++
 arch/arm64/include/asm/kasan.h   |  36 +++++++++
 arch/arm64/include/asm/memory.h  |   2 +
 arch/arm64/include/asm/pgalloc.h |   1 +
 arch/arm64/include/asm/pgtable.h |   9 ++-
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
 arch/arm64/mm/kasan_init.c       | 165 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/pgd.c              |   2 -
 arch/x86/include/asm/kasan.h     |   3 +
 arch/x86/mm/kasan_init_64.c      | 123 ++---------------------------
 include/linux/kasan.h            |  10 ++-
 mm/kasan/Makefile                |   2 +-
 mm/kasan/kasan_init.c            | 152 ++++++++++++++++++++++++++++++++++++
 scripts/Makefile.kasan           |   4 +-
 24 files changed, 450 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan.h
 create mode 100644 arch/arm64/mm/kasan_init.c
 create mode 100644 mm/kasan/kasan_init.c

-- 
2.4.6
