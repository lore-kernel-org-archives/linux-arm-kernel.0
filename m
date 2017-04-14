From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Apr 2017 22:53:12 +0200
Subject: [PATCH] i2c: designware: do not show SDA hold time warning when not
 needed
Message-ID: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the I2C controller IP block has a revision too old to be able to
configure the SDA hold time, the driver currently displays a
warning. However, it does so unconditionally, even if no SDA hold time
has been configured through the Device Tree. This causes useless
warnings when running the system, so only show the warning if a SDA
hold time was specified.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7a3faa5..7f9da6e 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -436,8 +436,9 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
 		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
 	} else {
-		dev_warn(dev->dev,
-			"Hardware too old to adjust SDA hold time.\n");
+		if (dev->sda_hold_time)
+			dev_warn(dev->dev,
+				 "Hardware too old to adjust SDA hold time.\n");
 	}
 
 	/* Configure Tx/Rx FIFO threshold levels */
-- 
2.7.4
