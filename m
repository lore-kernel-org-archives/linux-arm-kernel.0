From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 19:35:37 +0800
Subject: [PATCH v4 2/2] ARM: uncompress debug support for multiplatform build
In-Reply-To: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
References: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1363001737-8745-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of giving zero support of uncompress debug for multiplatform
build, the patch turns uncompress debug into one part of DEBUG_LL
support.  When DEBUG_LL is turned on for a particular platform,
uncompress debug works too for that platform.

OMAP is an exception here.  OMAP low-level debug code places data
in the .data section, and that is allowed in decompressor.  That's
why Kconfig symbol DEBUG_UNCOMPRESS that controls multiplatform
uncompress debug support is defined with !DEBUG_OMAP2PLUS_UART.

It creates arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
included there, implements a generic putc() using those macros, which
will be built when DEBUG_UNCOMPRESS is defined.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig.debug              |    4 ++++
 arch/arm/boot/compressed/Makefile   |    3 +++
 arch/arm/boot/compressed/debug.S    |   12 ++++++++++++
 arch/arm/include/debug/uncompress.h |    4 ++++
 4 files changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/compressed/debug.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fc54a5b..559228c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -601,6 +601,10 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+config DEBUG_UNCOMPRESS
+	bool
+	default y if ARCH_MULTIPLATFORM && DEBUG_LL && !DEBUG_OMAP2PLUS_UART
+
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..e3238bc 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,9 @@ endif
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
+OBJS	+= debug.o
+endif
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
new file mode 100644
index 0000000..6e8382d
--- /dev/null
+++ b/arch/arm/boot/compressed/debug.S
@@ -0,0 +1,12 @@
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+#include CONFIG_DEBUG_LL_INCLUDE
+
+ENTRY(putc)
+	addruart r1, r2, r3
+	waituart r3, r1
+	senduart r0, r1
+	busyuart r3, r1
+	mov	 pc, lr
+ENDPROC(putc)
diff --git a/arch/arm/include/debug/uncompress.h b/arch/arm/include/debug/uncompress.h
index e19955d..0e2949b 100644
--- a/arch/arm/include/debug/uncompress.h
+++ b/arch/arm/include/debug/uncompress.h
@@ -1,3 +1,7 @@
+#ifdef CONFIG_DEBUG_UNCOMPRESS
+extern void putc(int c);
+#else
 static inline void putc(int c) {}
+#endif
 static inline void flush(void) {}
 static inline void arch_decomp_setup(void) {}
-- 
1.7.9.5
