From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:14:56 +0200
Subject: [RFC v3 PATCH 0/7] ARM[64]: kernel mode NEON in atomic contexts
Message-ID: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take #3 of this RFC series.

Instead of having additional separate versions of kernel_neon_begin/end, the
existing ones now have been modified to always take a preallocated stack area
as an argument.

The stack area is allocated by DEFINE_NEON_REGSTACK[_PARTIAL](varname), where
the partial version takes an additional int num_regs indicating how many
registers need to be freed up.

In the !in_interrupt() case, these functions operate as before, and the regstack
is defined to minimal size in this case as it will remain unused anyway. In the
in_interrupt() case, 'num_regs' (or all) NEON registers are stacked/unstacked
using the allocated stack region.

Patches #1 and #4 implement the above for ARM and ARM64, respectively. Patch #3
implements the optimization for ARM64 suggested by Catalin, which has no lazy
restore, potentially resulting in lots of unnecessary stack/unstack sequences
otherwise.

The remaining patches are existing or new users of this API, for reference.

Ard Biesheuvel (7):
  ARM: add support for kernel mode NEON in atomic context
  ARM: port NEON version of xor_blocks() to new kmode NEON api
  ARM64: defer reloading a task's FPSIMD state to userland resume
  ARM64: add support for kernel mode NEON in atomic context
  ARM64: add Crypto Extensions based synchronous core AES cipher
  ARM64: add Crypto Extensions based synchronous AES in CCM mode
  lib/raid6: port NEON implementation to updated kmode NEON api

 arch/arm/include/asm/fpstate.h        |  12 +
 arch/arm/include/asm/neon.h           |  32 ++-
 arch/arm/include/asm/xor.h            |  48 ++--
 arch/arm/vfp/vfphw.S                  |  45 ++++
 arch/arm/vfp/vfpmodule.c              |  55 +++--
 arch/arm64/Makefile                   |  11 +-
 arch/arm64/crypto/Makefile            |  14 ++
 arch/arm64/crypto/aes-sync.c          | 453 ++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aesce-ccm.S         | 186 ++++++++++++++
 arch/arm64/include/asm/fpsimd.h       |  17 ++
 arch/arm64/include/asm/fpsimdmacros.h |  35 +++
 arch/arm64/include/asm/neon.h         |  31 ++-
 arch/arm64/include/asm/thread_info.h  |   4 +-
 arch/arm64/kernel/entry-fpsimd.S      |  24 ++
 arch/arm64/kernel/entry.S             |   2 +-
 arch/arm64/kernel/fpsimd.c            |  34 +--
 arch/arm64/kernel/signal.c            |   2 +
 lib/raid6/neon.c                      |   9 +-
 18 files changed, 932 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-sync.c
 create mode 100644 arch/arm64/crypto/aesce-ccm.S

-- 
1.8.1.2
