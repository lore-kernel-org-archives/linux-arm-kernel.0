From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:28 +0900
Subject: [PATCH 04/12] ARM: restart: S5P64X0: use new restart hook
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/common.c              |    9 +++++++++
 arch/arm/mach-s5p64x0/common.h              |    2 ++
 arch/arm/mach-s5p64x0/include/mach/system.h |    2 --
 arch/arm/mach-s5p64x0/mach-smdk6440.c       |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c       |    1 +
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index af02dc3..b7555a0 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -45,6 +45,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
+#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -457,3 +458,11 @@ static int __init s5p64x0_init_irq_eint(void)
 	return ret;
 }
 arch_initcall(s5p64x0_init_irq_eint);
+
+void s5p64x0_restart(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-s5p64x0/common.h b/arch/arm/mach-s5p64x0/common.h
index 8a1eca5..f8a60fd 100644
--- a/arch/arm/mach-s5p64x0/common.h
+++ b/arch/arm/mach-s5p64x0/common.h
@@ -22,6 +22,8 @@ void s5p6440_setup_clocks(void);
 void s5p6450_register_clocks(void);
 void s5p6450_setup_clocks(void);
 
+void s5p64x0_restart(char mode, const char *cmd);
+
 #ifdef CONFIG_CPU_S5P6440
 
 extern  int s5p64x0_init(void);
diff --git a/arch/arm/mach-s5p64x0/include/mach/system.h b/arch/arm/mach-s5p64x0/include/mach/system.h
index 60f5753..cf26e09 100644
--- a/arch/arm/mach-s5p64x0/include/mach/system.h
+++ b/arch/arm/mach-s5p64x0/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 74f3f02..34d98a1 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -248,4 +248,5 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5p64x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 193ed2d..135cf5d 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -268,4 +268,5 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.map_io		= smdk6450_map_io,
 	.init_machine	= smdk6450_machine_init,
 	.timer		= &s5p_timer,
+	.restart	= s5p64x0_restart,
 MACHINE_END
-- 
1.7.4.4
