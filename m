From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 May 2014 20:39:24 +0900
Subject: [PATCH v5 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <201405271307.56729.arnd@arndb.de>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
 <1399307221-8659-6-git-send-email-a.kesavan@samsung.com>
 <201405271307.56729.arnd@arndb.de>
Message-ID: <002101cf79a0$50fba0f0$f2f2e2d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 05 May 2014, Abhilash Kesavan wrote:
> > +static const struct mcpm_platform_ops exynos_power_ops = {
> > +       .power_up               = exynos_power_up,
> > +       .power_down             = exynos_power_down,
> > +       .power_down_finish      = exynos_power_down_finish,
> > +};
> 
> 
> I'm getting a build error in linux-next because there is
> no .power_down_finish
> member in mcpm_platform_ops here.
> 
Yeah, commit 166aaf39 ("ARM: 8029/1: mcpm: Rename the power_down_finish()
functions to be less confusing") changed the name to
wait_for_cpu_powerdown...

So need to change it accordingly...

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
b/arch/arm/mach-exynos/mcpm-exynos.c
index 1ac618c..34c4e6f 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -235,7 +235,7 @@ static void exynos_power_down(void)
 	/* Not dead at this point?  Let our caller cope. */
 }
 
-static int exynos_power_down_finish(unsigned int cpu, unsigned int cluster)
+static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int
cluster)
 {
 	unsigned int tries = 100;
 	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
@@ -261,7 +261,7 @@ static int exynos_power_down_finish(unsigned int cpu,
unsigned int cluster)
 static const struct mcpm_platform_ops exynos_power_ops = {
 	.power_up		= exynos_power_up,
 	.power_down		= exynos_power_down,
-	.power_down_finish	= exynos_power_down_finish,
+	.wait_for_powerdown	= exynos_wait_for_powerdown,
 };
 
 static void __init exynos_mcpm_usage_count_init(void)

Thanks,
Kukjin
