From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:23:20 +0000
Subject: [PATCH 13/22] ARM: SMP: move CPU number sanity checks to
	smp_init_cpus()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcA4-0007rp-JE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the number of CPUs is sanity checked before setting
the number of possible CPUs.  This avoids any chance of overflowing
the cpu_possible bitmap.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c   |   21 +++++++++++----------
 arch/arm/mach-realview/platsmp.c |   20 ++++++++++----------
 arch/arm/mach-ux500/platsmp.c    |   26 +++++++++++++-------------
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 56a8bce..3c87468 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -120,16 +120,6 @@ void __init smp_init_cpus(void)
 
 	ncores = get_core_count();
 
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
-void __init smp_prepare_cpus(unsigned int max_cpus)
-{
-	unsigned int ncores = get_core_count();
-	unsigned int cpu = smp_processor_id();
-	int i;
-
 	/* sanity check */
 	if (ncores == 0) {
 		printk(KERN_ERR
@@ -144,6 +134,17 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		       ncores, NR_CPUS);
 		ncores = NR_CPUS;
 	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
 	smp_store_cpu_info(cpu);
 
 	/*
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index af3d909..108e92f 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -160,16 +160,6 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores = get_core_count();
 
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
-void __init smp_prepare_cpus(unsigned int max_cpus)
-{
-	unsigned int ncores = get_core_count();
-	unsigned int cpu = smp_processor_id();
-	int i;
-
 	/* sanity check */
 	if (ncores == 0) {
 		printk(KERN_ERR
@@ -186,6 +176,16 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		ncores = NR_CPUS;
 	}
 
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
 	smp_store_cpu_info(cpu);
 
 	/*
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index b8987bd..a51962b 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -128,16 +128,6 @@ void __init smp_init_cpus(void)
 {
 	unsigned int i, ncores = get_core_count();
 
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-}
-
-void __init smp_prepare_cpus(unsigned int max_cpus)
-{
-	unsigned int ncores = get_core_count();
-	unsigned int cpu = smp_processor_id();
-	int i;
-
 	/* sanity check */
 	if (ncores == 0) {
 		printk(KERN_ERR
@@ -145,14 +135,24 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		ncores = 1;
 	}
 
-	if (ncores > num_possible_cpus())	{
+	if (ncores > NR_CPUS) {
 		printk(KERN_WARNING
 		       "U8500: no. of cores (%d) greater than configured "
 		       "maximum of %d - clipping\n",
-		       ncores, num_possible_cpus());
-		ncores = num_possible_cpus();
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
 	}
 
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = num_possible_cpus();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
 	smp_store_cpu_info(cpu);
 
 	/*
-- 
1.6.2.5
