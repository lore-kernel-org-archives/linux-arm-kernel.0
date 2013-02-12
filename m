From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 00:45:34 +0900
Subject: [PATCH 06/06] ARM: shmobile: Remove emev2_get_core_count()
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
References: <20130212154438.13067.77359.sendpatchset@w520>
Message-ID: <20130212154534.13067.45412.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-emev2.c
by getting rid of the emev2_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-emev2.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- 0007/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-02-12 23:51:54.000000000 +0900
@@ -50,18 +50,6 @@ static void modify_scu_cpu_psr(unsigned
 
 }
 
-static unsigned int __init emev2_get_core_count(void)
-{
-	if (!scu_base) {
-		scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
-		emev2_clock_init(); /* need ioremapped SMU */
-	}
-
-	WARN_ON_ONCE(!scu_base);
-
-	return scu_base ? scu_get_core_count(scu_base) : 1;
-}
-
 static void __cpuinit emev2_secondary_init(unsigned int cpu)
 {
 	gic_secondary_init(0);
@@ -93,7 +81,14 @@ static void __init emev2_smp_prepare_cpu
 
 static void __init emev2_smp_init_cpus(void)
 {
-	unsigned int ncores = emev2_get_core_count();
+	unsigned int ncores;
+
+	if (!scu_base) {
+		scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
+		emev2_clock_init(); /* need ioremapped SMU */
+	}
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	shmobile_smp_init_cpus(ncores);
 }
