From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu,  4 Sep 2014 15:52:31 +0200
Subject: [PATCH v3 4/9] drivercore / platform: Convert to
 dev_pm_domain_attach|detach()
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409838756-31963-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously only the ACPI PM domain was supported by the platform bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/base/platform.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ab4f4ce..904be3d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -506,11 +506,12 @@ static int platform_drv_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	acpi_dev_pm_attach(_dev, true);
-
-	ret = drv->probe(dev);
-	if (ret)
-		acpi_dev_pm_detach(_dev, true);
+	ret = dev_pm_domain_attach(_dev, true);
+	if (ret != -EPROBE_DEFER) {
+		ret = drv->probe(dev);
+		if (ret)
+			dev_pm_domain_detach(_dev, true);
+	}
 
 	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
 		dev_warn(_dev, "probe deferral not supported\n");
@@ -532,7 +533,7 @@ static int platform_drv_remove(struct device *_dev)
 	int ret;
 
 	ret = drv->remove(dev);
-	acpi_dev_pm_detach(_dev, true);
+	dev_pm_domain_detach(_dev, true);
 
 	return ret;
 }
@@ -543,7 +544,7 @@ static void platform_drv_shutdown(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 
 	drv->shutdown(dev);
-	acpi_dev_pm_detach(_dev, true);
+	dev_pm_domain_detach(_dev, true);
 }
 
 /**
-- 
1.9.1
