From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:37 +0800
Subject: [PATCH 12/15] ARM: sa1100: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-sa1100/assabet.c    |    1 +
 arch/arm/mach-sa1100/badge4.c     |    1 +
 arch/arm/mach-sa1100/cerf.c       |    1 +
 arch/arm/mach-sa1100/collie.c     |    1 +
 arch/arm/mach-sa1100/generic.c    |    4 ++++
 arch/arm/mach-sa1100/generic.h    |    7 +++++++
 arch/arm/mach-sa1100/h3100.c      |    1 +
 arch/arm/mach-sa1100/h3600.c      |    1 +
 arch/arm/mach-sa1100/hackkit.c    |    1 +
 arch/arm/mach-sa1100/jornada720.c |    1 +
 arch/arm/mach-sa1100/lart.c       |    1 +
 arch/arm/mach-sa1100/nanoengine.c |    1 +
 arch/arm/mach-sa1100/pleb.c       |    1 +
 arch/arm/mach-sa1100/pm.c         |    4 +---
 arch/arm/mach-sa1100/shannon.c    |    1 +
 arch/arm/mach-sa1100/simpad.c     |    1 +
 16 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 375d3f7..d1dc7f1 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -538,6 +538,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= assabet_init,
+	.init_late	= sa11x0_init_late,
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
 #endif
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index e0f0c03..b30fb99 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -305,6 +305,7 @@ MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 	.map_io		= badge4_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.init_late	= sa11x0_init_late,
 	.timer		= &sa1100_timer,
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 4a61f60..09d7f4b 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -134,5 +134,6 @@ MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	.init_irq	= cerf_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= cerf_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index c7f418b..ea5cff3 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -401,5 +401,6 @@ MACHINE_START(COLLIE, "Sharp-Collie")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= collie_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 7c524b4..49468e6 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -359,6 +359,10 @@ static int __init sa1100_init(void)
 
 arch_initcall(sa1100_init);
 
+void __init sa11x0_init_late(void)
+{
+	sa11x0_pm_init();
+}
 
 /*
  * Common I/O mapping:
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 9eb3b3c..a5b7c13 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -11,6 +11,7 @@ extern void __init sa1100_map_io(void);
 extern void __init sa1100_init_irq(void);
 extern void __init sa1100_init_gpio(void);
 extern void sa11x0_restart(char, const char *);
+extern void sa11x0_init_late(void);
 
 #define SET_BANK(__nr,__start,__size) \
 	mi->bank[__nr].start = (__start), \
@@ -41,3 +42,9 @@ void sa11x0_register_mcp(struct mcp_plat_data *data);
 
 struct sa1100fb_mach_info;
 void sa11x0_register_lcd(struct sa1100fb_mach_info *inf);
+
+#ifdef CONFIG_PM
+int sa11x0_pm_init(void);
+#else
+static inline int sa11x0_pm_init(void) { return 0; }
+#endif
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index b2e8d0f..e1571ea 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -110,6 +110,7 @@ MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3100_mach_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index cb6659f..ba7a290 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -160,6 +160,7 @@ MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3600_mach_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 5535475..7f86bd9 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -199,5 +199,6 @@ MACHINE_START(HACKKIT, "HackKit Cpu Board")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= hackkit_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index ca7a7e8..e3084f4 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -348,6 +348,7 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= jornada720_mach_init,
+	.init_late	= sa11x0_init_late,
 #ifdef CONFIG_SA1111
 	.dma_zone_size	= SZ_1M,
 #endif
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index eb6534e..b775a0a 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -147,6 +147,7 @@ MACHINE_START(LART, "LART")
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.init_machine	= lart_init,
+	.init_late	= sa11x0_init_late,
 	.timer		= &sa1100_timer,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 8f6446b..41f69d9 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -112,5 +112,6 @@ MACHINE_START(NANOENGINE, "BSE nanoEngine")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= nanoengine_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 1602575..37fe0a0 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -135,5 +135,6 @@ MACHINE_START(PLEB, "PLEB")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine   = pleb_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 2fa499e..690cf0c 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -117,10 +117,8 @@ static const struct platform_suspend_ops sa11x0_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
-static int __init sa11x0_pm_init(void)
+int __init sa11x0_pm_init(void)
 {
 	suspend_set_ops(&sa11x0_pm_ops);
 	return 0;
 }
-
-late_initcall(sa11x0_pm_init);
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index ca8bf59..5d33fc3 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -104,5 +104,6 @@ MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= shannon_init,
+	.init_late	= sa11x0_init_late,
 	.restart	= sa11x0_restart,
 MACHINE_END
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 3efae03..fbd5359 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -395,6 +395,7 @@ MACHINE_START(SIMPAD, "Simpad")
 	.map_io		= simpad_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.init_late	= sa11x0_init_late,
 	.timer		= &sa1100_timer,
 	.restart	= sa11x0_restart,
 MACHINE_END
-- 
1.7.5.4
