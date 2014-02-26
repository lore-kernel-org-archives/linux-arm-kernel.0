From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 27 Feb 2014 08:13:35 +0900
Subject: [PATCH 01/02] ARM: shmobile: Hook in MCPM and CCI to APMU code
In-Reply-To: <20140226231326.4303.71886.sendpatchset@w520>
References: <20140226231326.4303.71886.sendpatchset@w520>
Message-ID: <20140226231335.4303.85826.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add MCPM and CCI hooks to the shared APMU code to allow
multicluster operation on r8a7790. Tested with SMP boot
and CPU Hotplug on r8a7790 Lager.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp.S             |    7 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/platsmp-apmu.c        |  111 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/platsmp.c             |    4 
 4 files changed, 116 insertions(+), 7 deletions(-)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2014-02-27 00:57:50.000000000 +0900
@@ -19,6 +19,13 @@ ENTRY(shmobile_invalidate_start)
 	b	secondary_startup
 ENDPROC(shmobile_invalidate_start)
 
+#ifdef CONFIG_MCPM
+ENTRY(shmobile_invalidate_mcpm_entry)
+	bl	v7_invalidate_l1
+	b	mcpm_entry_point
+ENDPROC(shmobile_invalidate_mcpm_entry)
+#endif
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2014-02-27 00:57:50.000000000 +0900
@@ -16,6 +16,7 @@ extern void shmobile_smp_hook(unsigned i
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
+extern void shmobile_invalidate_mcpm_entry(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
--- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-02-27 00:57:50.000000000 +0900
@@ -7,22 +7,28 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/arm-cci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
+#include <asm/mcpm.h>
 #include <asm/smp_plat.h>
 #include <mach/common.h>
 
-static struct {
+static struct apmu_cpu {
 	void __iomem *iomem;
 	int bit;
 } apmu_cpus[CONFIG_NR_CPUS];
 
+#define MAX_NR_CLUSTERS 2
+static struct apmu_cpu *apmu_clst2cpu[MAX_NR_CLUSTERS][CONFIG_NR_CPUS];
+
 #define WUPCR_OFFS 0x10
 #define PSTR_OFFS 0x40
 #define CPUNCR_OFFS(n) (0x100 + (0x10 * (n)))
@@ -69,14 +75,23 @@ static int apmu_wrap(int cpu, int (*fn)(
 
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
+	u32 id;
+	int mcpm_cpu, mcpm_cluster;
+
 	if (apmu_cpus[cpu].iomem)
 		return;
 
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
 	apmu_cpus[cpu].bit = bit;
 
-	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x\n", cpu, bit,
-		 res->start, resource_size(res));
+	id = cpu_logical_map(cpu);
+	mcpm_cpu = MPIDR_AFFINITY_LEVEL(id, 0);
+	mcpm_cluster = MPIDR_AFFINITY_LEVEL(id, 1);
+
+	pr_debug("apmu ioremap %d %d %pr %d %d\n",
+		 cpu, bit, res, mcpm_cluster, mcpm_cpu);
+
+	apmu_clst2cpu[mcpm_cluster][mcpm_cpu] = &apmu_cpus[cpu];
 }
 
 static struct {
@@ -93,7 +108,8 @@ static struct {
 	}
 };
 
-static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit))
+static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
+			   bool allow_multicluster)
 {
 	u32 id;
 	int k;
@@ -110,7 +126,8 @@ static void apmu_parse_cfg(void (*fn)(st
 					is_allowed = true;
 			}
 		}
-		if (!is_allowed)
+
+		if (!allow_multicluster && !is_allowed)
 			continue;
 
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
@@ -124,14 +141,19 @@ static void apmu_parse_cfg(void (*fn)(st
 	}
 }
 
+static int __init shmobile_smp_apmu_cci_init(void);
+
 void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
 	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
-	/* perform per-cpu setup */
-	apmu_parse_cfg(apmu_init_cpu);
+	/* allow multi-cluster operation in case CCI is detected */
+	if (IS_ENABLED(CONFIG_ARM_CCI) && !shmobile_smp_apmu_cci_init())
+		apmu_parse_cfg(apmu_init_cpu, true);
+	else
+		apmu_parse_cfg(apmu_init_cpu, false);
 }
 
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -192,4 +214,79 @@ int shmobile_smp_apmu_cpu_kill(unsigned
 {
 	return apmu_wrap(cpu, apmu_power_off_poll);
 }
+#else
+#define shmobile_smp_apmu_cpu_die() shmobile_smp_sleep()
+static inline int shmobile_smp_apmu_cpu_kill(void) { return -ENOTSUPP; }
 #endif
+
+#if defined(CONFIG_MCPM) && defined(CONFIG_ARM_CCI)
+static void __naked apmu_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile ("cmp	r0, #1\n"
+		      "bxne	lr\n"
+		      "b	cci_enable_port_for_self ");
+}
+
+static int apmu_power_up(unsigned int cpu, unsigned int cluster)
+{
+	struct apmu_cpu *ac = apmu_clst2cpu[cluster][cpu];
+	if (!ac)
+		return -EINVAL;
+
+	shmobile_smp_hook(ac - &apmu_cpus[0],
+			  virt_to_phys(shmobile_invalidate_mcpm_entry), 0);
+
+	return apmu_wrap(ac - &apmu_cpus[0], apmu_power_on);
+}
+
+static void apmu_power_down(void)
+{
+	shmobile_smp_apmu_cpu_die(smp_processor_id());
+}
+
+static int apmu_power_down_finish(unsigned int cpu, unsigned int cluster)
+{
+	struct apmu_cpu *ac = apmu_clst2cpu[cluster][cpu];
+	int ret = -EINVAL;
+
+	if (ac)
+		ret = shmobile_smp_apmu_cpu_kill(ac - &apmu_cpus[0]);
+
+	return ret < 0 ? ret : 0;
+}
+
+static const struct mcpm_platform_ops apmu_pm_power_ops = {
+	.power_up = apmu_power_up,
+	.power_down = apmu_power_down,
+	.power_down_finish = apmu_power_down_finish,
+};
+
+static int __init shmobile_smp_apmu_mcpm_hook(void)
+{
+	int ret;
+
+	mcpm_smp_set_ops();
+
+	ret = mcpm_platform_register(&apmu_pm_power_ops);
+	if (!ret) {
+		if (cci_probed())
+			mcpm_sync_init(apmu_power_up_setup);
+
+		pr_info("APMU MCPM power management initialized\n");
+	}
+	return ret;
+}
+#else
+static inline int shmobile_smp_apmu_mcpm_hook(void) { return 0; }
+#endif
+
+static int __init shmobile_smp_apmu_cci_init(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
+	if (node && of_device_is_available(node))
+		return shmobile_smp_apmu_mcpm_hook();
+
+	return -ENODEV;
+}
--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2014-02-27 00:57:50.000000000 +0900
@@ -28,6 +28,10 @@ void shmobile_smp_hook(unsigned int cpu,
 	shmobile_smp_fn[cpu] = fn;
 	shmobile_smp_arg[cpu] = arg;
 	flush_cache_all();
+
+	sync_cache_w(&shmobile_smp_mpidr[cpu]);
+	sync_cache_w(&shmobile_smp_fn[cpu]);
+	sync_cache_w(&shmobile_smp_arg[cpu]);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
