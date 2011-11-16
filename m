From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Nov 2011 11:47:38 +0100
Subject: [PATCH 2/3] i2c: mxs: use global reset function
In-Reply-To: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1321440459-4527-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The former mach specific reset_block function has been converted to a global
one. Use the new one to remove mach dependency from the driver.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/Kconfig   |    1 +
 drivers/i2c/busses/i2c-mxs.c |    9 ++-------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index a3afac4..76714a8 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -467,6 +467,7 @@ config I2C_MV64XXX
 config I2C_MXS
 	tristate "Freescale i.MX28 I2C interface"
 	depends on SOC_IMX28
+	select STMP_DEVICE
 	help
 	  Say Y here if you want to use the I2C bus controller on
 	  the Freescale i.MX28 processors.
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 7e78f7c..8b92e40 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -26,8 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 #include <linux/io.h>
-
-#include <mach/common.h>
+#include <linux/stmp_device.h>
 
 #define DRIVER_NAME "mxs-i2c"
 
@@ -110,13 +109,9 @@ struct mxs_i2c_dev {
 	struct i2c_adapter adapter;
 };
 
-/*
- * TODO: check if calls to here are really needed. If not, we could get rid of
- * mxs_reset_block and the mach-dependency. Needs an I2C analyzer, probably.
- */
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
-	mxs_reset_block(i2c->regs);
+	stmp_reset_block(i2c->regs);
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
-- 
1.7.7.1
