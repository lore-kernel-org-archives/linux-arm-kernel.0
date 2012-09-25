From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Sep 2012 16:46:50 -0600
Subject: [RFC PATCH 1/3] ARM: move ICEDCC uncompress.h to common location
In-Reply-To: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1348613212-21897-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Create a common location for uncompress.h, and select the included debug
macro file using config option.

This does the same for uncompress.h as a recent patch for debug-macro.S,
which was based on a suggestion by Russell King and implemented by Rob
Herring.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig.debug                     |   10 ++++
 arch/arm/boot/compressed/misc.c            |   64 +---------------------------
 arch/arm/include/debug/icedcc-uncompress.h |   61 ++++++++++++++++++++++++++
 arch/arm/include/debug/none-uncompress.h   |    3 +
 4 files changed, 75 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/include/debug/icedcc-uncompress.h
 create mode 100644 arch/arm/include/debug/none-uncompress.h

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..0daec3d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -420,6 +420,16 @@ config DEBUG_LL_INCLUDE
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "mach/debug-macro.S"
 
+config UNCOMPRESS_INCLUDE
+	string
+	default "debug/icedcc-uncompress.h" if DEBUG_ICEDCC
+	default "debug/none-uncompress.h" if ARCH_MULTIPLATFORM || \
+		DEBUG_HIGHBANK_UART || DEBUG_MVEBU_UART || \
+		DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
+		DEBUG_VEXPRESS_UART0_DETECT || DEBUG_VEXPRESS_UART0_CA9 || \
+		DEBUG_VEXPRESS_UART0_RS1
+	default "mach/uncompress.h"
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index df89983..afbdb3f 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,69 +25,7 @@ unsigned int __machine_arch_type;
 static void putstr(const char *ptr);
 extern void error(char *x);
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
-static inline void putc(int c) {}
-static inline void flush(void) {}
-static inline void arch_decomp_setup(void) {}
-#else
-#include <mach/uncompress.h>
-#endif
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
+#include CONFIG_UNCOMPRESS_INCLUDE
 
 static void putstr(const char *ptr)
 {
diff --git a/arch/arm/include/debug/icedcc-uncompress.h b/arch/arm/include/debug/icedcc-uncompress.h
new file mode 100644
index 0000000..b505241
--- /dev/null
+++ b/arch/arm/include/debug/icedcc-uncompress.h
@@ -0,0 +1,61 @@
+/*
+ * Decompressor debug output routines for ICEDCC
+ *
+ * Extracted from misc.c, which is by:
+ * Modified for ARM Linux by Russell King
+ * Nicolas Pitre <nico@visuaide.com>
+ */
+
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
+
+static void putc(int ch)
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
+
+#elif defined(CONFIG_CPU_XSCALE)
+
+static void putc(int ch)
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
+static void putc(int ch)
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
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
diff --git a/arch/arm/include/debug/none-uncompress.h b/arch/arm/include/debug/none-uncompress.h
new file mode 100644
index 0000000..e19955d
--- /dev/null
+++ b/arch/arm/include/debug/none-uncompress.h
@@ -0,0 +1,3 @@
+static inline void putc(int c) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
-- 
1.7.0.4
