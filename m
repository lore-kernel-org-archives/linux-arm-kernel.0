From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 22:19:12 +0200
Subject: [PATCH] cpufreq: integrator: fix integrator_cpufreq_remove return type
Message-ID: <1845195.odREGsY0qB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building this driver as a module, we get a helpful warning
about the return type:

drivers/cpufreq/integrator-cpufreq.c:232:2: warning: initialization from incompatible pointer type
  .remove = __exit_p(integrator_cpufreq_remove),

If the remove callback returns void, the caller gets an undefined
value as it expects an integer to be returned. This fixes the
problem by passing down the value from cpufreq_unregister_driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found while testing the integrator multiplatform patches from Linus Walleij,
this shows up as a new warning in allmodconfig.

diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
index c1320528b9d0..6bd69adc3c5e 100644
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ b/drivers/cpufreq/integrator-cpufreq.c
@@ -213,9 +213,9 @@ static int __init integrator_cpufreq_probe(struct platform_device *pdev)
 	return cpufreq_register_driver(&integrator_driver);
 }
 
-static void __exit integrator_cpufreq_remove(struct platform_device *pdev)
+static int __exit integrator_cpufreq_remove(struct platform_device *pdev)
 {
-	cpufreq_unregister_driver(&integrator_driver);
+	return cpufreq_unregister_driver(&integrator_driver);
 }
 
 static const struct of_device_id integrator_cpufreq_match[] = {
