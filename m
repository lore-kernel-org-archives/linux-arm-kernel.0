From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:45 +0200
Subject: [RFC PATCH 15/15] ARM: uncompress: Add documentation
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-15-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Short description for mach maintainters on how to use the
ucuart driver. It is in-line in the print.c file, as they will
probably look there for any compile/link errors caused by
their decompressor UART setup.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/print.c |   35 ++++++++++++++++++++++++++---------
 1 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
index cbb0dbf..b495c2e 100644
--- a/arch/arm/boot/compressed/print.c
+++ b/arch/arm/boot/compressed/print.c
@@ -1,21 +1,38 @@
 /*
- * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
- *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
- * Modified for ARM Linux by Russell King
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
  * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
  *  For this code to run directly from Flash, all constant variables must
- *  be marked with 'const' and all other variables initialized at run-time 
+ *  be marked with 'const' and all other variables initialized at run-time
  *  only.  This way all non constant variables will end up in the bss segment,
  *  which should point to addresses in RAM and cleared to 0 on start.
  *  This allows for a much quicker boot time.
  */
 
+/* UART usage before kernel start:
+ * The files in this directory allow the boot of a self-extracting kernel
+ * image. As the kernel itself is compressed, this is a separate environment
+ * and thus needs a separate UART driver to communicate with the outside.
+ * Machines have multiple ways for providing this UART driver in their
+ * uncompress.h files:
+ *
+ * a) If your UART is compatible with a standard 8250 or AMBA01X port,
+ *    call one of the below ucuart_8250/amba01x setup routines from the
+ *    function "static inline void arch_decomp_setup(void)", that
+ *    resides in the uncompress.h file.
+ * b) If your UART is not a standard one, but still an MMIO one, that
+ *    has at least a direct register for TX, use the generic ucuart_init()
+ *    function.
+ * c) If your UART is too complicated for these simple routines, or you
+ *    rather want to use a framebuffer, provide your own putc(), flush() and
+ *    arch_decomp_setup() functions and #define ARCH_UCUART_NONGENERIC
+ *    in your header file.
+ * d) You can supply the description of the UART in a device tree blob that
+ *    is passed to the kernel.
+ *    (Not yet: In this case, you may omit the uncompress.h file entirely)
+ */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
-- 
1.7.4.1
