From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 10:45:20 +0800
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform build
In-Reply-To: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of giving zero support of uncompress debug for multiplatform
build, the patch turns uncompress debug into one part of DEBUG_LL
support.  When DEBUG_LL is turned on for a particular platform,
uncompress debug works too for that platform.

It reuses the platform DEBUG_LL macros by creating a simple
arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
included there, and implements a generic putc() using those macros.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/compressed/Makefile   |    3 +++
 arch/arm/boot/compressed/debug.S    |   11 +++++++++++
 arch/arm/include/debug/uncompress.h |    4 ++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/compressed/debug.S

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..c9865f6 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,9 @@ endif
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+ifeq ($(CONFIG_DEBUG_LL),y)
+OBJS	+= debug.o
+endif
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
 
 # string library code (-Os is enforced to keep it much smaller)
diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
new file mode 100644
index 0000000..bdb0e25
--- /dev/null
+++ b/arch/arm/boot/compressed/debug.S
@@ -0,0 +1,11 @@
+#include <linux/linkage.h>
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
index e19955d..9aa5314 100644
--- a/arch/arm/include/debug/uncompress.h
+++ b/arch/arm/include/debug/uncompress.h
@@ -1,3 +1,7 @@
+#ifdef CONFIG_DEBUG_LL
+extern void putc(int c);
+#else
 static inline void putc(int c) {}
+#endif
 static inline void flush(void) {}
 static inline void arch_decomp_setup(void) {}
-- 
1.7.9.5
