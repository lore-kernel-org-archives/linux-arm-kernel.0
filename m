From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 Aug 2012 17:22:32 +0800
Subject: [PATCH V2 4/6] ARM: tegra30: add CPU hotplug support
In-Reply-To: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
References: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345022554-26292-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hotplug function put CPUs in offline or online state at runtime.
When the CPU been put in the offline state, it was been clock and
power gated. Except primary CPU other CPUs can be hotplugged.

Based on the work by:
Scott Williams <scwilliams@nvidia.com>
Colin Cross <ccross@android.com>
Gary King <gking@nvidia.com>

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile    |    1 +
 arch/arm/mach-tegra/common.c    |    2 +
 arch/arm/mach-tegra/hotplug.c   |  110 +++++++++------------------------------
 arch/arm/mach-tegra/sleep-t30.S |  107 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.h     |   21 +++++++
 5 files changed, 155 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-tegra/sleep-t30.S

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 060592a..211e279 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks_data.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-t30.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_SMP)                       += reset.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index f3654f8..0652056 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -34,6 +34,7 @@
 #include "fuse.h"
 #include "pmc.h"
 #include "apbio.h"
+#include "sleep.h"
 
 /*
  * Storage for debug-macro.S's state.
@@ -147,6 +148,7 @@ void __init tegra30_init_early(void)
 	tegra_init_cache(0x441, 0x551);
 	tegra_pmc_init();
 	tegra_powergate_init();
+	tegra30_hotplug_init();
 }
 #endif
 
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index d8dc9dd..be92d4c 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -1,91 +1,23 @@
 /*
- *  linux/arch/arm/mach-realview/hotplug.c
  *
  *  Copyright (C) 2002 ARM Ltd.
  *  All Rights Reserved
+ *  Copyright (c) 2010, 2012 NVIDIA Corporation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 #include <linux/kernel.h>
-#include <linux/errno.h>
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
-#include <asm/cp15.h>
+#include <asm/smp_plat.h>
 
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
+#include "sleep.h"
+#include "tegra_cpu_car.h"
 
-	flush_cache_all();
-	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-	"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	  : "=&r" (v)
-	  : "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
-{
-	/*
-	 * there is no power-control hardware on this platform, so all
-	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
-	 */
-	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
-
-		/*if (pen_release == cpu) {*/
-			/*
-			 * OK, proper wakeup, we're done
-			 */
-			break;
-		/*}*/
-
-		/*
-		 * Getting here, means that we have come out of WFI without
-		 * having been woken up - this shouldn't happen
-		 *
-		 * Just note it happening - when we're woken, we can report
-		 * its occurrence.
-		 */
-		(*spurious)++;
-	}
-}
+static void (*tegra_hotplug_shutdown)(void);
 
 int platform_cpu_kill(unsigned int cpu)
 {
@@ -99,22 +31,20 @@ int platform_cpu_kill(unsigned int cpu)
  */
 void platform_cpu_die(unsigned int cpu)
 {
-	int spurious = 0;
+	cpu = cpu_logical_map(cpu);
 
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
+	/* Flush the L1 data cache. */
+	flush_cache_all();
 
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
-	cpu_leave_lowpower();
+	/* Shut down the current CPU. */
+	tegra_hotplug_shutdown();
+
+	/* Clock gate the CPU */
+	tegra_wait_cpu_in_reset(cpu);
+	tegra_disable_cpu_clock(cpu);
 
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+	/* Should never return here. */
+	BUG();
 }
 
 int platform_cpu_disable(unsigned int cpu)
@@ -125,3 +55,11 @@ int platform_cpu_disable(unsigned int cpu)
 	 */
 	return cpu == 0 ? -EPERM : 0;
 }
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+extern void tegra30_hotplug_shutdown(void);
+void __init tegra30_hotplug_init(void)
+{
+	tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
+}
+#endif
diff --git a/arch/arm/mach-tegra/sleep-t30.S b/arch/arm/mach-tegra/sleep-t30.S
new file mode 100644
index 0000000..777d9ce
--- /dev/null
+++ b/arch/arm/mach-tegra/sleep-t30.S
@@ -0,0 +1,107 @@
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
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+
+#include <mach/iomap.h>
+
+#include "sleep.h"
+#include "flowctrl.h"
+
+#define TEGRA30_POWER_HOTPLUG_SHUTDOWN	(1 << 27) /* Hotplug shutdown */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PM_SLEEP)
+/*
+ * tegra30_hotplug_shutdown(void)
+ *
+ * Powergates the current CPU.
+ * Should never return.
+ */
+ENTRY(tegra30_hotplug_shutdown)
+	/* Turn off SMP coherency */
+	exit_smp r4, r5
+
+	/* Powergate this CPU */
+	mov	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
+	bl	tegra30_cpu_shutdown
+	mov	pc, lr			@ should never get here
+ENDPROC(tegra30_hotplug_shutdown)
+
+/*
+ * tegra30_cpu_shutdown(unsigned long flags)
+ *
+ * Puts the current CPU in wait-for-event mode on the flow controller
+ * and powergates it -- flags (in R0) indicate the request type.
+ * Must never be called for CPU 0.
+ *
+ * corrupts r0-r4, r12
+ */
+ENTRY(tegra30_cpu_shutdown)
+	cpu_id	r3
+	cmp	r3, #0
+	moveq	pc, lr		@ Must never be called for CPU 0
+
+	ldr	r12, =TEGRA_FLOW_CTRL_VIRT
+	cpu_to_csr_reg r1, r3
+	add	r1, r1, r12	@ virtual CSR address for this CPU
+	cpu_to_halt_reg r2, r3
+	add	r2, r2, r12	@ virtual HALT_EVENTS address for this CPU
+
+	/*
+	 * Clear this CPU's "event" and "interrupt" flags and power gate
+	 * it when halting but not before it is in the "WFE" state.
+	 */
+	movw	r12, \
+		FLOW_CTRL_CSR_INTR_FLAG | FLOW_CTRL_CSR_EVENT_FLAG | \
+		FLOW_CTRL_CSR_ENABLE
+	mov	r4, #(1 << 4)
+	orr	r12, r12, r4, lsl r3
+	str	r12, [r1]
+
+	/* Halt this CPU. */
+	mov	r3, #0x400
+delay_1:
+	subs	r3, r3, #1			@ delay as a part of wfe war.
+	bge	delay_1;
+	cpsid	a				@ disable imprecise aborts.
+	ldr	r3, [r1]			@ read CSR
+	str	r3, [r1]			@ clear CSR
+	tst	r0, #TEGRA30_POWER_HOTPLUG_SHUTDOWN
+	movne	r3, #FLOW_CTRL_WAITEVENT		@ For hotplug
+	str	r3, [r2]
+	ldr	r0, [r2]
+	b	wfe_war
+
+__cpu_reset_again:
+	dsb
+	.align 5
+	wfe					@ CPU should be power gated here
+wfe_war:
+	b	__cpu_reset_again
+
+	/*
+	 * 38 nop's, which fills reset of wfe cache line and
+	 * 4 more cachelines with nop
+	 */
+	.rept 38
+	nop
+	.endr
+	b	.				@ should never get here
+
+ENDPROC(tegra30_cpu_shutdown)
+#endif
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index d0c7a8b..2ad9b6d 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -19,6 +19,8 @@
 
 #include <mach/iomap.h>
 
+#define TEGRA_ARM_PERIF_VIRT (TEGRA_ARM_PERIF_BASE - IO_CPU_PHYS \
+					+ IO_CPU_VIRT)
 #define TEGRA_FLOW_CTRL_VIRT (TEGRA_FLOW_CTRL_BASE - IO_PPSB_PHYS \
 					+ IO_PPSB_VIRT)
 
@@ -52,5 +54,24 @@
 	movw	\reg, #:lower16:\val
 	movt	\reg, #:upper16:\val
 .endm
+
+/* Macro to exit SMP coherency. */
+.macro exit_smp, tmp1, tmp2
+	mrc	p15, 0, \tmp1, c1, c0, 1	@ ACTLR
+	bic	\tmp1, \tmp1, #(1<<6) | (1<<0)	@ clear ACTLR.SMP | ACTLR.FW
+	mcr	p15, 0, \tmp1, c1, c0, 1	@ ACTLR
+	isb
+	cpu_id	\tmp1
+	mov	\tmp1, \tmp1, lsl #2
+	mov	\tmp2, #0xf
+	mov	\tmp2, \tmp2, lsl \tmp1
+	mov32	\tmp1, TEGRA_ARM_PERIF_VIRT + 0xC
+	str	\tmp2, [\tmp1]			@ invalidate SCU tags for CPU
+	dsb
+.endm
+#else
+
+void tegra30_hotplug_init(void);
+
 #endif
 #endif
-- 
1.7.0.4
