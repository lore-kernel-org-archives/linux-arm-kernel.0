From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 21 May 2015 02:52:40 +0800
Subject: [PATCH v2 1/2] ARM: imx: enable smp for i.MX7D
Message-ID: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

i.MX7D have two cores.
enable multicore support.
enable cpu hotplug support.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Anson Huang <b20788@freescale.com>
---

This patch is based on Russel king's
ARM: v7 setup function should invalidate L1 cache

Change from V1 to V2
 - base on ARM: v7 setup function should invalidate L1 cache
 - remove unused define in gpcv2.c
 - change name imx_gpcv2_set_core1_pdn_pup_by_software to imx_gpcv2_set_core1_power
 - add timeout check.
 - Change to BUG_ON
 - Change use enable-method

 arch/arm/mach-imx/Kconfig      |  6 ++++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/common.h     |  4 +++
 arch/arm/mach-imx/gpcv2.c      | 67 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/hotplug.c    | 18 ++++++++++++
 arch/arm/mach-imx/mach-imx7d.c |  1 +
 arch/arm/mach-imx/platsmp.c    | 18 ++++++++++++
 arch/arm/mach-imx/src.c        | 35 ++++++++++++++++++++--
 8 files changed, 147 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-imx/gpcv2.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b8e0537..1852a8c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -53,6 +53,10 @@ config HAVE_IMX_GPC
 	bool
 	select PM_GENERIC_DOMAINS if PM
 
+config HAVE_IMX_GPCV2
+	bool
+	select PM_GENERIC_DOMAINS if PM
+
 config HAVE_IMX_MMDC
 	bool
 
@@ -552,6 +556,8 @@ config SOC_IMX7D
 	bool "i.MX7 Dual support"
 	select PINCTRL_IMX7D
 	select ARM_GIC
+	select ARM_ARCH_TIMER
+	select HAVE_IMX_GPCV2
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ce5be3c..4d32633 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_MACH_IMX35_DT) += imx35-dt.o
 
 obj-$(CONFIG_HAVE_IMX_ANATOP) += anatop.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
+obj-$(CONFIG_HAVE_IMX_GPCV2) += gpcv2.o
 obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
 obj-$(CONFIG_HAVE_IMX_SRC) += src.o
 ifneq ($(CONFIG_SOC_IMX6)$(CONFIG_SOC_LS1021A),)
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 21e4e86..2af85c8 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -66,6 +66,7 @@ void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
+void imx_gpcv2_set_core1_power(bool on);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
@@ -85,6 +86,7 @@ enum mx3_cpu_pwr_mode {
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
 
 void imx_enable_cpu(int cpu, bool enable);
+void imx_enable_cpu_ca7(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
 void imx_set_cpu_arg(int cpu, u32 arg);
@@ -110,9 +112,11 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode);
 void imx6q_set_int_mem_clk_lpm(bool enable);
 void imx6sl_set_wait_clk(bool enter);
 int imx_mmdc_get_ddr_type(void);
+int imx_gpcv2_init(const char *gpc_compat);
 
 void imx_cpu_die(unsigned int cpu);
 int imx_cpu_kill(unsigned int cpu);
+int imx_cpu_ca7_kill(unsigned int cpu);
 
 #ifdef CONFIG_SUSPEND
 void v7_cpu_resume(void);
diff --git a/arch/arm/mach-imx/gpcv2.c b/arch/arm/mach-imx/gpcv2.c
new file mode 100644
index 0000000..1f0ae42f
--- /dev/null
+++ b/arch/arm/mach-imx/gpcv2.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include "common.h"
+
+#define GPC_CPU_PGC_SW_PDN_REQ	0xfc
+#define GPC_CPU_PGC_SW_PUP_REQ	0xf0
+#define GPC_PGC_C1		0x840
+
+#define BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7	0x2
+
+static void __iomem *gpc_base;
+
+static inline void imx_gpcv2_set_m_core_pgc(bool enable, u32 offset)
+{
+	writel_relaxed(enable, gpc_base + offset);
+}
+
+void imx_gpcv2_set_core1_power(bool pdn)
+{
+	u32 reg = pdn ? GPC_CPU_PGC_SW_PUP_REQ : GPC_CPU_PGC_SW_PDN_REQ;
+	u32 val;
+	unsigned long timeout;
+
+	imx_gpcv2_set_m_core_pgc(true, GPC_PGC_C1);
+
+	val = readl_relaxed(gpc_base + reg);
+	val |= BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7;
+	writel_relaxed(val, gpc_base + reg);
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while ((readl_relaxed(gpc_base + reg) & BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7) != 0) {
+		if (time_after(jiffies, timeout)) {
+			BUG_ON(1);
+			imx_gpcv2_set_m_core_pgc(false, GPC_PGC_C1);
+			return;
+		}
+		cpu_relax();
+
+	}
+
+	imx_gpcv2_set_m_core_pgc(false, GPC_PGC_C1);
+}
+
+int __init imx_gpcv2_init(const char *gpc_compat)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, gpc_compat);
+	gpc_base = of_iomap(np, 0);
+
+	BUG_ON(!gpc_base);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index b35e99c..4581ec5 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -68,3 +68,21 @@ int imx_cpu_kill(unsigned int cpu)
 	imx_set_cpu_arg(cpu, 0);
 	return 1;
 }
+
+/*
+ * imx7 cortex a7 can power down each core.
+ * added power off operation after disable core 1.
+ */
+int imx_cpu_ca7_kill(unsigned int cpu)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+	while (imx_get_cpu_arg(cpu) == 0)
+		if (time_after(jiffies, timeout))
+			return 0;
+
+	imx_enable_cpu_ca7(cpu, false);
+	imx_gpcv2_set_core1_power(false);
+	imx_set_cpu_arg(cpu, 0);
+	return 1;
+}
diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 4d4a190..6afb700 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -27,6 +27,7 @@ static void __init imx7d_init_machine(void)
 static void __init imx7d_init_irq(void)
 {
 	imx_init_revision_from_anatop();
+	imx_gpcv2_init("fsl,imx7d-gpc");
 	imx_src_init();
 	irqchip_init();
 }
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7f27001..836efea 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -98,6 +98,24 @@ struct smp_operations  imx_smp_ops __initdata = {
 #endif
 };
 
+static int imx_ca7_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	imx_set_cpu_jump(cpu, secondary_startup);
+	imx_gpcv2_set_core1_power(true);
+	imx_enable_cpu_ca7(cpu, true);
+	return 0;
+}
+
+struct smp_operations  imx_smp_ca7_ops __initdata = {
+	.smp_boot_secondary	= imx_ca7_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= imx_cpu_die,
+	.cpu_kill		= imx_cpu_ca7_kill,
+#endif
+};
+
+CPU_METHOD_OF_DECLARE(imx_smp_ca7, "fsl,imx7d-smp", &imx_smp_ca7_ops);
+
 #define DCFG_CCSR_SCRATCHRW1	0x200
 
 static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 45f7f4e..514c5253 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -30,8 +30,17 @@
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
+/* below is for i.MX7D */
+#define SRC_GPR1_MX7D                     0x074
+#define SRC_A7RCR0                      0x004
+#define SRC_A7RCR1                      0x008
+
+#define BP_SRC_A7RCR0_A7_CORE_RESET0    0
+#define BP_SRC_A7RCR1_A7_CORE1_ENABLE   1
+
 static void __iomem *src_base;
 static DEFINE_SPINLOCK(scr_lock);
+static int src_gpr_offset;
 
 static const int sw_reset_bits[5] = {
 	BP_SRC_SCR_SW_GPU_RST,
@@ -96,23 +105,36 @@ void imx_enable_cpu(int cpu, bool enable)
 	spin_unlock(&scr_lock);
 }
 
+void imx_enable_cpu_ca7(int cpu, bool enable)
+{
+	u32 mask, val;
+
+	cpu = cpu_logical_map(cpu);
+	spin_lock(&scr_lock);
+	mask = 1 << (BP_SRC_A7RCR1_A7_CORE1_ENABLE + cpu - 1);
+	val = readl_relaxed(src_base + SRC_A7RCR1);
+	val = enable ? val | mask : val & ~mask;
+	writel_relaxed(val, src_base + SRC_A7RCR1);
+	spin_unlock(&scr_lock);
+}
+
 void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
 	cpu = cpu_logical_map(cpu);
 	writel_relaxed(virt_to_phys(jump_addr),
-		       src_base + SRC_GPR1 + cpu * 8);
+		       src_base + src_gpr_offset + cpu * 8);
 }
 
 u32 imx_get_cpu_arg(int cpu)
 {
 	cpu = cpu_logical_map(cpu);
-	return readl_relaxed(src_base + SRC_GPR1 + cpu * 8 + 4);
+	return readl_relaxed(src_base + src_gpr_offset + cpu * 8 + 4);
 }
 
 void imx_set_cpu_arg(int cpu, u32 arg)
 {
 	cpu = cpu_logical_map(cpu);
-	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
+	writel_relaxed(arg, src_base + src_gpr_offset + cpu * 8 + 4);
 }
 
 void __init imx_src_init(void)
@@ -120,6 +142,8 @@ void __init imx_src_init(void)
 	struct device_node *np;
 	u32 val;
 
+	src_gpr_offset = SRC_GPR1;
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx51-src");
 	if (!np)
 		return;
@@ -127,6 +151,11 @@ void __init imx_src_init(void)
 	WARN_ON(!src_base);
 
 	imx_reset_controller.of_node = np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-src");
+	if (np)
+		src_gpr_offset = SRC_GPR1_MX7D;
+
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		reset_controller_register(&imx_reset_controller);
 
-- 
1.9.1
