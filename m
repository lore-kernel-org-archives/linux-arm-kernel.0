From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:14 -0600
Subject: [PATCH v4 05/19] ARM: GIC: remove direct use of gic_raise_softirq
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation of moving gic code to drivers/irqchip, remove the direct
platform dependencies on gic_raise_softirq. Move the setup of
smp_cross_call into the gic code and use arch_send_wakeup_ipi_mask
function to trigger wake-up IPIs.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/common/gic.c               |   45 +++++++++++++++++++----------------
 arch/arm/include/asm/hardware/gic.h |    1 -
 arch/arm/kernel/smp.c               |    3 ++-
 arch/arm/mach-exynos/platsmp.c      |    4 +---
 arch/arm/mach-highbank/platsmp.c    |    4 +---
 arch/arm/mach-imx/platsmp.c         |    2 --
 arch/arm/mach-msm/platsmp.c         |    4 +---
 arch/arm/mach-omap2/omap-smp.c      |    4 +---
 arch/arm/mach-realview/platsmp.c    |    3 ---
 arch/arm/mach-shmobile/platsmp.c    |    2 --
 arch/arm/mach-shmobile/smp-emev2.c  |    2 +-
 arch/arm/mach-socfpga/platsmp.c     |    2 --
 arch/arm/mach-spear13xx/platsmp.c   |    2 --
 arch/arm/mach-tegra/platsmp.c       |    2 --
 arch/arm/mach-ux500/platsmp.c       |    4 +---
 arch/arm/mach-vexpress/ct-ca9x4.c   |    2 --
 arch/arm/mach-vexpress/platsmp.c    |    2 --
 arch/arm/plat-versatile/platsmp.c   |    2 +-
 18 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a..788658c 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -617,6 +617,27 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 }
 #endif
 
+#ifdef CONFIG_SMP
+void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+{
+	int cpu;
+	unsigned long map = 0;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* this always happens on GIC0 */
+	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+}
+#endif
+
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
@@ -743,6 +764,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	if (WARN_ON(!gic->domain))
 		return;
 
+#ifdef CONFIG_SMP
+	set_smp_cross_call(gic_raise_softirq);
+#endif
 	gic_chip.flags |= gic_arch_extn.flags;
 	gic_dist_init(gic);
 	gic_cpu_init(gic);
@@ -756,27 +780,6 @@ void __cpuinit gic_secondary_init(unsigned int gic_nr)
 	gic_cpu_init(&gic_data[gic_nr]);
 }
 
-#ifdef CONFIG_SMP
-void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
-{
-	int cpu;
-	unsigned long map = 0;
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= gic_cpu_map[cpu];
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
-	 */
-	dsb();
-
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
-}
-#endif
-
 #ifdef CONFIG_OF
 static int gic_cnt __initdata = 0;
 
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index fc59698..cfd3a7e 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -40,7 +40,6 @@ int gic_of_init(struct device_node *node, struct device_node *parent);
 void gic_secondary_init(unsigned int);
 void gic_handle_irq(struct pt_regs *regs);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
-void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
 
 static inline void gic_init(unsigned int nr, int start,
 			    void __iomem *dist , void __iomem *cpu)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 84f4cbf..3fc96db 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -416,7 +416,8 @@ static void (*smp_cross_call)(const struct cpumask *, unsigned int);
 
 void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
 {
-	smp_cross_call = fn;
+	if (!smp_cross_call)
+		smp_cross_call = fn;
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index c5c840e..5898f82 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -149,7 +149,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 							cpu_boot_reg(phys_cpu));
-		gic_raise_softirq(cpumask_of(cpu), 0);
+		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 		if (pen_release == -1)
 			break;
@@ -190,8 +190,6 @@ static void __init exynos_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
index 1129957..f305c91 100644
--- a/arch/arm/mach-highbank/platsmp.c
+++ b/arch/arm/mach-highbank/platsmp.c
@@ -32,7 +32,7 @@ static void __cpuinit highbank_secondary_init(unsigned int cpu)
 
 static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 	return 0;
 }
 
@@ -55,8 +55,6 @@ static void __init highbank_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 3777b80..8e72057 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -71,8 +71,6 @@ static void __init imx_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 void imx_smp_prepare(void)
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 7ed69b69..e27e57b 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -115,7 +115,7 @@ static int __cpuinit msm_boot_secondary(unsigned int cpu, struct task_struct *id
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
@@ -153,8 +153,6 @@ static void __init msm_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-        set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init msm_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index cd42d92..668172a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -157,7 +157,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
 		booted = true;
 	}
 
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 	/*
 	 * Now the secondary core is starting up let it run its
@@ -231,8 +231,6 @@ static void __init omap4_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 300f706..98e3052 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -14,7 +14,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
 
@@ -59,8 +58,6 @@ static void __init realview_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index ed8d235..d393c52 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -26,6 +26,4 @@ void __init shmobile_smp_init_cpus(unsigned int ncores)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index f674562..6262d67 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -100,7 +100,7 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
 
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 	return 0;
 }
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 68dd1b6..98a2220 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -83,8 +83,6 @@ static void __init socfpga_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index 2eaa3fa..27e3f69 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -104,8 +104,6 @@ static void __init spear13xx_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1b926df..d8e6754 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -159,8 +159,6 @@ static void __init tegra_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 79531f1..fa07d4d 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -91,7 +91,7 @@ static int __cpuinit ux500_boot_secondary(unsigned int cpu, struct task_struct *
 	 */
 	write_pen_release(cpu_logical_map(cpu));
 
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
@@ -155,8 +155,6 @@ static void __init ux500_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 60838dd..0ad050f 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -182,8 +182,6 @@ static void __init ct_ca9x4_init_cpu_map(void)
 
 	for (i = 0; i < ncores; ++i)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init ct_ca9x4_smp_enable(unsigned int max_cpus)
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index c5d70de..3bc0e38 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -128,8 +128,6 @@ static void __init vexpress_dt_smp_init_cpus(void)
 
 	for (i = 0; i < ncores; ++i)
 		set_cpu_possible(i, true);
-
-	set_smp_cross_call(gic_raise_softirq);
 }
 
 static void __init vexpress_dt_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 04ca493..2336024 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -79,7 +79,7 @@ int __cpuinit versatile_boot_secondary(unsigned int cpu, struct task_struct *idl
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 0);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.10.4
