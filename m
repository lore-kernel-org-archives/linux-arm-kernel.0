From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  1 Sep 2016 20:46:30 +0900
Subject: [PATCH 3/3] i2c: uniphier-f: set the adapter to master mode when
 probing
In-Reply-To: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
References: <1472730390-8907-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1472730390-8907-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the adapter is set to the master mode at the first use.
Since then, it is kept in the slave mode, so unexpected glitch
signals on the I2C lines may cause the adapter into insane state.
Setting it to the master mode along with initialization solves the
problem.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reported-by: Akio Noda <noda.akio@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 2886685..829df91 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -458,16 +458,20 @@ static struct i2c_bus_recovery_info uniphier_fi2c_bus_recovery_info = {
 static void uniphier_fi2c_hw_init(struct uniphier_fi2c_priv *priv,
 				  u32 bus_speed, unsigned long clk_rate)
 {
-	u32 clk_count;
+	u32 tmp;
+
+	tmp = readl(priv->membase + UNIPHIER_FI2C_CR);
+	tmp |= UNIPHIER_FI2C_CR_MST;
+	writel(tmp, priv->membase + UNIPHIER_FI2C_CR);
 
 	uniphier_fi2c_reset(priv);
 
-	clk_count = clk_rate / bus_speed;
+	tmp = clk_rate / bus_speed;
 
-	writel(clk_count, priv->membase + UNIPHIER_FI2C_CYC);
-	writel(clk_count / 2, priv->membase + UNIPHIER_FI2C_LCTL);
-	writel(clk_count / 2, priv->membase + UNIPHIER_FI2C_SSUT);
-	writel(clk_count / 16, priv->membase + UNIPHIER_FI2C_DSUT);
+	writel(tmp, priv->membase + UNIPHIER_FI2C_CYC);
+	writel(tmp / 2, priv->membase + UNIPHIER_FI2C_LCTL);
+	writel(tmp / 2, priv->membase + UNIPHIER_FI2C_SSUT);
+	writel(tmp / 16, priv->membase + UNIPHIER_FI2C_DSUT);
 
 	uniphier_fi2c_prepare_operation(priv);
 }
-- 
1.9.1
