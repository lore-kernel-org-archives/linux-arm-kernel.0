From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:36 +0800
Subject: [PATCH 11/15] ARM: s3c64xx: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-s3c64xx/common.c        |    5 +++++
 arch/arm/mach-s3c64xx/common.h        |    7 +++++++
 arch/arm/mach-s3c64xx/mach-anw6410.c  |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
 arch/arm/mach-s3c64xx/mach-hmt.c      |    1 +
 arch/arm/mach-s3c64xx/mach-mini6410.c |    1 +
 arch/arm/mach-s3c64xx/mach-ncp.c      |    1 +
 arch/arm/mach-s3c64xx/mach-real6410.c |    1 +
 arch/arm/mach-s3c64xx/mach-smartq5.c  |    1 +
 arch/arm/mach-s3c64xx/mach-smartq7.c  |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
 arch/arm/mach-s3c64xx/pm.c            |    3 +--
 13 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index b313380..be746e3 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -384,3 +384,8 @@ void s3c64xx_restart(char mode, const char *cmd)
 	/* if all else fails, or mode was for soft, jump to 0 */
 	soft_restart(0);
 }
+
+void __init s3c64xx_init_late(void)
+{
+	s3c64xx_pm_late_initcall();
+}
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 7a10be6..6cfc99b 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -24,6 +24,7 @@ void s3c64xx_register_clocks(unsigned long xtal, unsigned armclk_limit);
 void s3c64xx_setup_clocks(void);
 
 void s3c64xx_restart(char mode, const char *cmd);
+void s3c64xx_init_late(void);
 
 #ifdef CONFIG_CPU_S3C6400
 
@@ -51,4 +52,10 @@ extern void s3c6410_init_clocks(int xtal);
 #define s3c6410_init NULL
 #endif
 
+#ifdef CONFIG_PM
+int __init s3c64xx_pm_late_initcall(void);
+#else
+static inline int s3c64xx_pm_late_initcall(void) { return 0; }
+#endif
+
 #endif /* __ARCH_ARM_MACH_S3C64XX_COMMON_H */
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index b86f277..8808aa5 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -241,6 +241,7 @@ MACHINE_START(ANW6410, "A&W6410")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index e20bf58..607d3f1 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -811,6 +811,7 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 521e07b..1bf6b9d 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -272,6 +272,7 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index c34c2ab..5aef599 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -350,6 +350,7 @@ MACHINE_START(MINI6410, "MINI6410")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 0efa2ba..cad2e05 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -104,6 +104,7 @@ MACHINE_START(NCP, "NCP")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index be2a9a2..a88b60f 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -331,6 +331,7 @@ MACHINE_START(REAL6410, "REAL6410")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 3f42431d..c5021d0 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -152,6 +152,7 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e5c09b6..aa9072a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -168,6 +168,7 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 5f09653..b0f4525 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -93,6 +93,7 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d55bc96..315a8b4 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -709,6 +709,7 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.handle_irq	= vic_handle_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
+	.init_late	= s3c64xx_init_late,
 	.timer		= &s3c24xx_timer,
 	.restart	= s3c64xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 7d3e81b..7feb426 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -365,10 +365,9 @@ static __init int s3c64xx_pm_initcall(void)
 }
 arch_initcall(s3c64xx_pm_initcall);
 
-static __init int s3c64xx_pm_late_initcall(void)
+int __init s3c64xx_pm_late_initcall(void)
 {
 	pm_genpd_poweroff_unused();
 
 	return 0;
 }
-late_initcall(s3c64xx_pm_late_initcall);
-- 
1.7.5.4
