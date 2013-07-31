From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 31 Jul 2013 16:07:49 +0900
Subject: [PATCH 05/07] ARM: shmobile: Add shared SCU CPU Hotplug code
In-Reply-To: <20130731070702.14444.64961.sendpatchset@w520>
References: <20130731070702.14444.64961.sendpatchset@w520>
Message-ID: <20130731070749.14444.18254.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add CPU Hotplug functions for SCU equipped mach-shmobile SoCs.

The functions shmobile_smp_scu_cpu_die() together with
shmobile_smp_scu_cpu_kill() perform basic shutdown and
allows checking of shutdown status. These are written
to work together with SMP boot code in  headsmp-scu.S.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/platsmp-scu.c         |   45 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

--- 0004/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-07-29 16:59:06.000000000 +0900
@@ -14,6 +14,8 @@ extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
 					   struct task_struct *idle);
+extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
+extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
--- 0004/arch/arm/mach-shmobile/platsmp-scu.c
+++ work/arch/arm/mach-shmobile/platsmp-scu.c	2013-07-29 16:58:43.000000000 +0900
@@ -7,9 +7,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/smp.h>
+#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <mach/common.h>
@@ -29,3 +31,46 @@ int shmobile_smp_scu_boot_secondary(unsi
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+void shmobile_smp_scu_cpu_die(unsigned int cpu)
+{
+	dsb();
+	flush_cache_all();
+
+	/* disable cache coherency */
+	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
+
+	/* Endless loop until reset */
+	while (1)
+		cpu_do_idle();
+}
+
+static int shmobile_smp_scu_psr_core_disabled(int cpu)
+{
+	unsigned long mask = SCU_PM_POWEROFF << (cpu * 8);
+
+	if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
+		return 1;
+
+	return 0;
+}
+
+int shmobile_smp_scu_cpu_kill(unsigned int cpu)
+{
+	int k;
+
+	/* this function is running on another CPU than the offline target,
+	 * here we need wait for shutdown code in platform_cpu_die() to
+	 * finish before asking SoC-specific code to power off the CPU core.
+	 */
+	for (k = 0; k < 1000; k++) {
+		if (shmobile_smp_scu_psr_core_disabled(cpu))
+			return 1;
+
+		mdelay(1);
+	}
+
+	return 0;
+}
+#endif
