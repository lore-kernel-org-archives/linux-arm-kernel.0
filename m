From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:37 +0200
Subject: [RFC PATCH 07/15] ARM: uncompress: Move decompressing related stuff
	to decompress.c
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-7-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move decompressing related functions and declarations from misc.c
to decompress.c as it seems to be more logical.
misc.c now only holds the inclusion of uncompress.h and printing
functions.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/decompress.c |   59 +++++++++++++++++++++++++++++-
 arch/arm/boot/compressed/misc.c       |   66 ++++++++-------------------------
 2 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 6dec528..17200d5 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -1,3 +1,12 @@
+/*
+ * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
+ *  For this code to run directly from Flash, all constant variables must
+ *  be marked with 'const' and all other variables initialized at run-time
+ *  only.  This way all non constant variables will end up in the bss segment,
+ *  which should point to addresses in RAM and cleared to 0 on start.
+ *  This allows for a much quicker boot time.
+ */
+
 #define _LINUX_STRING_H_
 
 #include <linux/compiler.h>	/* for inline */
@@ -25,7 +34,55 @@ extern void error(char *);
 #include "../../../../lib/decompress_unlzma.c"
 #endif
 
-int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
+static int
+do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return decompress(input, len, NULL, NULL, output, NULL, error);
 }
+
+unsigned int __machine_arch_type;
+
+/* These are in misc.c */
+extern void putstr(const char *ptr);
+extern void error(char *x);
+extern void decomp_setup(void);
+
+/*
+ * gzip declarations
+ */
+extern char input_data[];
+extern char input_data_end[];
+
+unsigned char *output_data;
+
+unsigned long free_mem_ptr;
+unsigned long free_mem_end_ptr;
+
+void
+decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
+		unsigned long free_mem_ptr_end_p,
+		int arch_id)
+{
+	int ret;
+
+	output_data		= (unsigned char *)output_start;
+	free_mem_ptr		= free_mem_ptr_p;
+	free_mem_end_ptr	= free_mem_ptr_end_p;
+	__machine_arch_type	= arch_id;
+
+	/* This is arch_decomp_setup if its use is defined in uncompress.h */
+	decomp_setup();
+
+	putstr("Uncompressing Linux...");
+	ret = do_decompress(input_data, input_data_end - input_data,
+			    output_data, error);
+	if (ret)
+		error("decompressor returned an error");
+	else
+		putstr(" done, booting the kernel.\n");
+}
+
+asmlinkage void __div0(void)
+{
+	error("Attempting division by 0!");
+}
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index a4b8df2..25f0fb2 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -16,17 +16,28 @@
  *  This allows for a much quicker boot time.
  */
 
-unsigned int __machine_arch_type;
-
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>
 #include <linux/linkage.h>
 
-static void putstr(const char *ptr);
-extern void error(char *x);
+void putstr(const char *ptr);
+void error(char *x);
+extern unsigned int __machine_arch_type;
+#define arch_id __machine_arch_type
 
 #include <mach/uncompress.h>
 
+#ifdef ARCH_HAVE_DECOMP_SETUP
+void inline decomp_setup(void)
+{
+	arch_decomp_setup();
+}
+#else /* ARCH_HAVE_DECOMP_SETUP */
+void inline decomp_setup(void)
+{
+}
+#endif /* ARCH_HAVE_DECOMP_SETUP */
+
 #ifdef CONFIG_DEBUG_ICEDCC
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
@@ -45,7 +56,6 @@ static void icedcc_putc(int ch)
 	asm("mcr p14, 0, %0, c0, c5, 0" : : "r" (ch));
 }
 
-
 #elif defined(CONFIG_CPU_XSCALE)
 
 static void icedcc_putc(int ch)
@@ -83,7 +93,7 @@ static void icedcc_putc(int ch)
 #define putc(ch)	icedcc_putc(ch)
 #endif
 
-static void putstr(const char *ptr)
+void putstr(const char *ptr)
 {
 	char c;
 
@@ -96,17 +106,6 @@ static void putstr(const char *ptr)
 	flush();
 }
 
-/*
- * gzip declarations
- */
-extern char input_data[];
-extern char input_data_end[];
-
-unsigned char *output_data;
-
-unsigned long free_mem_ptr;
-unsigned long free_mem_end_ptr;
-
 #ifndef arch_error
 #define arch_error(x)
 #endif
@@ -121,36 +120,3 @@ void error(char *x)
 
 	while(1);	/* Halt */
 }
-
-asmlinkage void __div0(void)
-{
-	error("Attempting division by 0!");
-}
-
-extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
-
-
-void
-decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
-		unsigned long free_mem_ptr_end_p,
-		int arch_id)
-{
-	int ret;
-
-	output_data		= (unsigned char *)output_start;
-	free_mem_ptr		= free_mem_ptr_p;
-	free_mem_end_ptr	= free_mem_ptr_end_p;
-	__machine_arch_type	= arch_id;
-
-#ifdef ARCH_HAVE_DECOMP_SETUP
-	arch_decomp_setup();
-#endif /* ARCH_HAVE_DECOMP_SETUP */
-
-	putstr("Uncompressing Linux...");
-	ret = do_decompress(input_data, input_data_end - input_data,
-			    output_data, error);
-	if (ret)
-		error("decompressor returned an error");
-	else
-		putstr(" done, booting the kernel.\n");
-}
-- 
1.7.4.1
