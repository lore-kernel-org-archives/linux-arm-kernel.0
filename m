From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 20 Aug 2016 09:45:29 +0200
Subject: [PATCH 0/2] add interworking support to Thumb2 kernel
Message-ID: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the core kernel, interworking is supported since vmlinux is a static
binary, and the linker takes care of fixing up the bl instructions and
emitting veneers if necessary. For modules, however, all function objects
must currently be in the same mode, since the kernel's module loader does
not handle interworking switches at all.

However, now that we have optimized PLT support, we can simply enable it
unconditionally for Thumb2 builds, which by itself is reasonable since
the module area is pretty small, especially with multiplatform kernels
(current multi_v7_defconfig results in a .text section that exceeds 8 MB,
leaving less than 8 MB for modules when not using PLTs).
PLT support also allows us to reuse the veneer emitting routines to emit
veneers for interworking branches that cannot be fixed up by tweaking
the instruction encoding.

Patch #1 fixes an issue where ARM functions exported from other modules
will be mistaken for Thumb2 functions due to the missing STT_FUNC annotation
on SHN_UNDEF symbols.

Patch #2 implements the interworking support, by tweaking the instruction
encoding for unconditional bl instructions, and emitting a PLT veneer in
all other cases.

Ard Biesheuvel (2):
  ARM: Thumb-2: infer function annotation for external ksyms
  ARM: add interworking support to Thumb-2 kernel

 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/module.h |  3 +-
 arch/arm/kernel/module-plts.c | 21 +++++--
 arch/arm/kernel/module.c      | 64 ++++++++++++++++----
 4 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.7.4
