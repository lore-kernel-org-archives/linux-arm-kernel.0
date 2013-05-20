From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 20 May 2013 18:39:29 +0800
Subject: [PATCH V2 6/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
Message-ID: <1369046369-12489-7-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra114 is a quad cores SoC. Each core can be hotplugged including
CPU0. The hotplug sequence can be controlled by setting event trigger in
flow controller. Then the flow controller will take care all the power
sequence that include CPU up and down.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* add init value (r3) in tegra30_cpu_shutdown
* update some comment message
---
 arch/arm/mach-tegra/Makefile        |  1 +
 arch/arm/mach-tegra/hotplug.c       |  2 ++
 arch/arm/mach-tegra/reset-handler.S | 15 ++++++++++++---
 arch/arm/mach-tegra/sleep-tegra30.S | 30 +++++++++++++++++++++++++-----
 arch/arm/mach-tegra/sleep.h         |  2 ++
 5 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index d011f0a..98b184e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 184914a..d07f152 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -55,4 +55,6 @@ void __init tegra_hotplug_init(void)
 		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
+		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
 }
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 424e01f..d2042ac 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -38,18 +38,24 @@
  *	  CPU boot vector when restarting the a CPU following
  *	  an LP2 transition. Also branched to by LP0 and LP1 resume after
  *	  re-enabling sdram.
+ *
+ *	r6: SoC ID
  */
 ENTRY(tegra_resume)
 	bl	v7_invalidate_l1
 
 	cpu_id	r0
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+	cmp	r6, #TEGRA114
+	beq	no_cpu0_chk
+
 	cmp	r0, #0				@ CPU0?
  THUMB(	it	ne )
 	bne	cpu_resume			@ no
+no_cpu0_chk:
 
 #ifndef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
-	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
@@ -187,11 +193,14 @@ __is_not_lp2:
 
 #ifdef CONFIG_SMP
 	/*
-	 * Can only be secondary boot (initial or hotplug) but CPU 0
-	 * cannot be here.
+	 * Can only be secondary boot (initial or hotplug)
+	 * CPU0 can't be here for Tegra20/30
 	 */
+	cmp	r6, #TEGRA114
+	beq	__no_cpu0_chk
 	cmp	r10, #0
 	bleq	__die				@ CPU0 cannot be here
+__no_cpu0_chk:
 	ldr	lr, [r12, #RESET_DATA(STARTUP_SECONDARY)]
 	cmp	lr, #0
 	bleq	__die				@ no secondary startup handler
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index d29dfcc..ada8821 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -19,6 +19,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 
+#include "fuse.h"
 #include "sleep.h"
 #include "flowctrl.h"
 
@@ -43,14 +44,19 @@ ENDPROC(tegra30_hotplug_shutdown)
  *
  * Puts the current CPU in wait-for-event mode on the flow controller
  * and powergates it -- flags (in R0) indicate the request type.
- * Must never be called for CPU 0.
  *
- * corrupts r0-r4, r12
+ * r10 = SoC ID
+ * corrupts r0-r4, r10-r12
  */
 ENTRY(tegra30_cpu_shutdown)
 	cpu_id	r3
+	tegra_get_soc_id TEGRA_APB_MISC_VIRT, r10
+	cmp	r10, #TEGRA30
+	bne	_no_cpu0_chk	@ It's not Tegra30
+
 	cmp	r3, #0
 	moveq	pc, lr		@ Must never be called for CPU 0
+_no_cpu0_chk:
 
 	ldr	r12, =TEGRA_FLOW_CTRL_VIRT
 	cpu_to_csr_reg r1, r3
@@ -65,7 +71,9 @@ ENTRY(tegra30_cpu_shutdown)
 	movw	r12, \
 		FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG | \
 		FLOW_CTRL_CSR_ENABLE
-	mov	r4, #(1 << 4)
+	cmp	r10, #TEGRA30
+	moveq	r4, #(1 << 4)			@ wfe bitmap
+	movne	r4, #(1 << 8)			@ wfi bitmap
  ARM(	orr	r12, r12, r4, lsl r3	)
  THUMB(	lsl	r4, r4, r3		)
  THUMB(	orr	r12, r12, r4		)
@@ -79,9 +87,20 @@ delay_1:
 	cpsid	a				@ disable imprecise aborts.
 	ldr	r3, [r1]			@ read CSR
 	str	r3, [r1]			@ clear CSR
+
 	tst	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
+	beq	flow_ctrl_setting_for_lp2
+
+	/* flow controller set up for hotplug */
+	mov	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
+	b	flow_ctrl_done
+flow_ctrl_setting_for_lp2:
+	/* flow controller set up for LP2 */
+	cmp	r10, #TEGRA30
 	moveq   r3, #FLOW_CTRL_WAIT_FOR_INTERRUPT	@ For LP2
-	movne	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
+	movne	r3, #FLOW_CTRL_WAITEVENT
+flow_ctrl_done:
+	cmp	r10, #TEGRA30
 	str	r3, [r2]
 	ldr	r0, [r2]
 	b	wfe_war
@@ -89,7 +108,8 @@ delay_1:
 __cpu_reset_again:
 	dsb
 	.align 5
-	wfe					@ CPU should be power gated here
+	wfeeq					@ CPU should be power gated here
+	wfine
 wfe_war:
 	b	__cpu_reset_again
 
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 2269c0d..98b7da6 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -25,6 +25,8 @@
 					+ IO_PPSB_VIRT)
 #define TEGRA_CLK_RESET_VIRT (TEGRA_CLK_RESET_BASE - IO_PPSB_PHYS \
 					+ IO_PPSB_VIRT)
+#define TEGRA_APB_MISC_VIRT (TEGRA_APB_MISC_BASE - IO_APB_PHYS \
+					+ IO_APB_VIRT)
 #define TEGRA_PMC_VIRT	(TEGRA_PMC_BASE - IO_APB_PHYS + IO_APB_VIRT)
 
 /* PMC_SCRATCH37-39 and 41 are used for tegra_pen_lock and idle */
-- 
1.8.2.2
