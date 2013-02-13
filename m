From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 22:46:48 +0900
Subject: [PATCH 02/06] ARM: shmobile: Kill off r8a7779 scu_base_addr() function
In-Reply-To: <20130213134628.12153.47120.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
Message-ID: <20130213134648.12153.96101.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace scu_base_addr() with a static shmobile_scu_base
variable and introduce R8A7779_SCU_BASE.

Later in the series the shmobile_scu_base variable will be
made into a global variable so this is preparation only.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-02-13 20:52:34.000000000 +0900
@@ -31,6 +31,9 @@
 #include <asm/smp_twd.h>
 
 #define AVECR IOMEM(0xfe700040)
+#define R8A7779_SCU_BASE IOMEM(0xf0000000)
+
+static void __iomem *shmobile_scu_base;
 
 static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
@@ -56,11 +59,6 @@ static struct r8a7779_pm_ch *r8a7779_ch_
 	[3] = &r8a7779_ch_cpu3,
 };
 
-static void __iomem *scu_base_addr(void)
-{
-	return (void __iomem *)0xf0000000;
-}
-
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
@@ -75,7 +73,7 @@ void __init r8a7779_register_twd(void)
 
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
-	void __iomem *scu_base = scu_base_addr();
+	void __iomem *scu_base = shmobile_scu_base;
 
 	spin_lock(&scu_lock);
 	tmp = __raw_readl(scu_base + 8);
@@ -153,7 +151,7 @@ static void __init r8a7779_smp_prepare_c
 {
 	int cpu = cpu_logical_map(0);
 
-	scu_enable(scu_base_addr());
+	scu_enable(shmobile_scu_base);
 
 	/* Map the reset vector (in headsmp.S) */
 	__raw_writel(__pa(shmobile_secondary_vector), AVECR);
@@ -171,9 +169,10 @@ static void __init r8a7779_smp_prepare_c
 
 static void __init r8a7779_smp_init_cpus(void)
 {
-	unsigned int ncores = scu_get_core_count(scu_base_addr());
+	/* setup r8a7779 specific SCU base */
+	shmobile_scu_base = R8A7779_SCU_BASE;
 
-	shmobile_smp_init_cpus(ncores);
+	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
 
 struct smp_operations r8a7779_smp_ops  __initdata = {
