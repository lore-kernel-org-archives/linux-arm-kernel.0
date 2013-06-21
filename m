From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Jun 2013 15:32:08 +0200
Subject: [PATCH v3 3/4] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
In-Reply-To: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371821529-13791-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
in the I2C controller which violate the i2c repeated start
timing. The I2C standard requires a minimum of 4.7us for the repeated
start condition whereas the I2C controller of the Armada XP this time
is 2.9us.

So this patch adds a 5us delay for the start case only if the
the compatible i2c-mv78230 is set.

Based on the initals patches from Zbigniew Bodek

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index c07e742..e5b9c42 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -24,6 +24,7 @@
 #include <linux/of_i2c.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 #define MV64XXX_I2C_ADDR_ADDR(val)			((val & 0x7f) << 1)
 #define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
@@ -147,6 +148,8 @@ struct mv64xxx_i2c_data {
 	struct i2c_msg		*msg;
 	struct i2c_adapter	adapter;
 	bool			offload_enabled;
+/* 5us delay in order to avoid repeated start timing violation */
+	bool			errata_delay;
 };
 
 static struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
@@ -450,6 +453,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 			/* Setup for the next message */
 			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
 		}
+		if (drv_data->errata_delay)
+			udelay(5);
+
 		/*
 		 * We're never at the start of the message here, and by this
 		 * time it's already too late to do any protocol mangling.
@@ -509,6 +515,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + drv_data->reg_offsets.control);
 		drv_data->block = 0;
+		if (drv_data->errata_delay)
+			udelay(5);
+
 		wake_up(&drv_data->waitq);
 		break;
 
@@ -780,10 +789,12 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 
 	/*
 	 * For controllers embedded in new SoCs activate the
-	 * Transaction Generator support.
+	 * Transaction Generator support and the errata fix.
 	 */
-	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
+	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
 		drv_data->offload_enabled = true;
+		drv_data->errata_delay = true;
+	}
 
 out:
 	return rc;
-- 
1.8.1.2
