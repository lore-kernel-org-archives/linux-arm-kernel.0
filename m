From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Oct 2012 13:42:24 +0200
Subject: [PATCH 3/8] cpufreq: db8500: Register as a platform driver
In-Reply-To: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349869349-8070-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To fetch the mfd child device we register the cpufreq driver
as a platform driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/cpufreq/db8500-cpufreq.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 74b830b..7d61a6c 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -8,10 +8,12 @@
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
  *
  */
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <mach/id.h>
 
@@ -159,12 +161,28 @@ static struct cpufreq_driver db8500_cpufreq_driver = {
 	.attr   = db8500_cpufreq_attr,
 };
 
+static int db8500_cpufreq_probe(struct platform_device *pdev)
+{
+	return cpufreq_register_driver(&db8500_cpufreq_driver);
+}
+
+static struct platform_driver db8500_cpufreq_plat_driver = {
+	.driver = {
+		.name = "cpufreq-u8500",
+		.owner = THIS_MODULE,
+	},
+	.probe = db8500_cpufreq_probe,
+};
+
 static int __init db8500_cpufreq_register(void)
 {
 	if (!cpu_is_u8500_family())
 		return -ENODEV;
 
 	pr_info("cpufreq for DB8500 started\n");
-	return cpufreq_register_driver(&db8500_cpufreq_driver);
+	return platform_driver_register(&db8500_cpufreq_plat_driver);
 }
 device_initcall(db8500_cpufreq_register);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("cpufreq driver for DB8500");
-- 
1.7.10
