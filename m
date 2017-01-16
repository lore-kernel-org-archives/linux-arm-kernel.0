From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 16 Jan 2017 15:49:38 +0100
Subject: [PATCH v2] i2c: i2c-cadence: Initialize configuration before probing
 devices
Message-ID: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cadence I2C driver calls cdns_i2c_writereg(..) to setup a workaround
in the controller, but did so after calling i2c_add_adapter() which starts
probing devices on the bus. Change the order so that the configuration is
completely finished before using the adapter.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Only move the initialization to before i2c_add_adapter, don't change the
    logging output.
 drivers/i2c/busses/i2c-cadence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6869712..45d6771 100644
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
@@ -975,6 +971,10 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	 */
 	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
 
+	ret = i2c_add_adapter(&id->adap);
+	if (ret < 0)
+		goto err_clk_dis;
+
 	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
 		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
 
-- 
1.9.1
