From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 4 Jan 2013 17:32:22 +0800
Subject: [PATCH 2/2] ARM: tegra: make device can run on UP
In-Reply-To: <1357291942-32433-1-git-send-email-josephl@nvidia.com>
References: <1357291942-32433-1-git-send-email-josephl@nvidia.com>
Message-ID: <1357291942-32433-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset handler code is used for either UP or SMP. To make Tegra device
can compile for UP. It needs to be moved to another file that is not SMP
only. This is because the reset handler also be needed by CPU idle
"powered-down" mode. So we also need to put the reset handler init function
in non-SMP only and init them always.

And currently the implementation of the reset handler to know which CPU is
OK to bring up was identital with "cpu_present_mask". But the
"cpu_present_mask" did not initialize yet when the reset handler init
function was moved to init early function. We use the "cpu_possible_mask"
to replace "cpu_present_mask". Then it can work on both UP and SMP case.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                       |   2 +-
 arch/arm/mach-tegra/common.c                       |   3 +
 arch/arm/mach-tegra/headsmp.S                      | 262 ---------------------
 arch/arm/mach-tegra/platsmp.c                      |   1 -
 arch/arm/mach-tegra/{headsmp.S => reset-handler.S} |  26 +-
 arch/arm/mach-tegra/reset.c                        |   2 +-
 6 files changed, 21 insertions(+), 275 deletions(-)
 copy arch/arm/mach-tegra/{headsmp.S => reset-handler.S} (90%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index bd5d312..660ee03 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,6 +8,7 @@ obj-y					+= flowctrl.o
 obj-y					+= powergate.o
 obj-y					+= apbio.o
 obj-y					+= pm.o
+obj-y					+= reset.o reset-handler.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
@@ -26,7 +27,6 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
 endif
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
-obj-$(CONFIG_SMP)                       += reset.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d54cfc5..3efe80b 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -37,6 +37,7 @@
 #include "apbio.h"
 #include "sleep.h"
 #include "pm.h"
+#include "reset.h"
 
 /*
  * Storage for debug-macro.S's state.
@@ -137,6 +138,7 @@ static void __init tegra_init_cache(void)
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 void __init tegra20_init_early(void)
 {
+	tegra_cpu_reset_handler_init();
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra2_init_clocks();
@@ -150,6 +152,7 @@ void __init tegra20_init_early(void)
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 void __init tegra30_init_early(void)
 {
+	tegra_cpu_reset_handler_init();
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra30_init_clocks();
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
index 23f487d..fd473f2 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/headsmp.S
@@ -1,64 +1,9 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-#include <asm/cache.h>
-#include <asm/asm-offsets.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include "flowctrl.h"
-#include "iomap.h"
-#include "reset.h"
 #include "sleep.h"
 
-#define APB_MISC_GP_HIDREV	0x804
-#define PMC_SCRATCH41	0x140
-
-#define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
-
         .section ".text.head", "ax"
-/*
- * Tegra specific entry point for secondary CPUs.
- *   The secondary kernel init calls v7_flush_dcache_all before it enables
- *   the L1; however, the L1 comes out of reset in an undefined state, so
- *   the clean + invalidate performed by v7_flush_dcache_all causes a bunch
- *   of cache lines with uninitialized data and uninitialized tags to get
- *   written out to memory, which does really unpleasant things to the main
- *   processor.  We fix this by performing an invalidate, rather than a
- *   clean + invalidate, before jumping into the kernel.
- */
-ENTRY(v7_invalidate_l1)
-        mov     r0, #0
-        mcr     p15, 2, r0, c0, c0, 0
-        mrc     p15, 1, r0, c0, c0, 0
-
-        ldr     r1, =0x7fff
-        and     r2, r1, r0, lsr #13
-
-        ldr     r1, =0x3ff
-
-        and     r3, r1, r0, lsr #3  @ NumWays - 1
-        add     r2, r2, #1          @ NumSets
-
-        and     r0, r0, #0x7
-        add     r0, r0, #4          @ SetShift
-
-        clz     r1, r3              @ WayShift
-        add     r4, r3, #1          @ NumWays
-1:      sub     r2, r2, #1          @ NumSets--
-        mov     r3, r4              @ Temp = NumWays
-2:      subs    r3, r3, #1          @ Temp--
-        mov     r5, r3, lsl r1
-        mov     r6, r2, lsl r0
-        orr     r5, r5, r6          @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-        mcr     p15, 0, r5, c7, c6, 2
-        bgt     2b
-        cmp     r2, #0
-        bgt     1b
-        dsb
-        isb
-        mov     pc, lr
-ENDPROC(v7_invalidate_l1)
-
 
 ENTRY(tegra_secondary_startup)
         bl      v7_invalidate_l1
@@ -67,210 +12,3 @@ ENTRY(tegra_secondary_startup)
 	mcr	p14, 0, r0, c7, c12, 6
         b       secondary_startup
 ENDPROC(tegra_secondary_startup)
-
-#ifdef CONFIG_PM_SLEEP
-/*
- *	tegra_resume
- *
- *	  CPU boot vector when restarting the a CPU following
- *	  an LP2 transition. Also branched to by LP0 and LP1 resume after
- *	  re-enabling sdram.
- */
-ENTRY(tegra_resume)
-	bl	v7_invalidate_l1
-	/* Enable coresight */
-	mov32	r0, 0xC5ACCE55
-	mcr	p14, 0, r0, c7, c12, 6
-
-	cpu_id	r0
-	cmp	r0, #0				@ CPU0?
-	bne	cpu_resume			@ no
-
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
-	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
-	beq	1f				@ Yes
-	/* Clear the flow controller flags for this CPU. */
-	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
-	ldr	r1, [r2]
-	/* Clear event & intr flag */
-	orr	r1, r1, \
-		#FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
-	movw	r0, #0x0FFD	@ enable, cluster_switch, immed, & bitmaps
-	bic	r1, r1, r0
-	str	r1, [r2]
-1:
-#endif
-
-#ifdef CONFIG_HAVE_ARM_SCU
-	/* enable SCU */
-	mov32	r0, TEGRA_ARM_PERIF_BASE
-	ldr	r1, [r0]
-	orr	r1, r1, #1
-	str	r1, [r0]
-#endif
-
-	/* L2 cache resume & re-enable */
-	l2_cache_resume r0, r1, r2, l2x0_saved_regs_addr
-
-	b	cpu_resume
-ENDPROC(tegra_resume)
-#endif
-
-#ifdef CONFIG_CACHE_L2X0
-	.globl	l2x0_saved_regs_addr
-l2x0_saved_regs_addr:
-	.long	0
-#endif
-
-	.align L1_CACHE_SHIFT
-ENTRY(__tegra_cpu_reset_handler_start)
-
-/*
- * __tegra_cpu_reset_handler:
- *
- * Common handler for all CPU reset events.
- *
- * Register usage within the reset handler:
- *
- *      R7  = CPU present (to the OS) mask
- *      R8  = CPU in LP1 state mask
- *      R9  = CPU in LP2 state mask
- *      R10 = CPU number
- *      R11 = CPU mask
- *      R12 = pointer to reset handler data
- *
- * NOTE: This code is copied to IRAM. All code and data accesses
- *       must be position-independent.
- */
-
-	.align L1_CACHE_SHIFT
-ENTRY(__tegra_cpu_reset_handler)
-
-	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
-	mrc	p15, 0, r10, c0, c0, 5		@ MPIDR
-	and	r10, r10, #0x3			@ R10 = CPU number
-	mov	r11, #1
-	mov	r11, r11, lsl r10  		@ R11 = CPU mask
-	adr	r12, __tegra_cpu_reset_handler_data
-
-#ifdef CONFIG_SMP
-	/* Does the OS know about this CPU? */
-	ldr	r7, [r12, #RESET_DATA(MASK_PRESENT)]
-	tst	r7, r11 			@ if !present
-	bleq	__die				@ CPU not present (to OS)
-#endif
-
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
-	bne	1f
-	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov32	r6, TEGRA_PMC_BASE
-	mov	r0, #0
-	cmp	r10, #0
-	strne	r0, [r6, #PMC_SCRATCH41]
-1:
-#endif
-
-	/* Waking up from LP2? */
-	ldr	r9, [r12, #RESET_DATA(MASK_LP2)]
-	tst	r9, r11				@ if in_lp2
-	beq	__is_not_lp2
-	ldr	lr, [r12, #RESET_DATA(STARTUP_LP2)]
-	cmp	lr, #0
-	bleq	__die				@ no LP2 startup handler
-	bx	lr
-
-__is_not_lp2:
-
-#ifdef CONFIG_SMP
-	/*
-	 * Can only be secondary boot (initial or hotplug) but CPU 0
-	 * cannot be here.
-	 */
-	cmp	r10, #0
-	bleq	__die				@ CPU0 cannot be here
-	ldr	lr, [r12, #RESET_DATA(STARTUP_SECONDARY)]
-	cmp	lr, #0
-	bleq	__die				@ no secondary startup handler
-	bx	lr
-#endif
-
-/*
- * We don't know why the CPU reset. Just kill it.
- * The LR register will contain the address we died@+ 4.
- */
-
-__die:
-	sub	lr, lr, #4
-	mov32	r7, TEGRA_PMC_BASE
-	str	lr, [r7, #PMC_SCRATCH41]
-
-	mov32	r7, TEGRA_CLK_RESET_BASE
-
-	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
-	bne	1f
-
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	mov32	r0, 0x1111
-	mov	r1, r0, lsl r10
-	str	r1, [r7, #0x340]		@ CLK_RST_CPU_CMPLX_SET
-#endif
-1:
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
-	mov32	r6, TEGRA_FLOW_CTRL_BASE
-
-	cmp	r10, #0
-	moveq	r1, #FLOW_CTRL_HALT_CPU0_EVENTS
-	moveq	r2, #FLOW_CTRL_CPU0_CSR
-	movne	r1, r10, lsl #3
-	addne	r2, r1, #(FLOW_CTRL_CPU1_CSR-8)
-	addne	r1, r1, #(FLOW_CTRL_HALT_CPU1_EVENTS-8)
-
-	/* Clear CPU "event" and "interrupt" flags and power gate
-	   it when halting but not before it is in the "WFI" state. */
-	ldr	r0, [r6, +r2]
-	orr	r0, r0, #FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG
-	orr	r0, r0, #FLOW_CTRL_CSR_ENABLE
-	str	r0, [r6, +r2]
-
-	/* Unconditionally halt this CPU */
-	mov	r0, #FLOW_CTRL_WAITEVENT
-	str	r0, [r6, +r1]
-	ldr	r0, [r6, +r1]			@ memory barrier
-
-	dsb
-	isb
-	wfi					@ CPU should be power gated here
-
-	/* If the CPU didn't power gate above just kill it's clock. */
-
-	mov	r0, r11, lsl #8
-	str	r0, [r7, #348]			@ CLK_CPU_CMPLX_SET
-#endif
-
-	/* If the CPU still isn't dead, just spin here. */
-	b	.
-ENDPROC(__tegra_cpu_reset_handler)
-
-	.align L1_CACHE_SHIFT
-	.type	__tegra_cpu_reset_handler_data, %object
-	.globl	__tegra_cpu_reset_handler_data
-__tegra_cpu_reset_handler_data:
-	.rept	TEGRA_RESET_DATA_SIZE
-	.long	0
-	.endr
-	.align L1_CACHE_SHIFT
-
-ENTRY(__tegra_cpu_reset_handler_end)
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 5882da0f..60daf9f 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -202,7 +202,6 @@ static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
 	/* Always mark the boot CPU (CPU0) as initialized. */
 	cpumask_set_cpu(0, &tegra_cpu_init_mask);
 
-	tegra_cpu_reset_handler_init();
 	scu_enable(scu_base);
 }
 
diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/reset-handler.S
similarity index 90%
copy from arch/arm/mach-tegra/headsmp.S
copy to arch/arm/mach-tegra/reset-handler.S
index 23f487d..1b34075 100644
--- a/arch/arm/mach-tegra/headsmp.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -1,3 +1,19 @@
+/*
+ * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
 #include <linux/linkage.h>
 #include <linux/init.h>
 
@@ -15,7 +31,6 @@
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
-        .section ".text.head", "ax"
 /*
  * Tegra specific entry point for secondary CPUs.
  *   The secondary kernel init calls v7_flush_dcache_all before it enables
@@ -59,15 +74,6 @@ ENTRY(v7_invalidate_l1)
         mov     pc, lr
 ENDPROC(v7_invalidate_l1)
 
-
-ENTRY(tegra_secondary_startup)
-        bl      v7_invalidate_l1
-	/* Enable coresight */
-	mov32	r0, 0xC5ACCE55
-	mcr	p14, 0, r0, c7, c12, 6
-        b       secondary_startup
-ENDPROC(tegra_secondary_startup)
-
 #ifdef CONFIG_PM_SLEEP
 /*
  *	tegra_resume
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 3fd89ec..1ac434e 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -75,7 +75,7 @@ void __init tegra_cpu_reset_handler_init(void)
 
 #ifdef CONFIG_SMP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
-		*((u32 *)cpu_present_mask);
+		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
 		virt_to_phys((void *)tegra_secondary_startup);
 #endif
-- 
1.8.0.3
