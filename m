From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 15 Nov 2012 14:19:21 +0530
Subject: [PATCHv3] i2c: omap: Move the remove constraint
Message-ID: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we just queue the transfer and release the
qos constraints, however we do not wait for the transfer
to complete to release the constraint. Move the remove
constraint after the bus busy as we are sure that the
transfers are completed by then.

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
v2: rebase to the for-next branch
v3: Fix a typo

 drivers/i2c/busses/i2c-omap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 482c63d..fabcbe1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -654,13 +654,14 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-	if (dev->set_mpu_wkup_lat != NULL)
-		dev->set_mpu_wkup_lat(dev->dev, -1);
-
 	if (r == 0)
 		r = num;
 
 	omap_i2c_wait_for_bb(dev);
+
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, -1);
+
 out:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
1.7.5.4
