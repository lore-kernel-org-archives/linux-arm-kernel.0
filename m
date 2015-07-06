From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:46 +0530
Subject: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c master
 mode reset
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Normally i2c controller works as master, so slave addr is not needed, or it
will impact some slave device (eg. ST NFC chip) i2c accesses, because it has
the same i2c address with controller.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/i2c/busses/i2c-pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4ac8c5..023e59f 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -459,7 +459,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	writel(I2C_ISR_INIT, _ISR(i2c));
 	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
 
-	if (i2c->reg_isar)
+	if (i2c->reg_isar && IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
 		writel(i2c->slave_addr, _ISAR(i2c));
 
 	/* set control register values */
-- 
1.9.1
