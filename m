From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:34:29 +0000
Subject: [PATCH 13/33] MFD: mcp-sa11x0: convert to use dev_pm_ops
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3vh-0000YW-Fk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the sa11x0 MCP driver to use dev_pm_ops rather than the legacy
members in the platform driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-sa11x0.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 4d06db7..46167f6 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/mfd/mcp.h>
 
 #include <mach/hardware.h>
@@ -266,33 +267,38 @@ static int mcp_sa11x0_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int mcp_sa11x0_suspend(struct platform_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int mcp_sa11x0_suspend(struct device *dev)
 {
-	struct mcp_sa11x0 *m = priv(platform_get_drvdata(dev));
+	struct mcp_sa11x0 *m = priv(dev_get_drvdata(dev));
 
 	writel(m->mccr0 & ~MCCR0_MCE, MCCR0(m));
 
 	return 0;
 }
 
-static int mcp_sa11x0_resume(struct platform_device *dev)
+static int mcp_sa11x0_resume(struct device *dev)
 {
-	struct mcp_sa11x0 *m = priv(platform_get_drvdata(dev));
+	struct mcp_sa11x0 *m = priv(dev_get_drvdata(dev));
 
 	writel_relaxed(m->mccr1, MCCR1(m));
 	writel_relaxed(m->mccr0, MCCR0(m));
 
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops mcp_sa11x0_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp_sa11x0_suspend, mcp_sa11x0_resume)
+};
 
 static struct platform_driver mcp_sa11x0_driver = {
 	.probe		= mcp_sa11x0_probe,
 	.remove		= mcp_sa11x0_remove,
-	.suspend	= mcp_sa11x0_suspend,
-	.resume		= mcp_sa11x0_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.pm	= &mcp_sa11x0_pm_ops,
 	},
 };
 
-- 
1.7.4.4
