From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 14:09:30 +0100
Subject: [PATCH v5sub2 0/8] arm64: implement virtual KASLR
Message-ID: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the request of Catalin, this series has been split off from my series
'arm64: implement support for KASLR v4' [1]. This sub-series deals with
creating a relocatable binary, and randomizing the virtual placement of
the kernel itself, the modules and the linear region based on entropy
supplied by the bootloader in the /chosen/kaslr-seed DT property.

Changes since v4:
- add randomization of the linear region, i.e., if the linear region is
  substantially larger than the space spanned by RAM, the mapping of RAM
  is moved to a random offset inside the linear region.
- dropped the CRC check in kaslr_early_init(), since the only code that may
  modify .data through __fixmap_remap_fdt() is instrumentation that should
  deal with that correctly (For instance, the branch profiling records taken
  branches in structs allocated in .data, and these counts will not be reset
  to 0 between the first and the second call to __mmap_switched())
- add Mark's ack to patch #4

Patch #1 adds support for resolving cross-module branches via veneers if the
module is located too far from the target. This should not be necessary in the
common case even with KASRL enabled, but since the space around the kernel image
will no longer be strictly reserved for modules, there is a slight chance that
the region may be exhausted, in which case modules will be moved further away
from the kernel (and each other)

Patches #2 and #3 deal with the fact that relocations of 64-bit values are
deferred to runtime when building a PIE executable, and some values are required
before the relocation routine executes (either in the code, or as an externally
visible constant in the Image header)

Patch #4 rehuffles asm/elf.h so we can use its preprocessor constants in head.S

Patch #5 and #6 implement building vmlinux as a PIE (Position Independent
Executable) binary, which is emitted with relocation information that is
processed by the program itself in the early boot code.

Patch #7 implements KASLR, i.e., CONFIG_RANDOMIZE_BASE for the core kernel and
for the module region.

Patch #8 implements KASLR for the linear region.

[1] http://thread.gmane.org/gmane.linux.kernel/2135931

Ard Biesheuvel (8):
  arm64: add support for module PLTs
  arm64: avoid R_AARCH64_ABS64 relocations for Image header fields
  arm64: avoid dynamic relocations in early boot code
  arm64: make asm/elf.h available to asm files
  scripts/sortextable: add support for ET_DYN binaries
  arm64: add support for building vmlinux as a relocatable PIE binary
  arm64: add support for kernel ASLR
  arm64: kaslr: randomize the linear region

 arch/arm64/Kconfig                 |  34 ++++
 arch/arm64/Makefile                |  10 +-
 arch/arm64/include/asm/assembler.h |  11 ++
 arch/arm64/include/asm/elf.h       |  24 ++-
 arch/arm64/include/asm/memory.h    |   5 +-
 arch/arm64/include/asm/module.h    |  11 ++
 arch/arm64/kernel/Makefile         |   2 +
 arch/arm64/kernel/efi-entry.S      |   2 +-
 arch/arm64/kernel/head.S           | 128 +++++++++++--
 arch/arm64/kernel/image.h          |  32 ++--
 arch/arm64/kernel/kaslr.c          | 143 ++++++++++++++
 arch/arm64/kernel/module-plts.c    | 201 ++++++++++++++++++++
 arch/arm64/kernel/module.c         |  20 +-
 arch/arm64/kernel/module.lds       |   3 +
 arch/arm64/kernel/setup.c          |  29 +++
 arch/arm64/kernel/vmlinux.lds.S    |  16 ++
 arch/arm64/mm/init.c               |  22 ++-
 arch/arm64/mm/mmu.c                |  33 +++-
 scripts/sortextable.c              |   8 +-
 19 files changed, 672 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm64/kernel/kaslr.c
 create mode 100644 arch/arm64/kernel/module-plts.c
 create mode 100644 arch/arm64/kernel/module.lds

-- 
2.5.0
