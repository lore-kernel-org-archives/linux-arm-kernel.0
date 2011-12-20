From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:26 +0900
Subject: [PATCH 02/12] ARM: restart: S3C64XX: use new restart hook
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/common.c                     |   10 ++++++++++
 arch/arm/mach-s3c64xx/common.h                     |    2 ++
 arch/arm/mach-s3c64xx/include/mach/system.h        |   11 -----------
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    1 +
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    1 +
 arch/arm/mach-s3c64xx/mach-real6410.c              |    1 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 +
 .../arm/plat-samsung/include/plat/watchdog-reset.h |    1 +
 14 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 8ae5b16..35182ba 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -44,6 +44,7 @@
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
+#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -373,3 +374,12 @@ static int __init s3c64xx_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(s3c64xx_init_irq_eint);
+
+void s3c64xx_restart(char mode, const char *cmd)
+{
+	if (mode != 's')
+		arch_wdt_reset();
+
+	/* if all else fails, or mode was for soft, jump to 0 */
+	soft_restart(0);
+}
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 9f523a2..8dc8ab6 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -23,6 +23,8 @@ void s3c64xx_init_io(struct map_desc *mach_desc, int size);
 void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
 void s3c64xx_setup_clocks(void);
 
+void s3c64xx_restart(char mode, const char *cmd);
+
 extern struct syscore_ops s3c64xx_irq_syscore_ops;
 extern struct sysdev_class s3c64xx_sysclass;
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index d8ca578..353ed43 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -11,20 +11,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/watchdog-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
 }
 
-static void arch_reset(char mode, const char *cmd)
-{
-	if (mode != 's')
-		arch_wdt_reset();
-
-	/* if all else fails, or mode was for soft, jump to 0 */
-	soft_restart(0);
-}
-
 #endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index bad1d0d..b86f277 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -242,4 +242,5 @@ MACHINE_START(ANW6410, "A&W6410")
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index b7350b0..f1c848a 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -717,4 +717,5 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index df38602..521e07b 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -273,4 +273,5 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 72ebe5d..c34c2ab 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -351,4 +351,5 @@ MACHINE_START(MINI6410, "MINI6410")
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 8bec707..0efa2ba 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -105,4 +105,5 @@ MACHINE_START(NCP, "NCP")
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 853c41e..be2a9a2 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -332,4 +332,5 @@ MACHINE_START(REAL6410, "REAL6410")
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 2804526..3f42431 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -153,4 +153,5 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index a0f9d1a..e5c09b6 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -169,4 +169,5 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 57a7eaa..5f09653 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -94,4 +94,5 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index cba6714..ca6fc20 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -706,4 +706,5 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
 	.timer		= &s3c24xx_timer,
+	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/plat-samsung/include/plat/watchdog-reset.h b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
index 40dbb2b..f19aff1 100644
--- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
+++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 static inline void arch_wdt_reset(void)
 {
-- 
1.7.4.4
