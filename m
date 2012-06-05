From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 5 Jun 2012 09:44:40 +0530
Subject: [PATCH] ARM: tegra: Remove flow controller programming
Message-ID: <1338869680-8266-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This particular code had no effect on WFI execution. It only
asserts/de-asserts signal to tegra "legacy" CPU idle stats
monitor, which we are no longer using (cpufreq is based on
kernel s/w idle stats instead).

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/mach-tegra/cpuidle.c |    6 +++---
 arch/arm/mach-tegra/sleep.S   |   29 -----------------------------
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index d83a8c0..566e2f8 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -27,9 +27,9 @@
 #include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 
-#include <mach/iomap.h>
+#include <asm/proc-fns.h>
 
-extern void tegra_cpu_wfi(void);
+#include <mach/iomap.h>
 
 static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index);
@@ -64,7 +64,7 @@ static int tegra_idle_enter_lp3(struct cpuidle_device *dev,
 
 	enter = ktime_get();
 
-	tegra_cpu_wfi();
+	cpu_do_idle();
 
 	exit = ktime_sub(ktime_get(), enter);
 	us = ktime_to_us(exit);
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5b20197..d29b156 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -62,32 +62,3 @@
 	movw	\reg, #:lower16:\val
 	movt	\reg, #:upper16:\val
 .endm
-
-/*
- * tegra_cpu_wfi
- *
- * puts current CPU in clock-gated wfi using the flow controller
- *
- * corrupts r0-r3
- * must be called with MMU on
- */
-
-ENTRY(tegra_cpu_wfi)
-	cpu_id	r0
-	cpu_to_halt_reg r1, r0
-	cpu_to_csr_reg r2, r0
-	mov32	r0, TEGRA_FLOW_CTRL_VIRT
-	mov	r3, #FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
-	str	r3, [r0, r2]	@ clear event & interrupt status
-	mov	r3, #FLOW_CTRL_WAIT_FOR_INTERRUPT | FLOW_CTRL_JTAG_RESUME
-	str	r3, [r0, r1]	@ put flow controller in wait irq mode
-	dsb
-	wfi
-	mov	r3, #0
-	str	r3, [r0, r1]	@ clear flow controller halt status
-	mov	r3, #FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
-	str	r3, [r0, r2]	@ clear event & interrupt status
-	dsb
-	mov	pc, lr
-ENDPROC(tegra_cpu_wfi)
-
-- 
1.7.4.1
