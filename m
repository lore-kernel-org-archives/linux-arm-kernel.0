From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jan 2016 10:56:51 -0800
Subject: [PATCH v4] ARM: fix atags_to_fdt with stack-protector-strong
Message-ID: <20160107185651.GA4928@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building with CONFIG_CC_STACKPROTECTOR_STRONG triggers protection code
generation under CONFIG_ARM_ATAG_DTB_COMPAT but this is too early for
being able to use any of the stack_chk code. Explicitly disable it for
only the atags_to_fdt bits.

Suggested-by: zhxihu <zhxihu@marvell.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v4:
- single invocation of cc-option, rmk
- kept arnd's ack, since it's functionally the same as v3
v3:
- actually send to everyone correctly
v2:
- use call cc-option unconditionally, arnd
---
 arch/arm/boot/compressed/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 3f9a9ebc77c3..f0a75d9e1648 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -106,6 +106,15 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
+# -fstack-protector-strong triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+nossp_flags := $(call cc-option, -fno-stack-protector)
+CFLAGS_atags_to_fdt.o := $(nossp_flags)
+CFLAGS_fdt.o := $(nossp_flags)
+CFLAGS_fdt_ro.o := $(nossp_flags)
+CFLAGS_fdt_rw.o := $(nossp_flags)
+CFLAGS_fdt_wip.o := $(nossp_flags)
+
 ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
