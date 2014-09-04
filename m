From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu,  4 Sep 2014 15:52:34 +0200
Subject: [PATCH v3 7/9] spi: core: Convert to dev_pm_domain_attach|detach()
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409838756-31963-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously only the ACPI PM domain was supported by the spi bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

Cc: linux-spi at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/spi/spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ca935df..72a0beb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -264,10 +264,12 @@ static int spi_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	acpi_dev_pm_attach(dev, true);
-	ret = sdrv->probe(to_spi_device(dev));
-	if (ret)
-		acpi_dev_pm_detach(dev, true);
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret != -EPROBE_DEFER) {
+		ret = sdrv->probe(to_spi_device(dev));
+		if (ret)
+			dev_pm_domain_detach(dev, true);
+	}
 
 	return ret;
 }
@@ -278,7 +280,7 @@ static int spi_drv_remove(struct device *dev)
 	int ret;
 
 	ret = sdrv->remove(to_spi_device(dev));
-	acpi_dev_pm_detach(dev, true);
+	dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
1.9.1
