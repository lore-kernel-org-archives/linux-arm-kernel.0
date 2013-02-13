From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 13 Feb 2013 22:46:38 +0900
Subject: [PATCH 01/06] ARM: shmobile: Kill off sh73a0 scu_base_addr() function
In-Reply-To: <20130213134628.12153.47120.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
Message-ID: <20130213134638.12153.54737.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace scu_base_addr() with a static shmobile_scu_base
variable and introduce SH73A0_SCU_BASE.

Later in the series the shmobile_scu_base variable will be
made into a global variable so this is preparation only.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- 0006/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-02-12 23:13:14.000000000 +0900
@@ -39,13 +39,12 @@
 
 #define PSTR_SHUTDOWN_MODE	3
 
-static void __iomem *scu_base_addr(void)
-{
-	return (void __iomem *)0xf0000000;
-}
+#define SH73A0_SCU_BASE IOMEM(0xf0000000)
+
+static void __iomem *shmobile_scu_base;
 
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
 void __init sh73a0_register_twd(void)
 {
 	twd_local_timer_register(&twd_local_timer);
@@ -71,21 +70,22 @@ static int __cpuinit sh73a0_boot_seconda
 
 static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
-	scu_enable(scu_base_addr());
+	scu_enable(shmobile_scu_base);
 
 	/* Map the reset vector (in headsmp-sh73a0.S) */
 	__raw_writel(0, APARMBAREA);      /* 4k */
 	__raw_writel(__pa(sh73a0_secondary_vector), SBAR);
 
 	/* enable cache coherency on booting CPU */
-	scu_power_mode(scu_base_addr(), SCU_PM_NORMAL);
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
 }
 
 static void __init sh73a0_smp_init_cpus(void)
 {
-	unsigned int ncores = scu_get_core_count(scu_base_addr());
+	/* setup sh73a0 specific SCU base */
+	shmobile_scu_base = SH73A0_SCU_BASE;
 
-	shmobile_smp_init_cpus(ncores);
+	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -121,7 +121,7 @@ static void sh73a0_cpu_die(unsigned int
 	flush_cache_all();
 
 	/* Set power off mode. This takes the CPU out of the MP cluster */
-	scu_power_mode(scu_base_addr(), SCU_PM_POWEROFF);
+	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
 
 	/* Enter shutdown mode */
 	cpu_do_idle();
