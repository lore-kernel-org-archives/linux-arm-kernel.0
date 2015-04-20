From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 20 Apr 2015 15:14:47 -0700
Subject: [PATCH] i2c: rk3x: report number of messages transmitted
Message-ID: <20150420221447.GA2005@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

master_xfer() method should return number of i2c messages transferred,
but on Rockchip we were usually returning just 1, which caused trouble
with users that actually check number of transferred messages vs.
checking for negative error codes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 5f96b1b..019d542 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -833,7 +833,7 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap,
 	clk_disable(i2c->clk);
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
-	return ret;
+	return ret < 0 ? ret : num;
 }
 
 static u32 rk3x_i2c_func(struct i2c_adapter *adap)
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
