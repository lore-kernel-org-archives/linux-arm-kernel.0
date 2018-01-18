From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Jan 2018 14:45:21 +0000
Subject: [RFC PATCH v2 0/3] arm64/kernel: get rid of GCC large model code
Message-ID: <20180118144524.18704-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC's large model uses literal pools to emit cross object symbol
references rather than movz/movk sequences, resulting in data items
mixed in the with executable code in modules' .text segments. This
is a potential cause for reduced performance (although no real world
scenarios are known), but may result in code gadgets that are exploitable
under speculative execution.

We are using GCC's large model for two separate, both of which can be
worked around rather easily:
- KASLR uses it to move modules and the kernel very far apart, which is
  not really needed,
- the Cortex-A53 erratum code uses it to avoid ADRP instruction altogether,
  which can be replaced by selective patching of only the ADRP instructions
  that are affected by the erratum

Ard Biesheuvel (3):
  arm64/kernel: kaslr: reduce module randomization range to 4 GB
  arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419
  arm64/kernel: enable A53 erratum #8434319 handling at runtime

 arch/arm64/Kconfig                  | 18 ++---
 arch/arm64/Makefile                 |  5 --
 arch/arm64/include/asm/cpucaps.h    |  3 +-
 arch/arm64/include/asm/module.h     |  2 +
 arch/arm64/kernel/cpu_errata.c      | 26 +++++++
 arch/arm64/kernel/kaslr.c           | 20 +++--
 arch/arm64/kernel/module-plts.c     | 79 +++++++++++++++++++-
 arch/arm64/kernel/module.c          | 43 +++++++++--
 arch/arm64/kernel/reloc_test_core.c |  4 +-
 arch/arm64/kernel/reloc_test_syms.S | 12 ++-
 include/linux/sizes.h               |  2 +
 11 files changed, 176 insertions(+), 38 deletions(-)

-- 
2.11.0
