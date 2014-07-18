From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 18 Jul 2014 15:00:46 +0100
Subject: [PATCH 0/7] arm: add UEFI support
Message-ID: <1405692053-7514-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set adds support for UEFI platforms 32-bit ARM platforms,
consisting of:
- UEFI stub support
  Turns the kernel into a UEFI executable, able to launch without a
  dedicated bootloader.
- UEFI runtime services
  Lets the kernel interact with services provided by firmware.
  (Used by 'efibootmgr' application.)
- UEFI system descriptions
  For now, adds the ability to extract information about available
  RAM from UEFI rather than hard-wired in .dtb or on command line.

This set depends on:
- Ard Biesheuvel "efi: efistub: Convert into static library"
                 About to go into linux-next, aiming for 3.17.
- Mark Salter    "arm: use generic fixmap.h"
- Mark Salter    "arm: add early_ioremap support"

The bits shared with arm64 went into 3.16-rc1.

Changes from previous version:
- Stub and runtime services support now merged (like on arm64) - they
  are no longer functionally separable.
- Some fixes and cleanup.

Leif Lindholm (4):
  arm: break part of __soft_restart out into separate function
  arm: add new asm macro update_sctlr
  arm: efi: use strcmp instead of strncmp for fdt parsing
  init: efi: arm: enable (U)EFI runtime services on arm

Roy Franz (3):
  arm: add strstr to compressed string.c
  arm: Disable stack protection for decompressor/stub
  arm: add [U]EFI support

 arch/arm/Kconfig                      |   21 ++
 arch/arm/boot/compressed/.gitignore   |    2 +
 arch/arm/boot/compressed/Makefile     |   23 +-
 arch/arm/boot/compressed/efi-header.S |  117 +++++++++
 arch/arm/boot/compressed/efi-stub.c   |   92 +++++++
 arch/arm/boot/compressed/head.S       |   78 +++++-
 arch/arm/boot/compressed/string.c     |   21 ++
 arch/arm/include/asm/assembler.h      |   14 ++
 arch/arm/include/asm/efi.h            |   47 ++++
 arch/arm/include/asm/idmap.h          |    1 +
 arch/arm/kernel/Makefile              |    2 +
 arch/arm/kernel/efi.c                 |  435 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/efi_phys.S            |   66 +++++
 arch/arm/kernel/process.c             |   12 +-
 arch/arm/kernel/setup.c               |    7 +-
 arch/arm/mm/idmap.c                   |   15 ++
 drivers/firmware/efi/libstub/fdt.c    |    5 +-
 init/main.c                           |    4 +
 18 files changed, 938 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/compressed/efi-header.S
 create mode 100644 arch/arm/boot/compressed/efi-stub.c
 create mode 100644 arch/arm/include/asm/efi.h
 create mode 100644 arch/arm/kernel/efi.c
 create mode 100644 arch/arm/kernel/efi_phys.S

-- 
1.7.10.4
