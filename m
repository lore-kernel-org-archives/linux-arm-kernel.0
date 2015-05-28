From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 19:02:48 +0530
Subject: [PATCH 3/3] i2c: pxa: Add pin ctrl support for CP core access
In-Reply-To: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432819968-17515-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432819968-17515-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMIC TWSI pins configuration for AP and CP is different on
eden, it need to be set to function 0 when AP get RIPC lock.
When AP release RIPC lock, it also need configure twsi pins
to other state, otherwise pinctrl will assume pins configration
is not changed even if it is changed by CP, so it will not
change twsi pins configuration to AP state when AP get RIPC
next time.

Signed-off-by: Shouming Wang <wangshm@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index eb26eb1..1340de1 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -184,6 +184,7 @@ struct pxa_i2c {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	*pin_i2c;
 	struct pinctrl_state	*pin_gpio;
+	struct pinctrl_state	*pin_i2c_cp;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -405,6 +406,10 @@ void mmp_hwlock_lock(struct i2c_adapter *adap)
 	ripc_status = true;
 
 	spin_unlock_irqrestore(&lock_for_ripc, flags);
+
+	if (pinctrl_select_state(i2c->pinctrl, i2c->pin_i2c) < 0)
+		dev_err(&i2c->adap.dev, "could not set i2c AP pins\n");
+
 }
 
 void mmp_hwlock_unlock(struct i2c_adapter *adap)
@@ -413,6 +418,9 @@ void mmp_hwlock_unlock(struct i2c_adapter *adap)
 
 	struct pxa_i2c *i2c = adap->algo_data;
 
+	if (pinctrl_select_state(i2c->pinctrl, i2c->pin_i2c_cp) < 0)
+		dev_err(&i2c->adap.dev, "could not set i2c CP pins\n");
+
 	spin_lock_irqsave(&lock_for_ripc, flags);
 	__raw_writel(1, i2c->hwlock_addr);
 	ripc_status = false;
@@ -430,6 +438,9 @@ int mmp_hwlock_trylock(struct i2c_adapter *adap)
 	ripc_status = !__raw_readl(i2c->hwlock_addr);
 	spin_unlock_irqrestore(&lock_for_ripc, flags);
 
+	if (ripc_status && (pinctrl_select_state(i2c->pinctrl, i2c->pin_i2c) < 0))
+		dev_err(&i2c->adap.dev, "could not set i2c AP pins\n");
+
 	return ripc_status;
 }
 
@@ -1497,8 +1508,14 @@ static int i2c_pxa_probe(struct platform_device *dev)
 			ret = IS_ERR(i2c->pin_gpio);
 		}
 
+		/* pin ctrl for CP - optional */
+		i2c->pin_i2c_cp = pinctrl_lookup_state(i2c->pinctrl, "i2c_cp");
+		if (IS_ERR(i2c->pin_i2c_cp))
+			dev_err(&dev->dev, "could not get i2c_cp pinstate\n");
+
 		if (ret) {
 			i2c->pin_i2c = NULL;
+			i2c->pin_i2c_cp = NULL;
 			i2c->pin_gpio = NULL;
 			i2c->pinctrl = NULL;
 			ret = 0;
-- 
1.9.1
