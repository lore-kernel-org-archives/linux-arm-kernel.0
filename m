From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:39 +0530
Subject: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in interrupt
 and pio mode
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of timeout during msg xfer assert reset to
i2c controller for both interrupt and PIO mode of operation.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
[vaibhav.hiremath at linaro.org: Split & merge patches into logical changes
and update the Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2777d5c..3c6ebb5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -197,6 +197,8 @@ struct pxa_i2c {
  */
 #define I2C_PXA_SLAVE_ADDR      0x1
 
+static void i2c_pxa_reset(struct pxa_i2c *i2c);
+
 #ifdef DEBUG
 
 struct bits {
@@ -846,6 +848,9 @@ out:
 		ret = I2C_RETRY;
 	}
 
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
@@ -912,6 +917,9 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	}
 
  out:
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
-- 
1.9.1
