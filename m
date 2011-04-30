From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:17 -0500
Subject: [PATCH 10/10] ARM: move set_cpu_present calls to common smp code
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

All platforms do the same thing and mark all cores present, so move this to
common smp init code. A platform can still override this and mark a core not
present if that is ever desired.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/smp.c             |    4 ++++
 arch/arm/mach-msm/platsmp.c       |   11 +----------
 arch/arm/mach-omap2/omap-smp.c    |    9 ---------
 arch/arm/mach-realview/platsmp.c  |    9 ---------
 arch/arm/mach-shmobile/platsmp.c  |    5 -----
 arch/arm/mach-ux500/platsmp.c     |    9 ---------
 arch/arm/mach-vexpress/ct-ca9x4.c |    4 ----
 arch/arm/mach-vexpress/platsmp.c  |    5 +----
 8 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8fe05ad..ccb912d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -351,6 +351,7 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	int i;
 	unsigned int ncores = num_possible_cpus();
 
 	smp_store_cpu_info(smp_processor_id());
@@ -361,6 +362,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	if (max_cpus > ncores)
 		max_cpus = ncores;
 
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
 	if (max_cpus > 1) {
 		/*
 		 * Enable the local timer or broadcast device for the
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 4315bb5..3ee7151 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -87,13 +87,4 @@ void __init smp_init_cpus(void)
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-{
-	int i;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-}
+{}
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 831c8a0..dfcc9ac 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -108,15 +108,6 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	/*
 	 * Initialise the SCU and wake up the secondary core using
 	 * wakeup_secondary().
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 655a93b..dc57494 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -48,15 +48,6 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	scu_enable(scu_base_addr());
 
 	/*
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index c681333..a9bdcda 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -50,10 +50,5 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	shmobile_smp_prepare_cpus();
 }
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 7b19f9d..f8dd320 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -74,15 +74,6 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated at the present time.
-	 */
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	scu_enable(scu_base_addr());
 	wakeup_secondary();
 }
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 4d1476f..aa366f1 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -211,10 +211,6 @@ static void ct_ca9x4_init_cpu_map(void)
 
 static void ct_ca9x4_smp_enable(unsigned int max_cpus)
 {
-	int i;
-	for (i = 0; i < max_cpus; i++)
-		set_cpu_present(i, true);
-
 	scu_enable(MMIO_P2V(A9_MPCORE_SCU));
 }
 #endif
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 7fa0b68..0c301ed 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -31,10 +31,7 @@ void __init smp_init_cpus(void)
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
-	/*
-	 * Initialise the present map, which describes the set of CPUs
-	 * actually populated@the present time.
-	 */
+	/* Enable the SCU */
 	ct_desc->smp_enable(max_cpus);
 
 	/*
-- 
1.7.1
