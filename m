From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:38 +0200
Subject: [RFC PATCH 08/15] ARM: uncompress: Rename misc.c to print.c
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-8-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that misc.c only holds functions related to printout
during decompression, rename it accordingly.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/boot/compressed/Makefile |    2 +-
 arch/arm/boot/compressed/misc.c   |  122 -------------------------------------
 arch/arm/boot/compressed/print.c  |  122 +++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 123 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/misc.c
 create mode 100644 arch/arm/boot/compressed/print.c

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index e4f32a8..d955d4f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -23,7 +23,7 @@ endif
 
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
-OBJS	+= misc.o decompress.o
+OBJS	+= print.o decompress.o
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
deleted file mode 100644
index 25f0fb2..0000000
--- a/arch/arm/boot/compressed/misc.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * misc.c
- * 
- * This is a collection of several routines from gzip-1.0.3 
- * adapted for Linux.
- *
- * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
- *
- * Modified for ARM Linux by Russell King
- *
- * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
- *  For this code to run directly from Flash, all constant variables must
- *  be marked with 'const' and all other variables initialized at run-time 
- *  only.  This way all non constant variables will end up in the bss segment,
- *  which should point to addresses in RAM and cleared to 0 on start.
- *  This allows for a much quicker boot time.
- */
-
-#include <linux/compiler.h>	/* for inline */
-#include <linux/types.h>
-#include <linux/linkage.h>
-
-void putstr(const char *ptr);
-void error(char *x);
-extern unsigned int __machine_arch_type;
-#define arch_id __machine_arch_type
-
-#include <mach/uncompress.h>
-
-#ifdef ARCH_HAVE_DECOMP_SETUP
-void inline decomp_setup(void)
-{
-	arch_decomp_setup();
-}
-#else /* ARCH_HAVE_DECOMP_SETUP */
-void inline decomp_setup(void)
-{
-}
-#endif /* ARCH_HAVE_DECOMP_SETUP */
-
-#ifdef CONFIG_DEBUG_ICEDCC
-
-#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-
-static void icedcc_putc(int ch)
-{
-	int status, i = 0x4000000;
-
-	do {
-		if (--i < 0)
-			return;
-
-		asm volatile ("mrc p14, 0, %0, c0, c1, 0" : "=r" (status));
-	} while (status & (1 << 29));
-
-	asm("mcr p14, 0, %0, c0, c5, 0" : : "r" (ch));
-}
-
-#elif defined(CONFIG_CPU_XSCALE)
-
-static void icedcc_putc(int ch)
-{
-	int status, i = 0x4000000;
-
-	do {
-		if (--i < 0)
-			return;
-
-		asm volatile ("mrc p14, 0, %0, c14, c0, 0" : "=r" (status));
-	} while (status & (1 << 28));
-
-	asm("mcr p14, 0, %0, c8, c0, 0" : : "r" (ch));
-}
-
-#else
-
-static void icedcc_putc(int ch)
-{
-	int status, i = 0x4000000;
-
-	do {
-		if (--i < 0)
-			return;
-
-		asm volatile ("mrc p14, 0, %0, c0, c0, 0" : "=r" (status));
-	} while (status & 2);
-
-	asm("mcr p14, 0, %0, c1, c0, 0" : : "r" (ch));
-}
-
-#endif
-
-#define putc(ch)	icedcc_putc(ch)
-#endif
-
-void putstr(const char *ptr)
-{
-	char c;
-
-	while ((c = *ptr++) != '\0') {
-		if (c == '\n')
-			putc('\r');
-		putc(c);
-	}
-
-	flush();
-}
-
-#ifndef arch_error
-#define arch_error(x)
-#endif
-
-void error(char *x)
-{
-	arch_error(x);
-
-	putstr("\n\n");
-	putstr(x);
-	putstr("\n\n -- System halted");
-
-	while(1);	/* Halt */
-}
diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
new file mode 100644
index 0000000..25f0fb2
--- /dev/null
+++ b/arch/arm/boot/compressed/print.c
@@ -0,0 +1,122 @@
+/*
+ * misc.c
+ * 
+ * This is a collection of several routines from gzip-1.0.3 
+ * adapted for Linux.
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ *
+ * Modified for ARM Linux by Russell King
+ *
+ * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
+ *  For this code to run directly from Flash, all constant variables must
+ *  be marked with 'const' and all other variables initialized at run-time 
+ *  only.  This way all non constant variables will end up in the bss segment,
+ *  which should point to addresses in RAM and cleared to 0 on start.
+ *  This allows for a much quicker boot time.
+ */
+
+#include <linux/compiler.h>	/* for inline */
+#include <linux/types.h>
+#include <linux/linkage.h>
+
+void putstr(const char *ptr);
+void error(char *x);
+extern unsigned int __machine_arch_type;
+#define arch_id __machine_arch_type
+
+#include <mach/uncompress.h>
+
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
+#ifdef CONFIG_DEBUG_ICEDCC
+
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+
+static void icedcc_putc(int ch)
+{
+	int status, i = 0x4000000;
+
+	do {
+		if (--i < 0)
+			return;
+
+		asm volatile ("mrc p14, 0, %0, c0, c1, 0" : "=r" (status));
+	} while (status & (1 << 29));
+
+	asm("mcr p14, 0, %0, c0, c5, 0" : : "r" (ch));
+}
+
+#elif defined(CONFIG_CPU_XSCALE)
+
+static void icedcc_putc(int ch)
+{
+	int status, i = 0x4000000;
+
+	do {
+		if (--i < 0)
+			return;
+
+		asm volatile ("mrc p14, 0, %0, c14, c0, 0" : "=r" (status));
+	} while (status & (1 << 28));
+
+	asm("mcr p14, 0, %0, c8, c0, 0" : : "r" (ch));
+}
+
+#else
+
+static void icedcc_putc(int ch)
+{
+	int status, i = 0x4000000;
+
+	do {
+		if (--i < 0)
+			return;
+
+		asm volatile ("mrc p14, 0, %0, c0, c0, 0" : "=r" (status));
+	} while (status & 2);
+
+	asm("mcr p14, 0, %0, c1, c0, 0" : : "r" (ch));
+}
+
+#endif
+
+#define putc(ch)	icedcc_putc(ch)
+#endif
+
+void putstr(const char *ptr)
+{
+	char c;
+
+	while ((c = *ptr++) != '\0') {
+		if (c == '\n')
+			putc('\r');
+		putc(c);
+	}
+
+	flush();
+}
+
+#ifndef arch_error
+#define arch_error(x)
+#endif
+
+void error(char *x)
+{
+	arch_error(x);
+
+	putstr("\n\n");
+	putstr(x);
+	putstr("\n\n -- System halted");
+
+	while(1);	/* Halt */
+}
-- 
1.7.4.1
