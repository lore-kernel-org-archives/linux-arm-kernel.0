From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Oct 2012 16:48:41 +0800
Subject: [PATCH V2 2/7] ARM: tegra: cpuidle: add LP2 resume function
In-Reply-To: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
References: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
Message-ID: <1350636526-25920-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LP2 is one of the Tegra low power states that supports power gating both
CPU cores and GICs. Adding a resume function for taking care the CPUs that
resume from LP2. This function was been hooked to reset handler. We take
care everything here before go into kernel.

Based on the work by:
Scott Williams <scwilliams@nvidia.com>
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* moving the code that only for Tegra30 inside the ifdef in the tegra_resume

 arch/arm/mach-tegra/headsmp.S |   58 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/reset.c   |    6 ++++
 arch/arm/mach-tegra/sleep.h   |    1 +
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index 6addc78..36066f2 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -69,6 +69,53 @@ ENTRY(tegra_secondary_startup)
         b       secondary_startup
 ENDPROC(tegra_secondary_startup)
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ *	tegra_resume
+ *
+ *	  CPU boot vector when restarting the a CPU following
+ *	  an LP2 transition. Also branched to by LP0 and LP1 resume after
+ *	  re-enabling sdram.
+ */
+ENTRY(tegra_resume)
+	bl	v7_invalidate_l1
+	/* Enable coresight */
+	mov32	r0, 0xC5ACCE55
+	mcr	p14, 0, r0, c7, c12, 6
+
+	cpu_id	r0
+	cmp	r0, #0				@ CPU0?
+	bne	cpu_resume			@ no
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+	/* Are we on Tegra20? */
+	mov32	r6, TEGRA_APB_MISC_BASE
+	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
+	and	r0, r0, #0xff00
+	cmp	r0, #(0x20 << 8)
+	beq	1f				@ Yes
+	/* Clear the flow controller flags for this CPU. */
+	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
+	ldr	r1, [r2]
+	/* Clear event & intr flag */
+	orr	r1, r1, \
+		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
+	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
+	bic	r1, r1, r0
+	str	r1, [r2]
+1:
+#endif
+
+	/* enable SCU */
+	mov32	r0, TEGRA_ARM_PERIF_BASE
+	ldr	r1, [r0]
+	orr	r1, r1, #1
+	str	r1, [r0]
+
+	b	cpu_resume
+ENDPROC(tegra_resume)
+#endif
+
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler_start)
 
@@ -122,6 +169,17 @@ ENTRY(__tegra_cpu_reset_handler)
 1:
 #endif
 
+	/* Waking up from LP2? */
+	ldr	r9, [r12, #RESET_DATA(MASK_LP2)]
+	tst	r9, r11				@ if in_lp2
+	beq	__is_not_lp2
+	ldr	lr, [r12, #RESET_DATA(STARTUP_LP2)]
+	cmp	lr, #0
+	bleq	__die				@ no LP2 startup handler
+	bx	lr
+
+__is_not_lp2:
+
 #ifdef CONFIG_SMP
 	/*
 	 * Can only be secondary boot (initial or hotplug) but CPU 0
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 5beb7eb..c48548f 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -26,6 +26,7 @@
 #include <mach/irammap.h>
 
 #include "reset.h"
+#include "sleep.h"
 #include "fuse.h"
 
 #define TEGRA_IRAM_RESET_BASE (TEGRA_IRAM_BASE + \
@@ -80,5 +81,10 @@ void __init tegra_cpu_reset_handler_init(void)
 		virt_to_phys((void *)tegra_secondary_startup);
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP2] =
+		virt_to_phys((void *)tegra_resume);
+#endif
+
 	tegra_cpu_reset_handler_enable();
 }
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index e25a7cd..c9dec37 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -72,6 +72,7 @@
 	dsb
 .endm
 #else
+void tegra_resume(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_init(void);
-- 
1.7.0.4
