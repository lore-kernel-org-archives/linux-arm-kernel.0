From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu,  4 Sep 2014 15:52:32 +0200
Subject: [PATCH v3 5/9] i2c: core: Convert to dev_pm_domain_attach|detach()
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409838756-31963-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously only the ACPI PM domain was supported by the i2c bus.

Let's convert to the common attach/detach functions for PM domains,
which currently means we are extending the support to include the
generic PM domain as well.

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
