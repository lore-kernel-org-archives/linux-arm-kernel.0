From: jason.chen@linaro.org (Jason Chen)
Date: Sat, 31 Dec 2011 14:23:44 +0800
Subject: [PATCH 2/2] ARM: imx6q: add cpu suspend/resume support in IRAM
Message-ID: <1325312624-22980-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For most power saving, this patch make arm core stop and
ddr go into self-refresh mode.

It already be tested on Freescale imx6q-arm2 board.

Signed-off-by: Jason Chen <jason.chen@linaro.org>
Signed-off-by: Jason Chen <jason.chen@freescale.com>
---
 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/clock-imx6q.c         |   37 +++--
 arch/arm/mach-imx/gpc.c                 |   21 ++
 arch/arm/mach-imx/pm-imx6q.c            |  128 +++++++++++++-
 arch/arm/mach-imx/suspend-imx6q.S       |  308 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    2 +
 arch/arm/plat-mxc/include/mach/mx6q.h   |    6 +
 7 files changed, 487 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 88a3966..0b07eef 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -72,7 +72,7 @@ AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o suspend-imx6q.o
 
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 56a7a3f..b7fecad 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -115,6 +115,8 @@
 #define CG14		28
 #define CG15		30
 
+#define BM_CCR_RBC_EN			(0x1 << 27)
+
 #define BM_CCSR_PLL1_SW_SEL		(0x1 << 2)
 #define BM_CCSR_STEP_SEL		(0x1 << 8)
 
@@ -1916,33 +1918,44 @@ static struct clk_lookup lookups[] = {
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	u32 val = readl_relaxed(CLPCR);
+	u32 clpcr = readl_relaxed(CLPCR);
+	u32 ccr = readl_relaxed(CCR);
 
-	val &= ~BM_CLPCR_LPM;
+	clpcr &= ~(BM_CLPCR_LPM | BM_CLPCR_VSTBY | BM_CLPCR_SBYOS
+			| BM_CLPCR_STBY_COUNT | BM_CLPCR_WB_PER_AT_LPM);
+	ccr &= ~(BM_CCR_RBC_EN);
 	switch (mode) {
 	case WAIT_CLOCKED:
 		break;
 	case WAIT_UNCLOCKED:
-		val |= 0x1 << BP_CLPCR_LPM;
+		clpcr |= 0x1 << BP_CLPCR_LPM;
 		break;
 	case STOP_POWER_ON:
-		val |= 0x2 << BP_CLPCR_LPM;
+		clpcr |= 0x2 << BP_CLPCR_LPM;
 		break;
 	case WAIT_UNCLOCKED_POWER_OFF:
-		val |= 0x1 << BP_CLPCR_LPM;
-		val &= ~BM_CLPCR_VSTBY;
-		val &= ~BM_CLPCR_SBYOS;
+		clpcr |= 0x1 << BP_CLPCR_LPM;
 		break;
 	case STOP_POWER_OFF:
-		val |= 0x2 << BP_CLPCR_LPM;
-		val |= 0x3 << BP_CLPCR_STBY_COUNT;
-		val |= BM_CLPCR_VSTBY;
-		val |= BM_CLPCR_SBYOS;
+		clpcr |= 0x2 << BP_CLPCR_LPM;
+		clpcr |= 0x3 << BP_CLPCR_STBY_COUNT;
+		clpcr |= BM_CLPCR_VSTBY;
+		clpcr |= BM_CLPCR_SBYOS;
+		break;
+	case ARM_POWER_OFF:
+		clpcr |= 0x2 << BP_CLPCR_LPM;
+		clpcr |= 0x3 << BP_CLPCR_STBY_COUNT;
+		clpcr |= BM_CLPCR_VSTBY;
+		clpcr |= BM_CLPCR_SBYOS;
+		clpcr |= BM_CLPCR_WB_PER_AT_LPM;
+		/* assert anatop_reg_bypass signal */
+		ccr |= BM_CCR_RBC_EN;
 		break;
 	default:
 		return -EINVAL;
 	}
-	writel_relaxed(val, CLPCR);
+	writel_relaxed(clpcr, CLPCR);
+	writel_relaxed(ccr, CCR);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index e1537f9..8fc255b 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -17,15 +17,36 @@
 #include <linux/of_irq.h>
 #include <asm/hardware/gic.h>
 
+#define GPC_CNTR		0x000
 #define GPC_IMR1		0x008
+#define GPC_ISR1		0x018
+#define GPC_ISR2		0x01c
+#define GPC_ISR3		0x020
+#define GPC_ISR4		0x024
 #define GPC_PGC_CPU_PDN		0x2a0
 
 #define IMR_NUM			4
+#define ISR_NUM			4
 
 static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
 
+bool imx_gpc_wake_irq_pending(void)
+{
+	void __iomem *reg_isr1 = gpc_base + GPC_ISR1;
+	int i;
+	u32 val;
+
+	for (i = 0; i < ISR_NUM; i++) {
+		val = readl_relaxed(reg_isr1 + i * 4);
+		if (val & gpc_wake_irqs[i])
+			return true;
+	}
+
+	return false;
+}
+
 void imx_gpc_pre_suspend(void)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index f20f191..6e45245 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -13,31 +13,73 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
+#include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <mach/iram.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 
+struct imx_iram_pm {
+	void *iram_cpaddr;
+	unsigned long suspend_iram_paddr;
+	unsigned long suspend_iram_size;
+	void *suspend_iram_vaddr;
+	void *reg_ptr[4];
+} imx6q_iram_pm;
+
 extern unsigned long phys_l2x0_saved_regs;
+extern void imx6q_suspend(void);
+static void (*suspend_in_iram)(unsigned long iram_paddr,
+				unsigned long iram_vaddr,
+				unsigned long iram_size);
 
 static int imx6q_suspend_finish(unsigned long val)
 {
-	cpu_do_idle();
+	if ((val == PM_SUSPEND_MEM) && suspend_in_iram) {
+		suspend_in_iram((unsigned long)imx6q_iram_pm.suspend_iram_paddr,
+				(unsigned long)imx6q_iram_pm.suspend_iram_vaddr,
+				(unsigned long)imx6q_iram_pm.suspend_iram_size);
+	} else
+		cpu_do_idle();
+
 	return 0;
 }
 
+static void imx6q_prepare_suspend_iram(void)
+{
+	unsigned long *iram_stack = imx6q_iram_pm.suspend_iram_vaddr
+					+ imx6q_iram_pm.suspend_iram_size;
+
+	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[3];
+	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[2];
+	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[1];
+	*(--iram_stack) = (unsigned long)imx6q_iram_pm.reg_ptr[0];
+}
+
 static int imx6q_pm_enter(suspend_state_t state)
 {
 	switch (state) {
+	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
-		imx6q_set_lpm(STOP_POWER_OFF);
+		if (imx_gpc_wake_irq_pending())
+			return 0;
+
+		if (state == PM_SUSPEND_STANDBY)
+			imx6q_set_lpm(STOP_POWER_OFF);
+		else
+			imx6q_set_lpm(ARM_POWER_OFF);
+
 		imx_gpc_pre_suspend();
 		imx_set_cpu_jump(0, v7_cpu_resume);
+		if (state == PM_SUSPEND_MEM)
+			imx6q_prepare_suspend_iram();
 		/* Zzz ... */
-		cpu_suspend(0, imx6q_suspend_finish);
+		cpu_suspend(state, imx6q_suspend_finish);
 		imx_smp_prepare();
 		imx_gpc_post_resume();
 		break;
@@ -48,11 +90,55 @@ static int imx6q_pm_enter(suspend_state_t state)
 	return 0;
 }
 
+static int imx6q_pm_valid(suspend_state_t state)
+{
+	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
+}
+
 static const struct platform_suspend_ops imx6q_pm_ops = {
 	.enter = imx6q_pm_enter,
-	.valid = suspend_valid_only_mem,
+	.valid = imx6q_pm_valid,
 };
 
+static int __init imx6q_pm_iram_of_init(void)
+{
+	struct device_node *np;
+
+	/*
+	 * these register may already ioremaped, need figure out
+	 * one way to save vmalloc space.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
+	imx6q_iram_pm.reg_ptr[0] = of_iomap(np, 0);
+	if (!imx6q_iram_pm.reg_ptr[0])
+		goto err0;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iomuxc");
+	imx6q_iram_pm.reg_ptr[1] = of_iomap(np, 0);
+	if (!imx6q_iram_pm.reg_ptr[1])
+		goto err1;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-mmdc");
+	imx6q_iram_pm.reg_ptr[2] = of_iomap(np, 0);
+	if (!imx6q_iram_pm.reg_ptr[2])
+		goto err2;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+	imx6q_iram_pm.reg_ptr[3] = of_iomap(np, 0);
+	if (!imx6q_iram_pm.reg_ptr[3])
+		goto err3;
+
+	return 0;
+err3:
+	iounmap(imx6q_iram_pm.reg_ptr[2]);
+err2:
+	iounmap(imx6q_iram_pm.reg_ptr[1]);
+err1:
+	iounmap(imx6q_iram_pm.reg_ptr[0]);
+err0:
+	return -EINVAL;
+}
+
 void __init imx6q_pm_init(void)
 {
 	/*
@@ -67,4 +153,38 @@ void __init imx6q_pm_init(void)
 	phys_l2x0_saved_regs = __pa(&l2x0_saved_regs);
 
 	suspend_set_ops(&imx6q_pm_ops);
+
+	/* Move suspend routine into iRAM */
+	imx6q_iram_pm.suspend_iram_size = SZ_4K;
+	imx6q_iram_pm.iram_cpaddr = iram_alloc(imx6q_iram_pm.suspend_iram_size,
+			&imx6q_iram_pm.suspend_iram_paddr);
+	if (imx6q_iram_pm.iram_cpaddr) {
+		if (imx6q_pm_iram_of_init() < 0) {
+			iram_free(imx6q_iram_pm.suspend_iram_paddr,
+					imx6q_iram_pm.suspend_iram_size);
+			return;
+		}
+		/*
+		 * Need to remap the area here since we want the memory region
+		 * to be noncached & executable.
+		 */
+		imx6q_iram_pm.suspend_iram_vaddr =
+			__arm_ioremap(imx6q_iram_pm.suspend_iram_paddr,
+					imx6q_iram_pm.suspend_iram_size,
+					MT_MEMORY_NONCACHED);
+		pr_info("cpaddr = %p suspend_iram_base=%p\n",
+				imx6q_iram_pm.iram_cpaddr,
+				imx6q_iram_pm.suspend_iram_vaddr);
+
+		/*
+		 * Need to run the suspend code from IRAM as the DDR needs
+		 * to be put into low power mode manually.
+		 */
+		memcpy(imx6q_iram_pm.iram_cpaddr, imx6q_suspend,
+					imx6q_iram_pm.suspend_iram_size);
+
+		suspend_in_iram = (void *)imx6q_iram_pm.suspend_iram_vaddr;
+
+	} else
+		suspend_in_iram = NULL;
 }
diff --git a/arch/arm/mach-imx/suspend-imx6q.S b/arch/arm/mach-imx/suspend-imx6q.S
new file mode 100644
index 0000000..f803e2b
--- /dev/null
+++ b/arch/arm/mach-imx/suspend-imx6q.S
@@ -0,0 +1,308 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later@the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/linkage.h>
+#include <mach/hardware.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#define SRC_GPR1_OFFSET		0x020
+#define SRC_GPR2_OFFSET		0x024
+#define MMDC_MAPSR_OFFSET 	0x404
+#define MMDC_MAPSR_PSS 		(1 << 4)
+#define MMDC_MAPSR_PSD 		(1 << 0)
+#define ANATOP_REG_2P5		0x130
+
+.macro	ddr_io_save
+	ldr	r4, [r9, #0x5ac] /* DRAM_DQM0 */
+	ldr	r5, [r9, #0x5b4] /* DRAM_DQM1 */
+	ldr	r6, [r9, #0x528] /* DRAM_DQM2 */
+	ldr	r7, [r9, #0x520] /* DRAM_DQM3 */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r4, [r9, #0x514] /* DRAM_DQM4 */
+	ldr	r5, [r9, #0x510] /* DRAM_DQM5 */
+	ldr	r6, [r9, #0x5bc] /* DRAM_DQM6 */
+	ldr	r7, [r9, #0x5c4] /* DRAM_DQM7 */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r4, [r9, #0x56c] /* DRAM_CAS */
+	ldr	r5, [r9, #0x578] /* DRAM_RAS */
+	ldr	r6, [r9, #0x588] /* DRAM_SDCLK_0 */
+	ldr	r7, [r9, #0x594] /* DRAM_SDCLK_1 */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r5, [r9, #0x750] /* DDRMODE_CTL */
+	ldr	r6, [r9, #0x774] /* DDRMODE */
+	stmfd	sp!, {r5-r6}
+
+	ldr	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
+	ldr	r5, [r9, #0x5b0] /* DRAM_SDQS1 */
+	ldr	r6, [r9, #0x524] /* DRAM_SDQS2 */
+	ldr	r7, [r9, #0x51c] /* DRAM_SDQS3 */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r4, [r9, #0x518] /* DRAM_SDQS4 */
+	ldr	r5, [r9, #0x50c] /* DRAM_SDQS5 */
+	ldr	r6, [r9, #0x5b8] /* DRAM_SDQS6 */
+	ldr	r7, [r9, #0x5c0] /* DRAM_SDQS7 */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r4, [r9, #0x784] /* GPR_B0DS */
+	ldr	r5, [r9, #0x788] /* GPR_B1DS */
+	ldr	r6, [r9, #0x794] /* GPR_B2DS */
+	ldr	r7, [r9, #0x79c] /* GPR_B3DS */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r4, [r9, #0x7a0] /* GPR_B4DS */
+	ldr	r5, [r9, #0x7a4] /* GPR_B5DS */
+	ldr	r6, [r9, #0x7a8] /* GPR_B6DS */
+	ldr	r7, [r9, #0x748] /* GPR_B7DS */
+	stmfd	sp!, {r4-r7}
+
+	ldr	r5, [r9, #0x74c] /* GPR_ADDS*/
+	ldr	r6, [r9, #0x59c] /* DRAM_SODT0*/
+	ldr	r7, [r9, #0x5a0] /* DRAM_SODT1*/
+	stmfd	sp!, {r5-r7}
+.endm
+
+.macro	ddr_io_restore
+	ldmfd	sp!, {r5-r7}
+	str	r5, [r9, #0x74c] /* GPR_ADDS*/
+	str	r6, [r9, #0x59c] /* DRAM_SODT0*/
+	str	r7, [r9, #0x5a0] /* DRAM_SODT1*/
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x7a0] /* GPR_B4DS */
+	str	r5, [r9, #0x7a4] /* GPR_B5DS */
+	str	r6, [r9, #0x7a8] /* GPR_B6DS */
+	str	r7, [r9, #0x748] /* GPR_B7DS */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x784] /* GPR_B0DS */
+	str	r5, [r9, #0x788] /* GPR_B1DS */
+	str	r6, [r9, #0x794] /* GPR_B2DS */
+	str	r7, [r9, #0x79c] /* GPR_B3DS */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x518] /* DRAM_SDQS4 */
+	str	r5, [r9, #0x50c] /* DRAM_SDQS5 */
+	str	r6, [r9, #0x5b8] /* DRAM_SDQS6 */
+	str	r7, [r9, #0x5c0] /* DRAM_SDQS7 */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
+	str	r5, [r9, #0x5b0] /* DRAM_SDQS1 */
+	str	r6, [r9, #0x524] /* DRAM_SDQS2 */
+	str	r7, [r9, #0x51c] /* DRAM_SDQS3 */
+
+	ldmfd	sp!, {r5-r6}
+	str	r5, [r9, #0x750] /* DDRMODE_CTL */
+	str	r6, [r9, #0x774] /* DDRMODE */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x56c] /* DRAM_CAS */
+	str	r5, [r9, #0x578] /* DRAM_RAS */
+	str	r6, [r9, #0x588] /* DRAM_SDCLK_0 */
+	str	r7, [r9, #0x594] /* DRAM_SDCLK_1 */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x514] /* DRAM_DQM4 */
+	str	r5, [r9, #0x510] /* DRAM_DQM5 */
+	str	r6, [r9, #0x5bc] /* DRAM_DQM6 */
+	str	r7, [r9, #0x5c4] /* DRAM_DQM7 */
+
+	ldmfd	sp!, {r4-r7}
+	str	r4, [r9, #0x5ac] /* DRAM_DQM0 */
+	str	r5, [r9, #0x5b4] /* DRAM_DQM1 */
+	str	r6, [r9, #0x528] /* DRAM_DQM2 */
+	str	r7, [r9, #0x520] /* DRAM_DQM3 */
+.endm
+
+.macro	ddr_io_set_lpm
+	mov	r4, #0
+	str	r4, [r9, #0x5ac] /* DRAM_DQM0 */
+	str	r4, [r9, #0x5b4] /* DRAM_DQM1 */
+	str	r4, [r9, #0x528] /* DRAM_DQM2 */
+	str	r4, [r9, #0x520] /* DRAM_DQM3 */
+
+	str	r4, [r9, #0x514] /* DRAM_DQM4 */
+	str	r4, [r9, #0x510] /* DRAM_DQM5 */
+	str	r4, [r9, #0x5bc] /* DRAM_DQM6 */
+	str	r4, [r9, #0x5c4] /* DRAM_DQM7 */
+
+	str	r4, [r9, #0x56c] /* DRAM_CAS */
+	str	r4, [r9, #0x578] /* DRAM_RAS */
+	str	r4, [r9, #0x588] /* DRAM_SDCLK_0 */
+	str	r4, [r9, #0x594] /* DRAM_SDCLK_1 */
+
+	str	r4, [r9, #0x750] /* DDRMODE_CTL */
+	str	r4, [r9, #0x774] /* DDRMODE */
+
+	str	r4, [r9, #0x5a8] /* DRAM_SDQS0 */
+	str	r4, [r9, #0x5b0] /* DRAM_SDQS1 */
+	str	r4, [r9, #0x524] /* DRAM_SDQS2 */
+	str	r4, [r9, #0x51c] /* DRAM_SDQS3 */
+
+	str	r4, [r9, #0x518] /* DRAM_SDQS4 */
+	str	r4, [r9, #0x50c] /* DRAM_SDQS5 */
+	str	r4, [r9, #0x5b8] /* DRAM_SDQS6 */
+	str	r4, [r9, #0x5c0] /* DRAM_SDQS7 */
+
+	str	r4, [r9, #0x784] /* GPR_B0DS */
+	str	r4, [r9, #0x788] /* GPR_B1DS */
+	str	r4, [r9, #0x794] /* GPR_B2DS */
+	str	r4, [r9, #0x79c] /* GPR_B3DS */
+
+	str	r4, [r9, #0x7a0] /* GPR_B4DS */
+	str	r4, [r9, #0x7a4] /* GPR_B5DS */
+	str	r4, [r9, #0x7a8] /* GPR_B6DS */
+	str	r4, [r9, #0x748] /* GPR_B7DS */
+
+	str	r4, [r9, #0x74c] /* GPR_ADDS*/
+	str	r4, [r9, #0x59c] /* DRAM_SODT0*/
+	str	r4, [r9, #0x5a0] /* DRAM_SODT1*/
+.endm
+
+/*
+ * imx6q_suspend:
+ *
+ * Suspend the processor (eg, wait for interrupt).
+ * Set the DDR into Self Refresh
+ * IRQs are already disabled.
+ *
+ * Registers usage in the imx6q_suspend:
+ *
+ * r0: suspend_iram_paddr
+ * r1: suspend_iram_vaddr
+ * r2: suspend_iram_size
+ *
+ * r8: src_base pointer
+ * r9: iomux_base pointer
+ * r10: mmdc_base pointer
+ * r11: anatop_base pointer
+ * sp: iram stack
+ *
+ * Corrupted registers: r0-r3
+ */
+
+ENTRY(imx6q_suspend)
+	mov	r3, sp				@ save sp
+	add	sp, r1, r2			@ set sp to top iram stack
+	sub	sp, sp, #16	 		@ 4 regs ptr
+	stmfd	sp!, {r4 - r12, lr}		@ save registers
+
+	add	r4, r1, r2
+	ldr	r8, [r4, #-16]			@ r8 = src_base pointer
+	ldr	r9, [r4, #-12]			@ r9 = iomux_base pointer
+	ldr	r10, [r4, #-8]			@ r10 = mmdc_base pointer
+	ldr	r11, [r4, #-4]			@ r11 = anatop_base pointer
+
+	/* should not access sp in ddr until resume with cache MMU on */
+	stmfd	sp!, {r3}			@ save old sp
+
+	ldr	r4, [r8, #SRC_GPR1_OFFSET]	@ r8 = src_base pointer
+	stmfd	sp!, {r4}			@ save old resume func
+
+	/* Enable weak 2P5 linear regulator */
+	ldr	r4, [r11, #ANATOP_REG_2P5]	@ r11 = anatop_base pointer
+	orr	r4, r4, #0x40000
+	str	r4, [r11, #ANATOP_REG_2P5]
+	mov	r6, #1
+wait:	ldr	r4, [r11, #ANATOP_REG_2P5]
+	and	r4, r4, r6, lsl #17			@ output ok?
+	cmp	r4, #0
+	beq	wait
+
+	/* save ddr iomux regs */
+	ddr_io_save
+
+	/* set ddr to low power mode */
+	ldr	r4, [r10, #MMDC_MAPSR_OFFSET]	@ r10 = mmdc_base pointer
+	bic	r4, #MMDC_MAPSR_PSD
+	str	r4, [r10, #MMDC_MAPSR_OFFSET]
+refresh:
+	ldr	r4, [r10, #MMDC_MAPSR_OFFSET]
+	and	r4, r4, #MMDC_MAPSR_PSS
+	cmp	r4, #0
+	beq	refresh
+
+	ddr_io_set_lpm
+
+	/* save resume pointer into SRC_GPR1, sp pointer into SRC_GPR2 */
+	ldr	r4, =imx6q_suspend
+	ldr	r5, =imx6q_resume
+	sub	r5, r5, r4			@ r5 = resmue offset
+	add	r5, r0, r5			@ r0 = suspend_iram_paddr, r5 = resmue phy addr
+	str	r5, [r8, #SRC_GPR1_OFFSET]	@ r8 = src_base pointer
+	sub	r5, sp, r1			@ r1 = suspend_iram_vaddr, r5 = sp offset
+	add	r5, r0, r5			@ r0 = suspend_iram_paddr, r5 = sp phy addr
+	str	r5, [r8, #SRC_GPR2_OFFSET]	@ r8 = src_base pointer
+
+	/* execute a wfi instruction to let SOC go into stop mode */
+	dsb
+	wfi
+
+	nop
+	nop
+	nop
+	nop
+
+	/*
+	 * if go here, means there is a wakeup irq pending, we should resume
+	 * system immediately.
+	 */
+	ddr_io_restore
+
+	/* Disable weak 2P5 linear regulator */
+	ldr	r4, [r11, #ANATOP_REG_2P5]	@ r11 = anatop_base pointer
+	bic	r4, #0x40000
+	str	r4, [r11, #ANATOP_REG_2P5]
+
+	ldmfd	sp!, {r4}			@ drop old resmue func ptr
+	ldmfd	sp!, {r3}
+	ldmfd	sp!, {r4 - r12, lr}
+	mov	sp, r3
+	mov	pc, lr
+
+/*
+ * when SOC exit stop mode, arm core restart from here, currently
+ * are running with MMU off.
+ */
+imx6q_resume:
+	ldr	r0, =MX6Q_SRC_BASE_ADDR
+	mov	r1, #0x0
+	str	r1, [r0, #SRC_GPR1_OFFSET] 	@ clear SRC_GPR1
+	ldr	sp, [r0, #SRC_GPR2_OFFSET]
+	str	r1, [r0, #SRC_GPR2_OFFSET]	@ clear SRC_GPR2
+
+	ldr	r9, =MX6Q_IOMUXC_BASE_ADDR
+	ddr_io_restore
+
+	ldr	r0, =MX6Q_MMDC0_BASE_ADDR
+	ldr	r1, [r0, #MMDC_MAPSR_OFFSET]
+	orr	r1, #MMDC_MAPSR_PSD
+	str	r1, [r0, #MMDC_MAPSR_OFFSET]
+
+	/* Disable weak 2P5 linear regulator */
+	ldr	r0, =MX6Q_ANATOP_BASE_ADDR
+	ldr	r1, [r0, #ANATOP_REG_2P5]
+	bic	r1, #0x40000
+	str	r1, [r0, #ANATOP_REG_2P5]
+
+	ldmfd	sp!, {r2}			@ resmue func ptr
+	ldmfd	sp!, {r3}
+	ldmfd	sp!, {r4 - r12, lr}
+	mov	sp, r3
+
+	/* return back */
+	mov	pc, r2
+ENDPROC(imx6q_suspend)
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 83cca9b..0e1e652 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -82,6 +82,7 @@ enum mxc_cpu_pwr_mode {
 	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
 	STOP_POWER_ON,		/* just STOP */
 	STOP_POWER_OFF,		/* STOP + SRPG */
+	ARM_POWER_OFF,          /* STOP + SRPG + ARM power off */
 };
 
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
@@ -123,6 +124,7 @@ extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_src_init(void);
 extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
+extern bool imx_gpc_wake_irq_pending(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
 extern void imx51_babbage_common_init(void);
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
index 254a561..eea2968 100644
--- a/arch/arm/plat-mxc/include/mach/mx6q.h
+++ b/arch/arm/plat-mxc/include/mach/mx6q.h
@@ -27,6 +27,12 @@
 #define MX6Q_CCM_SIZE			0x4000
 #define MX6Q_ANATOP_BASE_ADDR		0x020c8000
 #define MX6Q_ANATOP_SIZE		0x1000
+#define MX6Q_SRC_BASE_ADDR		0x020d8000
+#define MX6Q_SRC_SIZE			0x4000
+#define MX6Q_IOMUXC_BASE_ADDR		0x020e0000
+#define MX6Q_IOMUXC_SIZE		0x4000
+#define MX6Q_MMDC0_BASE_ADDR 		0x021b0000
+#define MX6Q_MMDC0_SIZE 		0x4000
 #define MX6Q_UART4_BASE_ADDR		0x021f0000
 #define MX6Q_UART4_SIZE			0x4000
 
-- 
1.7.4.1
