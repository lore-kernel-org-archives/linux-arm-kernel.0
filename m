From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:23:00 +0200
Subject: [PATCH 6/9] ARM: pass -marm to gcc by default for both C and assembler
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linaro cross toolchain and probably others nowadays default to
building in THUMB2 mode. When building a kernel for a CPU that does
not support THUMB2, the compiler complains about incorrect flags.
We can work around this by setting -marm for all non-T2 builds.

Without this patch, building assabet_defconfig results in:

usr/initramfs_data.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
arch/arm/nwfpe/entry.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
firmware/cis/PCMLM28.cis.gen.S:1:0: warning: target CPU does not support THUMB instructions [enabled by default]
(and many more)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Makefile |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f023e3a..5f914fc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -21,8 +21,6 @@ endif
 OBJCOPYFLAGS	:=-O binary -R .comment -S
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
-# Explicitly specifiy 32-bit ARM ISA since toolchain default can be -mthumb:
-KBUILD_CFLAGS	+=$(call cc-option,-marm,)
 
 # Never generate .eh_frame
 KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
@@ -105,17 +103,20 @@ endif
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
-CFLAGS_THUMB2	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
-AFLAGS_THUMB2	:=$(CFLAGS_THUMB2) -Wa$(comma)-mthumb
+CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
+AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
 CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
+else
+CFLAGS_ISA	:=$(call cc-option,-marm,)
+AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
-KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_THUMB2) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_THUMB2) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
1.7.10
