From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 16 May 2013 21:36:11 +0100
Subject: [PATCH 6/9] I2C: mv64xxx: fix error handling for request_irq()
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Message-ID: <E1Ud4uJ-0004Jt-0s@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Propagate the error code from request_irq() rather than ignoring it
entirely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 841792f..a82ab25 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -630,12 +630,12 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 	mv64xxx_i2c_hw_init(drv_data);
 
-	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-			MV64XXX_I2C_CTLR_NAME, drv_data)) {
+	rc = request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
+			 MV64XXX_I2C_CTLR_NAME, drv_data);
+	if (rc) {
 		dev_err(&drv_data->adapter.dev,
-			"mv64xxx: Can't register intr handler irq: %d\n",
-			drv_data->irq);
-		rc = -EINVAL;
+			"mv64xxx: Can't register intr handler irq%d: %d\n",
+			drv_data->irq, rc);
 		goto exit_clk;
 	} else if ((rc = i2c_add_numbered_adapter(&drv_data->adapter)) != 0) {
 		dev_err(&drv_data->adapter.dev,
-- 
1.7.4.4
