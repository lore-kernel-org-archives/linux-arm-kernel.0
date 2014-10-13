From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Oct 2014 16:02:05 +0200
Subject: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered during
 ->probe()
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
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
index b2afc29..43897ad 100644
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
