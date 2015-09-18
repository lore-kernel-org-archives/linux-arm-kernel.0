From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 18 Sep 2015 17:39:58 +0200
Subject: [PATCH v1 0/2] arm64: runtime workaround for erratum #843419
Message-ID: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements a workaround for the A53 erratum that may result in adrp
instructions to produce incorrect values if they appear in either of
the last two instruction slots of a 4 KB page.

Instead of building modules using the large code model, this approach
uses veneers to call the adrp instructions at unaffected offsets, unless
they can be converted into adr instructions, which is even better (this
depends on whether the symbol is with 1 MB of the place)

Changes since RFC/v0:
- use correct relocation entry type (RELA not REL)
- put veneers in .text or .init.text instead of dedicated sections: this way,
  modules remain compatible regardless of whether they were built with
  CONFIG_ARM64_MOD_VENEERS enabled
- allocate veneer space for all adrp instructions we encounter, since the check
  is performed before the module is at its final vmalloc address
- fix Kconfig text
- some cosmetic changes

Comments welcome.

Ard Biesheuvel (2):
  arm64: introduce infrastructure for emitting veneers at module reloc
    time
  arm64: errata: add module load workaround for erratum #843419

 arch/arm64/Kconfig                   |  24 ++++
 arch/arm64/include/asm/mod_veneers.h |  20 +++
 arch/arm64/include/asm/module.h      |  11 ++
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/mod_veneers.c      | 138 ++++++++++++++++++++
 arch/arm64/kernel/module.c           |  34 +++++
 6 files changed, 228 insertions(+)
 create mode 100644 arch/arm64/include/asm/mod_veneers.h
 create mode 100644 arch/arm64/kernel/mod_veneers.c

-- 
1.9.1
