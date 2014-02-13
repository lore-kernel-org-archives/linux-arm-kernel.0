From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Feb 2014 21:36:32 +0100
Subject: [PATCH 4/5] i2c: mv64xxx: directly call send_start when initializing
 transfer
In-Reply-To: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392323793-4125-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling the state machine with a definite state which is only used in
this context is superfluous. Do it directly.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 9c37b59..3af5266 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -97,7 +97,6 @@ enum {
 enum {
 	MV64XXX_I2C_ACTION_INVALID,
 	MV64XXX_I2C_ACTION_CONTINUE,
-	MV64XXX_I2C_ACTION_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_RESTART,
 	MV64XXX_I2C_ACTION_OFFLOAD_RESTART,
 	MV64XXX_I2C_ACTION_SEND_ADDR_1,
@@ -467,10 +466,6 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			drv_data->reg_base + drv_data->reg_offsets.control);
 		break;
 
-	case MV64XXX_I2C_ACTION_SEND_START:
-		mv64xxx_i2c_send_start(drv_data);
-		break;
-
 	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
 		writel(drv_data->addr1,
 			drv_data->reg_base + drv_data->reg_offsets.data);
@@ -628,12 +623,11 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 
-	drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
 	drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
 
 	drv_data->send_stop = is_last;
 	drv_data->block = 1;
-	mv64xxx_i2c_do_action(drv_data);
+	mv64xxx_i2c_send_start(drv_data);
 	spin_unlock_irqrestore(&drv_data->lock, flags);
 
 	mv64xxx_i2c_wait_for_completion(drv_data);
-- 
1.8.5.1
