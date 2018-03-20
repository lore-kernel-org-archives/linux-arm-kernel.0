From: stefan@agner.ch (Stefan Agner)
Date: Wed, 21 Mar 2018 00:02:06 +0100
Subject: [PATCH 5/5] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180320230206.25289-1-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
Message-ID: <20180320230206.25289-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cc-options call for compiler options which are not available
in clang. With this patch an ARMv7 multi platform kernel can be
successfully build using clang (tested with version 5.0.1).

Based-on-patches-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/compressed/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e9e3fde3c657..20e9fee1ccc5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
 endif
 
 ifeq ($(CONFIG_FRAME_POINTER),y)
-KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
+KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
 endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 45a6b9b7af2a..6a5c4ac97703 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -113,7 +113,7 @@ CFLAGS_fdt_ro.o := $(nossp_flags)
 CFLAGS_fdt_rw.o := $(nossp_flags)
 CFLAGS_fdt_wip.o := $(nossp_flags)
 
-ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
+ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-- 
2.16.2
