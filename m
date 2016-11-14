From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:02 +0530
Subject: [PATCH 07/16] ARM: ux500: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-8-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-ux500/platsmp.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 8f2f615..e1927ae 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -66,28 +66,10 @@ static void wakeup_secondary(void)
 
 static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
 {
-	struct device_node *np;
-	static void __iomem *scu_base;
-	unsigned int ncores;
-	int i;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
-	if (!np) {
-		pr_err("No SCU base address\n");
-		return;
-	}
-	scu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!scu_base) {
+	if (of_scu_enable()) {
 		pr_err("No SCU remap\n");
 		return;
 	}
-
-	scu_enable(scu_base);
-	ncores = scu_get_core_count(scu_base);
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
-	iounmap(scu_base);
 }
 
 static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
2.7.4
