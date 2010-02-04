From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  4 Feb 2010 10:52:56 +0100
Subject: [PATCH] arm: remove bit-rotten STANDALONE_DEBUG for decompressor
In-Reply-To: <20100204095147.GA6562@pengutronix.de>
References: <20100204095147.GA6562@pengutronix.de>
Message-ID: <1265277176-7808-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tried to get this running to debug the regression introduced by
e7db7b4 without success.  But this has several problems that make it
hard to fix:

	- lib/decompress_inflate.c includes in-kernel headers that make
	  it difficult to compile for user space.
	- the binary formats changed both in kernel and user space and
	  at least for the kernel side there isn't only a single
	  variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/Makefile.debug |   23 -----------------------
 arch/arm/boot/compressed/misc.c         |   27 ---------------------------
 2 files changed, 0 insertions(+), 50 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/Makefile.debug

diff --git a/arch/arm/boot/compressed/Makefile.debug b/arch/arm/boot/compressed/Makefile.debug
deleted file mode 100644
index 491a037..0000000
--- a/arch/arm/boot/compressed/Makefile.debug
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# linux/arch/arm/boot/compressed/Makefile
-#
-# create a compressed vmlinux image from the original vmlinux
-#
-
-COMPRESSED_EXTRA=../../lib/ll_char_wr.o
-OBJECTS=misc-debug.o ll_char_wr.aout.o
-
-CFLAGS=-D__KERNEL__ -O2 -DSTDC_HEADERS -DSTANDALONE_DEBUG -Wall -I../../../../include -c
-
-test-gzip: piggy.aout.o $(OBJECTS)
-	$(CC) -o $@ $(OBJECTS) piggy.aout.o
-
-misc-debug.o: misc.c
-	$(CC) $(CFLAGS) -o $@ misc.c
-
-piggy.aout.o: piggy.o
-	arm-linuxelf-objcopy --change-leading-char -I elf32-arm -O arm-aout32-linux piggy.o piggy.aout.o
-
-ll_char_wr.aout.o: $(COMPRESSED_EXTRA)
-	arm-linuxelf-objcopy --change-leading-char -I elf32-arm -O arm-aout32-linux $(COMPRESSED_EXTRA) ll_char_wr.aout.o
-
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 56a0d11..ea5d7eb 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -28,10 +28,6 @@ unsigned int __machine_arch_type;
 
 #include <asm/unaligned.h>
 
-#ifdef STANDALONE_DEBUG
-#define putstr printf
-#else
-
 static void putstr(const char *ptr);
 
 #include <mach/uncompress.h>
@@ -115,8 +111,6 @@ static void putstr(const char *ptr)
 	flush();
 }
 
-#endif
-
 #define __ptr_t void *
 
 #define memzero(s,n) __memzero(s,n)
@@ -238,10 +232,6 @@ static void putstr(const char *);
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 
-#ifdef STANDALONE_DEBUG
-#define NO_INFLATE_MALLOC
-#endif
-
 #define ARCH_HAS_DECOMP_WDOG
 
 #ifdef CONFIG_KERNEL_GZIP
@@ -272,8 +262,6 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-#ifndef STANDALONE_DEBUG
-
 unsigned long
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p,
@@ -297,18 +285,3 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
-#else
-
-char output_buffer[1500*1024];
-
-int main()
-{
-	output_data = output_buffer;
-
-	putstr("Uncompressing Linux...");
-	decompress(input_data, input_data_end - input_data,
-			NULL, NULL, output_data, NULL, error);
-	putstr("done.\n");
-	return 0;
-}
-#endif
-- 
1.6.6
