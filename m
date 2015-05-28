From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:40 +0530
Subject: [PATCH 08/12] i2c: pxa: enable/disable irq across message xfer
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-9-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid "spurious irq" caused by CP polling mode,
enable irq at the entry of i2c_pxa_xfer() fn and disable it
again before exit.
Also disable it before exiting probe function.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
[vaibhav.hiremath at linaro.org: Split & merge patches into logical changes
and update the Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 3c6ebb5..a3ac97c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1163,6 +1163,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	enable_irq(i2c->irq);
 	for (i = adap->retries; i >= 0; i--) {
 		ret = i2c_pxa_do_xfer(i2c, msgs, num);
 		if (ret != I2C_RETRY)
@@ -1176,6 +1177,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+	disable_irq(i2c->irq);
 	return ret;
 }
 
@@ -1363,6 +1365,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c_pxa_reset(i2c);
 
+	disable_irq(i2c->irq);
+
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
 #ifdef CONFIG_OF
-- 
1.9.1
