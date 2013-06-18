From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jun 2013 17:40:23 +0200
Subject: [PATCH v2 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
In-Reply-To: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1371570024-11613-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zbigniew Bodek <zbb@semihalf.com>

All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
in the I2C controller which violate the i2c repeated start
timing. The I2C standard requires a minimum of 4.7us for the repeated
start condition whereas the I2C controller of the Armada XP this time
is 2.9us.

So this patch adds a 5us delay for the start case only if the
mv64xxx_i2c_errata_delay flag is set.

[gregory.clement at free-electrons.com: Use the delay flasg as per-I2C
controller variable]
[gregory.clement at free-electrons.com: Merge the incoming commits into
this single one]
[gregory.clement at free-electrons.com: Reword the commit log]

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 1a3abd6..74f8fcb 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -23,6 +23,7 @@
 #include <linux/of_i2c.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 /* Register defines */
 #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
@@ -103,6 +104,10 @@ struct mv64xxx_i2c_data {
 	int			rc;
 	u32			freq_m;
 	u32			freq_n;
+
+/* 5us delay in order to avoid repeated start timing violation */
+	bool mv64xxx_i2c_errata_delay;
+
 #if defined(CONFIG_HAVE_CLK)
 	struct clk              *clk;
 #endif
@@ -252,6 +257,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
+		if (drv_data->mv64xxx_i2c_errata_delay)
+			udelay(5);
+
 		wake_up(&drv_data->waitq);
 		break;
 
@@ -300,6 +308,9 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
 		drv_data->block = 0;
+		if (drv_data->mv64xxx_i2c_errata_delay)
+			udelay(5);
+
 		wake_up(&drv_data->waitq);
 		break;
 
@@ -592,6 +603,9 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	 * So hard code the value to 1 second.
 	 */
 	drv_data->adapter.timeout = HZ;
+
+	if (of_machine_is_compatible("marvell,armadaxp"))
+		drv_data->mv64xxx_i2c_errata_delay = 1;
 out:
 	return rc;
 #endif
-- 
1.8.1.2
