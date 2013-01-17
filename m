From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 23:21:58 +0800
Subject: [PATCH 1/2] ARM: use Kconfig to select uncompress.h
In-Reply-To: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1358436119-30808-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the approach handling DEBUG_LL inclusion, the patch creates
a Kconfig symbol CONFIG_UNCOMPRESS_INCLUDE for choosing the correct
uncompress header.  For traditional build, mach/uncompress.h will be
included in arch/arm/boot/compressed/misc.c.  For multiplatform build,
debug/uncompress.h which contains a suite of empty functions will be
used.  In this way, a platform with particular uncompress.h
implementation could choose its own uncompress.h with this Kconfig
option.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug              |    5 +++++
 arch/arm/boot/compressed/misc.c     |    8 +-------
 arch/arm/include/debug/uncompress.h |    3 +++
 3 files changed, 9 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/debug/uncompress.h

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 05f83c8..86b273f8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -523,6 +523,11 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+config UNCOMPRESS_INCLUDE
+	string
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
+	default "mach/uncompress.h"
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index df89983..31bd43b 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,13 +25,7 @@ unsigned int __machine_arch_type;
 static void putstr(const char *ptr);
 extern void error(char *x);
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
-static inline void putc(int c) {}
-static inline void flush(void) {}
-static inline void arch_decomp_setup(void) {}
-#else
-#include <mach/uncompress.h>
-#endif
+#include CONFIG_UNCOMPRESS_INCLUDE
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
diff --git a/arch/arm/include/debug/uncompress.h b/arch/arm/include/debug/uncompress.h
new file mode 100644
index 0000000..e19955d
--- /dev/null
+++ b/arch/arm/include/debug/uncompress.h
@@ -0,0 +1,3 @@
+static inline void putc(int c) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
-- 
1.7.9.5
