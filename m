From: keescook@chromium.org (Kees Cook)
Date: Wed, 6 Jan 2016 15:36:56 -0800
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
Message-ID: <20160106233656.GA9316@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building with CONFIG_CC_STACKPROTECTOR_STRONG triggers protection code
generation under CONFIG_ARM_ATAG_DTB_COMPAT but this is too early for
being able to use any of the stack_chk code. Explicitly disable it for
only the atags_to_fdt bits.

Suggested-by: zhxihu <zhxihu@marvell.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- actually send to everyone correctly
v2:
- use call cc-option unconditionally, arnd
---
 arch/arm/boot/compressed/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 3f9a9ebc77c3..d7d2c2981f65 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -106,6 +106,14 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
+# -fstack-protector-strong triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+CFLAGS_atags_to_fdt.o := $(call cc-option, -fno-stack-protector)
+CFLAGS_fdt.o := $(call cc-option, -fno-stack-protector)
+CFLAGS_fdt_ro.o := $(call cc-option, -fno-stack-protector)
+CFLAGS_fdt_rw.o := $(call cc-option, -fno-stack-protector)
+CFLAGS_fdt_wip.o := $(call cc-option, -fno-stack-protector)
+
 ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
