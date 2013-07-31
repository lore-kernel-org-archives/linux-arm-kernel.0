From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 16:07:21 +0900
Subject: [PATCH 02/07] ARM: shmobile: Use shared SCU SMP boot code on sh73a0
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130731070721.14444.80422.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use shared SCU code on sh73a0 for SMP boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile     |    2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-29 21:40:18.000000000 +0900
@@ -17,7 +17,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
 
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
-smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
+smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
--- 0002/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-07-29 21:41:27.000000000 +0900
@@ -50,30 +50,30 @@ void __init sh73a0_register_twd(void)
 
 static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	cpu = cpu_logical_map(cpu);
+	unsigned int lcpu = cpu_logical_map(cpu);
+	int ret;
 
-	if (((__raw_readl(PSTR) >> (4 * cpu)) & 3) == 3)
-		__raw_writel(1 << cpu, WUPCR);	/* wake up */
+	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
+	if (ret)
+		return ret;
+
+	if (((__raw_readl(PSTR) >> (4 * lcpu)) & 3) == 3)
+		__raw_writel(1 << lcpu, WUPCR);	/* wake up */
 	else
-		__raw_writel(1 << cpu, SRESCR);	/* reset */
+		__raw_writel(1 << lcpu, SRESCR);	/* reset */
 
 	return 0;
 }
 
 static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
-	/* setup sh73a0 specific SCU base */
-	shmobile_scu_base = IOMEM(SH73A0_SCU_BASE);
-	scu_enable(shmobile_scu_base);
-
-	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
+	/* Map the reset vector (in headsmp.S) */
 	__raw_writel(0, APARMBAREA);      /* 4k */
 	__raw_writel(__pa(shmobile_boot_vector), SBAR);
-	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
-	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
-	/* enable cache coherency on booting CPU */
-	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+	/* setup sh73a0 specific SCU bits */
+	shmobile_scu_base = IOMEM(SH73A0_SCU_BASE);
+	shmobile_smp_scu_prepare_cpus(max_cpus);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
