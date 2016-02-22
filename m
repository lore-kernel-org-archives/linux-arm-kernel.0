From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:23 +0530
Subject: [PATCH 34/61] gpio: pcf857x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-35-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration and clean the
error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-pcf857x.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 709cd3f..169c09a 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -372,7 +372,7 @@ static int pcf857x_probe(struct i2c_client *client,
 	gpio->out = ~n_latch;
 	gpio->status = gpio->out;
 
-	status = gpiochip_add_data(&gpio->chip, gpio);
+	status = devm_gpiochip_add_data(&client->dev, &gpio->chip, gpio);
 	if (status < 0)
 		goto fail;
 
@@ -383,7 +383,7 @@ static int pcf857x_probe(struct i2c_client *client,
 					      IRQ_TYPE_NONE);
 		if (status) {
 			dev_err(&client->dev, "cannot add irqchip\n");
-			goto fail_irq;
+			goto fail;
 		}
 
 		status = devm_request_threaded_irq(&client->dev, client->irq,
@@ -391,7 +391,7 @@ static int pcf857x_probe(struct i2c_client *client,
 					IRQF_TRIGGER_FALLING | IRQF_SHARED,
 					dev_name(&client->dev), gpio);
 		if (status)
-			goto fail_irq;
+			goto fail;
 
 		gpiochip_set_chained_irqchip(&gpio->chip, &pcf857x_irq_chip,
 					     client->irq, NULL);
@@ -413,9 +413,6 @@ static int pcf857x_probe(struct i2c_client *client,
 
 	return 0;
 
-fail_irq:
-	gpiochip_remove(&gpio->chip);
-
 fail:
 	dev_dbg(&client->dev, "probe error %d for '%s'\n", status,
 		client->name);
@@ -440,7 +437,6 @@ static int pcf857x_remove(struct i2c_client *client)
 		}
 	}
 
-	gpiochip_remove(&gpio->chip);
 	return status;
 }
 
-- 
2.1.4
