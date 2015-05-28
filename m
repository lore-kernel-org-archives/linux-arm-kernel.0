From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:44 +0530
Subject: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yi Zhang <yizhang@marvell.com>

Enable i2c module/unit before transmission and disable when it finishes.

why?
It's because the i2c bus may be distrubed if the slave device,
typically a touch, powers on.

Signed-off-by: Yi Zhang <yizhang@marvell.com>
[vaibhav.hiremath at linaro.org: ported to latest kernel & also improved changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 844e1fc..f51d512 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -368,6 +368,16 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
 static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
 
+/* enable/disable i2c unit */
+static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
+{
+	if (enable)
+		writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
+	else
+		writel(readl(_ICR(i2c)) & ~ICR_IUE, _ICR(i2c));
+	udelay(100);
+}
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
@@ -575,8 +585,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	i2c_pxa_set_slave(i2c, 0);
 
 	/* enable unit */
-	writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
-	udelay(100);
+	i2c_pxa_enable(i2c, true);
 }
 
 
@@ -933,6 +942,9 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	/* Enable i2c unit */
+	i2c_pxa_enable(i2c, true);
+
 	/* If the I2C controller is disabled we need to reset it
 	  (probably due to a suspend/resume destroying state). We do
 	  this here as we can then avoid worrying about resuming the
@@ -953,6 +965,10 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+
+	/* disable i2c unit */
+	i2c_pxa_enable(i2c, false);
+
 	return ret;
 }
 
@@ -1168,6 +1184,9 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	/* Enable i2c unit */
+	i2c_pxa_enable(i2c, true);
+
 	enable_irq(i2c->irq);
 	for (i = adap->retries; i >= 0; i--) {
 		ret = i2c_pxa_do_xfer(i2c, msgs, num);
@@ -1183,6 +1202,9 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
  out:
 	i2c_pxa_set_slave(i2c, ret);
 	disable_irq(i2c->irq);
+	/* disable i2c unit */
+	i2c_pxa_enable(i2c, false);
+
 	return ret;
 }
 
@@ -1407,6 +1429,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 			ret = 0;
 		}
 	}
+
+	i2c_pxa_enable(i2c, false);
+
 #ifdef CONFIG_I2C_PXA_SLAVE
 	pr_info("I2C: %s: PXA I2C adapter, slave address %d\n",
 	       dev_name(&i2c->adap.dev), i2c->slave_addr);
-- 
1.9.1
