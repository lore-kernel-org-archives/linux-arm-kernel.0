From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 28 Aug 2014 10:38:58 +0200
Subject: [PATCH v2 5/9] i2c: core: Convert to dev_pm_domain_attach|detach()
In-Reply-To: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
References: <1409215142-8218-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409215142-8218-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously only the ACPI power domain was supported by the i2c bus.

Let's convert to the common attach/detach functions for power domains,
which currently means we are extending the support to include the
generic power domain as well.

Cc: linux-i2c at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 632057a..3cd8f11 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -279,10 +279,13 @@ static int i2c_device_probe(struct device *dev)
 	if (status < 0)
 		return status;
 
-	acpi_dev_pm_attach(&client->dev, true);
-	status = driver->probe(client, i2c_match_id(driver->id_table, client));
-	if (status)
-		acpi_dev_pm_detach(&client->dev, true);
+	status = dev_pm_domain_attach(&client->dev, true);
+	if (status != -EPROBE_DEFER) {
+		status = driver->probe(client, i2c_match_id(driver->id_table,
+					client));
+		if (status)
+			dev_pm_domain_detach(&client->dev, true);
+	}
 
 	return status;
 }
@@ -302,7 +305,7 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
-	acpi_dev_pm_detach(&client->dev, true);
+	dev_pm_domain_detach(&client->dev, true);
 	return status;
 }
 
-- 
1.9.1
