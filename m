From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 17 Sep 2015 21:38:53 +0200
Subject: [RFC PATCH 0/2] arm64: runtime workaround for erratum #843419
Message-ID: <1442518735-16625-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements a workaround for the A53 erratum that results in adrp
instructions to produce incorrect values if they appear in either of
the last two instruction slots of a 4 KB page.

Instead of building modules using the large code model, this approach
uses veneers to call the adrp instructions at unaffected offsets, unless
they can be converted into adr instructions, which is even better (this
depends on whether the symbol is with 1 MB of the place)

Comments welcome.

Ard Biesheuvel (2):
  arm64: introduce infrastructure for emitting veneers at module reloc
    time
  arm64: errata: add module load workaround for erratum #843419

 arch/arm64/Kconfig               |  21 +++
 arch/arm64/Makefile              |   4 +
 arch/arm64/include/asm/module.h  |   9 ++
 arch/arm64/include/asm/veneers.h |  19 +++
 arch/arm64/kernel/Makefile       |   1 +
 arch/arm64/kernel/module.c       |  33 +++++
 arch/arm64/kernel/module.lds     |   4 +
 arch/arm64/kernel/veneers.c      | 134 ++++++++++++++++++++
 8 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/include/asm/veneers.h
 create mode 100644 arch/arm64/kernel/module.lds
 create mode 100644 arch/arm64/kernel/veneers.c

-- 
1.9.1
