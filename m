From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:30 +0200
Subject: [PATCH 02/29] ARM: Exynos: bind power domains earlier,
 on device creation
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches change initialization time of power domain driver from client
device driver bind to device creation. This lets other core drivers to
register power domain notifiers before client driver is bound.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index fd76e1b..1d368a2 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -159,13 +159,13 @@ static int exynos_pm_notifier_call(struct notifier_block *nb,
 	struct device *dev = data;
 
 	switch (event) {
-	case BUS_NOTIFY_BIND_DRIVER:
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (dev->of_node)
 			exynos_read_domain_from_dt(dev);
 
 		break;
 
-	case BUS_NOTIFY_UNBOUND_DRIVER:
+	case BUS_NOTIFY_DEL_DEVICE:
 		exynos_remove_device_from_domain(dev);
 
 		break;
@@ -177,6 +177,13 @@ static struct notifier_block platform_nb = {
 	.notifier_call = exynos_pm_notifier_call,
 };
 
+static int exynos_pm_domain_add(struct device *dev, void *priv)
+{
+	if (dev->of_node)
+		exynos_read_domain_from_dt(dev);
+	return 0;
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -236,6 +243,7 @@ no_clk:
 	}
 
 	bus_register_notifier(&platform_bus_type, &platform_nb);
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, exynos_pm_domain_add);
 
 	return 0;
 }
-- 
1.9.2
