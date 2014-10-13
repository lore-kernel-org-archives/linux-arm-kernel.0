From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Oct 2014 16:02:04 +0200
Subject: [PATCH v3 3/9] amba: Keep PM domain powered during ->probe()
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413208930-26019-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 47bbdc1..a8a8e13 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -187,8 +187,15 @@ static int amba_probe(struct device *dev)
 		if (ret == -EPROBE_DEFER)
 			break;
 
+		ret = dev_pm_domain_get(dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
+			break;
+		}
+
 		ret = amba_get_enable_pclk(pcdev);
 		if (ret) {
+			dev_pm_domain_put(dev->pm_domain);
 			dev_pm_domain_detach(dev, true);
 			break;
 		}
@@ -198,6 +205,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_enable(dev);
 
 		ret = pcdrv->probe(pcdev, id);
+		dev_pm_domain_put(dev->pm_domain);
 		if (ret == 0)
 			break;
 
-- 
1.9.1
