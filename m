From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 10:04:03 -0700
Subject: [PATCH 3/9] crypto: omap-sham - Add suspend/resume support
In-Reply-To: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
References: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1356109449-11624-4-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Add suspend/resume support to the OMAP SHAM driver.

CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 777eb9f..9c3b096 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1269,12 +1269,31 @@ static int __devexit omap_sham_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int omap_sham_suspend(struct device *dev)
+{
+	pm_runtime_put_sync(dev);
+	return 0;
+}
+
+static int omap_sham_resume(struct device *dev)
+{
+	pm_runtime_get_sync(dev);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops omap_sham_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(omap_sham_suspend, omap_sham_resume)
+};
+
 static struct platform_driver omap_sham_driver = {
 	.probe	= omap_sham_probe,
 	.remove	= omap_sham_remove,
 	.driver	= {
 		.name	= "omap-sham",
 		.owner	= THIS_MODULE,
+		.pm	= &omap_sham_pm_ops,
 	},
 };
 
-- 
1.7.12
