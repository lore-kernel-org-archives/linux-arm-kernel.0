From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:22 +0100
Subject: [RFC PATCH 00/10] arm64: restrict __pa translation to linear virtual
 addresses
Message-ID: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pointed out by Will, performing non-trivial arithmetic in the implementation
of __pa() may affect performance. So instead of allowing __pa() to deal with
addresses that are either covered by the kernel mappin in the vmalloc area, or
by the linear region, let's restrict ourselves to the latter.

This involves replacing some __pa() translations with a specific translation
for kernel symbols (__pa_symbol), but other than that it is fairly
straightforward (except KASAN is being a pain again, but for the purpose of this
discussion that should not matter too much)

Patch #1 is a fix for a bug that I spotted  while working on this.

Patch #2 introduces the new translations __kimg_to_phys and __pa_symbol. They
do exactly the same but the former matches the existing __phys_to_kimg, and the
latter already exists on x86 as well for translating 'symbols visible to C code'

Patch #3 - #9 replace various instances of __pa() translations involving virtual
addresses pointing into the kernel image.

Patch #10 finally removes the comparison against PAGE_OFFSET from the
implementation of __virt_to_phys(), so that it can only be used for addresses
that are known to be in the linear region.

git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-pa-linear-mapping

Ard Biesheuvel (10):
  arm64: mm: move assignment of 'high_memory' before its first use
  arm64: introduce __kimg_to_phys() and __pa_symbol()
  arm64: mm: avoid __pa translations in cpu_replace_ttbr1
  arm64: mm: avoid __pa translations on empty_zero_page
  arm64: mm: avoid __pa translations in early_fixmap_init
  arm64: mm: use __pa_symbol() not __pa() for section boundary symbols
  arm64: mm: avoid __pa translations for idmap_pg_dir and swapper_pg_dir
  arm64: vdso: avoid __pa translations
  arm64: insn: avoid __pa translations
  arm64: mm: restrict __pa() translations to linear virtual addresses

 arch/arm64/include/asm/memory.h      | 15 ++++++++----
 arch/arm64/include/asm/mmu_context.h | 10 ++++----
 arch/arm64/include/asm/pgalloc.h     |  2 --
 arch/arm64/include/asm/pgtable.h     |  2 +-
 arch/arm64/kernel/insn.c             |  2 +-
 arch/arm64/kernel/setup.c            |  8 +++----
 arch/arm64/kernel/vdso.c             |  5 ++--
 arch/arm64/mm/init.c                 | 13 +++++++----
 arch/arm64/mm/mmu.c                  | 24 ++++++++++----------
 9 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.5.0
