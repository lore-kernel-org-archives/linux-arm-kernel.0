From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Oct 2014 16:02:06 +0200
Subject: [PATCH v3 5/9] i2c: core: Keep PM domain powered during ->probe()
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413208930-26019-6-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To sucessfully probe some devices their corresponding PM domains may
need to be powered.

Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6..37a52c6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -646,8 +646,15 @@ static int i2c_device_probe(struct device *dev)
 
 	status = dev_pm_domain_attach(&client->dev, true);
 	if (status != -EPROBE_DEFER) {
+		status = dev_pm_domain_get(client->dev.pm_domain);
+		if (status) {
+			dev_pm_domain_detach(&client->dev, true);
+			return status;
+		}
+
 		status = driver->probe(client, i2c_match_id(driver->id_table,
 					client));
+		dev_pm_domain_put(client->dev.pm_domain);
 		if (status)
 			dev_pm_domain_detach(&client->dev, true);
 	}
-- 
1.9.1
