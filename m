From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 16:07:40 +0900
Subject: [PATCH 04/07] ARM: shmobile: Use shared SCU SMP boot code on emev2
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130731070740.14444.10398.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use shared SCU code on emev2 for SMP boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile    |    2 +-
 arch/arm/mach-shmobile/smp-emev2.c |   19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

--- 0004/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-31 11:58:03.000000000 +0900
@@ -34,7 +34,7 @@ endif
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
-smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
+smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-07-31 11:58:39.000000000 +0900
@@ -34,6 +34,12 @@
 
 static int emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	int ret;
+
+	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
+	if (ret)
+		return ret;
+
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
 }
@@ -42,21 +48,16 @@ static void __init emev2_smp_prepare_cpu
 {
 	void __iomem *smu;
 
-	/* setup EMEV2 specific SCU base, enable */
-	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
-	scu_enable(shmobile_scu_base);
-
-	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
+	/* Tell ROM loader about our vector (in headsmp.S) */
 	smu = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
 	if (smu) {
 		iowrite32(__pa(shmobile_boot_vector), smu + SMU_GENERAL_REG0);
 		iounmap(smu);
 	}
-	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
-	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
-	/* enable cache coherency on booting CPU */
-	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+	/* setup EMEV2 specific SCU bits */
+	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
+	shmobile_smp_scu_prepare_cpus(max_cpus);
 }
 
 struct smp_operations emev2_smp_ops __initdata = {
