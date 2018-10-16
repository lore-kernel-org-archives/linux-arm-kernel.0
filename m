From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Oct 2018 12:01:49 +0900
Subject: [PATCH 3/3] i2c: uniphier-f: fix race condition when IRQ is cleared
In-Reply-To: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1539658909-26691-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current IRQ handler clears all the IRQ status bits when it bails
out. This is dangerous because it might clear away the status bits
that have just been set while processing the current handler. If this
happens, the IRQ event for the latest transfer is lost forever.

The IRQ status bits must be cleared *before* the next transfer is
kicked.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 0677153..dd38474 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -143,9 +143,10 @@ static void uniphier_fi2c_set_irqs(struct uniphier_fi2c_priv *priv)
 	writel(priv->enabled_irqs, priv->membase + UNIPHIER_FI2C_IE);
 }
 
-static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv)
+static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv,
+				     u32 mask)
 {
-	writel(-1, priv->membase + UNIPHIER_FI2C_IC);
+	writel(mask, priv->membase + UNIPHIER_FI2C_IC);
 }
 
 static void uniphier_fi2c_stop(struct uniphier_fi2c_priv *priv)
@@ -172,6 +173,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
 		priv->enabled_irqs, irq_status);
 
+	uniphier_fi2c_clear_irqs(priv, irq_status);
+
 	if (irq_status & UNIPHIER_FI2C_INT_STOP)
 		goto complete;
 
@@ -250,8 +253,6 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	}
 
 handled:
-	uniphier_fi2c_clear_irqs(priv);
-
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
@@ -340,7 +341,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 		priv->flags |= UNIPHIER_FI2C_STOP;
 
 	reinit_completion(&priv->comp);
-	uniphier_fi2c_clear_irqs(priv);
+	uniphier_fi2c_clear_irqs(priv, U32_MAX);
 	writel(UNIPHIER_FI2C_RST_TBRST | UNIPHIER_FI2C_RST_RBRST,
 	       priv->membase + UNIPHIER_FI2C_RST);	/* reset TX/RX FIFO */
 
-- 
2.7.4
