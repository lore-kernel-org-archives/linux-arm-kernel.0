From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:34 +0530
Subject: [PATCH 02/12] i2c: pxa: No need to set slave addr for i2c master mode
 reset
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jett.Zhou" <jtzhou@marvell.com>

Normally i2c controller works as master, so slave addr is not needed, or it
will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
the same i2c address with controller.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
[vaibhav.hiremath at linaro.org: Updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4ac8c5..d4c798a 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -459,8 +459,10 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	writel(I2C_ISR_INIT, _ISR(i2c));
 	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
 
+#ifdef CONFIG_I2C_PXA_SLAVE
 	if (i2c->reg_isar)
 		writel(i2c->slave_addr, _ISAR(i2c));
+#endif
 
 	/* set control register values */
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
-- 
1.9.1
