From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:40 +0200
Subject: [PATCH 0/8] arm64: kaslr cleanups and improvements
Message-ID: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow up to my series 'arm64: more granular KASLR' [1] that I sent
out about six weeks ago. It also partially supersedes [2].

The first patch is an unrelated cleanup that is completely orthogonal (but
happens to touch head.S as well) and is arbitrarily listed first.

Patches #2 to #5 address some issues that were introduced by KASLR, primarily
that we now have to take great care to only dereference literals that are
subject to R_AARCH64_AB64 relocations until after the relocation routine has
completed, and, since the latter runs with the caches on, take care not to
derefence such literals on secondaries until the MMU is enabled.

Formerly, this was addressed by using literals holding complicated expressions
that can be resolved at link time via R_AARCH64_PREL64/R_AARCH64_PREL32
relocations, and by explicitly cleaning these literals in the caches so that
the secondaries can see them with the MMU off.

Instead, take care not to use /any/ 64-bit literals until after the relocation
code has executed, and after the MMU is enabled. This makes the code a lot
cleaner, and less error prone.

The final three patches enhance the KASLR code, by dealing with relocatable
kernels whose physical placement is not TEXT_OFFSET bytes beyond a 2 MB aligned
base address, and by using this capability deliberately to allow for 5 bits of
additional entropy to be used.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/483819
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/490216

Ard Biesheuvel (8):
  arm64: kernel: don't export local symbols from head.S
  arm64: kernel: use literal for relocated address of
    __secondary_switched
  arm64: kernel: perform relocation processing from ID map
  arm64: introduce mov_q macro to move a constant into a 64-bit register
  arm64: kernel: replace early 64-bit literal loads with move-immediates
  arm64: don't map TEXT_OFFSET bytes below the kernel if we can avoid it
  arm64: relocatable: deal with physically misaligned kernel images
  arm64: kaslr: increase randomization granularity

 arch/arm64/include/asm/assembler.h        |  20 +++
 arch/arm64/kernel/head.S                  | 136 +++++++++++---------
 arch/arm64/kernel/image.h                 |   2 -
 arch/arm64/kernel/kaslr.c                 |   6 +-
 arch/arm64/kernel/vmlinux.lds.S           |   7 +-
 drivers/firmware/efi/libstub/arm64-stub.c |  15 ++-
 6 files changed, 112 insertions(+), 74 deletions(-)

-- 
2.5.0
