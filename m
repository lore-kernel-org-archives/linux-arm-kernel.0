From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Feb 2014 21:36:30 +0100
Subject: [PATCH 2/5] i2c: mv64xxx: refactor message start to ensure proper
 initialization
In-Reply-To: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392323793-4125-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the offload mechanism can fall back to a standard transfer,
having two seperate initialization states is unfortunate. Let's just
have one state which does things consistently. This fixes a bug where
some preparation was missing when the fallback happened. And it makes
the code much easier to follow.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index ba64978..d52d849 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -97,7 +97,6 @@ enum {
 enum {
 	MV64XXX_I2C_ACTION_INVALID,
 	MV64XXX_I2C_ACTION_CONTINUE,
-	MV64XXX_I2C_ACTION_OFFLOAD_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_START,
 	MV64XXX_I2C_ACTION_SEND_RESTART,
 	MV64XXX_I2C_ACTION_OFFLOAD_RESTART,
@@ -460,15 +459,14 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			drv_data->reg_base + drv_data->reg_offsets.control);
 		break;
 
-	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
-		if (!mv64xxx_i2c_offload_msg(drv_data))
-			break;
-		else
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
-		/* FALLTHRU */
 	case MV64XXX_I2C_ACTION_SEND_START:
-		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
-			drv_data->reg_base + drv_data->reg_offsets.control);
+		/* Can we offload this msg ? */
+		if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
+			/* No, switch to standard path */
+			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
+			writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
+				drv_data->reg_base + drv_data->reg_offsets.control);
+		}
 		break;
 
 	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
@@ -627,15 +625,10 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
 	unsigned long	flags;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
-	if (drv_data->offload_enabled) {
-		drv_data->action = MV64XXX_I2C_ACTION_OFFLOAD_SEND_START;
-		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
-	} else {
-		mv64xxx_i2c_prepare_for_io(drv_data, msg);
 
-		drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
-		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
-	}
+	drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+	drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+
 	drv_data->send_stop = is_last;
 	drv_data->block = 1;
 	mv64xxx_i2c_do_action(drv_data);
-- 
1.8.5.1
