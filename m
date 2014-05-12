From: qiang2.chen@sonymobile.com (Qiang Chen)
Date: Mon, 12 May 2014 16:42:13 +0800
Subject: [PATCH] ARM: decompressor: disable branch profiling
Message-ID: <1399884133-2311-1-git-send-email-qiang2.chen@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early kernel decrompressing code can't call into the kernel
in order to profile branches. This patch fixes below link error:

arch/arm/boot/compressed/decompress.o: In function `lzo1x_decompress_safe':
undefined reference to `ftrace_likely_update'

Signed-off-by: Qiang Chen <qiang2.chen@sonymobile.com>
---
 arch/arm/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 68c9183..384c843 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -120,6 +120,7 @@ ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
 ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
-- 
1.8.2.2
