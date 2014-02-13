From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Feb 2014 21:36:29 +0100
Subject: [PATCH 1/5] i2c: mv64xxx: put offload check into offload prepare
 function
In-Reply-To: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392323793-4125-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes code simpler to read and prepares a reorganization needed for a
bugfix.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b8c5187..ba64978 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -204,6 +204,9 @@ static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
 	unsigned long ctrl_reg;
 	struct i2c_msg *msg = drv_data->msgs;
 
+	if (!drv_data->offload_enabled)
+		return -EOPNOTSUPP;
+
 	drv_data->msg = msg;
 	drv_data->byte_posn = 0;
 	drv_data->bytes_left = msg->len;
@@ -433,8 +436,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 
 		drv_data->msgs++;
 		drv_data->num_msgs--;
-		if (!(drv_data->offload_enabled &&
-				mv64xxx_i2c_offload_msg(drv_data))) {
+		if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
 			drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
 			writel(drv_data->cntl_bits,
 			drv_data->reg_base + drv_data->reg_offsets.control);
-- 
1.8.5.1
