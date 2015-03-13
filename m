From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:48 +0100
Subject: [PATCH 8/9] mmmc: core: Keep PM domain powered during ->probe() of
 SDIO func driver
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 71357b8..0d89b4b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -320,7 +320,14 @@ int sdio_add_func(struct sdio_func *func)
 	if (ret)
 		return ret;
 
+	ret = dev_pm_domain_get(func->dev.pm_domain);
+	if (ret) {
+		dev_pm_domain_detach(&func->dev, false);
+		return ret;
+	}
+
 	ret = device_add(&func->dev);
+	dev_pm_domain_put(func->dev.pm_domain);
 	if (ret) {
 		dev_pm_domain_detach(&func->dev, false);
 		return ret;
-- 
1.9.1
