From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  9 Mar 2017 11:05:33 -0300
Subject: [PATCH] i2c: exynos5: Avoid transaction timeouts due
 TRANSFER_DONE_AUTO not set
Message-ID: <20170309140533.24618-1-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 7999eecb7e56 ("i2c: exynos5: fix arbitration lost handling"),
some I2C transactions are failing because the TRANSFER_DONE_AUTO field is
not set in the I2C_TRANS_STATUS register so the i2c->status value is left
to -EINVAL causing the i2c->msg_complete completion to never be signaled.

For example, when reading the time of an I2C rtc on an Exynos5800 machine:

$ cat /sys/class/rtc/rtc0/time
[   25.924594] exynos5-hsi2c 12e10000.i2c: rx timeout
[   65.028365] max77686-rtc max77802-rtc: Fail to read time reg(-22)
cat: /sys/class/rtc/rtc0/time: Invalid argument

The Exynos5422 manual states clearly that most I2C_TRANS_STATUS reg bits
(including TRANSFER_DONE_AUTO) are cleared after the register is read. So
reading has side effects and should only be done if HSI2C_INT_I2C was set.

Fixes: 7999eecb7e56 ("i2c: exynos5: fix arbitration lost handling")
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

---

 drivers/i2c/busses/i2c-exynos5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index cbd93ce0661f..736a82472101 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -457,7 +457,6 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 
 	int_status = readl(i2c->regs + HSI2C_INT_STATUS);
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
-	trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 
 	/* handle interrupt related to the transfer status */
 	if (i2c->variant->hw == HSI2C_EXYNOS7) {
@@ -482,11 +481,13 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 			goto stop;
 		}
 
+		trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 		if ((trans_status & HSI2C_MASTER_ST_MASK) == HSI2C_MASTER_ST_LOSE) {
 			i2c->state = -EAGAIN;
 			goto stop;
 		}
 	} else if (int_status & HSI2C_INT_I2C) {
+		trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 		if (trans_status & HSI2C_NO_DEV_ACK) {
 			dev_dbg(i2c->dev, "No ACK from device\n");
 			i2c->state = -ENXIO;
-- 
2.9.3
