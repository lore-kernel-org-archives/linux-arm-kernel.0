From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 15:58:47 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.4
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <5419864.uERWTbJ9BK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 September 2015 17:59:33 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC cleanup for v4.4.
> 
>  24 files changed, 4 insertions(+), 2687 deletions(-)
> 
> Is a pleasing diffstat if I do say so myself.
> 
> Of particular note the last legacy board code for Renesas ARM based SoCs,
> that of the bockw board, is removed in this pull request.
> 
> 

After a long delay in response, I've merged it now into next/cleanup.

So the transition is complete and you beat me with the multiplatform
conversion that I have pending for the other ARMv7 platforms, nice work!

	Arnd


I've used the opportunity to look for any remaining code that you may
have missed, by tracking symbols that are defined globally but never used
in mach-shmobile, and didn't find much (which is good).

Could you have a look at the patch below and integrate the parts that
make sense to you?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 4e54512bee30..bcf4cc51b926 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -170,7 +170,7 @@ static inline void cpu_enter_lowpower_a15(void)
 	dsb();
 }
 
-void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
+static void shmobile_smp_apmu_cpu_shutdown(unsigned int cpu)
 {
 
 	/* Select next sleep mode using the APMU */
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 47a862e7f8ba..61ed75ce7782 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -30,19 +30,6 @@
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
 
-struct r8a7779_pm_domain {
-	struct generic_pm_domain genpd;
-	struct rcar_sysc_ch ch;
-};
-
-static inline
-const struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
-{
-	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
-}
-
-#if defined(CONFIG_PM) || defined(CONFIG_SMP)
-
 static void __init r8a7779_sysc_init(void)
 {
 	void __iomem *base = rcar_sysc_init(0xffd85000);
@@ -52,92 +39,10 @@ static void __init r8a7779_sysc_init(void)
 	iowrite32(0, base + SYSCIMR);
 }
 
-#else /* CONFIG_PM || CONFIG_SMP */
-
-static inline void r8a7779_sysc_init(void) {}
-
-#endif /* CONFIG_PM || CONFIG_SMP */
-
-#ifdef CONFIG_PM
-
-static int pd_power_down(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_down(to_r8a7779_ch(genpd));
-}
-
-static int pd_power_up(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_up(to_r8a7779_ch(genpd));
-}
-
-static bool pd_is_off(struct generic_pm_domain *genpd)
-{
-	return rcar_sysc_power_is_off(to_r8a7779_ch(genpd));
-}
-
-static bool pd_active_wakeup(struct device *dev)
-{
-	return true;
-}
-
-static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
-{
-	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
-
-	pm_genpd_init(genpd, NULL, false);
-	genpd->dev_ops.active_wakeup = pd_active_wakeup;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
-
-	if (pd_is_off(&r8a7779_pd->genpd))
-		pd_power_up(&r8a7779_pd->genpd);
-}
-
-static struct r8a7779_pm_domain r8a7779_pm_domains[] = {
-	{
-		.genpd.name = "SH4A",
-		.ch = {
-			.chan_offs = 0x80, /* PWRSR1 .. PWRER1 */
-			.isr_bit = 16, /* SH4A */
-		},
-	},
-	{
-		.genpd.name = "SGX",
-		.ch = {
-			.chan_offs = 0xc0, /* PWRSR2 .. PWRER2 */
-			.isr_bit = 20, /* SGX */
-		},
-	},
-	{
-		.genpd.name = "VDP1",
-		.ch = {
-			.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
-			.isr_bit = 21, /* VDP */
-		},
-	},
-	{
-		.genpd.name = "IMPX3",
-		.ch = {
-			.chan_offs = 0x140, /* PWRSR4 .. PWRER4 */
-			.isr_bit = 24, /* IMP */
-		},
-	},
-};
-
-void __init r8a7779_init_pm_domains(void)
-{
-	int j;
-
-	for (j = 0; j < ARRAY_SIZE(r8a7779_pm_domains); j++)
-		r8a7779_init_pm_domain(&r8a7779_pm_domains[j]);
-}
-
-#endif /* CONFIG_PM */
-
 void __init r8a7779_pm_init(void)
 {
 	static int once;
 
-	if (!once++)
+	if (!once++ && (IS_ENABLED(CONFIG_PM) || IS_ENABLED(CONFIG_SMP)))
 		r8a7779_sysc_init();
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b0c9986d022d..0ab9d3272875 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -42,7 +42,8 @@ static void __init r8a7778_timer_init(void)
 
 #define INT2NTSR0	0x00018 /* 0xfe700018 */
 #define INT2NTSR1	0x0002c /* 0xfe70002c */
-void __init r8a7778_init_irq_dt(void)
+
+static void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
 
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index aa3339258d9c..5a2d8a37deaa 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -182,7 +182,7 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	return 0;
 }
 
-struct cma *rcar_gen2_dma_contiguous;
+static struct cma *rcar_gen2_dma_contiguous;
 
 void __init rcar_gen2_reserve(void)
 {
