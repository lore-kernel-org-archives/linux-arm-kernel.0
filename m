From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Aug 2016 13:59:33 +0200
Subject: [PATCH v2 0/3] ARM: kernel: module PLT optimizations
Message-ID: <1471435176-13146-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Jongsung, the O(n^2) search in the PLT allocation code may
disproportionately affect module load time for modules with a larger number
of relocations.

Since the existing routines rather naively take branch instructions into
account that are internal to the module, we can improve the situation
significantly by checking the symbol section index first, and disregarding
symbols that are defined in the same module. Also, we can reduce the
algorithmic complexity to O(n log n) by sorting the reloc section before
processing it, and disregarding zero-addend relocations in the optimization.

Patch #1 merge the core and init PLTs, since the latter is virtually empty
anyway.

Patch #2 implements the optimization to only take SHN_UNDEF symbols into
account.

Patch #3 sort the reloc section, so that the duplicate check can be done by
comparing an entry with the previous one. Since REL entries (as opposed to
RELA entries) do not contain the addend, simply disregard non-zero addends
in the optimization since those are rare anyway.

v2: added patch #3

Ard Biesheuvel (3):
  ARM: kernel: merge core and init PLTs
  ARM: kernel: allocate PLT entries only for external symbols
  ARM: kernel: sort relocation sections before allocating PLTs

 arch/arm/include/asm/module.h |   6 +-
 arch/arm/kernel/module-plts.c | 208 ++++++++++++--------
 arch/arm/kernel/module.lds    |   3 +-
 3 files changed, 132 insertions(+), 85 deletions(-)

-- 
2.7.4
