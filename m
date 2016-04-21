From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 21 Apr 2016 10:04:53 +0800
Subject: [PATCH] usb: xhci-mtk: fixup mouse wakeup failure during system
 suspend
Message-ID: <1461204293-18243-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Click mouse after xhci suspend completion but before system suspend
completion, system will not be waken up by mouse if the duration of
them is larger than 20ms which is the device UFP's resume signaling
lasted. Another reason is that the SPM is not enabled before system
suspend compeltion, this causes SPM also not notice the resume signal.
So in order to reduce the duration less than 20ms, make use of
syscore's suspend/resume interface.
In fact it is a work around solution which only reduces the
probability of failure, because we can't ensure that the duration from
syscore's suspend completion to SPM working is always less than 20ms.

Because the syscore runs on irq disabled context, and xhci's
suspend/resume calls some sleeping functions, enable local irq
and then disable it during suspend/resume. This may be not a problem,
since only boot CPU is runing.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 79959f1..8277f02 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/syscore_ops.h>
 
 #include "xhci.h"
 #include "xhci-mtk.h"
@@ -490,6 +491,8 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 	return xhci_gen_setup(hcd, xhci_mtk_quirks);
 }
 
+static struct device *xhci_mtk_syscore_dev;
+
 static int xhci_mtk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -512,6 +515,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	if (!mtk)
 		return -ENOMEM;
 
+	xhci_mtk_syscore_dev = dev;
 	mtk->dev = dev;
 	mtk->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(mtk->vbus)) {
@@ -740,6 +744,29 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	return 0;
 }
 
+static int xhci_mtk_syscore_suspend(void)
+{
+	local_irq_enable();
+	xhci_mtk_suspend(xhci_mtk_syscore_dev);
+	local_irq_disable();
+
+	return 0;
+}
+
+static void xhci_mtk_syscore_resume(void)
+{
+	local_irq_enable();
+	xhci_mtk_resume(xhci_mtk_syscore_dev);
+	local_irq_disable();
+
+	return;
+}
+
+static struct syscore_ops xhci_mtk_syscore_ops = {
+	.suspend = xhci_mtk_syscore_suspend,
+	.resume = xhci_mtk_syscore_resume,
+};
+
 static const struct dev_pm_ops xhci_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
 };
@@ -758,7 +785,7 @@ static struct platform_driver mtk_xhci_driver = {
 	.remove	= xhci_mtk_remove,
 	.driver	= {
 		.name = "xhci-mtk",
-		.pm = DEV_PM_OPS,
+		/*.pm = DEV_PM_OPS,*/
 		.of_match_table = of_match_ptr(mtk_xhci_of_match),
 	},
 };
@@ -766,6 +793,7 @@ MODULE_ALIAS("platform:xhci-mtk");
 
 static int __init xhci_mtk_init(void)
 {
+	register_syscore_ops(&xhci_mtk_syscore_ops);
 	xhci_init_driver(&xhci_mtk_hc_driver, &xhci_mtk_overrides);
 	return platform_driver_register(&mtk_xhci_driver);
 }
@@ -774,6 +802,7 @@ module_init(xhci_mtk_init);
 static void __exit xhci_mtk_exit(void)
 {
 	platform_driver_unregister(&mtk_xhci_driver);
+	unregister_syscore_ops(&xhci_mtk_syscore_ops);
 }
 module_exit(xhci_mtk_exit);
 
-- 
1.7.9.5
