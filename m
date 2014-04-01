From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  1 Apr 2014 16:03:48 +0800
Subject: [PATCH v1 6/8] ARM: hisi: add hip04 SoC support
In-Reply-To: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396339430-21084-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
Cortex A15 Core. And HiP04 supports LPAE to support large memory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig               |   2 +-
 arch/arm/mach-hisi/Kconfig     |  10 ++
 arch/arm/mach-hisi/core.h      |   6 +
 arch/arm/mach-hisi/hisilicon.c |  17 +++
 arch/arm/mach-hisi/platsmp.c   | 257 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48712e..3f2e973 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1107,7 +1107,7 @@ source arch/arm/mm/Kconfig
 
 config ARM_NR_BANKS
 	int
-	default 16 if ARCH_EP93XX
+	default 16 if ARCH_EP93XX || ARCH_HIP04
 	default 8
 
 config IWMMXT
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index da16efd..707abfe 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -19,6 +19,16 @@ config ARCH_HI3xxx
 	help
 	  Support for Hisilicon Hi36xx/Hi37xx processor family
 
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select ARM_LPAE
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
+	select MCPM
+	select SMP
+	help
+	  Support for Hisilicon HiP04 processor family
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index af23ec2..e008c7a 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -12,4 +12,10 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
+#define HIP04_BOOTWRAPPER_PHYS		0x10c00000
+#define HIP04_BOOTWRAPPER_MAGIC		0xa5a5a5a5
+#define HIP04_BOOTWRAPPER_SIZE		0x00010000
+
+extern bool __init hip04_smp_init_ops(void);
+
 #endif
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..ca277de 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -14,6 +14,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
+#include <linux/memblock.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
@@ -88,3 +89,19 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
 MACHINE_END
+
+static const char *hip04_compat[] __initconst = {
+	"hisilicon,hip04-d01",
+	NULL,
+};
+
+static void __init hip04_reserve(void)
+{
+	memblock_reserve(HIP04_BOOTWRAPPER_PHYS, HIP04_BOOTWRAPPER_SIZE);
+}
+
+DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
+	.dt_compat	= hip04_compat,
+	.smp_init	= smp_init_ops(hip04_smp_init_ops),
+	.reserve	= hip04_reserve,
+MACHINE_END
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 471f1ee..a0082d7 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -9,9 +9,13 @@
  */
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/mcpm.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
@@ -87,3 +91,256 @@ struct smp_operations hi3xxx_smp_ops __initdata = {
 	.cpu_kill		= hi3xxx_cpu_kill,
 #endif
 };
+
+/* bits definition in SC_CPU_RESET_REQ[x]/SC_CPU_RESET_DREQ[x]
+ * 1 -- unreset; 0 -- reset
+ */
+#define CORE_RESET_BIT(x)		(1 << x)
+#define NEON_RESET_BIT(x)		(1 << (x + 4))
+#define CORE_DEBUG_RESET_BIT(x)		(1 << (x + 9))
+#define CLUSTER_L2_RESET_BIT		(1 << 8)
+#define CLUSTER_DEBUG_RESET_BIT		(1 << 13)
+
+/*
+ * bits definition in SC_CPU_RESET_STATUS[x]
+ * 1 -- reset status; 0 -- unreset status
+ */
+#define CORE_RESET_STATUS(x)		(1 << x)
+#define NEON_RESET_STATUS(x)		(1 << (x + 4))
+#define CORE_DEBUG_RESET_STATUS(x)	(1 << (x + 9))
+#define CLUSTER_L2_RESET_STATUS		(1 << 8)
+#define CLUSTER_DEBUG_RESET_STATUS	(1 << 13)
+#define CORE_WFI_STATUS(x)		(1 << (x + 16))
+#define CORE_WFE_STATUS(x)		(1 << (x + 20))
+#define CORE_DEBUG_ACK(x)		(1 << (x + 24))
+
+#define SC_CPU_RESET_REQ(x)		(0x520 + (x << 3))	/* reset */
+#define SC_CPU_RESET_DREQ(x)		(0x524 + (x << 3))	/* unreset */
+#define SC_CPU_RESET_STATUS(x)		(0x1520 + (x << 3))
+
+#define FAB_SF_MODE			0x0c
+#define FAB_SF_INVLD			0x10
+
+/* bits definition in FB_SF_INVLD */
+#define FB_SF_INVLD_START		(1 << 8)
+
+#define HIP04_MAX_CLUSTERS		4
+#define HIP04_MAX_CPUS_PER_CLUSTER	4
+
+static void __iomem *relocation = NULL, *sysctrl = NULL, *fabric = NULL;
+static int hip04_cpu_table[HIP04_MAX_CLUSTERS][HIP04_MAX_CPUS_PER_CLUSTER];
+static DEFINE_SPINLOCK(boot_lock);
+
+static bool hip04_cluster_down(unsigned int cluster)
+{
+	int i;
+
+	for (i = 0; i < HIP04_MAX_CPUS_PER_CLUSTER; i++)
+		if (hip04_cpu_table[cluster][i])
+			return false;
+	return true;
+}
+
+static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
+{
+	unsigned long data;
+
+	if (!fabric)
+		return;
+	data = readl_relaxed(fabric + FAB_SF_MODE);
+	if (on)
+		data |= 1 << cluster;
+	else
+		data &= ~(1 << cluster);
+	writel_relaxed(data, fabric + FAB_SF_MODE);
+	while (1) {
+		if (data == readl_relaxed(fabric + FAB_SF_MODE))
+			break;
+	}
+}
+
+static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
+{
+	unsigned long data, mask;
+
+	if (!relocation || !sysctrl)
+		return -ENODEV;
+	if (cluster >= HIP04_MAX_CLUSTERS || cpu >= HIP04_MAX_CPUS_PER_CLUSTER)
+		return -EINVAL;
+
+	spin_lock(&boot_lock);
+	writel_relaxed(HIP04_BOOTWRAPPER_PHYS, relocation);
+	writel_relaxed(HIP04_BOOTWRAPPER_MAGIC, relocation + 4);
+	writel_relaxed(virt_to_phys(mcpm_entry_point), relocation + 8);
+	writel_relaxed(0, relocation + 12);
+
+	if (hip04_cluster_down(cluster)) {
+		data = CLUSTER_L2_RESET_BIT | CLUSTER_DEBUG_RESET_BIT;
+		writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
+		do {
+			mask = CLUSTER_L2_RESET_STATUS | \
+			       CLUSTER_DEBUG_RESET_STATUS;
+			data = readl_relaxed(sysctrl + \
+					     SC_CPU_RESET_STATUS(cluster));
+		} while (data & mask);
+		hip04_set_snoop_filter(cluster, 1);
+	}
+
+	hip04_cpu_table[cluster][cpu]++;
+
+	data = CORE_RESET_BIT(cpu) | NEON_RESET_BIT(cpu) | \
+	       CORE_DEBUG_RESET_BIT(cpu);
+	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
+	spin_unlock(&boot_lock);
+
+	return 0;
+}
+
+static void hip04_mcpm_power_down(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	unsigned int v;
+
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	local_irq_disable();
+	gic_cpu_if_down();
+
+	__mcpm_cpu_down(cpu, cluster);
+
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "Ir" (CR_C)
+	  : "cc");
+
+	flush_cache_louis();
+
+	asm volatile(
+	/*
+	* Turn off coherency
+	*/
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, %1\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (0x40)
+	: "cc");
+
+	isb();
+	dsb();
+}
+
+static int hip04_mcpm_power_down_finish(unsigned int cpu, unsigned int cluster)
+{
+	int ret = -EBUSY;
+
+	spin_lock(&boot_lock);
+	BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
+	__mcpm_cpu_going_down(cpu, cluster);
+
+	hip04_cpu_table[cluster][cpu]--;
+	if (hip04_cpu_table[cluster][cpu]) {
+		pr_err("Cluster %d CPU%d is still running\n", cluster, cpu);
+		goto out;
+	}
+	ret = 0;
+out:
+	spin_unlock(&boot_lock);
+	return ret;
+}
+
+static void hip04_mcpm_powered_up(void)
+{
+	if (!relocation)
+		return;
+	spin_lock(&boot_lock);
+	writel_relaxed(0, relocation);
+	writel_relaxed(0, relocation + 4);
+	writel_relaxed(0, relocation + 8);
+	writel_relaxed(0, relocation + 12);
+	spin_unlock(&boot_lock);
+}
+
+static const struct mcpm_platform_ops hip04_mcpm_ops = {
+	.power_up		= hip04_mcpm_power_up,
+	.power_down		= hip04_mcpm_power_down,
+	.power_down_finish	= hip04_mcpm_power_down_finish,
+	.powered_up		= hip04_mcpm_powered_up,
+};
+
+static bool __init hip04_cpu_table_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	if (cluster >= HIP04_MAX_CLUSTERS ||
+	    cpu >= HIP04_MAX_CPUS_PER_CLUSTER) {
+		pr_err("%s: boot CPU is out of bound!\n", __func__);
+		return false;
+	}
+	hip04_set_snoop_filter(cluster, 1);
+	hip04_cpu_table[cluster][cpu] = 1;
+	return true;
+}
+
+static int __init hip04_mcpm_init(void)
+{
+	struct device_node *np;
+	int ret = -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-mcpm");
+	if (!np) {
+		pr_err("failed to find hisilicon,hip04-mcpm node\n");
+		goto err;
+	}
+	relocation = of_iomap(np, 0);
+	if (!relocation) {
+		pr_err("failed to get relocation space\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+	sysctrl = of_iomap(np, 1);
+	if (!sysctrl) {
+		pr_err("failed to get sysctrl base\n");
+		ret = -ENOMEM;
+		goto err_sysctrl;
+	}
+	fabric = of_iomap(np, 2);
+	if (!fabric) {
+		pr_err("failed to get fabric base\n");
+		ret = -ENOMEM;
+		goto err_fabric;
+	}
+	if (!hip04_cpu_table_init())
+		return -EINVAL;
+	ret = mcpm_platform_register(&hip04_mcpm_ops);
+	if (!ret) {
+		mcpm_sync_init(NULL);
+		pr_info("HiP04 MCPM initialized\n");
+	}
+	return ret;
+err_fabric:
+	iounmap(sysctrl);
+err_sysctrl:
+	iounmap(relocation);
+err:
+	return ret;
+}
+early_initcall(hip04_mcpm_init);
+
+bool __init hip04_smp_init_ops(void)
+{
+	mcpm_smp_set_ops();
+	return true;
+}
-- 
1.8.3.2
