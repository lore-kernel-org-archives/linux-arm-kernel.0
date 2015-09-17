From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 17 Sep 2015 12:38:06 +0300
Subject: [PATCH v6 0/6] KASAN for arm64
Message-ID: <1442482692-6416-1-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual patches available in git
	git://github.com/aryabinin/linux.git kasan/arm64v6

Changes since v5:
 - Rebase on top of 4.3-rc1
 - Fixed EFI boot.
 - Updated Doc/features/KASAN.

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
  arm64: introduce VA_START macro - the first kernel virtual address.
  arm64: move PGD_SIZE definition to pgalloc.h
  x86, efi, kasan: #undef memset/memcpy/memmove per arch.
  arm64: add KASAN support
  Documentation/features/KASAN: arm64 supports KASAN now

Linus Walleij (1):
  ARM64: kasan: print memory assignment

 .../features/debug/KASAN/arch-support.txt          |   2 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/Makefile                                |   7 +
 arch/arm64/include/asm/kasan.h                     |  36 +++++
 arch/arm64/include/asm/memory.h                    |   2 +
 arch/arm64/include/asm/pgalloc.h                   |   1 +
 arch/arm64/include/asm/pgtable.h                   |   9 +-
 arch/arm64/include/asm/string.h                    |  16 ++
 arch/arm64/kernel/Makefile                         |   2 +
 arch/arm64/kernel/arm64ksyms.c                     |   3 +
 arch/arm64/kernel/head.S                           |   3 +
 arch/arm64/kernel/module.c                         |  16 +-
 arch/arm64/kernel/setup.c                          |   4 +
 arch/arm64/lib/memcpy.S                            |   3 +
 arch/arm64/lib/memmove.S                           |   7 +-
 arch/arm64/lib/memset.S                            |   3 +
 arch/arm64/mm/Makefile                             |   3 +
 arch/arm64/mm/init.c                               |   6 +
 arch/arm64/mm/kasan_init.c                         | 165 +++++++++++++++++++++
 arch/arm64/mm/pgd.c                                |   2 -
 arch/x86/include/asm/efi.h                         |  12 ++
 drivers/firmware/efi/Makefile                      |   8 +
 drivers/firmware/efi/libstub/efistub.h             |   4 -
 lib/Makefile                                       |   3 +-
 scripts/Makefile.kasan                             |   4 +-
 25 files changed, 307 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan.h
 create mode 100644 arch/arm64/mm/kasan_init.c

-- 
2.4.6
