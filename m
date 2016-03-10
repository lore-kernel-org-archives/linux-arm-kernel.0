From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 10 Mar 2016 12:40:00 +0700
Subject: [PATCH 0/8] EFI framebuffer support for ARM and arm64
Message-ID: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support to ARM and arm64 for using the kernel's EFI
framebuffer driver to drive EFI Graphics Output Protocol (GOP) based
framebuffers.

This involves refactoring some of the existing x86 code so it can be reused
by ARM and arm64, and wiring it up both in the UEFI stub and in the core
kernel into the existing UEFI infrastructure for ARM and arm64.

Ard Biesheuvel (8):
  efi: make install_configuration_table() boot service usable
  efi: libstub: move Graphics Output Protocol handling to generic code
  efi/x86: libstub: move to generic GOP code
  efi/x86: efifb: move DMI based quirks handling out of generic code
  efi: efifb: use builtin_platform_driver and drop unused includes
  efi/arm*: libstub: wire up GOP handling into the ARM UEFI stub
  efi/arm*: efifb: expose efifb platform device if GOP is available
  efi/arm: populate screen_info based on data provided by the UEFI stub

 arch/arm/include/asm/efi.h                |  20 +-
 arch/arm/kernel/efi.c                     |  24 ++
 arch/arm/kernel/setup.c                   |   3 +-
 arch/arm64/include/asm/efi.h              |  11 +-
 arch/arm64/kernel/efi.c                   |   3 +
 arch/arm64/kernel/image.h                 |   1 +
 arch/x86/boot/compressed/eboot.c          | 308 +----------------
 arch/x86/boot/compressed/eboot.h          |  74 ----
 arch/x86/include/asm/efi.h                |   7 +
 arch/x86/kernel/sysfb_efi.c               |  15 +
 drivers/firmware/efi/arm-init.c           |  25 ++
 drivers/firmware/efi/libstub/Makefile     |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c   |  23 ++
 drivers/firmware/efi/libstub/arm32-stub.c |  38 +++
 drivers/firmware/efi/libstub/gop.c        | 354 ++++++++++++++++++++
 drivers/video/fbdev/Kconfig               |   2 +-
 drivers/video/fbdev/efifb.c               |  21 +-
 include/linux/efi.h                       |  89 ++++-
 18 files changed, 615 insertions(+), 405 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/gop.c

-- 
1.9.1
