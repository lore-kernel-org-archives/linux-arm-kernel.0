From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:51 +0530
Subject: [PATCH-v3 07/11] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-8-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yi Zhang <yizhang@marvell.com>

Enable i2c module/unit before transmission and disable when it finishes.

why?
It's because the i2c bus may be distrubed if the slave device,
typically a touch, powers on.

As we do not want to break slave mode support, this patch introduces
DT property to control disable of the I2C module after xfer in master mode
of operation.

i2c-disable-after-xfer : If set, driver will disable I2C module after msg xfer

Signed-off-by: Yi Zhang <yizhang@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2de9300..dfd1dd0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -161,6 +161,7 @@ struct pxa_i2c {
 	unsigned char		master_code;
 	unsigned long		rate;
 	bool			highmode_enter;
+	bool			disable_after_xfer;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -284,6 +285,24 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
 static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 
+/* enable/disable i2c unit */
+static inline int i2c_pxa_is_enabled(struct pxa_i2c *i2c)
+{
+	return (readl(_ICR(i2c)) & ICR_IUE);
+}
+
+static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
+{
+	if (enable) {
+		if (!i2c_pxa_is_enabled(i2c)) {
+			writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
+			udelay(100);
+		}
+	} else {
+		writel(readl(_ICR(i2c)) & ~ICR_IUE, _ICR(i2c));
+	}
+}
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
@@ -480,8 +499,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	i2c_pxa_set_slave(i2c, 0);
 
 	/* enable unit */
-	writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
-	udelay(100);
+	i2c_pxa_enable(i2c, true);
 }
 
 
@@ -832,6 +850,9 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	/* Enable i2c unit */
+	i2c_pxa_enable(i2c, true);
+
 	/* If the I2C controller is disabled we need to reset it
 	  (probably due to a suspend/resume destroying state). We do
 	  this here as we can then avoid worrying about resuming the
@@ -852,6 +873,11 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+
+	/* disable i2c unit */
+	if (i2c->disable_after_xfer)
+		i2c_pxa_enable(i2c, false);
+
 	return ret;
 }
 
@@ -1067,6 +1093,9 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	/* Enable i2c unit */
+	i2c_pxa_enable(i2c, true);
+
 	for (i = adap->retries; i >= 0; i--) {
 		ret = i2c_pxa_do_xfer(i2c, msgs, num);
 		if (ret != I2C_RETRY)
@@ -1080,6 +1109,10 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+	/* disable i2c unit */
+	if (i2c->disable_after_xfer)
+		i2c_pxa_enable(i2c, false);
+
 	return ret;
 }
 
@@ -1120,6 +1153,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 	/* For device tree we always use the dynamic or alias-assigned ID */
 	i2c->adap.nr = -1;
 
+	i2c->disable_after_xfer = of_property_read_bool(np,
+				"i2c-disable-after-xfer");
+
 	if (of_get_property(np, "mrvl,i2c-polling", NULL))
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
@@ -1271,6 +1307,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, i2c);
 
+	if (i2c->disable_after_xfer)
+		i2c_pxa_enable(i2c, false);
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, " PXA I2C adapter, slave address %d\n",
 		i2c->slave_addr);
-- 
1.9.1
