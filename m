From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 12 Jan 2012 14:30:48 +0100
Subject: [PATCH] arm: Fix missing api-change from subsys_interface change
Message-ID: <201201121430.49448.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4a858cfc9a (arm: convert sysdev_class to a regular subsystem)
converted the samsung sysdevs into subsys_interface instances.

While the original add-function only had a (struct sys_device *)
parameter, the dev_add from subsys_interface needs
	(struct device *, struct subsys_interface *)
leading to "initialized from incompatible pointer type" warnings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
The patch applies cleanly against the current driver-core git,
hopefully it's the right tree.

 arch/arm/mach-exynos/pm.c                    |    2 +-
 arch/arm/mach-s3c2410/cpu-freq.c             |    8 +++++---
 arch/arm/mach-s3c2410/dma.c                  |    5 +++--
 arch/arm/mach-s3c2410/pll.c                  |    2 +-
 arch/arm/mach-s3c2410/pm.c                   |    2 +-
 arch/arm/mach-s3c2412/cpu-freq.c             |    3 ++-
 arch/arm/mach-s3c2412/dma.c                  |    3 ++-
 arch/arm/mach-s3c2412/irq.c                  |    2 +-
 arch/arm/mach-s3c2412/pm.c                   |    2 +-
 arch/arm/mach-s3c2416/irq.c                  |    3 ++-
 arch/arm/mach-s3c2416/pm.c                   |    2 +-
 arch/arm/mach-s3c2440/clock.c                |    2 +-
 arch/arm/mach-s3c2440/dma.c                  |    3 ++-
 arch/arm/mach-s3c2440/irq.c                  |    2 +-
 arch/arm/mach-s3c2440/s3c2440-cpufreq.c      |    3 ++-
 arch/arm/mach-s3c2440/s3c2440-pll-12000000.c |    2 +-
 arch/arm/mach-s3c2440/s3c2440-pll-16934400.c |    3 ++-
 arch/arm/mach-s3c2440/s3c2442.c              |    2 +-
 arch/arm/mach-s3c2440/s3c244x-clock.c        |    2 +-
 arch/arm/mach-s3c2440/s3c244x-irq.c          |    2 +-
 arch/arm/mach-s3c2443/dma.c                  |    3 ++-
 arch/arm/mach-s3c2443/irq.c                  |    3 ++-
 arch/arm/mach-s5p64x0/pm.c                   |    2 +-
 arch/arm/mach-s5pv210/pm.c                   |    2 +-
 24 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index a4f61a4..21beb91 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -206,7 +206,7 @@ static void exynos4_pm_prepare(void)
 
 }
 
-static int exynos4_pm_add(struct device *dev)
+static int exynos4_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = exynos4_pm_prepare;
 	pm_cpu_sleep = exynos4_cpu_suspend;
diff --git a/arch/arm/mach-s3c2410/cpu-freq.c b/arch/arm/mach-s3c2410/cpu-freq.c
index 7dc6c46..5404535 100644
--- a/arch/arm/mach-s3c2410/cpu-freq.c
+++ b/arch/arm/mach-s3c2410/cpu-freq.c
@@ -115,7 +115,8 @@ static struct s3c_cpufreq_info s3c2410_cpufreq_info = {
 	.debug_io_show	= s3c_cpufreq_debugfs_call(s3c2410_iotiming_debugfs),
 };
 
-static int s3c2410_cpufreq_add(struct device *dev)
+static int s3c2410_cpufreq_add(struct device *dev,
+			       struct subsys_interface *sif)
 {
 	return s3c_cpufreq_register(&s3c2410_cpufreq_info);
 }
@@ -133,7 +134,8 @@ static int __init s3c2410_cpufreq_init(void)
 
 arch_initcall(s3c2410_cpufreq_init);
 
-static int s3c2410a_cpufreq_add(struct device *dev)
+static int s3c2410a_cpufreq_add(struct device *dev,
+				struct subsys_interface *sif)
 {
 	/* alter the maximum freq settings for S3C2410A. If a board knows
 	 * it only has a maximum of 200, then it should register its own
@@ -144,7 +146,7 @@ static int s3c2410a_cpufreq_add(struct device *dev)
 	s3c2410_cpufreq_info.max.pclk =  66500000;
 	s3c2410_cpufreq_info.name = "s3c2410a";
 
-	return s3c2410_cpufreq_add(dev);
+	return s3c2410_cpufreq_add(dev, sif);
 }
 
 static struct subsys_interface s3c2410a_cpufreq_interface = {
diff --git a/arch/arm/mach-s3c2410/dma.c b/arch/arm/mach-s3c2410/dma.c
index 2afd000..4803338 100644
--- a/arch/arm/mach-s3c2410/dma.c
+++ b/arch/arm/mach-s3c2410/dma.c
@@ -132,7 +132,8 @@ static struct s3c24xx_dma_order __initdata s3c2410_dma_order = {
 	},
 };
 
-static int __init s3c2410_dma_add(struct device *dev)
+static int __init s3c2410_dma_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	s3c2410_dma_init();
 	s3c24xx_dma_order_set(&s3c2410_dma_order);
@@ -148,7 +149,7 @@ static struct subsys_interface s3c2410_dma_interface = {
 
 static int __init s3c2410_dma_drvinit(void)
 {
-	return subsys_interface_register(&s3c2410_interface);
+	return subsys_interface_register(&s3c2410_dma_interface);
 }
 
 arch_initcall(s3c2410_dma_drvinit);
diff --git a/arch/arm/mach-s3c2410/pll.c b/arch/arm/mach-s3c2410/pll.c
index c07438b..e0b3b34 100644
--- a/arch/arm/mach-s3c2410/pll.c
+++ b/arch/arm/mach-s3c2410/pll.c
@@ -66,7 +66,7 @@ static struct cpufreq_frequency_table pll_vals_12MHz[] = {
     { .frequency = 270000000, .index = PLLVAL(127, 1, 1),  },
 };
 
-static int s3c2410_plls_add(struct device *dev)
+static int s3c2410_plls_add(struct device *dev, struct subsys_interface *sif)
 {
 	return s3c_plltab_register(pll_vals_12MHz, ARRAY_SIZE(pll_vals_12MHz));
 }
diff --git a/arch/arm/mach-s3c2410/pm.c b/arch/arm/mach-s3c2410/pm.c
index fda5385..03f706d 100644
--- a/arch/arm/mach-s3c2410/pm.c
+++ b/arch/arm/mach-s3c2410/pm.c
@@ -111,7 +111,7 @@ struct syscore_ops s3c2410_pm_syscore_ops = {
 	.resume		= s3c2410_pm_resume,
 };
 
-static int s3c2410_pm_add(struct device *dev)
+static int s3c2410_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s3c2410_pm_prepare;
 	pm_cpu_sleep = s3c2410_cpu_suspend;
diff --git a/arch/arm/mach-s3c2412/cpu-freq.c b/arch/arm/mach-s3c2412/cpu-freq.c
index d8664b7..125be7d 100644
--- a/arch/arm/mach-s3c2412/cpu-freq.c
+++ b/arch/arm/mach-s3c2412/cpu-freq.c
@@ -194,7 +194,8 @@ static struct s3c_cpufreq_info s3c2412_cpufreq_info = {
 	.debug_io_show  = s3c_cpufreq_debugfs_call(s3c2412_iotiming_debugfs),
 };
 
-static int s3c2412_cpufreq_add(struct device *dev)
+static int s3c2412_cpufreq_add(struct device *dev,
+			       struct subsys_interface *sif)
 {
 	unsigned long fclk_rate;
 
diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
index 142acd3..38472ac 100644
--- a/arch/arm/mach-s3c2412/dma.c
+++ b/arch/arm/mach-s3c2412/dma.c
@@ -159,7 +159,8 @@ static struct s3c24xx_dma_selection __initdata s3c2412_dma_sel = {
 	.map_size	= ARRAY_SIZE(s3c2412_dma_mappings),
 };
 
-static int __init s3c2412_dma_add(struct device *dev)
+static int __init s3c2412_dma_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	s3c2410_dma_init();
 	return s3c24xx_dma_init_map(&s3c2412_dma_sel);
diff --git a/arch/arm/mach-s3c2412/irq.c b/arch/arm/mach-s3c2412/irq.c
index a8a46c1..e65619d 100644
--- a/arch/arm/mach-s3c2412/irq.c
+++ b/arch/arm/mach-s3c2412/irq.c
@@ -170,7 +170,7 @@ static int s3c2412_irq_rtc_wake(struct irq_data *data, unsigned int state)
 
 static struct irq_chip s3c2412_irq_rtc_chip;
 
-static int s3c2412_irq_add(struct device *dev)
+static int s3c2412_irq_add(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int irqno;
 
diff --git a/arch/arm/mach-s3c2412/pm.c b/arch/arm/mach-s3c2412/pm.c
index d1adfa6..d045885 100644
--- a/arch/arm/mach-s3c2412/pm.c
+++ b/arch/arm/mach-s3c2412/pm.c
@@ -56,7 +56,7 @@ static void s3c2412_pm_prepare(void)
 {
 }
 
-static int s3c2412_pm_add(struct device *dev)
+static int s3c2412_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s3c2412_pm_prepare;
 	pm_cpu_sleep = s3c2412_cpu_suspend;
diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
index 36df761..fd49f35 100644
--- a/arch/arm/mach-s3c2416/irq.c
+++ b/arch/arm/mach-s3c2416/irq.c
@@ -213,7 +213,8 @@ static int __init s3c2416_add_sub(unsigned int base,
 	return 0;
 }
 
-static int __init s3c2416_irq_add(struct device *dev)
+static int __init s3c2416_irq_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	printk(KERN_INFO "S3C2416: IRQ Support\n");
 
diff --git a/arch/arm/mach-s3c2416/pm.c b/arch/arm/mach-s3c2416/pm.c
index 3bdb15a..1bd4817 100644
--- a/arch/arm/mach-s3c2416/pm.c
+++ b/arch/arm/mach-s3c2416/pm.c
@@ -48,7 +48,7 @@ static void s3c2416_pm_prepare(void)
 	__raw_writel(virt_to_phys(s3c_cpu_resume), S3C2412_INFORM1);
 }
 
-static int s3c2416_pm_add(struct device *dev)
+static int s3c2416_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s3c2416_pm_prepare;
 	pm_cpu_sleep = s3c2416_cpu_suspend;
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index bedbc87..414364e 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -149,7 +149,7 @@ static struct clk_lookup s3c2440_clk_lookup[] = {
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
 };
 
-static int s3c2440_clk_add(struct device *dev)
+static int s3c2440_clk_add(struct device *dev, struct subsys_interface *sif)
 {
 	struct clk *clock_upll;
 	struct clk *clock_h;
diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c2440/dma.c
index 15b1ddf..5f0a0c8 100644
--- a/arch/arm/mach-s3c2440/dma.c
+++ b/arch/arm/mach-s3c2440/dma.c
@@ -174,7 +174,8 @@ static struct s3c24xx_dma_order __initdata s3c2440_dma_order = {
 	},
 };
 
-static int __init s3c2440_dma_add(struct device *dev)
+static int __init s3c2440_dma_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	s3c2410_dma_init();
 	s3c24xx_dma_order_set(&s3c2440_dma_order);
diff --git a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c2440/irq.c
index 4fee9bc..4a18cde 100644
--- a/arch/arm/mach-s3c2440/irq.c
+++ b/arch/arm/mach-s3c2440/irq.c
@@ -92,7 +92,7 @@ static struct irq_chip s3c_irq_wdtac97 = {
 	.irq_ack	= s3c_irq_wdtac97_ack,
 };
 
-static int s3c2440_irq_add(struct device *dev)
+static int s3c2440_irq_add(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int irqno;
 
diff --git a/arch/arm/mach-s3c2440/s3c2440-cpufreq.c b/arch/arm/mach-s3c2440/s3c2440-cpufreq.c
index cf75966..6177676 100644
--- a/arch/arm/mach-s3c2440/s3c2440-cpufreq.c
+++ b/arch/arm/mach-s3c2440/s3c2440-cpufreq.c
@@ -270,7 +270,8 @@ struct s3c_cpufreq_info s3c2440_cpufreq_info = {
 	.debug_io_show  = s3c_cpufreq_debugfs_call(s3c2410_iotiming_debugfs),
 };
 
-static int s3c2440_cpufreq_add(struct device *dev)
+static int s3c2440_cpufreq_add(struct device *dev,
+			       struct subsys_interface *sif)
 {
 	xtal = s3c_cpufreq_clk_get(NULL, "xtal");
 	hclk = s3c_cpufreq_clk_get(NULL, "hclk");
diff --git a/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c b/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
index b5368ae..551fb43 100644
--- a/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
+++ b/arch/arm/mach-s3c2440/s3c2440-pll-12000000.c
@@ -51,7 +51,7 @@ static struct cpufreq_frequency_table s3c2440_plls_12[] __initdata = {
 	{ .frequency = 400000000,	.index = PLLVAL(0x5c, 1, 1),  }, 	/* FVco 800.000000 */
 };
 
-static int s3c2440_plls12_add(struct device *dev)
+static int s3c2440_plls12_add(struct device *dev, struct subsys_interface *sif)
 {
 	struct clk *xtal_clk;
 	unsigned long xtal;
diff --git a/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c b/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
index 42f2b5c..3f15bcf 100644
--- a/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
+++ b/arch/arm/mach-s3c2440/s3c2440-pll-16934400.c
@@ -79,7 +79,8 @@ static struct cpufreq_frequency_table s3c2440_plls_169344[] __initdata = {
 	{ .frequency = 402192000,	.index = PLLVAL(87, 2, 1), 	}, 	/* FVco 804.384000 */
 };
 
-static int s3c2440_plls169344_add(struct device *dev)
+static int s3c2440_plls169344_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	struct clk *xtal_clk;
 	unsigned long xtal;
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
index 8004e04..22cb7c9 100644
--- a/arch/arm/mach-s3c2440/s3c2442.c
+++ b/arch/arm/mach-s3c2440/s3c2442.c
@@ -122,7 +122,7 @@ static struct clk s3c2442_clk_cam_upll = {
 	},
 };
 
-static int s3c2442_clk_add(struct device *dev)
+static int s3c2442_clk_add(struct device *dev, struct subsys_interface *sif)
 {
 	struct clk *clock_upll;
 	struct clk *clock_h;
diff --git a/arch/arm/mach-s3c2440/s3c244x-clock.c b/arch/arm/mach-s3c2440/s3c244x-clock.c
index b3fdbdd..6d9b688 100644
--- a/arch/arm/mach-s3c2440/s3c244x-clock.c
+++ b/arch/arm/mach-s3c2440/s3c244x-clock.c
@@ -72,7 +72,7 @@ static struct clk clk_arm = {
 	},
 };
 
-static int s3c244x_clk_add(struct device *dev)
+static int s3c244x_clk_add(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned long camdivn = __raw_readl(S3C2440_CAMDIVN);
 	unsigned long clkdivn;
diff --git a/arch/arm/mach-s3c2440/s3c244x-irq.c b/arch/arm/mach-s3c2440/s3c244x-irq.c
index 74d3dcf..5fe8e58 100644
--- a/arch/arm/mach-s3c2440/s3c244x-irq.c
+++ b/arch/arm/mach-s3c2440/s3c244x-irq.c
@@ -91,7 +91,7 @@ static struct irq_chip s3c_irq_cam = {
 	.irq_ack	= s3c_irq_cam_ack,
 };
 
-static int s3c244x_irq_add(struct device *dev)
+static int s3c244x_irq_add(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int irqno;
 
diff --git a/arch/arm/mach-s3c2443/dma.c b/arch/arm/mach-s3c2443/dma.c
index de6b4a2..1422451 100644
--- a/arch/arm/mach-s3c2443/dma.c
+++ b/arch/arm/mach-s3c2443/dma.c
@@ -135,7 +135,8 @@ static struct s3c24xx_dma_selection __initdata s3c2443_dma_sel = {
 	.map_size	= ARRAY_SIZE(s3c2443_dma_mappings),
 };
 
-static int __init s3c2443_dma_add(struct device *dev)
+static int __init s3c2443_dma_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	s3c24xx_dma_init(6, IRQ_S3C2443_DMA0, 0x100);
 	return s3c24xx_dma_init_map(&s3c2443_dma_sel);
diff --git a/arch/arm/mach-s3c2443/irq.c b/arch/arm/mach-s3c2443/irq.c
index 35e4ff2..ac2829f 100644
--- a/arch/arm/mach-s3c2443/irq.c
+++ b/arch/arm/mach-s3c2443/irq.c
@@ -241,7 +241,8 @@ static int __init s3c2443_add_sub(unsigned int base,
 	return 0;
 }
 
-static int __init s3c2443_irq_add(struct device *dev)
+static int __init s3c2443_irq_add(struct device *dev,
+				  struct subsys_interface *sif)
 {
 	printk("S3C2443: IRQ Support\n");
 
diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
index 23f9b22..9cba18b 100644
--- a/arch/arm/mach-s5p64x0/pm.c
+++ b/arch/arm/mach-s5p64x0/pm.c
@@ -160,7 +160,7 @@ static void s5p64x0_pm_prepare(void)
 
 }
 
-static int s5p64x0_pm_add(struct device *dev)
+static int s5p64x0_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s5p64x0_pm_prepare;
 	pm_cpu_sleep = s5p64x0_cpu_suspend;
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index 677c71c..736bfb1 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -133,7 +133,7 @@ static void s5pv210_pm_prepare(void)
 	s3c_pm_do_save(s5pv210_core_save, ARRAY_SIZE(s5pv210_core_save));
 }
 
-static int s5pv210_pm_add(struct device *dev)
+static int s5pv210_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s5pv210_pm_prepare;
 	pm_cpu_sleep = s5pv210_cpu_suspend;
-- 
1.7.5.4
