From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 12:24:29 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100225093859.GA19870@n2100.arm.linux.org.uk>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
Message-ID: <20100225122429.GA3101@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 09:38:59AM +0000, Russell King - ARM Linux wrote:
> Then we can tailor our misc.c not to use static data (which is the real
> problem - not the functions being static), and the -Dstatic= hack will
> go away.

And here's the patch - not run tested yet, but compile-tested for
gzip and LZO in both ROM=y and ROM=n modes.

    ARM: Eliminate decompressor -Dstatic= PIC hack

    We used to build decompressors with -Dstatic= to avoid any local data
    being generated.  The problem is that local data generates GOTOFF
    relocations, which means we can't relocate the data relative to the
    text segment.

    Global data, on the other hand, goes through the GOT, and can be
    relocated anywhere.

    Unfortunately, with the new decompressors, this presents a problem
    since they declare static data within functions, and this leads to
    stack overflow.

    Fix this by separating out the decompressor code into a separate file,
    and removing 'static' from BSS data in misc.c.

    Also, discard the .data section - this means that should we end up
    with read/write initialized data, the decompressor will fail to link
    and the problem will be obvious.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

 arch/arm/boot/compressed/Makefile       |    6 +--
 arch/arm/boot/compressed/decompress.c   |   45 +++++++++++++
 arch/arm/boot/compressed/misc.c         |  109 +++---------------------------
 arch/arm/boot/compressed/vmlinux.lds.in |    2 +-
 4 files changed, 58 insertions(+), 104 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2d4d88b..97c89e7 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -5,7 +5,7 @@
 #
 
 HEAD	= head.o
-OBJS	= misc.o
+OBJS	= misc.o decompress.o
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 #
@@ -106,10 +106,6 @@ lib1funcs = $(obj)/lib1funcs.o
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
 	$(call cmd,shipped)
 
-# Don't allow any static data in misc.o, which
-# would otherwise mess up our GOT table
-CFLAGS_misc.o := -Dstatic=
-
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
 	$(call if_changed,ld)
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
new file mode 100644
index 0000000..0da382f
--- /dev/null
+++ b/arch/arm/boot/compressed/decompress.c
@@ -0,0 +1,45 @@
+#define _LINUX_STRING_H_
+
+#include <linux/compiler.h>	/* for inline */
+#include <linux/types.h>	/* for size_t */
+#include <linux/stddef.h>	/* for NULL */
+#include <linux/linkage.h>
+#include <asm/string.h>
+
+extern unsigned long free_mem_ptr;
+extern unsigned long free_mem_end_ptr;
+extern void error(char *);
+
+#define STATIC static
+
+#define ARCH_HAS_DECOMP_WDOG
+
+/* Diagnostic functions */
+#ifdef DEBUG
+#  define Assert(cond,msg) {if(!(cond)) error(msg);}
+#  define Trace(x) fprintf x
+#  define Tracev(x) {if (verbose) fprintf x ;}
+#  define Tracevv(x) {if (verbose>1) fprintf x ;}
+#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
+#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
+#else
+#  define Assert(cond,msg)
+#  define Trace(x)
+#  define Tracev(x)
+#  define Tracevv(x)
+#  define Tracec(c,x)
+#  define Tracecv(c,x)
+#endif
+
+#ifdef CONFIG_KERNEL_GZIP
+#include "../../../../lib/decompress_inflate.c"
+#endif
+
+#ifdef CONFIG_KERNEL_LZO
+#include "../../../../lib/decompress_unlzo.c"
+#endif
+
+void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
+{
+	decompress(input, len, NULL, NULL, output, NULL, error);
+}
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 7e0fe4d..4c663fb 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -23,8 +23,8 @@ unsigned int __machine_arch_type;
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
-#include <asm/string.h>
 #include <linux/linkage.h>
+#include <asm/string.h>
 
 #include <asm/unaligned.h>
 
@@ -106,57 +106,7 @@ static void putstr(const char *ptr)
 
 #endif
 
-#define __ptr_t void *
-
-#define memzero(s,n) __memzero(s,n)
-
-/*
- * Optimised C version of memzero for the ARM.
- */
-void __memzero (__ptr_t s, size_t n)
-{
-	union { void *vp; unsigned long *ulp; unsigned char *ucp; } u;
-	int i;
-
-	u.vp = s;
-
-	for (i = n >> 5; i > 0; i--) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 4) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 3) {
-		*u.ulp++ = 0;
-		*u.ulp++ = 0;
-	}
-
-	if (n & 1 << 2)
-		*u.ulp++ = 0;
-
-	if (n & 1 << 1) {
-		*u.ucp++ = 0;
-		*u.ucp++ = 0;
-	}
-
-	if (n & 1)
-		*u.ucp++ = 0;
-}
-
-static inline __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
-			    size_t __n)
+void *memcpy(void *__dest, __const void *__src, size_t __n)
 {
 	int i = 0;
 	unsigned char *d = (unsigned char *)__dest, *s = (unsigned char *)__src;
@@ -193,59 +143,20 @@ static inline __ptr_t memcpy(__ptr_t __dest, __const __ptr_t __src,
 /*
  * gzip delarations
  */
-#define STATIC static
-
-/* Diagnostic functions */
-#ifdef DEBUG
-#  define Assert(cond,msg) {if(!(cond)) error(msg);}
-#  define Trace(x) fprintf x
-#  define Tracev(x) {if (verbose) fprintf x ;}
-#  define Tracevv(x) {if (verbose>1) fprintf x ;}
-#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
-#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
-#else
-#  define Assert(cond,msg)
-#  define Trace(x)
-#  define Tracev(x)
-#  define Tracevv(x)
-#  define Tracec(c,x)
-#  define Tracecv(c,x)
-#endif
-
-static void error(char *m);
-
 extern char input_data[];
 extern char input_data_end[];
 
-static unsigned char *output_data;
-static unsigned long output_ptr;
-
-static void error(char *m);
+unsigned char *output_data;
+unsigned long output_ptr;
 
-static void putstr(const char *);
-
-static unsigned long free_mem_ptr;
-static unsigned long free_mem_end_ptr;
-
-#ifdef STANDALONE_DEBUG
-#define NO_INFLATE_MALLOC
-#endif
-
-#define ARCH_HAS_DECOMP_WDOG
-
-#ifdef CONFIG_KERNEL_GZIP
-#include "../../../../lib/decompress_inflate.c"
-#endif
-
-#ifdef CONFIG_KERNEL_LZO
-#include "../../../../lib/decompress_unlzo.c"
-#endif
+unsigned long free_mem_ptr;
+unsigned long free_mem_end_ptr;
 
 #ifndef arch_error
 #define arch_error(x)
 #endif
 
-static void error(char *x)
+void error(char *x)
 {
 	arch_error(x);
 
@@ -261,6 +172,8 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
+extern void do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
+
 #ifndef STANDALONE_DEBUG
 
 unsigned long
@@ -281,8 +194,8 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	output_ptr = get_unaligned_le32(tmp);
 
 	putstr("Uncompressing Linux...");
-	decompress(input_data, input_data_end - input_data,
-			NULL, NULL, output_data, NULL, error);
+	do_decompress(input_data, input_data_end - input_data,
+			output_data, error);
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index a5924b9..d00b544 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -14,6 +14,7 @@ SECTIONS
   /DISCARD/ : {
     *(.ARM.exidx*)
     *(.ARM.extab*)
+    *(.data)
   }
 
   . = TEXT_START;
@@ -40,7 +41,6 @@ SECTIONS
   .got			: { *(.got) }
   _got_end = .;
   .got.plt		: { *(.got.plt) }
-  .data			: { *(.data) }
   _edata = .;
 
   . = BSS_START;
