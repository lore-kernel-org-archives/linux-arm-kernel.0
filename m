From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:43 +0100
Subject: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
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
index f009936..19182b0 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -241,8 +241,15 @@ static int amba_probe(struct device *dev)
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
@@ -252,6 +259,7 @@ static int amba_probe(struct device *dev)
 		pm_runtime_enable(dev);
 
 		ret = pcdrv->probe(pcdev, id);
+		dev_pm_domain_put(dev->pm_domain);
 		if (ret == 0)
 			break;
 
-- 
1.9.1
