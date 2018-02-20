From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 22:59:54 +0100
Subject: [PATCH 7/7] efi: disable LTO for EFI stub
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
Message-ID: <20180220215954.4092811-8-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the EFI stub on 32-bit ARM with LTO resulted in a build error:

arm-linux-gnueabi-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: plugin needed to handle lto object
arch/arm/boot/compressed/head.o: In function `efi_stub_entry':

Locally disabling LTO for this directory seems to do the trick.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/libstub/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..cc4c53f1ff0a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,9 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   $(DISABLE_LTO)
+
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
-- 
2.9.0
