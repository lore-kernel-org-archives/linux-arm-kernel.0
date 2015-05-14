From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 14:10:10 +0800
Subject: [RFC 6/7] ARM: sunxi: mcpm: Support cpu0 hotplug
In-Reply-To: <1431583811-25780-1-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
Message-ID: <1431583811-25780-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets the flags that makes BROM jump execution on the
primary core (cpu0)to the SMP software entry code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mcpm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-sunxi/mcpm.c b/arch/arm/mach-sunxi/mcpm.c
index 5ea4b488890c..e74e8aab2560 100644
--- a/arch/arm/mach-sunxi/mcpm.c
+++ b/arch/arm/mach-sunxi/mcpm.c
@@ -58,8 +58,12 @@
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
 
+#define CPU0_SUPPORT_HOTPLUG_MAGIC0	0xFA50392F
+#define CPU0_SUPPORT_HOTPLUG_MAGIC1	0x790DCA3A
+
 static void __iomem *cpucfg_base;
 static void __iomem *prcm_base;
+static void __iomem *sram_b_smp_base;
 
 static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
 				      bool enable)
@@ -93,6 +97,17 @@ static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
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
@@ -101,6 +116,10 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	/* Set hotplug support magic flags for cpu0 */
+	if (cluster == 0 && cpu == 0)
+		sunxi_cpu0_hotplug_support_set(true);
+
 	/* assert processor power-on reset */
 	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
@@ -441,6 +460,19 @@ static int __init sunxi_mcpm_init(void)
 		return -ENOMEM;
 	}
 
+	node = of_find_compatible_node(NULL, NULL,
+			"allwinner,sun9i-smp-sram");
+	if (!node)
+		return -ENODEV;
+
+	sram_b_smp_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!sram_b_smp_base) {
+		pr_err("%s: failed to map secure SRAM\n", __func__);
+		iounmap(sram_b_smp_base);
+		return -ENOMEM;
+	}
+
 	ret = mcpm_platform_register(&sunxi_power_ops);
 	if (!ret)
 		ret = mcpm_sync_init(sunxi_power_up_setup);
-- 
2.1.4
