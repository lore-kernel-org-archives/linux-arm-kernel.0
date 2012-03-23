From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 23 Mar 2012 13:19:27 +0530
Subject: [PATCH 2/2] ARM: GIC: Create common infrastructure for GIC DT bindings
In-Reply-To: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
References: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
Message-ID: <23b4d2ea357a7a785b6c42d0fa7ae9478bad552b.1332488625.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few platforms define there own struct of_device_id[] for GIC. They don't
do anything specific in init_irq() other than of_irq_init().

This patch creates this struct array in gic.c and make other platforms use it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/gic.c               |   10 ++++++++++
 arch/arm/include/asm/hardware/gic.h |    1 +
 arch/arm/mach-exynos/common.c       |    9 +--------
 arch/arm/mach-highbank/highbank.c   |    7 +------
 arch/arm/mach-imx/mach-imx6q.c      |    2 +-
 arch/arm/mach-tegra/common.c        |    7 +------
 arch/arm/mach-ux500/cpu.c           |    7 +------
 arch/arm/mach-vexpress/v2m.c        |   12 +-----------
 8 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..77afdae 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -781,4 +781,14 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 	gic_cnt++;
 	return 0;
 }
+
+static const struct of_device_id gic_of_match[] __initconst = {
+	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{ /* Sentinel */ }
+};
+
+void __init gic_init_irq(void)
+{
+	of_irq_init(gic_of_match);
+}
 #endif
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6c..7bce4bd 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -42,6 +42,7 @@ void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
 		    u32 offset, struct device_node *);
 int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
+void __init gic_init_irq(void);
 void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 85ed8b5..76f6079 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -502,13 +502,6 @@ static void __init combiner_init(unsigned int combiner_nr, void __iomem *base,
 	}
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id exynos4_dt_irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{},
-};
-#endif
-
 void __init exynos4_init_irq(void)
 {
 	int irq;
@@ -520,7 +513,7 @@ void __init exynos4_init_irq(void)
 		gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
 #ifdef CONFIG_OF
 	else
-		of_irq_init(exynos4_dt_irq_match);
+		gic_init_irq();
 #endif
 
 	for (irq = 0; irq < EXYNOS4_MAX_COMBINER_NR; irq++) {
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 410a112..42b30c6 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -80,14 +80,9 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 static void __init highbank_init_irq(void)
 {
-	of_irq_init(irq_match);
+	gic_init_irq();
 	l2x0_of_init(0, ~0UL);
 }
 
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 7696dfa..ebaf6c5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -105,7 +105,6 @@ static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
 }
 
 static const struct of_device_id imx6q_irq_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
 	{ .compatible = "fsl,imx6q-gpio", .data = imx6q_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
@@ -115,6 +114,7 @@ static void __init imx6q_init_irq(void)
 	l2x0_of_init(0, ~0UL);
 	imx_src_init();
 	imx_gpc_init();
+	gic_init_irq();
 	of_irq_init(imx6q_irq_match);
 }
 
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 22df10f..c8d6208 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -52,15 +52,10 @@ u32 tegra_uart_config[3] = {
 };
 
 #ifdef CONFIG_OF
-static const struct of_device_id tegra_dt_irq_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
-	{ }
-};
-
 void __init tegra_dt_init_irq(void)
 {
 	tegra_init_irq();
-	of_irq_init(tegra_dt_irq_match);
+	gic_init_irq();
 }
 #endif
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index d11f389..3bb6f13 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -30,11 +30,6 @@
 
 void __iomem *_PRCMU_BASE;
 
-static const struct of_device_id ux500_dt_irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{},
-};
-
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
@@ -51,7 +46,7 @@ void __init ux500_init_irq(void)
 
 #ifdef CONFIG_OF
 	if (of_have_populated_dt())
-		of_irq_init(ux500_dt_irq_match);
+		gic_init_irq();
 	else
 #endif
 		gic_init(0, 29, dist_base, cpu_base);
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 47cdcca..3d875f2 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -619,16 +619,6 @@ void __init v2m_dt_init_early(void)
 	versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
 }
 
-static  struct of_device_id vexpress_irq_match[] __initdata = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
-static void __init v2m_dt_init_irq(void)
-{
-	of_irq_init(vexpress_irq_match);
-}
-
 static void __init v2m_dt_timer_init(void)
 {
 	struct device_node *node;
@@ -677,7 +667,7 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.dt_compat	= v2m_dt_match,
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
-	.init_irq	= v2m_dt_init_irq,
+	.init_irq	= gic_init_irq,
 	.timer		= &v2m_dt_timer,
 	.init_machine	= v2m_dt_init,
 	.handle_irq	= gic_handle_irq,
-- 
1.7.8.110.g4cb5d
