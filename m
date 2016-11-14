From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:07 +0530
Subject: [PATCH 12/16] ARM: imx: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-13-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

At the same time this patch cleans up mach-imx platform files by
removing static mapping of SCU and dropping imx_scu_map_io function.

CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-imx/common.h     |  5 -----
 arch/arm/mach-imx/mach-imx6q.c |  8 +-------
 arch/arm/mach-imx/platsmp.c    | 32 +++++---------------------------
 arch/arm/mach-imx/pm-imx6.c    |  3 ++-
 4 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c4436d9..9787d5f 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -87,11 +87,6 @@ u32 imx_get_cpu_arg(int cpu);
 void imx_set_cpu_arg(int cpu, u32 arg);
 #ifdef CONFIG_SMP
 void v7_secondary_startup(void);
-void imx_scu_map_io(void);
-void imx_smp_prepare(void);
-#else
-static inline void imx_scu_map_io(void) {}
-static inline void imx_smp_prepare(void) {}
 #endif
 void imx_src_init(void);
 void imx_gpc_pre_suspend(bool arm_power_off);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 45801b2..1c6cc9f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -383,12 +383,6 @@ static void __init imx6q_init_late(void)
 	}
 }
 
-static void __init imx6q_map_io(void)
-{
-	debug_ll_io_init();
-	imx_scu_map_io();
-}
-
 static void __init imx6q_init_irq(void)
 {
 	imx_gpc_check_dt();
@@ -410,7 +404,7 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
 	.l2c_aux_val 	= 0,
 	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(imx_smp_ops),
-	.map_io		= imx6q_map_io,
+	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6q_init_irq,
 	.init_machine	= imx6q_init_machine,
 	.init_late      = imx6q_init_late,
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 711dbbd..c032369 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -26,26 +26,6 @@
 u32 g_diag_reg;
 static void __iomem *scu_base;
 
-static struct map_desc scu_io_desc __initdata = {
-	/* .virtual and .pfn are run-time assigned */
-	.length		= SZ_4K,
-	.type		= MT_DEVICE,
-};
-
-void __init imx_scu_map_io(void)
-{
-	unsigned long base;
-
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
-
-	scu_io_desc.virtual = IMX_IO_P2V(base);
-	scu_io_desc.pfn = __phys_to_pfn(base);
-	iotable_init(&scu_io_desc, 1);
-
-	scu_base = IMX_IO_ADDRESS(base);
-}
-
 static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	imx_set_cpu_jump(cpu, v7_secondary_startup);
@@ -61,20 +41,18 @@ static void __init imx_smp_init_cpus(void)
 {
 	int i, ncores;
 
-	ncores = scu_get_core_count(scu_base);
+	if (!IS_ERR(scu_base))
+		ncores = scu_get_core_count(scu_base);
 
 	for (i = ncores; i < NR_CPUS; i++)
 		set_cpu_possible(i, false);
 }
 
-void imx_smp_prepare(void)
-{
-	scu_enable(scu_base);
-}
-
 static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 {
-	imx_smp_prepare();
+	scu_base = of_scu_get_base();
+	if (!IS_ERR(scu_base))
+		scu_enable(scu_base);
 
 	/*
 	 * The diagnostic register holds the errata bits.  Mostly bootloader
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 1515e49..859aacb 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -26,6 +26,7 @@
 #include <asm/fncpy.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
+#include <asm/smp_scu.h>
 #include <asm/tlb.h>
 
 #include "common.h"
@@ -393,7 +394,7 @@ static int imx6q_pm_enter(suspend_state_t state)
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
 		if (cpu_is_imx6q() || cpu_is_imx6dl())
-			imx_smp_prepare();
+			of_scu_enable();
 		imx_anatop_post_resume();
 		imx_gpc_post_resume();
 		imx6_enable_rbc(false);
-- 
2.7.4
