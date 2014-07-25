From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 25 Jul 2014 21:31:36 +0300
Subject: [RFC PATCH 3/3] ARM: keystone: pm_domain: setup clk pm domain clocks
 from DT
In-Reply-To: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1406313096-29761-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements custom pm_clk_notifier callback for Keystone 2
CLK PM domain which fills list of clocks for Device with all
clocks assigned to this Device in DT.

After this patch .con_ids field in pm_clk_notifier_block is not
used and there are no limitation for clocks names in DT any more.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-keystone/pm_domain.c |   46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index ca79dda..56542d2 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -47,6 +47,51 @@ static int keystone_pm_runtime_resume(struct device *dev)
 
 	return pm_generic_runtime_resume(dev);
 }
+
+static int keystone_pm_clk_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct pm_clk_notifier_block *clknb;
+	struct device *dev = data;
+	int error;
+	unsigned int i;
+	struct clk *clk;
+	struct device_node *np = dev->of_node;
+
+	dev_dbg(dev, "%s() %ld\n", __func__, action);
+
+	clknb = container_of(nb, struct pm_clk_notifier_block, nb);
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		if (dev->pm_domain)
+			break;
+
+		error = pm_clk_create(dev);
+		if (error)
+			break;
+
+		dev->pm_domain = clknb->pm_domain;
+
+		for (i = 0; (clk = of_clk_get(np, i)) && !IS_ERR(clk); i++) {
+			if (pm_clk_add_clk(dev, clk))
+				clk_put(clk);
+		}
+
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		if (dev->pm_domain != clknb->pm_domain)
+			break;
+
+		dev->pm_domain = NULL;
+		pm_clk_destroy(dev);
+		break;
+	}
+
+	return 0;
+}
+#else
+
 #endif
 
 static struct dev_pm_domain keystone_pm_domain = {
@@ -59,6 +104,7 @@ static struct dev_pm_domain keystone_pm_domain = {
 
 static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
+	.nb = { .notifier_call = keystone_pm_clk_notify, },
 };
 
 static struct of_device_id of_keystone_table[] = {
-- 
1.7.9.5
