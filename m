From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 17 Jul 2014 16:48:39 +0200
Subject: [PATCH v2 4/5] i2c: sc3c2410: Remove suspension check
In-Reply-To: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
Message-ID: <1405608520-5644-4-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now take care of suspension in the i2c core code. So we can remove this
check here.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
same as v1

 drivers/i2c/busses/i2c-s3c2410.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index e828a1d..568b993 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -103,7 +103,6 @@ enum s3c24xx_i2c_state {
 struct s3c24xx_i2c {
 	wait_queue_head_t	wait;
 	kernel_ulong_t		quirks;
-	unsigned int		suspended:1;
 
 	struct i2c_msg		*msg;
 	unsigned int		msg_num;
@@ -714,9 +713,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	unsigned long timeout;
 	int ret;
 
-	if (i2c->suspended)
-		return -EIO;
-
 	ret = s3c24xx_i2c_set_master(i2c);
 	if (ret != 0) {
 		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
@@ -1257,16 +1253,6 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int s3c24xx_i2c_suspend_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
-
-	i2c->suspended = 1;
-
-	return 0;
-}
-
 static int s3c24xx_i2c_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1275,7 +1261,6 @@ static int s3c24xx_i2c_resume(struct device *dev)
 	clk_prepare_enable(i2c->clk);
 	s3c24xx_i2c_init(i2c);
 	clk_disable_unprepare(i2c->clk);
-	i2c->suspended = 0;
 
 	return 0;
 }
@@ -1284,7 +1269,6 @@ static int s3c24xx_i2c_resume(struct device *dev)
 #ifdef CONFIG_PM
 static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
-	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
 	.resume = s3c24xx_i2c_resume,
 #endif
 };
-- 
1.9.1
