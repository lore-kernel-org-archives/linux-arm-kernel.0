From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:35:52 +0000
Subject: [PATCH 14/17] ARM: sa11x0: neponset: suspend/resume in _noirq state
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOvI-0001CS-EM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume in the _noirq state, so that we're saving the
state of the modem control signals as late as possible, and restoring
them as early as possible.  There's nothing to do in thaw/poweroff
methods as we've already saved the necessary state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 2451a38..59223ba 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 
@@ -303,10 +304,10 @@ static int __devexit neponset_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int neponset_suspend(struct platform_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int neponset_suspend(struct device *dev)
 {
-	struct neponset_drvdata *d = platform_get_drvdata(dev);
+	struct neponset_drvdata *d = dev_get_drvdata(dev);
 
 	d->ncr0 = NCR_0;
 	d->mdm_ctl_0 = MDM_CTL_0;
@@ -314,9 +315,9 @@ static int neponset_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int neponset_resume(struct platform_device *dev)
+static int neponset_resume(struct device *dev)
 {
-	struct neponset_drvdata *d = platform_get_drvdata(dev);
+	struct neponset_drvdata *d = dev_get_drvdata(dev);
 
 	NCR_0 = d->ncr0;
 	MDM_CTL_0 = d->mdm_ctl_0;
@@ -324,19 +325,24 @@ static int neponset_resume(struct platform_device *dev)
 	return 0;
 }
 
+static const struct dev_pm_ops neponset_pm_ops = {
+	.suspend_noirq = neponset_suspend,
+	.resume_noirq = neponset_resume,
+	.freeze_noirq = neponset_suspend,
+	.restore_noirq = neponset_resume,
+};
+#define PM_OPS &neponset_pm_ops
 #else
-#define neponset_suspend NULL
-#define neponset_resume  NULL
+#define PM_OPS NULL
 #endif
 
 static struct platform_driver neponset_device_driver = {
 	.probe		= neponset_probe,
 	.remove		= __devexit_p(neponset_remove),
-	.suspend	= neponset_suspend,
-	.resume		= neponset_resume,
 	.driver		= {
 		.name	= "neponset",
 		.owner	= THIS_MODULE,
+		.pm	= PM_OPS,
 	},
 };
 
-- 
1.7.4.4
