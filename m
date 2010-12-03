From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:23:41 +0000
Subject: [PATCH 14/22] ARM: SMP: Clean up ncores sanity checks
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcAP-0007rt-0Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scu_get_core_count() never returns zero cores, so we don't need to
check and correct if ncores is zero.

Tegra was missing the check against NR_CPUS, leading to a potential
bitfield overflow if this becomes the case.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c   |    6 ------
 arch/arm/mach-realview/platsmp.c |    7 -------
 arch/arm/mach-s5pv310/platsmp.c  |    7 -------
 arch/arm/mach-tegra/platsmp.c    |    6 ++++++
 arch/arm/mach-ux500/platsmp.c    |    6 ------
 arch/arm/mach-vexpress/platsmp.c |    7 -------
 6 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 3c87468..5f10f38 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -121,12 +121,6 @@ void __init smp_init_cpus(void)
 	ncores = get_core_count();
 
 	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "OMAP4: strange core count of 0? Default to 1\n");
-		ncores = 1;
-	}
-
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "OMAP4: no. of cores (%d) greater than configured "
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 108e92f..13116cd 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -161,13 +161,6 @@ void __init smp_init_cpus(void)
 	unsigned int i, ncores = get_core_count();
 
 	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "Realview: strange CM count of 0? Default to 1\n");
-
-		ncores = 1;
-	}
-
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "Realview: no. of cores (%d) greater than configured "
diff --git a/arch/arm/mach-s5pv310/platsmp.c b/arch/arm/mach-s5pv310/platsmp.c
index d474426..560ada8 100644
--- a/arch/arm/mach-s5pv310/platsmp.c
+++ b/arch/arm/mach-s5pv310/platsmp.c
@@ -130,13 +130,6 @@ void __init smp_init_cpus(void)
 	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "S5PV310: strange CM count of 0? Default to 1\n");
-
-		ncores = 1;
-	}
-
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "S5PV310: no. of cores (%d) greater than configured "
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 1c0fd92..5b194dd 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -117,6 +117,12 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores = scu_get_core_count(scu_base);
 
+	if (ncores > NR_CPUS) {
+		printk(KERN_ERR "Tegra: no. of cores (%u) greater than configured (%u), clipping\n",
+			ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
 	for (i = 0; i < ncores; i++)
 		cpu_set(i, cpu_possible_map);
 }
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a51962b..e31024e 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -129,12 +129,6 @@ void __init smp_init_cpus(void)
 	unsigned int i, ncores = get_core_count();
 
 	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "U8500: strange CM count of 0? Default to 1\n");
-		ncores = 1;
-	}
-
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "U8500: no. of cores (%d) greater than configured "
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 276f916..b5a7586 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -124,13 +124,6 @@ void __init smp_init_cpus(void)
 	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
-	if (ncores == 0) {
-		printk(KERN_ERR
-		       "vexpress: strange CM count of 0? Default to 1\n");
-
-		ncores = 1;
-	}
-
 	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "vexpress: no. of cores (%d) greater than configured "
-- 
1.6.2.5
