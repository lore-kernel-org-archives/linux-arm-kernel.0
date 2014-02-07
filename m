From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Feb 2014 11:55:54 +0100
Subject: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected but not
 used on a message
Message-ID: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Offload can be used only on regular transactions and for 1 to byte
transfers. In the other cases we switch back to usual work flow.

In this case we need to call mv64xxx_i2c_prepare_for_io() as this
function is not used when we try to use offloading.

This commit adds this missing call when offloading have failed in the
MV64XXX_I2C_ACTION_OFFLOAD_SEND_START case.

This fix the timeout seen when the the i2c driver try to access an
address where the device is absent on the Armada XP bases board.

Cc: stable at vger.kernel.org # v3.12+
Fixes: 930ab3d403ae (i2c: mv64xxx: Add I2C Transaction Generator support)

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b8c5187b9ee0..a1700c62d955 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -461,8 +461,15 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
 		if (!mv64xxx_i2c_offload_msg(drv_data))
 			break;
-		else
+		else {
 			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+			/*
+			 * Switch to the standard path, so we finally need to
+			 * prepare the io that have not been done in
+			 * mv64xxx_i2c_execute_msg
+			 */
+			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
+		}
 		/* FALLTHRU */
 	case MV64XXX_I2C_ACTION_SEND_START:
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
-- 
1.8.1.2
