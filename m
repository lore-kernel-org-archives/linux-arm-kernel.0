From: jbe@pengutronix.de (Juergen Beisert)
Date: Wed, 22 May 2013 12:19:43 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
 <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
Message-ID: <201305221219.43558.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> i2c slowness is a different issue.

Same happens here for my i.M23 based platform. It seems the PIO mode does not
work, or at least not like it works on a i.MX28. Each short transfer needs
about one second (without an error message) but does not send anything on the
I2C lines.

I need the following patches to make I2C master work within a 3.10-rc2 kernel:

Subject: [PATCH] I2C/MXS: distinguish i.MX23 and i.MX28 based I2C controller
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

---
 drivers/i2c/busses/i2c-mxs.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 2039f23..5e69d8c 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -97,10 +97,17 @@
 #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
 				 MXS_I2C_CTRL0_MASTER_MODE)
 
+enum mxs_i2c_devtype {
+	MXS_I2C_UNKNOWN = 0,
+	MXS_I2C_V1,
+	MXS_I2C_V2,
+};
+
 /**
  * struct mxs_i2c_dev - per device, private MXS-I2C data
  *
  * @dev: driver model device node
+ * @dev_type: distinguish i.MX23/i.MX28 features
  * @regs: IO registers pointer
  * @cmd_complete: completion object for transaction wait
  * @cmd_err: error code for last transaction
@@ -108,6 +115,7 @@
  */
 struct mxs_i2c_dev {
 	struct device *dev;
+	enum mxs_i2c_devtype dev_type;
 	void __iomem *regs;
 	struct completion cmd_complete;
 	int cmd_err;
@@ -633,8 +641,28 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
 	return 0;
 }
 
+static struct platform_device_id mxs_i2c_devtype[] = {
+	{
+		.name = "imx23-i2c",
+		.driver_data = MXS_I2C_V1,
+	}, {
+		.name = "imx28-i2c",
+		.driver_data = MXS_I2C_V2,
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, mxs_i2c_devtype);
+
+static const struct of_device_id mxs_i2c_dt_ids[] = {
+	{ .compatible = "fsl,imx23-i2c", .data = &mxs_i2c_devtype[0], },
+	{ .compatible = "fsl,imx28-i2c", .data = &mxs_i2c_devtype[1], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
+
 static int mxs_i2c_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+				of_match_device(mxs_i2c_dt_ids, &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct mxs_i2c_dev *i2c;
 	struct i2c_adapter *adap;
@@ -651,6 +679,11 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
+	if (of_id) {
+		const struct platform_device_id *device_id = of_id->data;
+		i2c->dev_type = device_id->driver_data;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 
@@ -726,12 +759,6 @@ static int mxs_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mxs_i2c_dt_ids[] = {
-	{ .compatible = "fsl,imx28-i2c", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_i2c_dt_ids);
-
 static struct platform_driver mxs_i2c_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
---------------------------------------------------------------------------------------------

Subject: [PATCH] I2C/MXS: on i.MX23 only do DMA based I2C transfers
Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

---
 drivers/i2c/busses/i2c-mxs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 5e69d8c..90cbac5 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -500,9 +500,10 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
 	 * using PIO mode while longer transfers use DMA. The 8 byte border is
 	 * based on this empirical measurement and a lot of previous frobbing.
+	 * Note: this special feature only works on i.MX28 SoC
 	 */
 	i2c->cmd_err = 0;
-	if (msg->len < 8) {
+	if (i2c->dev_type == MXS_I2C_V2 && msg->len < 8) {
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
 		if (ret)
 			mxs_i2c_reset(i2c);

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
