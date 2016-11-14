From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:31:59 +0530
Subject: [PATCH 04/16] ARM: realview: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

Also this patch removes computation of number of cores
from SCU, as for DT platform it will be taken care from
DT CPU device nodes.

CC: Russell King <linux@armlinux.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-realview/platsmp-dt.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index 70ca99e..b2dbf77 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -23,8 +23,6 @@
 
 static const struct of_device_id realview_scu_match[] = {
 	{ .compatible = "arm,arm11mp-scu", },
-	{ .compatible = "arm,cortex-a9-scu", },
-	{ .compatible = "arm,cortex-a5-scu", },
 	{ }
 };
 
@@ -41,27 +39,18 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 	struct device_node *np;
 	void __iomem *scu_base;
 	struct regmap *map;
-	unsigned int ncores;
 	int i;
 
-	np = of_find_matching_node(NULL, realview_scu_match);
-	if (!np) {
-		pr_err("PLATSMP: No SCU base address\n");
-		return;
+	if (of_scu_enable()) {
+		np = of_find_matching_node(NULL, realview_scu_match);
+		scu_base = of_iomap(np, 0);
+		of_node_put(np);
+		if (!scu_base) {
+			pr_err("PLATSMP: No SCU remap\n");
+			return;
+		}
+		scu_enable(scu_base);
 	}
-	scu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!scu_base) {
-		pr_err("PLATSMP: No SCU remap\n");
-		return;
-	}
-
-	scu_enable(scu_base);
-	ncores = scu_get_core_count(scu_base);
-	pr_info("SCU: %d cores detected\n", ncores);
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-	iounmap(scu_base);
 
 	/* The syscon contains the magic SMP start address registers */
 	np = of_find_matching_node(NULL, realview_syscon_match);
-- 
2.7.4
