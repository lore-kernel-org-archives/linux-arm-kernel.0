From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 31 Aug 2018 23:30:48 +0900
Subject: [PATCH 2/2] i2c: uniphier-f: issue STOP only for last message or
 I2C_M_STOP
In-Reply-To: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 9918bdd..a403e85 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -401,11 +401,8 @@ static int uniphier_fi2c_master_xfer(struct i2c_adapter *adap,
 		return ret;
 
 	for (msg = msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop = !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop = true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop = (msg + 1 == emsg) || (msg->flags & I2C_M_STOP);
 
 		ret = uniphier_fi2c_master_xfer_one(adap, msg, stop);
 		if (ret)
-- 
2.7.4
