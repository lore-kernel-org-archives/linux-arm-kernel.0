From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:46 +0100
Subject: [PATCH 6/9] spi: core: Keep PM domain powered during ->probe()
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-7-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c64a3e5..bb75a0f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -263,7 +263,14 @@ static int spi_drv_probe(struct device *dev)
 
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret != -EPROBE_DEFER) {
+		ret = dev_pm_domain_get(dev->pm_domain);
+		if (ret) {
+			dev_pm_domain_detach(dev, true);
+			return ret;
+		}
+
 		ret = sdrv->probe(to_spi_device(dev));
+		dev_pm_domain_put(dev->pm_domain);
 		if (ret)
 			dev_pm_domain_detach(dev, true);
 	}
-- 
1.9.1
