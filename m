From: weber@corscience.de (Thomas Weber)
Date: Thu, 13 Oct 2011 08:50:22 +0200
Subject: [PATCHv2] ARM: zImage: Use $(CROSS_COMPILE)size to get .bss size
Message-ID: <1318488622-20023-1-git-send-email-weber@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use $(CROSS_COMPILE)size to determine the bss size
from vmlinux.

The problem is introduced in:

commit 5ffb04f6690d71fab241b3562ebf52b893ac4ff1
ARM: zImage: make sure appended DTB doesn't get
overwritten by kernel .bss

This fixes following error message:

size: arch/arm/boot/compressed/../../../../vmlinux:
File format is ambiguous

size: Matching formats:
elf32-littlearm
elf32-littlearm-symbian
elf32-littlearm-vxworks

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Thomas Weber <weber@corscience.de>
---
v2: 
 - Fixed commit hash and rebased to rmk/devel-stable branch.
 - Added received Acked-by

 arch/arm/boot/compressed/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index e4f32a8..3103632 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -126,7 +126,7 @@ ccflags-y := -fpic -fno-builtin -I$(obj)
 asflags-y := -Wa,-march=all
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
+KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
-- 
1.7.7
