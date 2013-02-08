From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 8 Feb 2013 19:44:52 +0800
Subject: [PATCH v3 2/2] ARM: uncompress debug support for multiplatform build
In-Reply-To: <20130206093236.GD17833@n2100.arm.linux.org.uk>
References: <20130206093236.GD17833@n2100.arm.linux.org.uk>
Message-ID: <1360323892-2860-1-git-send-email-shawn.guo@linaro.org>
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
Acked-by: Olof Johansson <olof@lixom.net>
---
Changes since v2:
 * Build arch/arm/boot/compressed/debug.S only for multiplatform kernel
   to fix the breakage on traditional platform build
 * Include asm/assembler.h in arch/arm/boot/compressed/debug.S, as it
   may commonly be needed by platforms to be converted to multiplatform

Russell,

I will put it into patch system if I do not receive any comment
tomorrow.

Shawn

 arch/arm/boot/compressed/Makefile   |    5 +++++
 arch/arm/boot/compressed/debug.S    |   12 ++++++++++++
 arch/arm/include/debug/uncompress.h |    4 ++++
 3 files changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/compressed/debug.S

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..13bdd10 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,11 @@ endif
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+ifeq ($(CONFIG_DEBUG_LL),y)
+OBJS	+= debug.o
+endif
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
