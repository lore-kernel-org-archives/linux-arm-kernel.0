From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 09:46:44 +0100
Subject: [PATCH 0/2] use adrp/add pairs for PLT entries
Message-ID: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, PLT entries use a non-idiomatic movn/movz/movz/br instruction
sequence which is also longer than necessary. Also, the code emitting
them does not use the instruction generation code but open codes the
opcodes directly.

The extended KASLR range is now 4 GB, given that we switched to the
small code model everywhere else (including for modules), so we can
switch to adrp/add/br sequences which are easier in the I-cache.

So implement adrp/add pair generation in the instruction generation code
and wire it up into the PLT code. Note that the Cortex-A53 errata handling
requires some special care to ensure that generated veneers are not
susceptible to the erratum.

Cc: Torsten Duwe <duwe@lst.de>
Cc: Jessica Yu <jeyu@kernel.org>

Ard Biesheuvel (2):
  arm64/insn: add support for emitting ADR/ADRP instructions
  arm64/module: switch to ADRP/ADD sequences for PLT entries

 arch/arm64/include/asm/insn.h   |  8 ++
 arch/arm64/include/asm/module.h | 36 ++------
 arch/arm64/kernel/ftrace.c      |  2 +-
 arch/arm64/kernel/insn.c        | 29 ++++++
 arch/arm64/kernel/module-plts.c | 93 +++++++++++++++-----
 arch/arm64/kernel/module.c      |  4 +-
 6 files changed, 119 insertions(+), 53 deletions(-)

-- 
2.17.1
