From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:10 -0800
Subject: [PATCH v2 00/18] Add support for clang LTO
Message-ID: <20171115213428.22559-1-samitolvanen@google.com>
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
  $ ./scripts/config -e LTO_CLANG
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang

--

Changes in v2:
 - Fixed issues found by the 0-day bot.
 - Moved clang and gold fixes that don't depend on LTO earlier in the
   patch set.
 - Added clang support to cc-version.
 - Renamed CLANG_LTO to LTO_CLANG, added CONFIG_LTO for sharing code
   with potential gcc LTO work, and added checks for compiler support
   to prepare-compiler-check.
 - Added linker selection to Makefile, so LD doesn't have to be passed
   in make command line.
 - arm64 specific:
   - Added -fno-jump-tables to arch/arm64/kvm/hyp to prevent clang
     from generating jump tables with EL1 virtual addresses for code
     that runs at EL2.
   - Adopted Alex's version of the mrs_s / msr_s fix, which uses the
     same code path for both gcc and clang.
   - Enabled LLVM bug 30792 workaround only for clang < 6.0.
   - Instead of disabling PLTs, removed NOLOAD from PLT sections in
     modules to work around a bug in gold.
   - Instead of disabling ARM64_ERRATUM_843419 with gold, enabled the
     previously disabled ADR_PREL_PG_HI21* relocations.
   - Instead of omitting -m for gold, pass aarch64_elf64_(be|le)_vec.

--

Alex Matveev (1):
  arm64: make mrs_s and msr_s macros work with LTO

Greg Hackmann (1):
  arm64: use -mno-implicit-float instead of -mgeneral-regs-only

Sami Tolvanen (16):
  kbuild: add ld-name macro and support for GNU gold
  kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION with GNU gold
  kbuild: move gcc-version.sh to cc-version.sh and add clang support
  arm64: fix -m for GNU gold
  arm64: kvm: use -fno-jump-tables with clang
  arm64: keep .altinstructions and .altinstr_replacement
  arm64: don't disable ADR_PREL_PG_HI21* with ARM64_ERRATUM_843419
  arm64: explicitly pass --no-fix-cortex-a53-843419 to GNU gold
  arm64: add a workaround for GNU gold with ARM64_MODULE_PLTS
  kbuild: add support for clang LTO
  kbuild: fix dynamic ftrace with clang LTO
  scripts/mod: disable LTO for empty.c
  efi/libstub: disable LTO
  arm64: crypto: disable LTO for aes-ce-cipher.c
  arm64: disable RANDOMIZE_MODULE_REGION_FULL with LTO_CLANG
  arm64: select ARCH_SUPPORTS_LTO_CLANG

 .gitignore                            |   2 +
 Makefile                              |  59 ++++++++++++++++++-
 arch/Kconfig                          |  32 ++++++++++
 arch/arm64/Kconfig                    |   3 +-
 arch/arm64/Makefile                   |  21 ++++++-
 arch/arm64/crypto/Makefile            |   2 +-
 arch/arm64/include/asm/kvm_hyp.h      |   8 ++-
 arch/arm64/include/asm/sysreg.h       |  55 +++++++++++------
 arch/arm64/kernel/module.c            |   2 -
 arch/arm64/kernel/module.lds          |   4 +-
 arch/arm64/kernel/vmlinux.lds.S       |   4 +-
 arch/arm64/kvm/hyp/Makefile           |   4 ++
 drivers/firmware/efi/libstub/Makefile |   3 +-
 include/asm-generic/vmlinux.lds.h     |   9 +--
 include/linux/compiler-clang.h        |   7 +++
 include/linux/compiler_types.h        |   4 ++
 kernel/trace/ftrace.c                 |   6 +-
 scripts/Kbuild.include                |   8 ++-
 scripts/Makefile.build                |  80 ++++++++++++++++++++++++-
 scripts/Makefile.modpost              |  67 ++++++++++++++++++---
 scripts/cc-version.sh                 |  45 ++++++++++++++
 scripts/gcc-version.sh                |  33 -----------
 scripts/link-vmlinux.sh               | 108 ++++++++++++++++++++++++++++++----
 scripts/mod/Makefile                  |   1 +
 scripts/recordmcount.c                |   3 +-
 25 files changed, 475 insertions(+), 95 deletions(-)
 create mode 100755 scripts/cc-version.sh
 delete mode 100755 scripts/gcc-version.sh

-- 
2.15.0.448.gf294e3d99a-goog
