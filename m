From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Mon, 11 Nov 2013 16:50:20 +0530
Subject: [PATCH V2] i2c: s3c2410 : Add polling mode support
Message-ID: <1384168820-2986-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasanth Ananthan <vasanthananthan@gmail.com>

This patch adds polling mode support for i2c-s3c2410 driver.The
SATA PHY controller's CMU and TRSV block's are of I2C register
map in exynos5250.These blocks can be configured using i2c.

But i2c controller instance on which these block's sits lacks an
interrupt line.Also the current i2c-s3c2410 driver is only interrupt
driven, thus a polling mode support is required in the driver for
supporting this controller. This patch adds this support to the driver.

Changes from V1:
	1.Changed the is_ack() to have even period b/w polls and
	  used usleep_range() instead of udelay().

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 .../devicetree/bindings/i2c/i2c-s3c2410.txt        |    2 +
 drivers/i2c/busses/i2c-s3c2410.c                   |   66 +++++++++++++++++---
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index 296eb45..278de8e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -10,6 +10,8 @@ Required properties:
           inside HDMIPHY block found on several samsung SoCs
       (d) "samsung, exynos5440-i2c", for s3c2440-like i2c used
 	   on EXYNOS5440 which does not need GPIO configuration.
+      (e) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
+	   a host to SATA PHY controller on an internal bus.
   - reg: physical base address of the controller and length of memory mapped
     region.
   - interrupts: interrupt number to the cpu.
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3747b9b..08ed126 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -85,6 +85,7 @@
 #define QUIRK_S3C2440		(1 << 0)
 #define QUIRK_HDMIPHY		(1 << 1)
 #define QUIRK_NO_GPIO		(1 << 2)
+#define QUIRK_POLL		(1 << 3)
 
 /* Max time to wait for bus to become idle after a xfer (in us) */
 #define S3C2410_IDLE_TIMEOUT	5000
@@ -141,6 +142,8 @@ static struct platform_device_id s3c24xx_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
 
+static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat);
+
 #ifdef CONFIG_OF
 static const struct of_device_id s3c24xx_i2c_match[] = {
 	{ .compatible = "samsung,s3c2410-i2c", .data = (void *)0 },
@@ -149,6 +152,8 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
 	{ .compatible = "samsung,exynos5440-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_NO_GPIO) },
+	{ .compatible = "samsung,exynos5-sata-phy-i2c",
+	  .data = (void *)(QUIRK_S3C2440 | QUIRK_POLL | QUIRK_NO_GPIO) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
@@ -187,7 +192,8 @@ static inline void s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret)
 	if (ret)
 		i2c->msg_idx = ret;
 
-	wake_up(&i2c->wait);
+	if (!(i2c->quirks & QUIRK_POLL))
+		wake_up(&i2c->wait);
 }
 
 static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
@@ -224,6 +230,22 @@ static inline void s3c24xx_i2c_enable_irq(struct s3c24xx_i2c *i2c)
 	writel(tmp | S3C2410_IICCON_IRQEN, i2c->regs + S3C2410_IICCON);
 }
 
+static bool is_ack(struct s3c24xx_i2c *i2c)
+{
+	int tries;
+
+	for (tries = 50; tries; --tries) {
+		if (readl(i2c->regs + S3C2410_IICCON)
+			& S3C2410_IICCON_IRQPEND) {
+			if (!(readl(i2c->regs + S3C2410_IICSTAT)
+				& S3C2410_IICSTAT_LASTBIT))
+				return true;
+		}
+		usleep_range(1000, 2000);
+	}
+	dev_err(i2c->dev, "ack was not recieved\n");
+	return false;
+}
 
 /* s3c24xx_i2c_message_start
  *
@@ -268,6 +290,16 @@ static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 
 	stat |= S3C2410_IICSTAT_START;
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
+
+	if (i2c->quirks & QUIRK_POLL) {
+		while ((i2c->msg_num != 0) && is_ack(i2c)) {
+			i2c_s3c_irq_nextbyte(i2c, stat);
+			stat = readl(i2c->regs + S3C2410_IICSTAT);
+
+			if (stat & S3C2410_IICSTAT_ARBITR)
+				dev_err(i2c->dev, "deal with arbitration loss\n");
+		}
+	}
 }
 
 static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
@@ -675,6 +707,15 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
 	s3c24xx_i2c_enable_irq(i2c);
 	s3c24xx_i2c_message_start(i2c, msgs);
 
+	if (i2c->quirks & QUIRK_POLL) {
+		ret = i2c->msg_idx;
+
+		if (ret != num)
+			dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
+
+		goto out;
+	}
+
 	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
 
 	ret = i2c->msg_idx;
@@ -820,6 +861,9 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
 	if (div1 == 512)
 		iiccon |= S3C2410_IICCON_TXDIV_512;
 
+	if (i2c->quirks & QUIRK_POLL)
+		iiccon |= S3C2410_IICCON_SCALE(2);
+
 	writel(iiccon, i2c->regs + S3C2410_IICCON);
 
 	if (i2c->quirks & QUIRK_S3C2440) {
@@ -1117,18 +1161,20 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	 * ensure no current IRQs pending
 	 */
 
-	i2c->irq = ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
-		return ret;
-	}
+	if (!(i2c->quirks & QUIRK_POLL)) {
+		i2c->irq = ret = platform_get_irq(pdev, 0);
+		if (ret <= 0) {
+			dev_err(&pdev->dev, "cannot find IRQ\n");
+			return ret;
+		}
 
 	ret = devm_request_irq(&pdev->dev, i2c->irq, s3c24xx_i2c_irq, 0,
-			       dev_name(&pdev->dev), i2c);
+				dev_name(&pdev->dev), i2c);
 
-	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
-		return ret;
+		if (ret != 0) {
+			dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
+			return ret;
+		}
 	}
 
 	ret = s3c24xx_i2c_register_cpufreq(i2c);
-- 
1.7.9.5
