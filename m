From: hechtb@gmail.com (Bastian Hecht)
Date: Mon,  4 Mar 2013 18:54:05 +0100
Subject: [PATCH] ARM: shmobile: r8a7740: Add CPU Core Standby Mode
In-Reply-To: <1362419645-3116-1-git-send-email-hechtb+renesas@gmail.com>
References: <1362419645-3116-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1362419645-3116-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In system CPU core standby mode, the cache in the system CPU enters RAM standby
state and the power supply to the system CPU logic is turned off. The on-chip
peripheral modules in the system block continue to operate in sleep mode.

We use this mode as the suspend-to-memory mechanism.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c          |   63 ++++++++++++++++++-
 arch/arm/mach-shmobile/sleep-r8a7740.S       |   83 ++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/sleep-r8a7740.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index c621edf..1206a6d 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o sleep-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index c401c8d..b8960a2 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -57,6 +57,7 @@ extern void r8a7740_add_standard_devices(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
+extern void r8a7740_resume_core_standby(void);
 
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 40b87aa..ee3d713 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -10,9 +10,29 @@
  */
 #include <linux/console.h>
 #include <linux/suspend.h>
+#include <asm/io.h>
+#include <asm/suspend.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <mach/pm-rmobile.h>
 #include <mach/common.h>
 
+/* CPGA */
+#define SYSTBCR IOMEM(0xe6150024)
+
+/* SYSC */
+#define STBCHR IOMEM(0xe6180000)
+#define STBCHRB IOMEM(0xe6180040)
+#define SBAR IOMEM(0xe6180020)
+#define SRSTFR IOMEM(0xe61800B4)
+
+/* SRSTFR flags */
+#define RAMST	(1 << 19)
+#define RCLNKA	(1 << 7)
+#define RCPRES	(1 << 5)
+#define RCWD1	(1 << 4)
+#define RPF	(1 << 0)
+
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
 {
@@ -62,15 +82,54 @@ void __init r8a7740_init_pm_domains(void)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_SUSPEND
-static int r8a7740_enter_suspend(suspend_state_t suspend_state)
+static void r8a7740_set_reset_vector(unsigned long address)
+{
+	__raw_writel(address, SBAR);
+}
+
+static int r8a7740_do_idle_core_standby(unsigned long unused)
 {
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * cpu_suspend() guarantees that all data made it to the L2.
+	 * Flush it out now.
+	 */
+	outer_flush_all();
+#endif
 	cpu_do_idle();
 	return 0;
 }
 
+static int r8a7740_enter_core_standby(suspend_state_t suspend_state)
+{
+	u32 reg32;
+
+	r8a7740_set_reset_vector(__pa(r8a7740_resume_core_standby));
+
+	/* clear all flags that lead to a cold boot */
+	__raw_writel(~(RAMST | RCLNKA | RCPRES | RCWD1 | RPF), SRSTFR);
+	/* indicate warm boot */
+	__raw_writel(0x80000000, STBCHRB);
+	/* clear other flags checked by internal ROM boot loader */
+	__raw_writel(0x00000000, STBCHR);
+
+	/* set the System CPU Core Standby flag */
+	reg32 = readl(SYSTBCR);
+	reg32 |= (1 << 4);
+	writel(reg32, SYSTBCR);
+
+	cpu_suspend(0, r8a7740_do_idle_core_standby);
+
+	/* Clear the flag so that other WFI instructions don't get affected */
+	reg32 &= ~(1 << 4);
+	writel(reg32, SYSTBCR);
+
+	return 0;
+}
+
 static void r8a7740_suspend_init(void)
 {
-	shmobile_suspend_ops.enter = r8a7740_enter_suspend;
+	shmobile_suspend_ops.enter = r8a7740_enter_core_standby;
 }
 #else
 static void r8a7740_suspend_init(void) {}
diff --git a/arch/arm/mach-shmobile/sleep-r8a7740.S b/arch/arm/mach-shmobile/sleep-r8a7740.S
new file mode 100644
index 0000000..7a2608f
--- /dev/null
+++ b/arch/arm/mach-shmobile/sleep-r8a7740.S
@@ -0,0 +1,83 @@
+/*
+ * Low level sleep code for the SoC r8a7740
+ *
+ * Copyright (C) 2013 Bastian Hecht
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/memory.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#if defined(CONFIG_SUSPEND)
+/*
+ * The secondary kernel init calls v7_flush_dcache_all before it enables
+ * the L1; however, the L1 comes out of reset in an undefined state, so
+ * the clean + invalidate performed by v7_flush_dcache_all causes a bunch
+ * of cache lines with uninitialized data and uninitialized tags to get
+ * written out to memory, which does really unpleasant things to the main
+ * processor.  We fix this by performing an invalidate, rather than a
+ * clean + invalidate, before jumping into the kernel.
+ *
+ * This funciton is cloned from arch/arm/mach-tegra/headsmp.S
+ */
+	.section ".text.head", "ax"
+ENTRY(v7_invalidate_l1)
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
+	mcr	p15, 2, r0, c0, c0, 0
+	mrc	p15, 1, r0, c0, c0, 0
+
+	ldr	r1, =0x7fff
+	and	r2, r1, r0, lsr #13
+
+	ldr	r1, =0x3ff
+
+	and	r3, r1, r0, lsr #3	@ NumWays - 1
+	add	r2, r2, #1		@ NumSets
+
+	and	r0, r0, #0x7
+	add	r0, r0, #4	@ SetShift
+
+	clz	r1, r3		@ WayShift
+	add	r4, r3, #1	@ NumWays
+1:	sub	r2, r2, #1	@ NumSets--
+	mov	r3, r4		@ Temp = NumWays
+2:	subs	r3, r3, #1	@ Temp--
+	mov	r5, r3, lsl r1
+	mov	r6, r2, lsl r0
+	orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
+	mcr	p15, 0, r5, c7, c6, 2
+	bgt	2b
+	cmp	r2, #0
+	bgt	1b
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7_invalidate_l1)
+
+	.text
+ENTRY(v7_cpu_resume)
+	bl	v7_invalidate_l1
+	b	cpu_resume
+ENDPROC(v7_cpu_resume)
+
+/*
+ * The entry point of a warm reboot, used by wakeup scenarios
+ *
+ * The CPU jumps in this case to (0xfffff000 & SBAR), so we need
+ * to align this function properly.
+ * We use a long jump into the text segment and use the physical
+ * address as the MMU is still turned off.
+ */
+	.align	12
+	.text
+ENTRY(r8a7740_resume_core_standby)
+	ldr	pc, 1f
+1:	.long	v7_cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
+ENDPROC(r8a7740_resume_core_standby)
+#endif
-- 
1.7.9.5
