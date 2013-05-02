From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 19:23:21 +0200
Subject: [PATCH 1/4] ARM: compressed/head.S: work around new binutils warning
In-Reply-To: <1367515404-512212-1-git-send-email-arnd@arndb.de>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
Message-ID: <1367515404-512212-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In August 2012, Matthew Gretton-Dann checked a change into binutils
labelled "Error on obsolete & warn on deprecated registers", apparently as
part of ARMv8 support. Apparently, this was supposed to emit the message
"Warning: This coprocessor register access is deprecated in ARMv8" when
using certain mcr/mrc instructions and building for ARMv8. Unfortunately,
the message that is actually emitted appears to be '(null)', which is
less helpful in comparison.

Even more unfortunately, this is biting us on every single kernel
build with a new gas, because arch/arm/boot/compressed/head.S and some
other files in that directory are built with -march=all since kernel
commit 80cec14a8 "[ARM] Add -march=all to assembly file build in
arch/arm/boot/compressed" back in v2.6.28.

This patch reverts Russell's nice solution and instead marks the head.S
file to be built for armv7-a, which fortunately lets us build all
instructions in that file without warnings even on the broken binutils.

Without this patch, building anything results in:

arch/arm/boot/compressed/head.S: Assembler messages:
arch/arm/boot/compressed/head.S:565: Warning: (null)
arch/arm/boot/compressed/head.S:676: Warning: (null)
arch/arm/boot/compressed/head.S:698: Warning: (null)
arch/arm/boot/compressed/head.S:722: Warning: (null)
arch/arm/boot/compressed/head.S:726: Warning: (null)
arch/arm/boot/compressed/head.S:957: Warning: (null)
arch/arm/boot/compressed/head.S:996: Warning: (null)
arch/arm/boot/compressed/head.S:997: Warning: (null)
arch/arm/boot/compressed/head.S:1027: Warning: (null)
arch/arm/boot/compressed/head.S:1035: Warning: (null)
arch/arm/boot/compressed/head.S:1046: Warning: (null)
arch/arm/boot/compressed/head.S:1060: Warning: (null)
arch/arm/boot/compressed/head.S:1092: Warning: (null)
arch/arm/boot/compressed/head.S:1094: Warning: (null)
arch/arm/boot/compressed/head.S:1095: Warning: (null)
arch/arm/boot/compressed/head.S:1102: Warning: (null)
arch/arm/boot/compressed/head.S:1134: Warning: (null)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Gretton-Dann <matthew.gretton-dann@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/compressed/Makefile      | 2 +-
 arch/arm/boot/compressed/head-sa1100.S | 1 +
 arch/arm/boot/compressed/head-shark.S  | 1 +
 arch/arm/boot/compressed/head.S        | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 001a13a..592ede5 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -128,7 +128,7 @@ KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
 ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
-asflags-y := -Wa,-march=all -DZIMAGE
+asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
 KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
diff --git a/arch/arm/boot/compressed/head-sa1100.S b/arch/arm/boot/compressed/head-sa1100.S
index 6179d94..3115e31 100644
--- a/arch/arm/boot/compressed/head-sa1100.S
+++ b/arch/arm/boot/compressed/head-sa1100.S
@@ -11,6 +11,7 @@
 #include <asm/mach-types.h>
 
 		.section        ".start", "ax"
+		.arch	armv4
 
 __SA1100_start:
 
diff --git a/arch/arm/boot/compressed/head-shark.S b/arch/arm/boot/compressed/head-shark.S
index 089c560..92b5689 100644
--- a/arch/arm/boot/compressed/head-shark.S
+++ b/arch/arm/boot/compressed/head-shark.S
@@ -18,6 +18,7 @@
 	
 		.section	".start", "ax"
 
+		.arch armv4
 		b	__beginning
 	
 __ofw_data:	.long	0				@ the number of memory blocks
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..6938559 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -11,6 +11,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
+	.arch	armv7-a
 /*
  * Debugging stuff
  *
-- 
1.8.1.2
