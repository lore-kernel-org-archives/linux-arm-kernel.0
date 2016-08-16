From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Aug 2016 17:51:44 +0200
Subject: [PATCH 0/2] ARM: kernel: module PLT optimizations
Message-ID: <1471362706-29859-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Jongsung, the O(n^2) search in the PLT allocation code may
disproportionately affect module load time for modules with a larger number
of relocations.

Since the existing routines rather naively take branch instructions into
account that are internal to the module, we can improve the situation
significantly by checking the symbol section index first, and disregarding
symbols that are defined in the same module.

Patch #1 merge the core and init PLTs, since the latter is virtually empty
anyway.

Patch #2 implements the optimization to only take SHN_UNDEF symbols into
account.

Ard Biesheuvel (2):
  ARM: kernel: merge core and init PLTs
  ARM: kernel: allocate PLT entries only for external symbols

 arch/arm/include/asm/module.h |   6 +-
 arch/arm/kernel/module-plts.c | 100 ++++++++++----------
 arch/arm/kernel/module.lds    |   3 +-
 3 files changed, 53 insertions(+), 56 deletions(-)

-- 
2.7.4
