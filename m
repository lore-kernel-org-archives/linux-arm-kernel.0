From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:45 +0100
Subject: [PATCH 5/9] i2c: core: Keep PM domain powered during ->probe()
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-6-git-send-email-ulf.hansson@linaro.org>
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
index 210cf48..0eabe55 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -655,8 +655,15 @@ static int i2c_device_probe(struct device *dev)
 
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
