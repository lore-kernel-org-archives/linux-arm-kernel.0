From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:37:12 +0000
Subject: [PATCH 21/33] MFD: ucb1x00-core: clean up device handling in probe
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3yK-0000ZB-Hi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the device handling so we can use the struct device sanely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 7386f82..74d9fcf 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -553,6 +553,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 	if (!ucb)
 		goto err_disable;
 
+	device_initialize(&ucb->dev);
 	ucb->dev.class = &ucb1x00_class;
 	ucb->dev.parent = &mcp->attached_device;
 	dev_set_name(&ucb->dev, "ucb1x00");
@@ -563,11 +564,16 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	ucb->id  = id;
 	ucb->mcp = mcp;
+
+	ret = device_add(&ucb->dev);
+	if (ret)
+		goto err_dev_add;
+
 	ucb->irq = ucb1x00_detect_irq(ucb);
 	if (ucb->irq == NO_IRQ) {
-		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
+		dev_err(&ucb->dev, "IRQ probe failed\n");
 		ret = -ENODEV;
-		goto err_free;
+		goto err_no_irq;
 	}
 
 	ucb->gpio.base = -1;
@@ -581,25 +587,20 @@ static int ucb1x00_probe(struct mcp *mcp)
 		ucb->gpio.direction_output = ucb1x00_gpio_direction_output;
 		ret = gpiochip_add(&ucb->gpio);
 		if (ret)
-			goto err_free;
+			goto err_gpio_add;
 	} else
 		dev_info(&ucb->dev, "gpio_base not set so no gpiolib support");
 
 	ret = request_irq(ucb->irq, ucb1x00_irq, IRQF_TRIGGER_RISING,
 			  "UCB1x00", ucb);
 	if (ret) {
-		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
+		dev_err(&ucb->dev, "ucb1x00: unable to grab irq%d: %d\n",
 			ucb->irq, ret);
-		goto err_gpio;
+		goto err_irq;
 	}
 
 	mcp_set_drvdata(mcp, ucb);
 
-	ret = device_register(&ucb->dev);
-	if (ret)
-		goto err_irq;
-
-
 	INIT_LIST_HEAD(&ucb->devs);
 	mutex_lock(&ucb1x00_mutex);
 	list_add(&ucb->node, &ucb1x00_devices);
@@ -611,12 +612,13 @@ static int ucb1x00_probe(struct mcp *mcp)
 	return ret;
 
  err_irq:
-	free_irq(ucb->irq, ucb);
- err_gpio:
 	if (ucb->gpio.base != -1)
 		temp = gpiochip_remove(&ucb->gpio);
- err_free:
-	kfree(ucb);
+ err_gpio_add:
+ err_no_irq:
+	device_del(&ucb->dev);
+ err_dev_add:
+	put_device(&ucb->dev);
  err_disable:
 	mcp_disable(mcp);
  out:
-- 
1.7.4.4
