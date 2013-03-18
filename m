From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:16 +0900
Subject: [PATCH 06/43] ARM: shmobile: Remove emev2_get_core_count()
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Reduce the number of lines of code in smp-emev2.c
by getting rid of the emev2_get_core_count() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-emev2.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 6427821..4ede413 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -50,18 +50,6 @@ static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 
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
@@ -93,7 +81,14 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 
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
-- 
1.7.10.4
