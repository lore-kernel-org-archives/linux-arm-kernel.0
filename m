From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Wed, 10 Apr 2013 16:00:20 +0530
Subject: [PATCH] I2C: EXYNOS5: Set up the TX FIFO and RX FIFO for HSI2C
Message-ID: <1365589820-28440-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch, set up TX FIFO and RX FIFO of HSI2C controller based
on i2c message length.If we configure TX and RX FIFO for a default
value,the ALMOST_EMPTY and ALMOST_FULL will rise the interrupts
unnecessary.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/i2c/busses/i2c-exynos5.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index a38c616..b25c717 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -77,9 +77,9 @@
 /* I2C_FIFO_CTL Register bits */
 #define HSI2C_RXFIFO_EN				(1u << 0)
 #define HSI2C_TXFIFO_EN				(1u << 1)
-#define HSI2C_TXFIFO_TRIGGER_LEVEL		(0x30 << 16)
-#define HSI2C_RXFIFO_TRIGGER_LEVEL		(0x30 << 4)
-
+#define HSI2C_FIFO_MAX				(0x40)
+#define HSI2C_RXFIFO_TRIGGER_LEVEL(x)		((x) << 4)
+#define HSI2C_TXFIFO_TRIGGER_LEVEL(x)		((x) << 16)
 /* I2C_TRAILING_CTL Register bits */
 #define HSI2C_TRAILING_COUNT			(0xf)
 
@@ -400,10 +400,9 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 			goto stop;
 		}
 
-		/* 0x30 is the default trigger level for TX FIFO */
-		len = 48 - fifo_level;
-
-		if (len > i2c->msg->len)
+		if (i2c->msg->len > HSI2C_FIFO_MAX)
+			len = HSI2C_FIFO_MAX;
+		else
 			len = i2c->msg->len;
 
 		i2c->msg_len += len;
@@ -492,10 +491,11 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	u32 i2c_auto_conf = 0;
 	u32 fifo_ctl;
 
+	unsigned short len = (i2c->msg->len > HSI2C_FIFO_MAX) ?
+					HSI2C_FIFO_MAX : i2c->msg->len;
 	exynos5_i2c_en_timeout(i2c);
 
-	fifo_ctl = HSI2C_RXFIFO_EN | HSI2C_TXFIFO_EN |
-		HSI2C_TXFIFO_TRIGGER_LEVEL | HSI2C_RXFIFO_TRIGGER_LEVEL;
+	fifo_ctl = HSI2C_RXFIFO_EN | HSI2C_TXFIFO_EN;
 	writel(fifo_ctl, i2c->regs + HSI2C_FIFO_CTL);
 
 	i2c_ctl = readl(i2c->regs + HSI2C_CTL);
@@ -506,11 +506,13 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 
 		i2c_auto_conf |= HSI2C_READ_WRITE;
 
+		fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(len);
 		int_en |= (HSI2C_INT_RX_ALMOSTFULL_EN |
 			HSI2C_INT_TRAILING_EN);
 	} else {
 		i2c_ctl |= HSI2C_TXCHON;
 
+		fifo_ctl |= HSI2C_TXFIFO_TRIGGER_LEVEL(len);
 		int_en |= HSI2C_INT_TX_ALMOSTEMPTY_EN;
 	}
 
@@ -519,6 +521,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 
 	writel(HSI2C_SLV_ADDR_MAS(i2c->msg->addr), i2c->regs + HSI2C_ADDR);
 
+	writel(fifo_ctl, i2c->regs + HSI2C_FIFO_CTL);
 	writel(i2c_ctl, i2c->regs + HSI2C_CTL);
 
 	/* In auto mode the length of xfer cannot be 0 */
-- 
1.7.9.5
