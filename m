From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Jun 2014 16:18:13 +0200
Subject: [PATCH 0/2] efi: preserve NEON registers on UEFI services calls
Message-ID: <1403533095-2611-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current UEFI implementation for arm64 fails to preserve/restore the contents
of the NEON register file, which may result in data corruption, especially now
that those contents are lazily restored for user processes.

This series proposes to fix this by wrapping all runtime services calls, and
adding kernel_neon_begin()/kernel_neon_end() pairs to the wrappers.

The first patch moves the existing x86 versions of those wrappers to generic
code, so that the second patch can easily enable them by supplying a definition
for  efi_call_virt and adding a call to efi_native_runtime_setup().

Ard Biesheuvel (2):
  efi/x86: move UEFI Runtime Services wrappers to generic code
  efi/arm64: preserve NEON registers on UEFI runtime services calls

 arch/arm64/include/asm/efi.h   |  21 ++++++
 arch/arm64/kernel/efi.c        |  14 +---
 arch/x86/platform/efi/efi.c    | 144 +----------------------------------
 drivers/firmware/efi/Makefile  |   2 +-
 drivers/firmware/efi/runtime.c | 167 +++++++++++++++++++++++++++++++++++++++++
 include/linux/efi.h            |   2 +
 6 files changed, 194 insertions(+), 156 deletions(-)
 create mode 100644 drivers/firmware/efi/runtime.c

-- 
1.8.3.2
