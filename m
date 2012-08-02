From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Aug 2012 13:23:26 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent versions
 of binutils
Message-ID: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent upstream versions of binutils fail to assembler compressed/head.S
when passed the -march=all option:

http://lists.gnu.org/archive/html/bug-binutils/2011-04/msg00162.html

The recommended workaround from the tools folks is not to pass the
option, and instead let the assembler deduce the CPU type based on the
features used by the code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/boot/compressed/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index bb26756..0f7f3f4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -126,7 +126,6 @@ KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
 ccflags-y := -fpic -fno-builtin -I$(obj)
-asflags-y := -Wa,-march=all
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
 KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
-- 
1.7.4.1
