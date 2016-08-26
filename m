From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 26 Aug 2016 19:12:51 +0800
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7D has 2 cortex-a7 ARM core, add support for
booting up SMP kernel with 2 CPUs.

The existing i.MX SMP code is designed for i.MX6
series SoCs which have cortex-a9 ARM core, but i.MX7D
has 2 cortex-a7 ARM core, so we need to add runtime
check for those differences between cortex-a9 and
cortex-a7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/headsmp.S    | 11 +++++++++++
 arch/arm/mach-imx/mach-imx7d.c |  2 ++
 arch/arm/mach-imx/platsmp.c    | 19 ++++++++++++++++++-
 arch/arm/mach-imx/src.c        | 38 ++++++++++++++++++++++++++++++--------
 4 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 6c28d28..a26e459 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -26,7 +26,18 @@ diag_reg_offset:
 	.endm
 
 ENTRY(v7_secondary_startup)
+	.word	0xc070			@ 0xc07 is cortex-a7 id
+	.word	0xfff0			@ mask for core type
+
 ARM_BE8(setend be)			@ go BE8 if entered LE
+	mrc     p15, 0, r0, c0, c0, 0
+	adr	r1, v7_secondary_startup
+	ldr	r2, [r1]
+	ldr	r3, [r1, #0x4]
+	and     r0, r0, r3
+	cmp     r0, r2
+	beq     secondary_startup
+
 	set_diag_reg
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 26ca744..ef3dce6 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -99,6 +99,7 @@ static void __init imx7d_init_machine(void)
 
 static void __init imx7d_init_irq(void)
 {
+	imx_gpcv2_check_dt();
 	imx_init_revision_from_anatop();
 	imx_src_init();
 	irqchip_init();
@@ -111,6 +112,7 @@ static const char *const imx7d_dt_compat[] __initconst = {
 };
 
 DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
+	.smp		= smp_ops(imx_smp_ops),
 	.init_irq	= imx7d_init_irq,
 	.init_machine	= imx7d_init_machine,
 	.dt_compat	= imx7d_dt_compat,
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 711dbbd..63af911 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -60,8 +60,17 @@ static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 static void __init imx_smp_init_cpus(void)
 {
 	int i, ncores;
+	unsigned long val, arch_type;
 
-	ncores = scu_get_core_count(scu_base);
+	asm volatile("mrc p15, 0, %0, c0, c0, 0" : "=r" (arch_type));
+
+	if (((arch_type >> 4) & 0xfff) == 0xc07) {
+		/* cortex-a7 core number is in bit[25:24] of CP15 L2CTLR */
+		asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
+		ncores = ((val >> 24) & 0x3) + 1;
+	} else {
+		ncores = scu_get_core_count(scu_base);
+	}
 
 	for (i = ncores; i < NR_CPUS; i++)
 		set_cpu_possible(i, false);
@@ -74,6 +83,14 @@ void imx_smp_prepare(void)
 
 static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 {
+	unsigned long arch_type;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 0" : "=r" (arch_type));
+
+	/* no need for cortex-a7 */
+	if (((arch_type >> 4) & 0xfff) == 0xc07)
+		return;
+
 	imx_smp_prepare();
 
 	/*
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 70b083f..1fda72a 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <asm/smp_plat.h>
 #include "common.h"
+#include "hardware.h"
 
 #define SRC_SCR				0x000
 #define SRC_GPR1			0x020
@@ -30,6 +31,15 @@
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
+/* below are for i.MX7D */
+#define SRC_GPR1_V2                     0x074
+#define SRC_A7RCR0                      0x004
+#define SRC_A7RCR1                      0x008
+#define SRC_M4RCR                       0x00C
+
+#define BP_SRC_A7RCR0_A7_CORE_RESET0   0
+#define BP_SRC_A7RCR1_A7_CORE1_ENABLE  1
+
 static void __iomem *src_base;
 static DEFINE_SPINLOCK(scr_lock);
 
@@ -87,12 +97,21 @@ void imx_enable_cpu(int cpu, bool enable)
 	u32 mask, val;
 
 	cpu = cpu_logical_map(cpu);
-	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
 	spin_lock(&scr_lock);
-	val = readl_relaxed(src_base + SRC_SCR);
-	val = enable ? val | mask : val & ~mask;
-	val |= 1 << (BP_SRC_SCR_CORE1_RST + cpu - 1);
-	writel_relaxed(val, src_base + SRC_SCR);
+	if (cpu_is_imx7d()) {
+		if (enable)
+			imx_gpcv2_set_core1_pdn_pup_by_software(false);
+		mask = 1 << (BP_SRC_A7RCR1_A7_CORE1_ENABLE + cpu - 1);
+		val = readl_relaxed(src_base + SRC_A7RCR1);
+		val = enable ? val | mask : val & ~mask;
+		writel_relaxed(val, src_base + SRC_A7RCR1);
+	} else {
+		mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
+		val = readl_relaxed(src_base + SRC_SCR);
+		val = enable ? val | mask : val & ~mask;
+		val |= 1 << (BP_SRC_SCR_CORE1_RST + cpu - 1);
+		writel_relaxed(val, src_base + SRC_SCR);
+	}
 	spin_unlock(&scr_lock);
 }
 
@@ -100,19 +119,22 @@ void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
 	cpu = cpu_logical_map(cpu);
 	writel_relaxed(virt_to_phys(jump_addr),
-		       src_base + SRC_GPR1 + cpu * 8);
+		       src_base + (cpu_is_imx7d() ?
+		       SRC_GPR1_V2 : SRC_GPR1) + cpu * 8);
 }
 
 u32 imx_get_cpu_arg(int cpu)
 {
 	cpu = cpu_logical_map(cpu);
-	return readl_relaxed(src_base + SRC_GPR1 + cpu * 8 + 4);
+	return readl_relaxed(src_base + (cpu_is_imx7d() ?
+		SRC_GPR1_V2 : SRC_GPR1) + cpu * 8 + 4);
 }
 
 void imx_set_cpu_arg(int cpu, u32 arg)
 {
 	cpu = cpu_logical_map(cpu);
-	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
+	writel_relaxed(arg, src_base + (cpu_is_imx7d() ?
+		SRC_GPR1_V2 : SRC_GPR1) + cpu * 8 + 4);
 }
 
 void __init imx_src_init(void)
-- 
1.9.1
