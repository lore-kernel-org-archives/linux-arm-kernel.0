From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:24:01 +0000
Subject: [PATCH 15/22] ARM: SMP: get rid of get_core_count()
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcAj-0007rx-Eb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need this small function as well as scu_get_core_count()

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap-smp.c   |   12 +-----------
 arch/arm/mach-realview/platsmp.c |   13 ++++---------
 arch/arm/mach-ux500/platsmp.c    |    9 +++------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 5f10f38..405a8fc 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -29,16 +29,6 @@
 /* SCU base address */
 static void __iomem *scu_base;
 
-/*
- * Use SCU config register to count number of cores
- */
-static inline unsigned int get_core_count(void)
-{
-	if (scu_base)
-		return scu_get_core_count(scu_base);
-	return 1;
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -118,7 +108,7 @@ void __init smp_init_cpus(void)
 	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
 	BUG_ON(!scu_base);
 
-	ncores = get_core_count();
+	ncores = scu_get_core_count(scu_base);
 
 	/* sanity check */
 	if (ncores > NR_CPUS) {
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 13116cd..6595e87 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -50,14 +50,6 @@ static void __iomem *scu_base_addr(void)
 		return (void __iomem *)0;
 }
 
-static inline unsigned int get_core_count(void)
-{
-	void __iomem *scu_base = scu_base_addr();
-	if (scu_base)
-		return scu_get_core_count(scu_base);
-	return 1;
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -158,7 +150,10 @@ static void __init poke_milo(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = get_core_count();
+	void __iomem *scu_base = scu_base_addr();
+	unsigned int i, ncores;
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
 
 	/* sanity check */
 	if (ncores > NR_CPUS) {
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index e31024e..fd40fa1 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -28,11 +28,6 @@
  */
 volatile int __cpuinitdata pen_release = -1;
 
-static unsigned int __init get_core_count(void)
-{
-	return scu_get_core_count(__io_address(UX500_SCU_BASE));
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 void __cpuinit platform_secondary_init(unsigned int cpu)
@@ -126,7 +121,9 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores = get_core_count();
+	unsigned int i, ncores;
+
+	ncores = scu_get_core_count(__io_address(UX500_SCU_BASE));
 
 	/* sanity check */
 	if (ncores > NR_CPUS) {
-- 
1.6.2.5
