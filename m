From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed,  2 May 2012 19:33:34 +0800
Subject: [PATCH 09/15] ARM: pnx4008: use machine specific hook for late init
In-Reply-To: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335958420-5193-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-pnx4008/core.c |   12 ++++++++++++
 arch/arm/mach-pnx4008/pm.c   |    4 +---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pnx4008/core.c b/arch/arm/mach-pnx4008/core.c
index be4c928..a00d2f1 100644
--- a/arch/arm/mach-pnx4008/core.c
+++ b/arch/arm/mach-pnx4008/core.c
@@ -265,6 +265,17 @@ static void pnx4008_restart(char mode, const char *cmd)
 	soft_restart(0);
 }
 
+#ifdef CONFIG_PM
+extern int pnx4008_pm_init(void);
+#else
+static inline int pnx4008_pm_init(void) { return 0; }
+#endif
+
+void __init pnx4008_init_late(void)
+{
+	pnx4008_pm_init();
+}
+
 extern struct sys_timer pnx4008_timer;
 
 MACHINE_START(PNX4008, "Philips PNX4008")
@@ -273,6 +284,7 @@ MACHINE_START(PNX4008, "Philips PNX4008")
 	.map_io 		= pnx4008_map_io,
 	.init_irq 		= pnx4008_init_irq,
 	.init_machine 		= pnx4008_init,
+	.init_late		= pnx4008_init_late,
 	.timer 			= &pnx4008_timer,
 	.restart		= pnx4008_restart,
 MACHINE_END
diff --git a/arch/arm/mach-pnx4008/pm.c b/arch/arm/mach-pnx4008/pm.c
index f3e60a0..26f8d06 100644
--- a/arch/arm/mach-pnx4008/pm.c
+++ b/arch/arm/mach-pnx4008/pm.c
@@ -124,7 +124,7 @@ static const struct platform_suspend_ops pnx4008_pm_ops = {
 	.valid = pnx4008_pm_valid,
 };
 
-static int __init pnx4008_pm_init(void)
+int __init pnx4008_pm_init(void)
 {
 	u32 sram_size_to_allocate;
 
@@ -151,5 +151,3 @@ static int __init pnx4008_pm_init(void)
 	suspend_set_ops(&pnx4008_pm_ops);
 	return 0;
 }
-
-late_initcall(pnx4008_pm_init);
-- 
1.7.5.4
