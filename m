From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 25 Nov 2011 02:58:58 +0100
Subject: [PATCH] ARM: fix $(CROSS_COMPILE) prefix missing from size invocation
Message-ID: <1322186338-6020-1-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise, cross compilation may fail with error messages like:

...
size: arch/arm/boot/compressed/../../../../vmlinux: File format is ambiguous
size: Matching formats: elf32-littlearm elf32-littlearm-symbian elf32-littlearm-vxworks
  LD      arch/arm/boot/compressed/vmlinux
  arm-angstrom-linux-uclibcgnueabi-ld:--defsym _kernel_bss_size=: syntax error

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/boot/compressed/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 21f56ff..cf0a64c 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -126,7 +126,8 @@ ccflags-y := -fpic -fno-builtin -I$(obj)
 asflags-y := -Wa,-march=all
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
+KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
+		awk 'END{print $$3}')
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
-- 
1.7.3.4
