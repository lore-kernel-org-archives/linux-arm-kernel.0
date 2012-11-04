From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Sun, 4 Nov 2012 16:14:33 +0530
Subject: [PATCHv2 7/7] i2c: omap: Restore i2c context always
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1352025873-27492-8-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the restore is done based on the flag
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE.

This helps the following
- The driver is always capable of restoring regardless
of the off mode support being there or not.

- While testing omap2430 it is found that in case of certain
error paths (timeout) a reset is done. However the restore
never happens as it is dependent on the POSTIDLE flag.
The other option would be to call a restore in the reset
case. As there are only a few registers to be restored
the penalty in the idle case should not be much.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Todo: the flag could be deleted if the patch is accepted.

 drivers/i2c/busses/i2c-omap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 70d43b7..f66c5ab 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1314,8 +1314,7 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	if (!_dev->regs)
 		return 0;
 
-	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
-		__omap_i2c_init(_dev);
+	__omap_i2c_init(_dev);
 
 	return 0;
 }
-- 
1.7.5.4
