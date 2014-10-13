From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Oct 2014 16:02:08 +0200
Subject: [PATCH v3 7/9] mmc: core: Attach PM domain prior probing of SDIO func
 driver
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413208930-26019-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Align the behvaior to how other buses are handling attachment of PM
domains. Additionally, let's add error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 65cf7a7..ba97779 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -313,13 +313,19 @@ int sdio_add_func(struct sdio_func *func)
 	dev_set_name(&func->dev, "%s:%d", mmc_card_id(func->card), func->num);
 
 	sdio_acpi_set_handle(func);
+
+	ret = dev_pm_domain_attach(&func->dev, false);
+	if (ret)
+		return ret;
+
 	ret = device_add(&func->dev);
-	if (ret == 0) {
-		sdio_func_set_present(func);
-		dev_pm_domain_attach(&func->dev, false);
+	if (ret) {
+		dev_pm_domain_detach(&func->dev, false);
+		return ret;
 	}
 
-	return ret;
+	sdio_func_set_present(func);
+	return 0;
 }
 
 /*
-- 
1.9.1
