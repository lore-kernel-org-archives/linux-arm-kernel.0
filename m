From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:50 +0900
Subject: [PATCH 09/12] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We add 2 Suspend to RAM modes:
- A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
                        and the 2nd level cache with either PLL0 on
                        or off

As the suspend to memory mechanism we use A3SM PLL off. A3SM PLL on
is included here too, so CPUIdle can use both power down modes (not
included in this patch).

The setup of the SYSC regarding the external IRQs is taken from
pm-sh7372.c from Magnus Damm.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Makefile               |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    3 +
 arch/arm/mach-shmobile/pm-r8a7740.c           |  164 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/sleep-r8a7740.S        |   57 +++++++++
 4 files changed, 222 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/sleep-r8a7740.S

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 068f1da..0568894 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o sleep-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 1cf6869..5cfe5d9 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -543,6 +543,9 @@ extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
+extern void r8a7740_resume(void);
+extern void r8a7740_shutdown(void);
+extern void r8a7740_enter_a3sm_common(int);
 
 #ifdef CONFIG_PM
 extern void __init r8a7740_init_pm_domains(void);
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 40b87aa..fe3c867 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -8,10 +8,52 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/bitrev.h>
 #include <linux/console.h>
+#include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/io.h>
+#include <asm/suspend.h>
+#include <asm/cacheflush.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <mach/pm-rmobile.h>
 #include <mach/common.h>
+#include <mach/r8a7740.h>
+
+/* CPGA */
+#define PLLC01STPCR	IOMEM(0xe61500c8)
+#define SYSTBCR		IOMEM(0xe6150024)
+
+/* SYSC */
+#define STBCHR		IOMEM(0xe6180000)
+#define STBCHRB		IOMEM(0xe6180040)
+#define SPDCR		IOMEM(0xe6180008)
+#define SBAR		IOMEM(0xe6180020)
+#define SRSTFR		IOMEM(0xe61800B4)
+#define WUPSMSK		IOMEM(0xe618002c)
+#define WUPSMSK2	IOMEM(0xe6180048)
+#define WUPSFAC		IOMEM(0xe6180098)
+#define IRQCR		IOMEM(0xe618022c)
+#define IRQCR2		IOMEM(0xe6180238)
+#define IRQCR3		IOMEM(0xe6180244)
+#define IRQCR4		IOMEM(0xe6180248)
+
+/* SRSTFR flags */
+#define RAMST		(1 << 19)
+#define RCLNKA		(1 << 7)
+#define RCPRES		(1 << 5)
+#define RCWD1		(1 << 4)
+#define RPF		(1 << 0)
+
+/* INTC */
+#define ICR1A		IOMEM(0xe6900000)
+#define ICR2A		IOMEM(0xe6900004)
+#define ICR3A		IOMEM(0xe6900008)
+#define ICR4A		IOMEM(0xe690000c)
+#define INTMSK00A	IOMEM(0xe6900040)
+#define INTMSK10A	IOMEM(0xe6900044)
+#define INTMSK20A	IOMEM(0xe6900048)
+#define INTMSK30A	IOMEM(0xe690004c)
 
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
@@ -58,13 +100,129 @@ void __init r8a7740_init_pm_domains(void)
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 }
-
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_SUSPEND
+static void r8a7740_set_reset_vector(unsigned long address)
+{
+	__raw_writel(address, SBAR);
+}
+
+static void r8a7740_icr_to_irqcr(unsigned long icr, u16 *irqcr1p, u16 *irqcr2p)
+{
+	u16 tmp, irqcr1, irqcr2;
+	int k;
+
+	irqcr1 = 0;
+	irqcr2 = 0;
+
+	/* convert INTCA ICR register layout to SYSC IRQCR+IRQCR2 */
+	for (k = 0; k <= 7; k++) {
+		tmp = (icr >> ((7 - k) * 4)) & 0xf;
+		irqcr1 |= (tmp & 0x03) << (k * 2);
+		irqcr2 |= (tmp >> 2) << (k * 2);
+	}
+
+	*irqcr1p = irqcr1;
+	*irqcr2p = irqcr2;
+}
+
+static void r8a7740_setup_sysc(unsigned long msk, unsigned long msk2)
+{
+	u16 irqcrx_low, irqcrx_high, irqcry_low, irqcry_high;
+	unsigned long tmp;
+
+	/* read IRQ0A -> IRQ15A mask */
+	tmp = bitrev8(__raw_readb(INTMSK00A));
+	tmp |= bitrev8(__raw_readb(INTMSK10A)) << 8;
+
+	/* setup WUPSMSK from clocks and external IRQ mask */
+	msk = (~msk & 0xc030000f) | (tmp << 4);
+	__raw_writel(msk, WUPSMSK);
+
+	/* propage level/edge trigger for external IRQ 0->15 */
+	r8a7740_icr_to_irqcr(__raw_readl(ICR1A), &irqcrx_low, &irqcry_low);
+	r8a7740_icr_to_irqcr(__raw_readl(ICR2A), &irqcrx_high, &irqcry_high);
+	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR);
+	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR2);
+
+	/* read IRQ16A -> IRQ31A mask */
+	tmp = bitrev8(__raw_readb(INTMSK20A));
+	tmp |= bitrev8(__raw_readb(INTMSK30A)) << 8;
+
+	/* setup WUPSMSK2 from clocks and external IRQ mask */
+	msk2 = (~msk2 & 0x00030000) | tmp;
+	__raw_writel(msk2, WUPSMSK2);
+
+	/* propage level/edge trigger for external IRQ 16->31 */
+	r8a7740_icr_to_irqcr(__raw_readl(ICR3A), &irqcrx_low, &irqcry_low);
+	r8a7740_icr_to_irqcr(__raw_readl(ICR4A), &irqcrx_high, &irqcry_high);
+	__raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR3);
+	__raw_writel((irqcry_high << 16) | irqcry_low, IRQCR4);
+}
+
+static void r8a7740_prepare_wakeup(void)
+{
+	/* clear all flags that lead to a cold boot */
+	__raw_writel(~(RAMST | RCLNKA | RCPRES | RCWD1 | RPF), SRSTFR);
+	/* indicate warm boot */
+	__raw_writel(0x80000000, STBCHRB);
+	/* clear other flags checked by internal ROM boot loader */
+	__raw_writel(0x00000000, STBCHR);
+}
+
+static int r8a7740_do_suspend(unsigned long unused)
+{
+	/*
+	 * cpu_suspend() guarantees that all data made it to the L2.
+	 * Flush it out now and disable the cache controller.
+	 */
+	outer_flush_all();
+	outer_disable();
+
+	r8a7740_shutdown();
+
+	return 0;
+}
+
+void r8a7740_enter_a3sm_common(int pllc0_on)
+{
+	u32 reg32;
+
+	if (pllc0_on)
+		__raw_writel(0, PLLC01STPCR);
+	else
+		__raw_writel(1 << 28, PLLC01STPCR);
+
+	r8a7740_set_reset_vector(__pa(r8a7740_resume));
+	r8a7740_prepare_wakeup();
+	r8a7740_setup_sysc(1 << 0, 0);
+
+	/* Activate delayed shutdown of A3SM */
+	reg32 = __raw_readl(SPDCR);
+	reg32 |= (1 << 31) | (1 << 12);
+	__raw_writel(reg32, SPDCR);
+
+	/* We activate CPU Core Standby as well here */
+	reg32 = __raw_readl(SYSTBCR);
+	reg32 |= (1 << 4);
+	__raw_writel(reg32, SYSTBCR);
+
+	/* Clear Wakeup Factors and do suspend */
+	reg32 = __raw_readl(WUPSFAC);
+	cpu_suspend(0, r8a7740_do_suspend);
+	outer_resume();
+	reg32 = __raw_readl(WUPSFAC);
+
+	/* Clear CPU Core Standby flag for other WFI instructions */
+	reg32 &= ~(1 << 4);
+	__raw_writel(reg32, SYSTBCR);
+
+}
+
 static int r8a7740_enter_suspend(suspend_state_t suspend_state)
 {
-	cpu_do_idle();
+	r8a7740_enter_a3sm_common(0);
 	return 0;
 }
 
@@ -74,7 +232,7 @@ static void r8a7740_suspend_init(void)
 }
 #else
 static void r8a7740_suspend_init(void) {}
-#endif
+#endif /* CONFIG_SUSPEND */
 
 void __init r8a7740_pm_init(void)
 {
diff --git a/arch/arm/mach-shmobile/sleep-r8a7740.S b/arch/arm/mach-shmobile/sleep-r8a7740.S
new file mode 100644
index 0000000..435531b
--- /dev/null
+++ b/arch/arm/mach-shmobile/sleep-r8a7740.S
@@ -0,0 +1,57 @@
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
+
+#ifdef CONFIG_SUSPEND
+
+/* r8a7740_shutdown expects L2 to be flushed */
+	.text
+ENTRY(r8a7740_shutdown)
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)		@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	bl      v7_flush_dcache_all
+
+wfi_loop:
+	bl	cpu_v7_do_idle
+	b wfi_loop
+ENDPROC(r8a7740)
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
+ENTRY(r8a7740_resume)
+	ldr	pc, 1f
+1:	.long	v7_cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
+ENDPROC(r8a7740_resume_core_standby)
+#endif
-- 
1.7.10.4
