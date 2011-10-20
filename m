From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 12:25:52 +0100
Subject: [PATCH] arm: fix handling of nr_cpus
In-Reply-To: <1318943804.2346.15.camel@deneb.redhat.com>
References: <1318339864-32396-1-git-send-email-msalter@redhat.com>
	<20111012172628.GC21648@n2100.arm.linux.org.uk>
	<1318508268.2300.67.camel@deneb.redhat.com>
	<20111013151004.GF21648@n2100.arm.linux.org.uk>
	<1318943804.2346.15.camel@deneb.redhat.com>
Message-ID: <20111020112552.GY21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 09:16:43AM -0400, Mark Salter wrote:
> That's fine by me. mach-msm, mach-shmobile, and mach-vexpress also need
> patching. They currently don't clip against NR_CPUS.

So more like this then?

 arch/arm/mach-exynos4/platsmp.c   |   10 ++++------
 arch/arm/mach-msm/platsmp.c       |    6 ++++++
 arch/arm/mach-omap2/omap-smp.c    |   10 ++++------
 arch/arm/mach-realview/platsmp.c  |   10 ++++------
 arch/arm/mach-shmobile/platsmp.c  |    6 ++++++
 arch/arm/mach-tegra/platsmp.c     |    8 ++++----
 arch/arm/mach-ux500/platsmp.c     |   10 ++++------
 arch/arm/mach-vexpress/ct-ca9x4.c |    6 ++++++
 8 files changed, 38 insertions(+), 28 deletions(-)

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
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 1a1af9e..7276595 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -156,6 +156,12 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores = get_core_count();
 
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
 
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
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
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
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index 66f9806..e4e485f 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -56,6 +56,12 @@ void __init smp_init_cpus(void)
 	unsigned int ncores = shmobile_smp_get_core_count();
 	unsigned int i;
 
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
 	for (i = 0; i < ncores; i++)
 		set_cpu_possible(i, true);
 
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
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
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
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
 	}
 
 	for (i = 0; i < ncores; i++)
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index bfd32f5..2b1e836 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -221,6 +221,12 @@ static void ct_ca9x4_init_cpu_map(void)
 {
 	int i, ncores = scu_get_core_count(MMIO_P2V(A9_MPCORE_SCU));
 
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+			ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
 	for (i = 0; i < ncores; ++i)
 		set_cpu_possible(i, true);
 
