From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 11 Oct 2017 12:09:24 +0900
Subject: [PATCH v3 8/8] PM / devfreq: exynos-bus: Register cooling device
In-Reply-To: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
 <CGME20171011030947epcas1p475944e5d83cf28deaa3cdef731315d63@epcas1p4.samsung.com>
Message-ID: <1507691364-3899-9-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the Exynos Bus-Frequency scaling device
as a cooling device of thermal management.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/devfreq/exynos-bus.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index c25658b26598..fe9ef6a3238b 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
+#include <linux/devfreq_cooling.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -41,6 +42,8 @@ struct exynos_bus {
 	struct clk *clk;
 	unsigned int voltage_tolerance;
 	unsigned int ratio;
+
+	struct thermal_cooling_device *cdev;
 };
 
 /*
@@ -468,6 +471,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	/* Register devfreq cooling device */
+	bus->cdev = of_devfreq_cooling_register(np, bus->devfreq);
+	if (IS_ERR(bus->cdev)) {
+		dev_err(dev, "running exynos-bus without cooling device\n");
+		bus->cdev = NULL;
+	}
+
 	goto out;
 passive:
 	/* Initialize the struct profile and governor data for passive device */
@@ -514,6 +524,15 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int exynos_bus_remove(struct platform_device *pdev)
+{
+	struct exynos_bus *bus = platform_get_drvdata(pdev);
+
+	devfreq_cooling_unregister(bus->cdev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int exynos_bus_resume(struct device *dev)
 {
@@ -556,6 +575,7 @@ static int exynos_bus_suspend(struct device *dev)
 
 static struct platform_driver exynos_bus_platdrv = {
 	.probe		= exynos_bus_probe,
+	.remove		= exynos_bus_remove,
 	.driver = {
 		.name	= "exynos-bus",
 		.pm	= &exynos_bus_pm,
-- 
1.9.1
