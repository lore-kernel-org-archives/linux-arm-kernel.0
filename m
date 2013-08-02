From: roy.franz@linaro.org (Roy Franz)
Date: Fri,  2 Aug 2013 14:29:01 -0700
Subject: [PATCH 0/7] RFC: EFI stub for ARM
Message-ID: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This RFC patch series adds EFI stub support for the ARM architecture.
Some code that was previously only used by x86/x86_64 is now shared
and has been made more general.  The stub for ARM is implemented in
a similar manner to x86 in that it is a shim layer between EFI and
the normal zImage/bzImage boot process, and that an image with the
stub configured is bootable as both a zImage and EFI application.

This patchset depends on a separately submitted bugfix to the
EFI stub: "correct call to free_pages"
http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=df981edcb9bce00b9c5e4f3cc33f3f98bc9a2394

Roy Franz (7):
  EFI stub documentation updates
  Move common EFI stub code from x86 arch code to common location
  Change EFI helper APIs to be more flexible
  Add proper definitions for some EFI function pointers.
  Add strstr to compressed string.c for ARM.
  Add EFI stub for ARM
  Add config EFI_STUB for ARM

 Documentation/efi-stub.txt             |   78 +++++
 Documentation/x86/efi-stub.txt         |   65 ----
 arch/arm/Kconfig                       |   10 +
 arch/arm/boot/compressed/Makefile      |   18 +-
 arch/arm/boot/compressed/efi-header.S  |  114 +++++++
 arch/arm/boot/compressed/efi-stub.c    |  514 ++++++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S        |   90 +++++-
 arch/arm/boot/compressed/string.c      |   21 ++
 arch/x86/Kconfig                       |    2 +-
 arch/x86/boot/compressed/eboot.c       |  488 ++----------------------------
 arch/x86/boot/compressed/eboot.h       |    6 -
 drivers/firmware/efi/efi-stub-helper.c |  506 +++++++++++++++++++++++++++++++
 include/linux/efi.h                    |   67 ++++-
 13 files changed, 1428 insertions(+), 551 deletions(-)
 create mode 100644 Documentation/efi-stub.txt
 delete mode 100644 Documentation/x86/efi-stub.txt
 create mode 100644 arch/arm/boot/compressed/efi-header.S
 create mode 100644 arch/arm/boot/compressed/efi-stub.c
 create mode 100644 drivers/firmware/efi/efi-stub-helper.c

-- 
1.7.10.4
