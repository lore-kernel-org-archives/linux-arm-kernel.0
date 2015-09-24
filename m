From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Sep 2015 09:37:14 -0700
Subject: [PATCH 0/2] arm64: EFI stub isolation
Message-ID: <1443112636-19573-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that the EFI stub only uses parts of the kernel proper
that are safe to use when the kernel virtual mapping is not active yet.

So move all C code dependencies to the libstub, and do a verification pass
to ensure that no absolute relocations are used.

On the arm64 side, annotate all the stub's dependencies as safe for PI
(position independent).

Ard Biesheuvel (2):
  arm64: use ENDPIPROC() to annotate position independent assembler
    routines
  arm64/efi: isolate EFI stub from the kernel proper

 arch/arm64/include/asm/assembler.h    |  8 +++
 arch/arm64/kernel/Makefile            | 12 ++++-
 arch/arm64/kernel/efi-entry.S         | 10 ++--
 arch/arm64/kernel/head.S              | 14 ++---
 arch/arm64/kernel/image.h             | 27 ++++++++++
 arch/arm64/lib/memchr.S               |  2 +-
 arch/arm64/lib/memcmp.S               |  2 +-
 arch/arm64/lib/memcpy.S               |  2 +-
 arch/arm64/lib/memmove.S              |  2 +-
 arch/arm64/lib/memset.S               |  2 +-
 arch/arm64/lib/strlen.S               |  2 +-
 arch/arm64/lib/strncmp.S              |  2 +-
 arch/arm64/mm/cache.S                 | 10 ++--
 drivers/firmware/efi/libstub/Makefile | 31 +++++++++--
 drivers/firmware/efi/libstub/string.c | 55 ++++++++++++++++++++
 15 files changed, 152 insertions(+), 29 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/string.c

-- 
1.9.1
