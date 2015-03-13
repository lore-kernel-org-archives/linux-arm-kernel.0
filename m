From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:44 +0100
Subject: [PATCH 4/9] drivercore / platform: Keep PM domain powered during
 ->probe()
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/platform.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9421fed..d35fef1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -509,7 +509,14 @@ static int platform_drv_probe(struct device *_dev)
 
 	ret = dev_pm_domain_attach(_dev, true);
 	if (ret != -EPROBE_DEFER) {
+		ret = dev_pm_domain_get(_dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(_dev, true);
+			return ret;
+		}
+
 		ret = drv->probe(dev);
+		dev_pm_domain_put(_dev->pm_domain);
 		if (ret)
 			dev_pm_domain_detach(_dev, true);
 	}
-- 
1.9.1
