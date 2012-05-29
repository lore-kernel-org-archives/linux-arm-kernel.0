From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 29 May 2012 16:26:21 +0530
Subject: [PATCHv10 09/11] I2C: OMAP: Do not set the XUDF(Transmit underflow)
 if the underflow is not reached
In-Reply-To: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1338288983-15026-10-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in the 1.153 errata handling, while waiting for transmitter
underflow, if NACK is got the XUDF(Transmit underflow) flag is also set.
Fix this by setting the XUDF(Transmit underflow) flag after wait for the
condition is over.

Cc: Alexander Shishkin <virtuoso@slind.org>
Acked-by: Moiz Sonasath <m-sonasath@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
-v10 Change the punctuation and reword.
-v9 XUDF is expanded to transmit underflow

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6129cb8..cd6feea 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -730,7 +730,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
-			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
 
@@ -743,6 +742,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 		return 0;
 	}
 
+	*err |= OMAP_I2C_STAT_XUDF;
 	return 0;
 }
 
-- 
1.7.5.4
