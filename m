From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:08 +0200
Subject: [PATCH 09/11] mmc: sdio: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-10-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2b32b88..b6d8203 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -139,7 +139,7 @@ static int sdio_bus_probe(struct device *dev)
 		return -ENODEV;
 
 	ret = dev_pm_domain_attach(dev, false);
-	if (ret == -EPROBE_DEFER)
+	if (ret)
 		return ret;
 
 	/* Unbound SDIO functions are always suspended.
-- 
2.7.4
