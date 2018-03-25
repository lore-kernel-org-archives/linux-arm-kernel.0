From: stefan@agner.ch (Stefan Agner)
Date: Sun, 25 Mar 2018 20:09:55 +0200
Subject: [PATCH v2 2/6] efi/libstub/arm: add support for building with clang
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Message-ID: <20180325180959.28008-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cc-options call for -mno-single-pic-base since the option is
not available in clang. LLVM/clang always assumes a fixed
displacement between text/data and hence uses PC relative
addressing.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..2bf69cca0d87 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base,)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.16.2
