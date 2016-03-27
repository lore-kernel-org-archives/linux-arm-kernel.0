From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 27 Mar 2016 17:10:58 -0400
Subject: [PATCH 4/4] drivers/bus: make arm-ccn.c driver explicitly non-modular
In-Reply-To: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1459113058-14340-5-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for this driver is currently:

config ARM_CCN
        bool "ARM CCN driver support"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We exchange module.h for moduleparam.h here since the driver uses
module_param_named, and for now the easiest way to remain compatible
with existing bootargs use cases is to leave this as-is.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/arm-ccn.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 7082c7268845..45d2ba72ba8e 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -9,6 +9,8 @@
  * GNU General Public License for more details.
  *
  * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Pawel Moll <pawel.moll@arm.com>
  */
 
 #include <linux/ctype.h>
@@ -16,7 +18,7 @@
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1302,20 +1304,6 @@ error_cpu_notifier:
 	return err;
 }
 
-static void arm_ccn_pmu_cleanup(struct arm_ccn *ccn)
-{
-	int i;
-
-	irq_set_affinity(ccn->irq, cpu_possible_mask);
-	unregister_cpu_notifier(&ccn->dt.cpu_nb);
-	for (i = 0; i < ccn->num_xps; i++)
-		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
-	writel(0, ccn->dt.base + CCN_DT_PMCR);
-	perf_pmu_unregister(&ccn->dt.pmu);
-	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
-}
-
-
 static int arm_ccn_for_each_valid_region(struct arm_ccn *ccn,
 		int (*callback)(struct arm_ccn *ccn, int region,
 		void __iomem *base, u32 type, u32 id))
@@ -1507,15 +1495,6 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	return arm_ccn_pmu_init(ccn);
 }
 
-static int arm_ccn_remove(struct platform_device *pdev)
-{
-	struct arm_ccn *ccn = platform_get_drvdata(pdev);
-
-	arm_ccn_pmu_cleanup(ccn);
-
-	return 0;
-}
-
 static const struct of_device_id arm_ccn_match[] = {
 	{ .compatible = "arm,ccn-504", },
 	{},
@@ -1525,9 +1504,9 @@ static struct platform_driver arm_ccn_driver = {
 	.driver = {
 		.name = "arm-ccn",
 		.of_match_table = arm_ccn_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = arm_ccn_probe,
-	.remove = arm_ccn_remove,
 };
 
 static int __init arm_ccn_init(void)
@@ -1539,14 +1518,4 @@ static int __init arm_ccn_init(void)
 
 	return platform_driver_register(&arm_ccn_driver);
 }
-
-static void __exit arm_ccn_exit(void)
-{
-	platform_driver_unregister(&arm_ccn_driver);
-}
-
-module_init(arm_ccn_init);
-module_exit(arm_ccn_exit);
-
-MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
-MODULE_LICENSE("GPL");
+device_initcall(arm_ccn_init);
-- 
2.6.1
