From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:10 +0200
Subject: [PATCH 11/11] spi: Respect all error codes from dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7b213fa..eeab67f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -356,11 +356,12 @@ static int spi_drv_probe(struct device *dev)
 	}
 
 	ret = dev_pm_domain_attach(dev, true);
-	if (ret != -EPROBE_DEFER) {
-		ret = sdrv->probe(spi);
-		if (ret)
-			dev_pm_domain_detach(dev, true);
-	}
+	if (ret)
+		return ret;
+
+	ret = sdrv->probe(spi);
+	if (ret)
+		dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
2.7.4
