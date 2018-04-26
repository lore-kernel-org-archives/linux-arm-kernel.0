From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Apr 2018 10:53:07 +0200
Subject: [PATCH 08/11] i2c: Respect all error codes from dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The limitation of being able to check only for -EPROBE_DEFER from
dev_pm_domain_attach() has been removed. Hence let's respect all error
codes and bail out accordingly.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb..a17f46a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -363,7 +363,7 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	status = dev_pm_domain_attach(&client->dev, true);
-	if (status == -EPROBE_DEFER)
+	if (status)
 		goto err_clear_wakeup_irq;
 
 	/*
-- 
2.7.4
