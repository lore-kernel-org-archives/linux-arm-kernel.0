From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  4 Jan 2018 22:37:53 +0800
Subject: [PATCH v2 7/8] ARM: sun9i: mcpm: Support cpu0 hotplug
In-Reply-To: <20180104143754.2425-1-wens@csie.org>
References: <20180104143754.2425-1-wens@csie.org>
Message-ID: <20180104143754.2425-8-wens@csie.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mcpm.c | 54 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index ddc26b5fec48..c8d74c783644 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -56,8 +56,12 @@
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
@@ -116,6 +120,17 @@ static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
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
@@ -124,6 +139,10 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	/* Set hotplug support magic flags for cpu0 */
+	if (cluster == 0 && cpu == 0)
+		sunxi_cpu0_hotplug_support_set(true);
+
 	/* assert processor power-on reset */
 	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
@@ -406,6 +425,13 @@ static void sunxi_cluster_powerdown(struct work_struct *_work)
 	sunxi_do_cluster_powerdown(cluster);
 }
 
+static void sunxi_cpu_is_up(unsigned int cpu, unsigned int cluster)
+{
+	/* Clear hotplug support magic flags for cpu0 */
+	if (cluster == 0 && cpu == 0)
+		sunxi_cpu0_hotplug_support_set(false);
+}
+
 static int sunxi_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	int ret;
@@ -425,6 +451,7 @@ static const struct mcpm_platform_ops sunxi_power_ops = {
 	.cluster_powerdown_prepare = sunxi_cluster_powerdown_prepare,
 	.cpu_cache_disable	   = sunxi_cpu_cache_disable,
 	.cluster_cache_disable	   = sunxi_cluster_cache_disable,
+	.cpu_is_up		   = sunxi_cpu_is_up,
 	.wait_for_powerdown	   = sunxi_wait_for_powerdown,
 };
 
@@ -484,7 +511,7 @@ static void sunxi_mcpm_setup_entry_point(void)
 
 static int __init sunxi_mcpm_init(void)
 {
-	struct device_node *cpucfg_node, *node;
+	struct device_node *cpucfg_node, *sram_node, *node;
 	struct resource res;
 	int ret;
 	int i, j;
@@ -525,12 +552,26 @@ static int __init sunxi_mcpm_init(void)
 		goto err_put_cpucfg_node;
 	}
 
+	sram_node = of_find_compatible_node(NULL, NULL,
+					    "allwinner,sun9i-a80-smp-sram");
+	if (!sram_node) {
+		ret = -ENODEV;
+		goto err_unmap_release_cpucfg;
+	}
+
+	sram_b_smp_base = of_io_request_and_map(sram_node, 0, "sunxi-mcpm");
+	if (IS_ERR(sram_b_smp_base)) {
+		ret = PTR_ERR(sram_b_smp_base);
+		pr_err("%s: failed to map secure SRAM\n", __func__);
+		goto err_put_sram_node;
+	}
+
 	/* Initialize our strictly ordered workqueue */
 	sunxi_mcpm_wq = alloc_ordered_workqueue("%s", 0, "sunxi-mcpm");
 	if (!sunxi_mcpm_wq) {
 		ret = -ENOMEM;
 		pr_err("%s: failed to create our workqueue\n", __func__);
-		goto err_unmap_release_cpucfg;
+		goto err_unmap_release_secure_sram;
 	}
 
 	/* Initialize power down work */
@@ -556,8 +597,9 @@ static int __init sunxi_mcpm_init(void)
 	if (ret)
 		goto err_destroy_workqueue;
 
-	/* We don't need the CPUCFG device node anymore */
+	/* We don't need the CPUCFG and SRAM device nodes anymore */
 	of_node_put(cpucfg_node);
+	of_node_put(sram_node);
 
 	/* Set the hardware entry point address */
 	sunxi_mcpm_setup_entry_point();
@@ -571,6 +613,12 @@ static int __init sunxi_mcpm_init(void)
 
 err_destroy_workqueue:
 	destroy_workqueue(sunxi_mcpm_wq);
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
