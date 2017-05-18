From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 May 2017 10:09:50 +0100
Subject: [PATCH 0/3] efi: arm64: use -fpie for building the stub
Message-ID: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clang requires the stub to be built with -fpie, or it may emit absolute
symbol references that trigger the absolute relocation detection code and
cause the build to fail.

The remedy is to set -fpie (#3), but due to stupid ELF symbol preemption
rules that only apply to shared libraries, this will result in more rather
than fewer absolute references (i.e., GOT entries), which we have to massage
away using visibility overrides first. (#1, #2)

Ard Biesheuvel (3):
  efi/libstub: arm64: use hidden attribute for struct screen_info
    reference
  efi/libstub: arm64: force 'hidden' visibility for section markers
  efi/libstub: arm64: set -fpie when building the EFI stub

 arch/arm64/include/asm/efi.h              |  3 +++
 drivers/firmware/efi/libstub/Makefile     |  2 +-
 drivers/firmware/efi/libstub/arm64-stub.c | 10 +++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.9.3
