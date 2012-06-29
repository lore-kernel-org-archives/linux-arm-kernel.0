From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 29 Jun 2012 17:48:52 +0800
Subject: [PATCH v8 04/14] usb: chipidea: msm: add remove method
In-Reply-To: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
References: <1340963342-28735-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340963342-28735-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

allow this driver to be removed too.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_msm.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index 8d438b8..11a7bef 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -84,6 +84,8 @@ static int __devinit ci13xxx_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_platform;
 
+	platform_set_drvdata(pdev, plat_ci);
+
 	pm_runtime_no_callbacks(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -95,16 +97,23 @@ put_platform:
 	return ret;
 }
 
+static int __devexit ci13xxx_msm_remove(struct platform_device *pdev)
+{
+	struct platform_device *plat_ci = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	platform_device_unregister(plat_ci);
+
+	return 0;
+}
+
 static struct platform_driver ci13xxx_msm_driver = {
 	.probe = ci13xxx_msm_probe,
+	.remove = __devexit_p(ci13xxx_msm_remove),
 	.driver = { .name = "msm_hsusb", },
 };
-MODULE_ALIAS("platform:msm_hsusb");
 
-static int __init ci13xxx_msm_init(void)
-{
-	return platform_driver_register(&ci13xxx_msm_driver);
-}
-module_init(ci13xxx_msm_init);
+module_platform_driver(ci13xxx_msm_driver);
 
+MODULE_ALIAS("platform:msm_hsusb");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
