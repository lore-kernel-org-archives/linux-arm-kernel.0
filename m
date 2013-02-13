From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 22:46:57 +0900
Subject: [PATCH 03/06] ARM: shmobile: Rework EMEV2 scu_base variable
In-Reply-To: <20130213134628.12153.47120.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
Message-ID: <20130213134657.12153.27160.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename the static scu_base variable into shmobile_scu_base.

Later in the series the shmobile_scu_base variable will be
made into a global variable so this is preparation only.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-emev2.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-02-13 21:01:25.000000000 +0900
@@ -32,8 +32,9 @@
 
 #define EMEV2_SCU_BASE 0x1e000000
 
+static void __iomem *shmobile_scu_base;
+
 static DEFINE_SPINLOCK(scu_lock);
-static void __iomem *scu_base;
 
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
@@ -42,10 +43,10 @@ static void modify_scu_cpu_psr(unsigned
 	/* we assume this code is running on a different cpu
 	 * than the one that is changing coherency setting */
 	spin_lock(&scu_lock);
-	tmp = readl(scu_base + 8);
+	tmp = readl(shmobile_scu_base + 8);
 	tmp &= ~clr;
 	tmp |= set;
-	writel(tmp, scu_base + 8);
+	writel(tmp, shmobile_scu_base + 8);
 	spin_unlock(&scu_lock);
 
 }
@@ -70,7 +71,7 @@ static void __init emev2_smp_prepare_cpu
 {
 	int cpu = cpu_logical_map(0);
 
-	scu_enable(scu_base);
+	scu_enable(shmobile_scu_base);
 
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
@@ -83,12 +84,12 @@ static void __init emev2_smp_init_cpus(v
 {
 	unsigned int ncores;
 
-	if (!scu_base) {
-		scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
+	if (!shmobile_scu_base) {
+		shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
 		emev2_clock_init(); /* need ioremapped SMU */
 	}
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	ncores = shmobile_scu_base ? scu_get_core_count(shmobile_scu_base) : 1;
 
 	shmobile_smp_init_cpus(ncores);
 }
