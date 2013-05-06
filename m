From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Mon,  6 May 2013 17:42:54 +0900
Subject: [PATCH -next 1/2] arm: Remove enforced Os flag for LZ4 decompressor
Message-ID: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-Os is enforced here, based on the test result of decompression time
below, slightly faster than -O2.

But further tests with UA show that using -O2 will be the right choice
especially in the case of the unaligned access enabled and the gap,
few counts in the normal decompression mode is small enough to remove -Os.

Decompression Time(counts)
     Normal    UA enabled
-Os  6717      3447
-O2  6720      2728

Note: ARM v7, Kernel 3.4
      counter freq. = 32768 HZ
      UA(Unaligned Access)
      gcc version 4.6.2

Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Yann Collet <yann.collet.73@gmail.com>
---
 arch/arm/boot/compressed/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 001a13a..198a4ad 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -27,9 +27,6 @@ OBJS	+= misc.o decompress.o
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 endif
-ifeq ($(CONFIG_KERNEL_LZ4),y)
-CFLAGS_decompress.o := -Os
-endif
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
-- 
1.8.1.1
