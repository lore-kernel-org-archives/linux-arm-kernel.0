From: laurent.navet@gmail.com (Laurent Navet)
Date: Fri, 17 Jul 2015 22:27:19 +0200
Subject: [PATCH V2] i2c: s3c2410: remove unused variable
Message-ID: <1437164839-9287-1-git-send-email-laurent.navet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in i2c_s3c_irq_nextbyte() ret is assigned zero and just used to return.
Remove it and make i2c_s3c_irq_nextbyte() a void function.
Found by using coccinelle.

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 50bfd8c..612303a 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -146,7 +146,7 @@ static const struct platform_device_id s3c24xx_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
 
-static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat);
+static void i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat);
 
 #ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_i2c_match[] = {
@@ -405,11 +405,10 @@ static inline int is_msgend(struct s3c24xx_i2c *i2c)
  * process an interrupt and work out what to do
  */
 
-static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
+static void i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 {
 	unsigned long tmp;
 	unsigned char byte;
-	int ret = 0;
 
 	switch (i2c->state) {
 
@@ -565,7 +564,7 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 	tmp &= ~S3C2410_IICCON_IRQPEND;
 	writel(tmp, i2c->regs + S3C2410_IICCON);
  out:
-	return ret;
+	return;
 }
 
 /* s3c24xx_i2c_irq
-- 
2.1.4
