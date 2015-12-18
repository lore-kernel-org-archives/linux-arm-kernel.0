From: keescook@chromium.org (Kees Cook)
Date: Fri, 18 Dec 2015 13:04:59 -0800
Subject: [PATCH] ARM: fix atags_to_fdt with stack-protector-strong
Message-ID: <20151218210459.GA23293@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building with CONFIG_CC_STACKPROTECTOR_STRONG triggers protection code
generation under CONFIG_ARM_ATAG_DTB_COMPAT but this is too early for
being able to use any of the stack_chk code. Explicitly disable it for
only the atags_to_fdt bits.

Suggested-by: zhxihu <zhxihu@marvell.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 3f9a9ebc77c3..8cfbc4a2090b 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -106,6 +106,14 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
+ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
+CFLAGS_atags_to_fdt.o := -fno-stack-protector
+CFLAGS_fdt.o := -fno-stack-protector
+CFLAGS_fdt_ro.o := -fno-stack-protector
+CFLAGS_fdt_rw.o := -fno-stack-protector
+CFLAGS_fdt_wip.o := -fno-stack-protector
+endif
+
 ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
