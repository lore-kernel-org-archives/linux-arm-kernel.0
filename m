From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 4 Oct 2012 10:04:41 +0200
Subject: [PATCH V2 3/3] spi: spi-pl022: Minor simplification for runtime pm
In-Reply-To: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349337881-15917-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

In probe pm_runtime_put_autosuspend has the same effect as doing
pm_runtime_put. This due to upper layer in driver core is preventing
the device from being runtime suspended by a pm_runtime_get*.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index a1db91a..51b7a95 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2246,10 +2246,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		pm_runtime_set_autosuspend_delay(dev,
 			platform_info->autosuspend_delay);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_put_autosuspend(dev);
-	} else {
-		pm_runtime_put(dev);
 	}
+	pm_runtime_put(dev);
+
 	return 0;
 
  err_spi_register:
-- 
1.7.10
