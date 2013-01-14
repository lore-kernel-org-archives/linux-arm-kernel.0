From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 22:23:21 +0800
Subject: [PATCH v2] ARM: imx: disable cpu in .cpu_kill hook
Message-ID: <1358173401-13158-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's buggy to disable the cpu that is being hot-unplugged in .cpu_die
hook which runs on the cpu itself.  Instead, it should be done in
.cpu_kill which runs on the thread (another cpu) that asks for shutting
down the cpu.  Move imx_enable_cpu(cpu, false) call into .cpu_kill
hook, and leave the cpu to be hot-unplugged in WFI within .cpu_die,
so that we can get a more stable cpu hot-plug operation.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h  |    1 +
 arch/arm/mach-imx/hotplug.c |   10 ++++++----
 arch/arm/mach-imx/platsmp.c |    1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7191ab4..fa36fb8 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -142,6 +142,7 @@ extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_clock_map_io(void);
 
 extern void imx_cpu_die(unsigned int cpu);
+extern int imx_cpu_kill(unsigned int cpu);
 
 #ifdef CONFIG_PM
 extern void imx6q_pm_init(void);
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 3dec962..7bc5fe1 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -46,9 +46,11 @@ static inline void cpu_enter_lowpower(void)
 void imx_cpu_die(unsigned int cpu)
 {
 	cpu_enter_lowpower();
-	imx_enable_cpu(cpu, false);
+	cpu_do_idle();
+}
 
-	/* spin here until hardware takes it down */
-	while (1)
-		;
+int imx_cpu_kill(unsigned int cpu)
+{
+	imx_enable_cpu(cpu, false);
+	return 1;
 }
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 3777b80..66fae88 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -92,5 +92,6 @@ struct smp_operations  imx_smp_ops __initdata = {
 	.smp_boot_secondary	= imx_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= imx_cpu_die,
+	.cpu_kill		= imx_cpu_kill,
 #endif
 };
-- 
1.7.9.5
