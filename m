From: o.mandel@menlosystems.com (Olaf Mandel)
Date: Mon, 18 May 2015 17:50:43 +0200
Subject: [PATCH] arm: add CONFIG_ARM_VERBOSE_BOOTUP
Message-ID: <1431964243-9995-1-git-send-email-o.mandel@menlosystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new option copies the behaviour of CONFIG_X86_VERBOSE_BOOTUP
to the arm architecture, allowing to completely silence the
serial port. The default value is y, which is the original
behaviour.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
CC: Marek Vasut <marex@denx.de>
---
 arch/arm/Kconfig.debug          |  9 +++++++++
 arch/arm/boot/compressed/misc.c | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c12ffb..644f585 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1565,6 +1565,15 @@ config UNCOMPRESS_INCLUDE
 					ARCH_SHMOBILE_LEGACY
 	default "mach/uncompress.h"
 
+config ARM_VERBOSE_BOOTUP
+        bool "Enable verbose arm bootup info messages"
+        default y
+        ---help---
+          Enables the informational output from the decompression stage
+          (e.g. bzImage) of the boot. Disable this if you want silent
+          bootup. Error messages from the compression stage are shown
+          even if this option is disabled.
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index d4f891f..4873708 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -22,7 +22,13 @@ unsigned int __machine_arch_type;
 #include <linux/types.h>
 #include <linux/linkage.h>
 
-static void putstr(const char *ptr);
+static void __putstr(const char *ptr);
+#ifdef CONFIG_ARM_VERBOSE_BOOTUP
+#define putstr(__x)	__putstr(__x)
+#else
+static inline void putstr(const char *ptr)
+{ }
+#endif
 extern void error(char *x);
 
 #include CONFIG_UNCOMPRESS_INCLUDE
@@ -83,7 +89,7 @@ static void icedcc_putc(int ch)
 #define putc(ch)	icedcc_putc(ch)
 #endif
 
-static void putstr(const char *ptr)
+static void __putstr(const char *ptr)
 {
 	char c;
 
@@ -115,9 +121,9 @@ void error(char *x)
 {
 	arch_error(x);
 
-	putstr("\n\n");
-	putstr(x);
-	putstr("\n\n -- System halted");
+	__putstr("\n\n");
+	__putstr(x);
+	__putstr("\n\n -- System halted");
 
 	while(1);	/* Halt */
 }
-- 
2.1.4
