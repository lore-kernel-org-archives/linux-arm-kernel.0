From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:01:57 +0100
Subject: [PATCH 5/9] ARM: atags_to_fdt: don't warn about stack size
In-Reply-To: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
Message-ID: <1455804123-2526139-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merge_fdt_bootargs() function by definition consumes more than 1024
bytes of stack because it has a 1024 byte command line on the stack,
meaning that we always get a warning when building this file:

arch/arm/boot/compressed/atags_to_fdt.c: In function 'merge_fdt_bootargs':
arch/arm/boot/compressed/atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]

However, as this is the decompressor and we know that it has a very shallow
call chain, and we do not actually risk overflowing the kernel stack
at runtime here.

This just shuts up the warning by disabling the warning flag for this
file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 7a6a58ef8aaf..b5db4c868640 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -85,6 +85,8 @@ $(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/
 $(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
 	$(addprefix $(obj)/,$(libfdt_hdrs))
 
+CFLAGS_REMOVE_atags_to_fdt.o += -Wframe-larger-than=${CONFIG_FRAME_WARN}
+
 ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
 OBJS	+= $(libfdt_objs) atags_to_fdt.o
 endif
-- 
2.7.0
