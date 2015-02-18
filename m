From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 18 Feb 2015 21:19:56 +0100
Subject: [PATCH] ARM: make of_device_ids const
Message-ID: <1424290796-18475-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. So mark the
non-const structs in arch/arm as const, too.

While at it also add some __initconst annotations.

Acked-by: Jason Cooper <jason@lakedameon.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/perf_event_cpu.c     | 2 +-
 arch/arm/mach-at91/at91rm9200_time.c | 2 +-
 arch/arm/mach-at91/pm.c              | 4 ++--
 arch/arm/mach-davinci/da8xx-dt.c     | 2 +-
 arch/arm/mach-exynos/suspend.c       | 2 +-
 arch/arm/mach-imx/mmdc.c             | 2 +-
 arch/arm/mach-keystone/pm_domain.c   | 2 +-
 arch/arm/mach-mmp/time.c             | 2 +-
 arch/arm/mach-mvebu/coherency.c      | 2 +-
 arch/arm/mach-mvebu/pmsu.c           | 2 +-
 arch/arm/mach-omap2/omap4-common.c   | 2 +-
 arch/arm/mach-omap2/prm3xxx.c        | 2 +-
 arch/arm/mach-omap2/prm44xx.c        | 2 +-
 arch/arm/mach-prima2/platsmp.c       | 2 +-
 arch/arm/mach-ux500/pm_domains.c     | 2 +-
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index dd9acc95ebc0..61b53c46edfa 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -231,7 +231,7 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 /*
  * PMU platform driver and devicetree bindings.
  */
-static struct of_device_id cpu_pmu_of_device_ids[] = {
+static const struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a17-pmu",	.data = armv7_a17_pmu_init},
 	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
 	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 51761f8927b7..b00d09555f2b 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -183,7 +183,7 @@ static struct clock_event_device clkevt = {
 void __iomem *at91_st_base;
 EXPORT_SYMBOL_GPL(at91_st_base);
 
-static struct of_device_id at91rm9200_st_timer_ids[] = {
+static const struct of_device_id at91rm9200_st_timer_ids[] = {
 	{ .compatible = "atmel,at91rm9200-st" },
 	{ /* sentinel */ }
 };
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index af8d8afc2e12..5e34fb143309 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -226,7 +226,7 @@ void at91_pm_set_standby(void (*at91_standby)(void))
 	}
 }
 
-static struct of_device_id ramc_ids[] = {
+static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
@@ -234,7 +234,7 @@ static struct of_device_id ramc_ids[] = {
 	{ /*sentinel*/ }
 };
 
-static void at91_dt_ramc(void)
+static __init void at91_dt_ramc(void)
 {
 	struct device_node *np;
 	const struct of_device_id *of_id;
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index f703d82f08a8..438f68547f4c 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,7 +20,7 @@
 
 #define DA8XX_NUM_UARTS	3
 
-static struct of_device_id da8xx_irq_match[] __initdata = {
+static const struct of_device_id da8xx_irq_match[] __initconst = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
 };
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 666ec3e5b03f..52e2b1a2fddb 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -587,7 +587,7 @@ static struct exynos_pm_data exynos5420_pm_data = {
 	.cpu_suspend	= exynos5420_cpu_suspend,
 };
 
-static struct of_device_id exynos_pmu_of_device_ids[] = {
+static const struct of_device_id exynos_pmu_of_device_ids[] __initconst = {
 	{
 		.compatible = "samsung,exynos3250-pmu",
 		.data = &exynos3250_pm_data,
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index a377f95033ae..0411f0664c15 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -68,7 +68,7 @@ int imx_mmdc_get_ddr_type(void)
 	return ddr_type;
 }
 
-static struct of_device_id imx_mmdc_dt_ids[] = {
+static const struct of_device_id imx_mmdc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-mmdc", },
 	{ /* sentinel */ }
 };
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index ef6041e7e675..41bebfd296dc 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -61,7 +61,7 @@ static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
 };
 
-static struct of_device_id of_keystone_table[] = {
+static const struct of_device_id of_keystone_table[] = {
 	{.compatible = "ti,keystone"},
 	{ /* end of list */ },
 };
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 2756351dbb35..10bfa03e58d4 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -213,7 +213,7 @@ void __init timer_init(int irq)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id mmp_timer_dt_ids[] = {
+static const struct of_device_id mmp_timer_dt_ids[] = {
 	{ .compatible = "mrvl,mmp-timer", },
 	{}
 };
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index b5895f040caa..e46e9ea1e187 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -51,7 +51,7 @@ enum {
 	COHERENCY_FABRIC_TYPE_ARMADA_380,
 };
 
-static struct of_device_id of_coherency_table[] = {
+static const struct of_device_id of_coherency_table[] = {
 	{.compatible = "marvell,coherency-fabric",
 	 .data = (void *) COHERENCY_FABRIC_TYPE_ARMADA_370_XP },
 	{.compatible = "marvell,armada-375-coherency-fabric",
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index d8ab605a44fa..8b9f5e202ccf 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -104,7 +104,7 @@ static void __iomem *pmsu_mp_base;
 
 static void *mvebu_cpu_resume;
 
-static struct of_device_id of_pmsu_table[] = {
+static const struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
 	{ .compatible = "marvell,armada-370-xp-pmsu", },
 	{ .compatible = "marvell,armada-380-pmsu", },
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 2418bdf28ca2..cee0fe1ee6ff 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -242,7 +242,7 @@ static int __init omap4_sar_ram_init(void)
 }
 omap_early_initcall(omap4_sar_ram_init);
 
-static struct of_device_id gic_match[] = {
+static const struct of_device_id gic_match[] = {
 	{ .compatible = "arm,cortex-a9-gic", },
 	{ .compatible = "arm,cortex-a15-gic", },
 	{ },
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index c5e00c6714b1..5713bbdf83bc 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -674,7 +674,7 @@ int __init omap3xxx_prm_init(void)
 	return prm_register(&omap3xxx_prm_ll_data);
 }
 
-static struct of_device_id omap3_prm_dt_match_table[] = {
+static const struct of_device_id omap3_prm_dt_match_table[] = {
 	{ .compatible = "ti,omap3-prm" },
 	{ }
 };
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 408c64efb807..a08a617a6c11 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -712,7 +712,7 @@ int __init omap44xx_prm_init(void)
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-static struct of_device_id omap_prm_dt_match_table[] = {
+static const struct of_device_id omap_prm_dt_match_table[] = {
 	{ .compatible = "ti,omap4-prm" },
 	{ .compatible = "ti,omap5-prm" },
 	{ .compatible = "ti,dra7-prm" },
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index fc2b03c81e5f..e46c91094dde 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -40,7 +40,7 @@ static void sirfsoc_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static struct of_device_id clk_ids[]  = {
+static const struct of_device_id clk_ids[]  = {
 	{ .compatible = "sirf,atlas7-clkc" },
 	{},
 };
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 0d4b5b46f15b..4d71c90f801c 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -49,7 +49,7 @@ static struct generic_pm_domain *ux500_pm_domains[NR_DOMAINS] = {
 	[DOMAIN_VAPE] = &ux500_pm_domain_vape,
 };
 
-static struct of_device_id ux500_pm_domain_matches[] = {
+static const struct of_device_id ux500_pm_domain_matches[] __initconst = {
 	{ .compatible = "stericsson,ux500-pm-domains", },
 	{ },
 };
-- 
2.1.4
