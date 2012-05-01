From: marex@denx.de (Marek Vasut)
Date: Tue,  1 May 2012 04:00:19 +0200
Subject: =?UTF-8?q?=5BPATCH=202/4=5D=20MXS=3A=20Set=20I2C=20timing=20registers=20for=20mxs-i2c?=
In-Reply-To: <1335837621-14816-1-git-send-email-marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
Message-ID: <1335837621-14816-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures the I2C bus timing registers according
to information passed via platform data. Currently, 100kHz and
400kHz modes are supported.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: linux-i2c at vger.kernel.org
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-mxs.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 3d471d5..717b7f9 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/i2c/mxs-i2c.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
@@ -43,6 +44,10 @@
 #define MXS_I2C_CTRL0_DIRECTION			0x00010000
 #define MXS_I2C_CTRL0_XFER_COUNT(v)		((v) & 0x0000FFFF)
 
+#define MXS_I2C_TIMING0		(0x10)
+#define MXS_I2C_TIMING1		(0x20)
+#define MXS_I2C_TIMING2		(0x30)
+
 #define MXS_I2C_CTRL1		(0x40)
 #define MXS_I2C_CTRL1_SET	(0x44)
 #define MXS_I2C_CTRL1_CLR	(0x48)
@@ -94,6 +99,25 @@
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
+
+struct mxs_i2c_speed_config {
+	uint32_t	timing0;
+	uint32_t	timing1;
+	uint32_t	timing2;
+};
+
+const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
+	.timing0	= 0x00780030,
+	.timing1	= 0x00800030,
+	.timing2	= 0x0015000d,
+};
+
+const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
+	.timing0	= 0x000f0007,
+	.timing1	= 0x001f000f,
+	.timing2	= 0x0015000d,
+};
+
 /**
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
@@ -109,6 +133,7 @@ struct mxs_i2c_dev {
 	struct completion cmd_complete;
 	u32 cmd_err;
 	struct i2c_adapter adapter;
+	const struct mxs_i2c_speed_config *speed;
 };
 
 /*
@@ -118,6 +143,11 @@ struct mxs_i2c_dev {
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
 	mxs_reset_block(i2c->regs);
+
+	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
+	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
+	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
+
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
 			i2c->regs + MXS_I2C_QUEUECTRL_SET);
@@ -321,12 +351,16 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct mxs_i2c_platform_data *pdata = pdev->dev.platform_data;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
 	struct resource *res;
 	resource_size_t res_size;
 	int err, irq;
 
+	if (!pdata)
+		return -ENODEV;
+
 	i2c = devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -352,6 +386,14 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
 		return err;
 
 	i2c->dev = dev;
+
+	/* Configure the bus speed. */
+	i2c->speed = &mxs_i2c_95kHz_config;
+	if (pdata->speed_khz == 400)
+		i2c->speed = &mxs_i2c_400kHz_config;
+	else if (pdata->speed_khz != 100)
+		dev_err(dev, "Invalid I2C speed selected, using 100kHz\n");
+
 	platform_set_drvdata(pdev, i2c);
 
 	/* Do reset to enforce correct startup after pinmuxing */
-- 
1.7.10
