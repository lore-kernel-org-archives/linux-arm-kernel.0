From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:50:29 +0200
Subject: [PATCH v3 2/6] ARM: mvebu: start using the CPU reset driver
In-Reply-To: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483433-25836-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit changes the PMSU driver to no longer map itself the CPU
reset registers, and instead call into the CPU reset driver to
deassert the secondary CPUs for SMP booting.

In order to provide Device Tree backward compatibility, the CPU reset
driver is extended to not only support its official compatible string
"marvell,armada-370-cpu-reset", but to also look at the PMSU
compatible string "marvell,armada-370-xp-pmsu" to find the CPU reset
registers address. This allows old Device Tree to work correctly with
newer kernel versions. Therefore, the CPU reset driver implements the
following logic:

 * If one of the normal compatible strings
   "marvell,armada-370-cpu-reset" is found, then we map its first
   memory resource as the CPU reset registers.

 * Otherwise, if none of the normal compatible strings have been
   found, we look for the "marvell,armada-370-xp-pmsu" compatible
   string, and we map the second memory as the CPU reset registers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/cpu-reset.c | 53 ++++++++++++++++++++++++++++-------------
 arch/arm/mach-mvebu/pmsu.c      | 20 ++++++++--------
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index 4ff4ce7..4a8f9ee 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -40,42 +40,63 @@ int mvebu_cpu_reset_deassert(int cpu)
 	return 0;
 }
 
-static int __init mvebu_cpu_reset_init(void)
+static int mvebu_cpu_reset_map(struct device_node *np, int res_idx)
 {
-	struct device_node *np;
 	struct resource res;
-	int ret = 0;
-
-	np = of_find_compatible_node(NULL, NULL,
-				     "marvell,armada-370-cpu-reset");
-	if (!np)
-		return 0;
 
-	if (of_address_to_resource(np, 0, &res)) {
+	if (of_address_to_resource(np, res_idx, &res)) {
 		pr_err("unable to get resource\n");
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	if (!request_mem_region(res.start, resource_size(&res),
 				np->full_name)) {
 		pr_err("unable to request region\n");
-		ret = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	cpu_reset_base = ioremap(res.start, resource_size(&res));
 	if (!cpu_reset_base) {
 		pr_err("unable to map registers\n");
 		release_mem_region(res.start, resource_size(&res));
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	cpu_reset_size = resource_size(&res);
 
-out:
+	return 0;
+}
+
+int __init mvebu_cpu_reset_init(void)
+{
+	struct device_node *np;
+	int res_idx;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "marvell,armada-370-cpu-reset");
+	if (np) {
+		res_idx = 0;
+	} else {
+		/*
+		 * This code is kept for backward compatibility with
+		 * old Device Trees.
+		 */
+		np = of_find_compatible_node(NULL, NULL,
+					     "marvell,armada-370-xp-pmsu");
+		if (np) {
+			pr_warn(FW_WARN "deprecated pmsu binding\n");
+			res_idx = 1;
+		}
+	}
+
+	/* No reset node found */
+	if (!np)
+		return -ENODEV;
+
+	ret = mvebu_cpu_reset_map(np, res_idx);
 	of_node_put(np);
+
 	return ret;
 }
 
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index d71ef53..1807639 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -21,14 +21,14 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/smp.h>
+#include <linux/resource.h>
 #include <asm/smp_plat.h>
+#include "common.h"
 #include "pmsu.h"
 
 static void __iomem *pmsu_mp_base;
-static void __iomem *pmsu_reset_base;
 
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
-#define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
 
 static struct of_device_id of_pmsu_table[] = {
 	{.compatible = "marvell,armada-370-xp-pmsu"},
@@ -38,11 +38,11 @@ static struct of_device_id of_pmsu_table[] = {
 #ifdef CONFIG_SMP
 int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 {
-	int reg, hw_cpu;
+	int hw_cpu, ret;
 
-	if (!pmsu_mp_base || !pmsu_reset_base) {
+	if (!pmsu_mp_base) {
 		pr_warn("Can't boot CPU. PMSU is uninitialized\n");
-		return 1;
+		return -ENODEV;
 	}
 
 	hw_cpu = cpu_logical_map(cpu_id);
@@ -50,10 +50,11 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 	writel(virt_to_phys(boot_addr), pmsu_mp_base +
 			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 
-	/* Release CPU from reset by clearing reset bit*/
-	reg = readl(pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
-	reg &= (~0x1);
-	writel(reg, pmsu_reset_base + PMSU_RESET_CTL_OFFSET(hw_cpu));
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_warn("unable to boot CPU: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -67,7 +68,6 @@ static int __init armada_370_xp_pmsu_init(void)
 	if (np) {
 		pr_info("Initializing Power Management Service Unit\n");
 		pmsu_mp_base = of_iomap(np, 0);
-		pmsu_reset_base = of_iomap(np, 1);
 		of_node_put(np);
 	}
 
-- 
1.8.3.2
