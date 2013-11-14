From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 15:08:42 -0800
Subject: [PATCH 9/8] i2c: Fix device tree binding for i2c-cbus-gpio
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Message-ID: <20131114230842.GU10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like we're missing two lines needed to make it
work properly with device tree.

Cc: linux-i2c at vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Wolfram, I found one more bug booting omaps with device tree.

--- a/drivers/i2c/busses/i2c-cbus-gpio.c
+++ b/drivers/i2c/busses/i2c-cbus-gpio.c
@@ -246,6 +246,7 @@ static int cbus_i2c_probe(struct platform_device *pdev)
 	adapter->owner		= THIS_MODULE;
 	adapter->class		= I2C_CLASS_HWMON;
 	adapter->dev.parent	= &pdev->dev;
+	adapter->dev.of_node	= pdev->dev.of_node;
 	adapter->nr		= pdev->id;
 	adapter->timeout	= HZ;
 	adapter->algo		= &cbus_i2c_algo;
@@ -289,6 +290,7 @@ static struct platform_driver cbus_i2c_driver = {
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-cbus-gpio",
+		.of_match_table = of_match_ptr(i2c_cbus_dt_ids),
 	},
 };
 module_platform_driver(cbus_i2c_driver);
