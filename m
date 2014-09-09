From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  9 Sep 2014 13:36:07 +0200
Subject: [PATCH v4 6/9] mmc: sdio: Convert to dev_pm_domain_attach|detach()
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1410262570-22785-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously only the ACPI PM domain was supported by the sdio bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Cc: linux-mmc at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4fa8fef9..1df0fc6 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -315,7 +315,7 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0) {
 		sdio_func_set_present(func);
-		acpi_dev_pm_attach(&func->dev, false);
+		dev_pm_domain_attach(&func->dev, false);
 	}
 
 	return ret;
@@ -332,7 +332,7 @@ void sdio_remove_func(struct sdio_func *func)
 	if (!sdio_func_present(func))
 		return;
 
-	acpi_dev_pm_detach(&func->dev, false);
+	dev_pm_domain_detach(&func->dev, false);
 	device_del(&func->dev);
 	put_device(&func->dev);
 }
-- 
1.9.1
