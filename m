From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu,  5 Jan 2017 11:47:20 +0100
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's ready
Message-ID: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver calls i2c_add_adapter before writing to config registers,
resulting in dmesg output like this, where devices fail to initialize:

cdns-i2c ff030000.i2c: timeout waiting on completion
pca953x 1-0041: failed reading register
pca953x: probe of 1-0041 failed with error -110
at24 1-0050: 512 byte 24c04 EEPROM, writable, 1 bytes/write
cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197

The adapter is being used before it completed the "probe". To fix
this, make "i2c_add_adapter" the last thing it calls in probe.
It also makes sense to show the adapter initialization before
the devices on the bus.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/i2c/busses/i2c-cadence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6869712..7793bb8 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -962,10 +962,6 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		goto err_clk_dis;
 	}
 
-	ret = i2c_add_adapter(&id->adap);
-	if (ret < 0)
-		goto err_clk_dis;
-
 	/*
 	 * Cadence I2C controller has a bug wherein it generates
 	 * invalid read transaction after HW timeout in master receiver mode.
@@ -978,6 +974,10 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
 		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
 
+	ret = i2c_add_adapter(&id->adap);
+	if (ret < 0)
+		goto err_clk_dis;
+
 	return 0;
 
 err_clk_dis:
-- 
1.9.1
