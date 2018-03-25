From: stefan@agner.ch (Stefan Agner)
Date: Sun, 25 Mar 2018 20:09:58 +0200
Subject: [PATCH v2 5/6] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Message-ID: <20180325180959.28008-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cc-options call for compiler options which are not available
in clang. With this patch an ARMv7 multi platform kernel can be
successfully build using clang (tested with version 5.0.1).

Based-on-patches-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Drop cc-options in CONFIG_FRAME_POINTER=y case

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
