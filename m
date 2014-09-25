From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 25 Sep 2014 18:05:36 +0300
Subject: [RFC PATCH 3/4] ARM: keystone: pm: remove unused clk pm domain code
In-Reply-To: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
References: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1411657537-25238-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused CLK PM domain code, since Keystone 2 PM
has been switched to use Generic PM domain framework.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-keystone/pm_domain.c | 57 --------------------------------------
 1 file changed, 57 deletions(-)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index 3cf6696..8a70caa 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -21,53 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
-#ifdef CONFIG_PM_RUNTIME
-
-static int keystone_pm_runtime_suspend(struct device *dev)
-{
-	int ret;
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	ret = pm_generic_runtime_suspend(dev);
-	if (ret)
-		return ret;
-
-	ret = pm_clk_suspend(dev);
-	if (ret) {
-		pm_generic_runtime_resume(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int keystone_pm_runtime_resume(struct device *dev)
-{
-	dev_dbg(dev, "%s\n", __func__);
-
-	pm_clk_resume(dev);
-
-	return pm_generic_runtime_resume(dev);
-}
-#endif
-
-static struct dev_pm_domain keystone_pm_domain = {
-	.ops = {
-		SET_RUNTIME_PM_OPS(keystone_pm_runtime_suspend,
-				   keystone_pm_runtime_resume, NULL)
-		USE_PLATFORM_PM_SLEEP_OPS
-	},
-};
-
-static struct pm_clk_notifier_block platform_domain_notifier = {
-	.pm_domain = &keystone_pm_domain,
-};
-
-static struct of_device_id of_keystone_table[] = {
-	{.compatible = "ti,keystone"},
-	{ /* end of list */ },
-};
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 
@@ -183,15 +136,5 @@ static int __init keystone_pm_domain_init(void) { return 0; }
 
 int __init keystone_pm_runtime_init(void)
 {
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, of_keystone_table);
-	if (!np)
-		return 0;
-
-	/* TODO: remove clock_ops code
-	 * pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
-	 */
-
 	return keystone_pm_domain_init();
 }
-- 
1.9.1
