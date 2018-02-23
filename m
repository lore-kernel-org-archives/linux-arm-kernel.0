From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 23 Feb 2018 14:37:33 +0100
Subject: [PATCH v4 01/10] ARM: sun9i: smp: Add sun9i dt parsing function
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
Message-ID: <20180223133742.26044-2-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the support for sun8i-a83t, create a new function
that handles all the resources needed on sun9i-a80 (because
it will be different from sun8i-a83t).

All the parsing of device tree is moved into this new function:
sun9i_dt_parsing. Create also a function to release the resources
retrieved during the dt parsing in case there is an error in init
function.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 99 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 11e46c6efb90..650a2ad4398f 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -684,35 +684,22 @@ static int __init sunxi_mc_smp_lookback(void)
 	return ret;
 }
 
-static int __init sunxi_mc_smp_init(void)
+static int sun9i_dt_parsing(struct resource res)
 {
-	struct device_node *cpucfg_node, *sram_node, *node;
-	struct resource res;
+	struct device_node *prcm_node, *cpucfg_node, *sram_node;
 	int ret;
 
-	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
-		return -ENODEV;
-
-	if (!sunxi_mc_smp_cpu_table_init())
-		return -EINVAL;
-
-	if (!cci_probed()) {
-		pr_err("%s: CCI-400 not available\n", __func__);
-		return -ENODEV;
-	}
-
-	node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
-	if (!node) {
-		pr_err("%s: PRCM not available\n", __func__);
+	prcm_node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun9i-a80-prcm");
+	if (!prcm_node)
 		return -ENODEV;
-	}
 
 	/*
 	 * Unfortunately we can not request the I/O region for the PRCM.
 	 * It is shared with the PRCM clock.
 	 */
-	prcm_base = of_iomap(node, 0);
-	of_node_put(node);
+	prcm_base = of_iomap(prcm_node, 0);
+	of_node_put(prcm_node);
 	if (!prcm_base) {
 		pr_err("%s: failed to map PRCM registers\n", __func__);
 		return -ENOMEM;
@@ -748,33 +735,12 @@ static int __init sunxi_mc_smp_init(void)
 		goto err_put_sram_node;
 	}
 
-	/* Configure CCI-400 for boot cluster */
-	ret = sunxi_mc_smp_lookback();
-	if (ret) {
-		pr_err("%s: failed to configure boot cluster: %d\n",
-		       __func__, ret);
-		goto err_unmap_release_secure_sram;
-	}
-
 	/* We don't need the CPUCFG and SRAM device nodes anymore */
 	of_node_put(cpucfg_node);
 	of_node_put(sram_node);
 
-	/* Set the hardware entry point address */
-	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
-	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
-
-	/* Actually enable multi cluster SMP */
-	smp_set_ops(&sunxi_mc_smp_smp_ops);
-
-	pr_info("sunxi multi cluster SMP support installed\n");
-
 	return 0;
 
-err_unmap_release_secure_sram:
-	iounmap(sram_b_smp_base);
-	of_address_to_resource(sram_node, 0, &res);
-	release_mem_region(res.start, resource_size(&res));
 err_put_sram_node:
 	of_node_put(sram_node);
 err_unmap_release_cpucfg:
@@ -785,6 +751,57 @@ static int __init sunxi_mc_smp_init(void)
 	of_node_put(cpucfg_node);
 err_unmap_prcm:
 	iounmap(prcm_base);
+
+	return ret;
+}
+
+static void sun9i_iounmap(void)
+{
+	iounmap(sram_b_smp_base);
+	iounmap(cpucfg_base);
+	iounmap(prcm_base);
+}
+
+static int __init sunxi_mc_smp_init(void)
+{
+	struct resource res;
+	int ret;
+
+	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+		return -ENODEV;
+
+	if (!sunxi_mc_smp_cpu_table_init())
+		return -EINVAL;
+
+	if (!cci_probed()) {
+		pr_err("%s: CCI-400 not available\n", __func__);
+		return -ENODEV;
+	}
+
+	ret = sun9i_dt_parsing(res);
+	if (ret) {
+		pr_err("%s: failed to parse DT: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Configure CCI-400 for boot cluster */
+	ret = sunxi_mc_smp_lookback();
+	if (ret) {
+		pr_err("%s: failed to configure boot cluster: %d\n",
+		       __func__, ret);
+		sun9i_iounmap();
+		return ret;
+	}
+
+	/* Set the hardware entry point address */
+	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+
+	/* Actually enable multi cluster SMP */
+	smp_set_ops(&sunxi_mc_smp_smp_ops);
+
+	pr_info("sunxi multi cluster SMP support installed\n");
+
 	return ret;
 }
 
-- 
2.11.0
