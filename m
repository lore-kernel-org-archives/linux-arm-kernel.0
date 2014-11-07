From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Fri, 07 Nov 2014 12:10:44 +0000
Subject: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
Message-ID: <545CB6C4.8010201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
set to zero, allowing the TX FIFO to become empty causes a STOP
condition to be generated on the I2C bus. If the transmit FIFO
threshold is set too high, an erroneous STOP condition can be
generated on long transfers - particularly where the interrupt
latency is extended.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/i2c/busses/i2c-designware-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 3c20e4b..e070edd 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -363,7 +363,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	}
 
 	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
+	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
 	/* configure the i2c master */
-- 
1.7.1
