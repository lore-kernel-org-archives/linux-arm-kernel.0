From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 31 Aug 2018 23:30:47 +0900
Subject: [PATCH 1/2] i2c: uniphier: issue STOP only for last message or
 I2C_M_STOP
Message-ID: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index bb181b0..454f914 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -248,11 +248,8 @@ static int uniphier_i2c_master_xfer(struct i2c_adapter *adap,
 		return ret;
 
 	for (msg = msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop = !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop = true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop = (msg + 1 == emsg) || (msg->flags & I2C_M_STOP);
 
 		ret = uniphier_i2c_master_xfer_one(adap, msg, stop);
 		if (ret)
-- 
2.7.4
