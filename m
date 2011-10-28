From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:05 +0100
Subject: [PATCH 37/51] ARM: mach-s3c64xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-38-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-s3c64xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-s3c64xx/Makefile              |    1 +
 arch/arm/mach-s3c64xx/include/mach/system.h |    7 -------
 arch/arm/mach-s3c64xx/reset.c               |   26 ++++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/reset.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 61b4034..ba2f2ac 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -14,6 +14,7 @@ obj-				:=
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= gpiolib.o
+obj-y				+= reset.o
 
 # Core support for S3C6400 system
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index 2e58cb7..51bc8eb 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/watchdog-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
@@ -20,11 +18,6 @@ static void arch_idle(void)
 
 static void arch_reset(char mode, const char *cmd)
 {
-	if (mode != 's')
-		arch_wdt_reset();
-
-	/* if all else fails, or mode was for soft, jump to 0 */
-	cpu_reset(0);
 }
 
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s3c64xx/reset.c b/arch/arm/mach-s3c64xx/reset.c
new file mode 100644
index 0000000..2ea710c
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/reset.c
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-s3c64xx/reset.c
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <plat/watchdog-reset.h>
+
+#include <asm/proc-fns.h>
+
+static void s3c64xx_arch_reset(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	/* if all else fails, or mode was for soft, jump to 0 */
+	cpu_reset(0);
+}
+
+static int __init s3c64xx_arch_reset_init(void)
+{
+	arm_arch_reset = s3c64xx_arch_reset;
+	return 0;
+}
+arch_initcall(s3c64xx_arch_reset_init);
-- 
1.7.4.1
