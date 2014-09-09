From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  9 Sep 2014 13:36:09 +0200
Subject: [PATCH v4 8/9] amba: Add support for attach/detach of PM domains
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1410262570-22785-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AMBA devices may on some SoCs resides in PM domains. To be able to
manage these devices from there, let's try to attach devices to their
corresponding PM domain during the probe phase.

To reverse these actions at the remove phase, we try to detach the
device from its PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/amba/bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 3cf61a1..8f52393 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -182,9 +182,15 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = dev_pm_domain_attach(dev, true);
+		if (ret == -EPROBE_DEFER)
+			break;
+
 		ret = amba_get_enable_pclk(pcdev);
-		if (ret)
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
 			break;
+		}
 
 		pm_runtime_get_noresume(dev);
 		pm_runtime_set_active(dev);
@@ -199,6 +205,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_put_noidle(dev);
 
 		amba_put_disable_pclk(pcdev);
+		dev_pm_domain_detach(dev, true);
 	} while (0);
 
 	return ret;
@@ -220,6 +227,7 @@ static int amba_remove(struct device *dev)
 	pm_runtime_put_noidle(dev);
 
 	amba_put_disable_pclk(pcdev);
+	dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
1.9.1
