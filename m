From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Jul 2013 17:15:03 +0800
Subject: [PATCH 1/8] ARM: tegra: add common resume handling code for LP1
 resuming
In-Reply-To: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
Message-ID: <1374830110-30685-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common LP1 resuming procedures of LP1 on Tegra was checking the LP1
mask first. The LP1 mask indicated that the Tegra device was in LP1 then
we need to resume the Tegra from the LP1 reset handler.

And the LP1 was putting the SDRAM to self-refresh mode, the SDRAM wasn't
accessible when resuming from LP1. We need to copy the LP1 reset handler
to IRAM before suspending. That's why you can see the address of LP1
reset handler was located in IRAM.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S | 13 +++++++++++++
 arch/arm/mach-tegra/reset.c         |  2 ++
 arch/arm/mach-tegra/sleep.h         |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 34614bd..492b10f 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -182,6 +182,19 @@ after_errata:
 1:
 #endif
 
+	/* Waking up from LP1? */
+	ldr	r8, [r12, #RESET_DATA(MASK_LP1)]
+	tst	r8, r11				@ if in_lp1
+	beq	__is_not_lp1
+	cmp	r10, #0
+	bne	__die				@ only CPU0 can be here
+	ldr	lr, [r12, #RESET_DATA(STARTUP_LP1)]
+ THUMB(	add	lr, lr, #1 )			@ switch to Thumb mode
+	cmp	lr, #0
+	bleq	__die				@ no LP1 startup handler
+	bx	lr
+__is_not_lp1:
+
 	/* Waking up from LP2? */
 	ldr	r9, [r12, #RESET_DATA(MASK_LP2)]
 	tst	r9, r11				@ if in_lp2
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 1ac434e..fd0bbf8 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -81,6 +81,8 @@ void __init tegra_cpu_reset_handler_init(void)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP1] =
+		TEGRA_IRAM_CODE_AREA;
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_LP2] =
 		virt_to_phys((void *)tegra_resume);
 #endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index e907e40..e7f8b6f 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -29,6 +29,8 @@
 					+ IO_APB_VIRT)
 #define TEGRA_PMC_VIRT	(TEGRA_PMC_BASE - IO_APB_PHYS + IO_APB_VIRT)
 
+#define TEGRA_IRAM_CODE_AREA	(TEGRA_IRAM_BASE + SZ_4K)
+
 /* PMC_SCRATCH37-39 and 41 are used for tegra_pen_lock and idle */
 #define PMC_SCRATCH37	0x130
 #define PMC_SCRATCH38	0x134
-- 
1.8.3.4
