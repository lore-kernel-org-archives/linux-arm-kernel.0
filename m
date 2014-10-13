From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Oct 2014 16:02:09 +0200
Subject: [PATCH v3 8/9] mmmc: core: Keep PM domain powered during ->probe() of
 SDIO func driver
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413208930-26019-9-git-send-email-ulf.hansson@linaro.org>
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
index ba97779..83c8836 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -318,7 +318,14 @@ int sdio_add_func(struct sdio_func *func)
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
