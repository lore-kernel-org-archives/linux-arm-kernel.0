From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Mar 2018 17:15:30 +0000
Subject: [PATCH v4 0/5] arm64/kernel: get rid of GCC large model code
Message-ID: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC's large model uses literal pools to emit cross object symbol
references rather than movz/movk sequences, resulting in data items
mixed in the with executable code in modules' .text segments, reducing
cache utilization, but also potentially resulting in the creation of
code gadgets that are exploitable under speculative execution.

We are using GCC's large model for two separate reasons, both of which can
be worked around rather easily:
- KASLR uses it to move modules and the kernel very far apart, which is
  not really needed,
- the Cortex-A53 erratum code uses it to avoid ADRP instruction altogether,
  which can be replaced by selective patching of only the ADRP instructions
  that are affected by the erratum

v4:
- dropped RFC prefix
- added patch #1 and #4
- use _AC() for new SIZE_4G constant with ULL prefix (#2)
- improve comments, get rid of BUG() when running out of PLT entries (#3)
- rely on new REVIDR checking code (#5)

Ard Biesheuvel (5):
  arm64: module: don't BUG when exceeding preallocated PLT count
  arm64/kernel: kaslr: reduce module randomization range to 4 GB
  arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419
  arm64/errata: add REVIDR handling to framework
  arm64/kernel: enable A53 erratum #8434319 handling at runtime

 arch/arm64/Kconfig                  | 18 ++--
 arch/arm64/Makefile                 |  5 --
 arch/arm64/include/asm/cpucaps.h    |  3 +-
 arch/arm64/include/asm/cpufeature.h |  4 +
 arch/arm64/include/asm/module.h     |  2 +
 arch/arm64/kernel/cpu_errata.c      | 31 ++++++-
 arch/arm64/kernel/kaslr.c           | 20 +++--
 arch/arm64/kernel/module-plts.c     | 90 +++++++++++++++++++-
 arch/arm64/kernel/module.c          | 42 +++++++--
 arch/arm64/kernel/reloc_test_core.c |  4 +-
 arch/arm64/kernel/reloc_test_syms.S | 12 ++-
 include/linux/sizes.h               |  4 +
 12 files changed, 191 insertions(+), 44 deletions(-)

-- 
2.11.0
