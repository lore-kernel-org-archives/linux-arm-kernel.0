From: astrachan@google.com (Alistair Strachan)
Date: Thu,  9 Aug 2018 09:40:42 -0700
Subject: [PATCH] efi/libstub: arm: support building with clang
Message-ID: <20180809164042.210675-1-astrachan@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with CONFIG_EFI and CONFIG_EFI_STUB on ARM, the libstub
Makefile would use -mno-single-pic-base without checking it was
supported by the compiler. As the ARM (32-bit) clang backend does not
support this flag, the build would fail.

This changes the Makefile to check the compiler's support for
-mno-single-pic-base before using it, similar to c1c386681bd7 ("ARM:
8767/1: add support for building ARM kernel with clang").

Cc: Stefan Agner <stefan@agner.ch>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-efi at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a34e9290a699..91339d13f2a1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.18.0.597.ga71716f1ad-goog
