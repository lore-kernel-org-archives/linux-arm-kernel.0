From: florian.meier@koalo.de (Florian Meier)
Date: Fri, 08 Nov 2013 10:49:21 +0100
Subject: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Message-ID: <527CB3A1.7050808@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to find I2C devices in the device tree, the platform nodes
have to be known by the I2C core. Analogous to the i2c-omap driver
this requires setting the dev.of_node parameter of the adapter.

Signed-off-by: Florian Meier <florian.meier@koalo.de>
---

I don't know if this is really necessary, but for me it does not work
without this line.

 drivers/i2c/busses/i2c-bcm2835.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index ea4b08f..8beecfa 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -299,6 +299,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
+	adap->dev.of_node = pdev->dev.of_node;
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
 
-- 
1.7.9.5
