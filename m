From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  9 Oct 2017 23:35:13 +0900
Subject: [PATCH 1/3] ARM: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
In-Reply-To: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1507559715-30918-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

{CFLAGS,LDFLAGS}_MODULE are supposed to be set by users, not by
in-kernel makefiles.

Documentation/kbuild/makefiles.txt clearly explains the difference:

  KBUILD_CFLAGS_MODULE   Options for $(CC) when building modules

      $(KBUILD_CFLAGS_MODULE) is used to add arch-specific options that
      are used for $(CC).
      From commandline CFLAGS_MODULE shall be used (see kbuild.txt).

  KBUILD_LDFLAGS_MODULE   Options for $(LD) when linking modules

      $(KBUILD_LDFLAGS_MODULE) is used to add arch-specific options
      used when linking modules. This is often a linker script.
      From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cdb5b55..cafa4d4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,11 +16,11 @@ LDFLAGS		:=
 LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
-LDFLAGS_MODULE	+= --be8
+KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
-LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
+KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
 endif
 
 GZFLAGS		:=-9
@@ -120,7 +120,7 @@ CFLAGS_ISA	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 # Work around buggy relocation from gas if requested:
 ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
-CFLAGS_MODULE	+=-fno-optimize-sibling-calls
+KBUILD_CFLAGS_MODULE	+=-fno-optimize-sibling-calls
 endif
 else
 CFLAGS_ISA	:=$(call cc-option,-marm,)
-- 
2.7.4
