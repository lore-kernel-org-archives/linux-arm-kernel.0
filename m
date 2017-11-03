From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:44 -0700
Subject: [PATCH 00/15] Add support for clang LTO
Message-ID: <20171103171203.107569-1-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds build system support for compiling the kernel with clang
Link Time Optimization (LTO), using GNU gold with the LLVMgold plug-in
for linking. Some background for clang's LTO support is available here:

  https://llvm.org/docs/LinkTimeOptimization.html

With -flto, clang produces LLVM bitcode instead of object files, and
the compilation to native code happens at link time. In addition, clang
cannot use an external assembler for inline assembly when LTO is enabled,
which causes further compatibility issues.

The patches in this series remove intermediate linking steps when LTO is
used, postpone processing done on object files until after the LTO link
step, add workarounds for GNU gold incompatibilities, and address inline
assembly incompatibilities for arm64.

These changes allow arm64 defconfig to be compiled with LTO, but other
architectures are not enabled until compatibility issues have been
addressed. In particular, x86 inline assembly doesn't currently compile
with clang's integrated assembler due to this LLVM bug:

  https://bugs.llvm.org/show_bug.cgi?id=24487

Due to recent bug fixes in the toolchain, it's recommended to use clang
5.0 or later, and GNU gold from binutils 2.27 or later, although older
versions may also work depending on your kernel configuration. Here are
the steps for compiling arm64 defconfig with LTO, assuming LLVMgold.so is
in LD_LIBRARY_PATH and the rest of the toolchain is in PATH:

  $ make ARCH=arm64 defconfig
  $ ./scripts/config -e CLANG_LTO
  $ make ARCH=arm64 oldconfig
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang \
         LD=aarch64-linux-gnu-ld.gold

You can also define LD_FINAL_VMLINUX to use a different linker for
vmlinux_link, which may be necessary for working around GNU gold issues
with KASLR, for example.

Greg Hackmann (1):
  arm64: use -mno-implicit-float instead of -mgeneral-regs-only

Sami Tolvanen (14):
  kbuild: add ld-name macro and support for GNU gold
  kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION with GNU gold
  kbuild: add support for clang LTO
  kbuild: fix dynamic ftrace with clang LTO
  scripts/mod: disable LTO for empty.c
  efi/libstub: disable clang LTO
  arm64: don't pass -maarch64linux to GNU gold
  arm64: keep .altinstructions and .altinstr_replacement
  arm64: disable ARM64_ERRATUM_843419 for clang LTO
  arm64: explicitly pass --no-fix-cortex-a53-843419 to GNU gold
  arm64: add a workaround for GNU gold with ARM64_MODULE_PLTS
  arm64: fix mrs_s/msr_s macros for clang LTO
  arm64: crypto: disable LTO for aes-ce-cipher.c
  arm64: select ARCH_SUPPORTS_CLANG_LTO

 .gitignore                            |   2 +
 Makefile                              |  21 ++++++-
 arch/Kconfig                          |  32 ++++++++++
 arch/arm64/Kconfig                    |   6 +-
 arch/arm64/Makefile                   |  17 +++++-
 arch/arm64/crypto/Makefile            |   2 +-
 arch/arm64/include/asm/kvm_hyp.h      |   2 +
 arch/arm64/include/asm/sysreg.h       |  71 ++++++++++++++++------
 arch/arm64/kernel/vmlinux.lds.S       |   4 +-
 drivers/firmware/efi/libstub/Makefile |   3 +-
 include/asm-generic/vmlinux.lds.h     |  10 ++--
 include/linux/compiler-clang.h        |   7 +++
 include/linux/compiler.h              |   4 ++
 kernel/trace/ftrace.c                 |   6 +-
 scripts/Kbuild.include                |   4 ++
 scripts/Makefile.build                |  83 +++++++++++++++++++++++++-
 scripts/Makefile.modpost              |  67 ++++++++++++++++++---
 scripts/link-vmlinux.sh               | 108 ++++++++++++++++++++++++++++++----
 scripts/mod/Makefile                  |   1 +
 scripts/recordmcount.c                |   3 +-
 20 files changed, 397 insertions(+), 56 deletions(-)

-- 
2.15.0.403.gc27cc4dac6-goog
