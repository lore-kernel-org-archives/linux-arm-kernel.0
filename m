From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 Jan 2018 16:46:53 +0800
Subject: [PATCH v4 7/8] ARM: sun9i: smp: Support cpu0 hotplug
In-Reply-To: <20180117084654.8234-1-wens@csie.org>
References: <20180117084654.8234-1-wens@csie.org>
Message-ID: <20180117084654.8234-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BROM has a branch that checks if the primary core is hotplugging.
If the magic flag is set, execution jumps to the address set in the
software entry register. (Secondary cores always branch to the that
address.)

This patch sets the flags that makes BROM jump execution on the
primary core (cpu0) to the SMP software entry code when the core is
powered back up. After it is re-integrated into the system, the flag
is cleared.

A custom .cpu_can_disable callback that returns true for all cpus,
so that cpu0 can really be brought down.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mc_smp.c | 59 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index fc0acfa07f74..11e46c6efb90 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -65,8 +65,12 @@
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
 
+#define CPU0_SUPPORT_HOTPLUG_MAGIC0	0xFA50392F
+#define CPU0_SUPPORT_HOTPLUG_MAGIC1	0x790DCA3A
+
 static void __iomem *cpucfg_base;
 static void __iomem *prcm_base;
+static void __iomem *sram_b_smp_base;
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -125,6 +129,17 @@ static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
 	return 0;
 }
 
+static void sunxi_cpu0_hotplug_support_set(bool enable)
+{
+	if (enable) {
+		writel(CPU0_SUPPORT_HOTPLUG_MAGIC0, sram_b_smp_base);
+		writel(CPU0_SUPPORT_HOTPLUG_MAGIC1, sram_b_smp_base + 0x4);
+	} else {
+		writel(0x0, sram_b_smp_base);
+		writel(0x0, sram_b_smp_base + 0x4);
+	}
+}
+
 static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	u32 reg;
@@ -133,6 +148,10 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	/* Set hotplug support magic flags for cpu0 */
+	if (cluster == 0 && cpu == 0)
+		sunxi_cpu0_hotplug_support_set(true);
+
 	/* assert processor power-on reset */
 	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
@@ -362,6 +381,13 @@ static bool sunxi_mc_smp_cluster_is_down(unsigned int cluster)
 	return true;
 }
 
+static void sunxi_mc_smp_secondary_init(unsigned int cpu)
+{
+	/* Clear hotplug support magic flags for cpu0 */
+	if (cpu == 0)
+		sunxi_cpu0_hotplug_support_set(false);
+}
+
 static int sunxi_mc_smp_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
 {
 	unsigned int mpidr, cpu, cluster;
@@ -572,13 +598,19 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
 	return !ret;
 }
 
+static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
+{
+	return true;
+}
 #endif
 
 static const struct smp_operations sunxi_mc_smp_smp_ops __initconst = {
+	.smp_secondary_init	= sunxi_mc_smp_secondary_init,
 	.smp_boot_secondary	= sunxi_mc_smp_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= sunxi_mc_smp_cpu_die,
 	.cpu_kill		= sunxi_mc_smp_cpu_kill,
+	.cpu_can_disable	= sunxi_mc_smp_cpu_can_disable,
 #endif
 };
 
@@ -654,7 +686,7 @@ static int __init sunxi_mc_smp_lookback(void)
 
 static int __init sunxi_mc_smp_init(void)
 {
-	struct device_node *cpucfg_node, *node;
+	struct device_node *cpucfg_node, *sram_node, *node;
 	struct resource res;
 	int ret;
 
@@ -702,16 +734,31 @@ static int __init sunxi_mc_smp_init(void)
 		goto err_put_cpucfg_node;
 	}
 
+	sram_node = of_find_compatible_node(NULL, NULL,
+					    "allwinner,sun9i-a80-smp-sram");
+	if (!sram_node) {
+		ret = -ENODEV;
+		goto err_unmap_release_cpucfg;
+	}
+
+	sram_b_smp_base = of_io_request_and_map(sram_node, 0, "sunxi-mc-smp");
+	if (IS_ERR(sram_b_smp_base)) {
+		ret = PTR_ERR(sram_b_smp_base);
+		pr_err("%s: failed to map secure SRAM\n", __func__);
+		goto err_put_sram_node;
+	}
+
 	/* Configure CCI-400 for boot cluster */
 	ret = sunxi_mc_smp_lookback();
 	if (ret) {
 		pr_err("%s: failed to configure boot cluster: %d\n",
 		       __func__, ret);
-		goto err_unmap_release_cpucfg;
+		goto err_unmap_release_secure_sram;
 	}
 
-	/* We don't need the CPUCFG device node anymore */
+	/* We don't need the CPUCFG and SRAM device nodes anymore */
 	of_node_put(cpucfg_node);
+	of_node_put(sram_node);
 
 	/* Set the hardware entry point address */
 	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
@@ -724,6 +771,12 @@ static int __init sunxi_mc_smp_init(void)
 
 	return 0;
 
+err_unmap_release_secure_sram:
+	iounmap(sram_b_smp_base);
+	of_address_to_resource(sram_node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+err_put_sram_node:
+	of_node_put(sram_node);
 err_unmap_release_cpucfg:
 	iounmap(cpucfg_base);
 	of_address_to_resource(cpucfg_node, 0, &res);
-- 
2.15.1
