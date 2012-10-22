From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 12:46:58 +0300
Subject: [PATCH 8/8] i2c: omap: implement handling for 'transferred' bytes
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Message-ID: <1350899218-13624-9-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is important in cases where client driver
wants to know how many bytes were actually
transferred.

There is one trick here: if transfer is completed,
meaning I2C_CNT reaches zero, then ARDY will be
asserted to let SW know that it can program a
new transfer.

When ARDY is asserted, I2C_CNT is reset to the
original value (msg->len), which means that
for a successful message, msg->transferred = msg->len
and we don't need to spend time with a register
read.

In case of NACK condition, however, I2C_CNT will
remain with the end value which is the amount of
data transferred until NACK condition found on the
bus inclusive. In this situation, msg->transferred
needs to be initialized with:

msg->len - read(I2C_CNT) - 1;

This patch implements exactly that handling.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8104aa2..f59c8cd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -594,6 +594,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		goto out;
 	}
 
+	msg->transferred = msg->len;
+	wmb();
+
 	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
 			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
 			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
@@ -603,6 +606,15 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	}
 
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
+		/* In case of a NACK, we need to check how many bytes we
+		 * actually transferred, so we can tell our client driver about
+		 * it.
+		 *
+		 * Let's check it here and overwrite msg->transferred.
+		 */
+		w = omap_i2c_read_reg(dev, OMAP_I2C_CNT_REG);
+		msg->transferred = msg->len - w - 1;
+
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
 
-- 
1.8.0.rc0
