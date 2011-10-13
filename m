From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 16:10:04 +0100
Subject: [PATCH] arm: fix handling of nr_cpus
In-Reply-To: <1318508268.2300.67.camel@deneb.redhat.com>
References: <1318339864-32396-1-git-send-email-msalter@redhat.com>
	<20111012172628.GC21648@n2100.arm.linux.org.uk>
	<1318508268.2300.67.camel@deneb.redhat.com>
Message-ID: <20111013151004.GF21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 08:17:47AM -0400, Mark Salter wrote:
> On Wed, 2011-10-12 at 18:26 +0100, Russell King - ARM Linux wrote:
> > On Tue, Oct 11, 2011 at 09:31:04AM -0400, Mark Salter wrote:
> > > The current code duplicates the setup of the cpu_possible bitmap in the
> > > platform smp_init_cpus() function. Unfortunately, all of those places
> > > have the same bug where the nr_cpus kernel parameter is ignored. This patch
> > > consolidates the duplicated code in one place and fixes it to honor the
> > > nr_cpus parameter. This is accomplished by having smp_init_cpus() return
> > > the platform specific number of cores so that the caller (setup_arch) can
> > > set up the cpu_possible bitmap correctly for all platforms.
> > 
> > Who says every platform we're going to see will always have CPUs 0..N ?
> > It's entirely possible that someone might want to have CPUs 0, 2, 3 as
> > possible CPUs but omit CPU1 for platform reasons.
> 
> Good point. We could do that by not setting the cpu_present bit for the
> CPU we want to omit. Or we could leave the current platform cpu_possible
> setup as-is and add something like:
> 
>    for (i = nr_cpu_ids; i < NR_CPUS; i++)
>        set_cpu_possible(i, false);
> 
> to setup_arch after the call to smp_init_cpus.

As long as the mask bitmaps remain allocated above nr_cpu_ids, then yes.
If that changes in generic code, I suspect this kind of thing may be
missed.

I still wonder if doing this wouldn't be easier though - it results in
a consistent message across all platforms, which is important if we're
going to be checking against a user-passed value.

 arch/arm/mach-exynos4/platsmp.c  |   10 ++++------
 arch/arm/mach-omap2/omap-smp.c   |   10 ++++------
 arch/arm/mach-realview/platsmp.c |   10 ++++------
 arch/arm/mach-tegra/platsmp.c    |    8 ++++----
 arch/arm/mach-ux500/platsmp.c    |   10 ++++------
 5 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index df6ef1b..7381f56 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -193,12 +193,10 @@ void __init smp_init_cpus(void)
 	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "EXYNOS4: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
+	if (ncores > nr_cpu_ids) {
+		pr_warn("EXYNOS4: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index ce65e93..ec95516 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,12 +109,10 @@ void __init smp_init_cpus(void)
 	ncores = scu_get_core_count(scu_base);
 
 	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "OMAP4: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
+	if (ncores > nr_cpu_ids) {
+		pr_warn("OMAP4: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 4ae943b..4b33a72 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -52,12 +52,10 @@ void __init smp_init_cpus(void)
 	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "Realview: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
+	if (ncores > nr_cpu_ids) {
+		pr_warn("Realview: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 0886cbc..f779d5e 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -114,10 +114,10 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores = scu_get_core_count(scu_base);
 
-	if (ncores > NR_CPUS) {
-		printk(KERN_ERR "Tegra: no. of cores (%u) greater than configured (%u), clipping\n",
-			ncores, NR_CPUS);
-		ncores = NR_CPUS;
+	if (ncores > nr_cpu_ids) {
+		pr_warn("Tegra: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a33df5f..3af3e5c 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -156,12 +156,10 @@ void __init smp_init_cpus(void)
 	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "U8500: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
+	if (ncores > nr_cpu_ids) {
+		pr_warn("U8500: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
