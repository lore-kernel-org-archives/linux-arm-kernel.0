From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:31 -0500
Subject: [PATCH 02/20] ARM: mach-s5pv210: use standard arch_idle()
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is equivalent and more similar to existing architectures.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-s5pv210/cpu.c                 |   12 ------------
 arch/arm/mach-s5pv210/include/mach/system.h |    2 +-
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 4c7b071131..8d500a7b80 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -99,14 +99,6 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 	}
 };
 
-static void s5pv210_idle(void)
-{
-	if (!need_resched())
-		cpu_do_idle();
-
-	local_irq_enable();
-}
-
 void s5pv210_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -191,9 +183,5 @@ core_initcall(s5pv210_core_init);
 int __init s5pv210_init(void)
 {
 	printk(KERN_INFO "S5PV210: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = s5pv210_idle;
-
 	return sysdev_register(&s5pv210_sysdev);
 }
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
index af8a200b21..0c1cb1f327 100644
--- a/arch/arm/mach-s5pv210/include/mach/system.h
+++ b/arch/arm/mach-s5pv210/include/mach/system.h
@@ -17,7 +17,7 @@
 
 static void arch_idle(void)
 {
-	/* nothing here yet */
+	cpu_do_idle();
 }
 
 #endif /* __ASM_ARCH_SYSTEM_H */
-- 
1.7.7.1.431.g10b2a
