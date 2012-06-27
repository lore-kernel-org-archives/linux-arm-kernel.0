From: khilman@ti.com (Kevin Hilman)
Date: Tue, 26 Jun 2012 18:45:32 -0700
Subject: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
Message-ID: <1340761532-27231-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
failure.

Without this, after a failed xfer, the runtime PM usecount will have
been incremented, but not decremented causing the usecount to never
reach zero after a failure.  This keeps the device always runtime PM
enabled which keeps the enclosing power domain active, and prevents
full-chip retention/off from happening during idle.

Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This patch applies to current i2c-embedded/for-next branch

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9895fa7..b105733 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -582,7 +582,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (IS_ERR_VALUE(r))
-		return r;
+		goto out;
 
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
-- 
1.7.9.2
