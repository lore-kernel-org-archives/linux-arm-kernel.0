From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Sun, 12 Feb 2012 14:59:54 +0100
Subject: [PATCH] ARM: S3C24XX: Fix restart on S3C2442
In-Reply-To: <201202121457.18632.heiko@sntech.de>
References: <1329051929-8303-1-git-send-email-GNUtoo@no-log.org>
 <201202121457.18632.heiko@sntech.de>
Message-ID: <201202121459.54568.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b27b072791dc (ARM: 7265/1: restart: S3C24XX: use new restart hook)
introduced the new restart hook also for the S3C244x cpus, but it
was only defined in the S3C2440 scope, i.e. when CPU_S3C2440 was
selected. Devices using the S3C2442 like the GTA02 normally don't select
this CPU which leads to compilation errors like:
    LD      .tmp_vmlinux1
  arch/arm/mach-s3c2440/built-in.o:(.arch.info.init+0x3c): undefined reference to `s3c2440_restart'
  make: *** [.tmp_vmlinux1] Error 1

Therefore move the s3c2440_restart function to s3c244x.c which is
common to both cpus and also fix the naming to reflect this.

Reported-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2440/common.h         |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c    |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c     |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c  |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c  |    2 +-
 arch/arm/mach-s3c2440/mach-osiris.c    |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c    |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c    |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c  |    2 +-
 arch/arm/mach-s3c2440/s3c2440.c        |   13 -------------
 arch/arm/mach-s3c2440/s3c244x.c        |   13 +++++++++++++
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-s3c2440/common.h b/arch/arm/mach-s3c2440/common.h
index db8a98a..0c1eb1d 100644
--- a/arch/arm/mach-s3c2440/common.h
+++ b/arch/arm/mach-s3c2440/common.h
@@ -12,6 +12,6 @@
 #ifndef __ARCH_ARM_MACH_S3C2440_COMMON_H
 #define __ARCH_ARM_MACH_S3C2440_COMMON_H
 
-void s3c2440_restart(char mode, const char *cmd);
+void s3c244x_restart(char mode, const char *cmd);
 
 #endif /* __ARCH_ARM_MACH_S3C2440_COMMON_H */
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index 2456955..19b577b 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -487,5 +487,5 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.init_machine	= anubis_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index d6a9763..d7ae49c 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -222,5 +222,5 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 5859e60..9a4a5bc 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -601,5 +601,5 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= gta02_machine_init,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index adbbb85..5d66fb2 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -701,5 +701,5 @@ MACHINE_START(MINI2440, "MINI2440")
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c2440/mach-nexcoder.c
index 40eaf84..5198e3e 100644
--- a/arch/arm/mach-s3c2440/mach-nexcoder.c
+++ b/arch/arm/mach-s3c2440/mach-nexcoder.c
@@ -158,5 +158,5 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c24xx_init_irq,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 4c480ef..c5daeb6 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -436,5 +436,5 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.init_irq	= s3c24xx_init_irq,
 	.init_machine	= osiris_init,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 80077f6..6f68abf 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -822,5 +822,5 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.init_irq = s3c24xx_init_irq,
 	.init_machine = rx1950_init_machine,
 	.timer = &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 20103ba..56af354 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -213,5 +213,5 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.init_irq	= rx3715_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 1deb60d..83a1036 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -183,5 +183,5 @@ MACHINE_START(S3C2440, "SMDK2440")
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
 	.timer		= &s3c24xx_timer,
-	.restart	= s3c2440_restart,
+	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index 517623a..2b3dddb 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -35,7 +35,6 @@
 #include <plat/cpu.h>
 #include <plat/s3c244x.h>
 #include <plat/pm.h>
-#include <plat/watchdog-reset.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -74,15 +73,3 @@ void __init s3c2440_map_io(void)
 	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1up;
 	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1up;
 }
-
-void s3c2440_restart(char mode, const char *cmd)
-{
-	if (mode == 's') {
-		soft_restart(0);
-	}
-
-	arch_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 36bc60f..a6c660a 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -46,6 +46,7 @@
 #include <plat/pm.h>
 #include <plat/pll.h>
 #include <plat/nand-core.h>
+#include <plat/watchdog-reset.h>
 
 static struct map_desc s3c244x_iodesc[] __initdata = {
 	IODESC_ENT(CLKPWR),
@@ -196,3 +197,15 @@ struct syscore_ops s3c244x_pm_syscore_ops = {
 	.suspend	= s3c244x_suspend,
 	.resume		= s3c244x_resume,
 };
+
+void s3c244x_restart(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		soft_restart(0);
+	}
+
+	arch_wdt_reset();
+
+	/* we'll take a jump through zero as a poor second */
+	soft_restart(0);
+}
-- 
1.7.2.3
