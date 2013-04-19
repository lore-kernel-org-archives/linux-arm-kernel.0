From: yuvaraj.cd@gmail.com (Yuvaraj Kumar C D)
Date: Fri, 19 Apr 2013 17:26:23 +0530
Subject: [PATCH] I2C: EXYNOS: High speed mode clock setting for HSI2C
Message-ID: <1366372583-7584-1-git-send-email-yuvaraj.cd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configure the High speed mode timing register using the
clock speed mentioned in the dts file.Also it configure the MASTER_ID
for High speed i2c transfer.
For i2c high speed transaction, tarnsaction initially starts with the
fast mode i,e 400Kbits/sec and then switches to high speed mode.For this
purpose it requires to set up timing value for fast mode and high speed
mode.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/i2c/busses/i2c-exynos5.c |   85 ++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 968c34f..ef7155f 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -139,12 +139,14 @@
 #define HSI2C_SLV_ADDR_SLV(x)			((x & 0x3ff) << 0)
 #define HSI2C_SLV_ADDR_MAS(x)			((x & 0x3ff) << 10)
 #define HSI2C_MASTER_ID(x)			((x & 0xff) << 24)
+#define MASTER_ID(x)				((x & 0x7) + 0x08)
 
 /* Controller operating frequency, timing values for operation
  * are calculated against this frequency
  */
 #define HSI2C_HS_TX_CLOCK	1000000
-#define HSI2C_FS_TX_CLOCK	1000000
+/*HSI2C supports upto 400 kb/s in FAST Mode and 3.4 Mb/s in High Speed Mode*/
+#define HSI2C_FS_TX_CLOCK	 400000
 #define HSI2C_HIGH_SPD		1
 #define HSI2C_FAST_SPD		0
 
@@ -173,7 +175,8 @@ struct exynos5_i2c {
 	int			gpios[2];
 
 	/* Controller operating frequency */
-	unsigned int		clock;
+	unsigned int		fs_clock;
+	unsigned int		hs_clock;
 	unsigned int		clk_cycle;
 	unsigned int		clk_div;
 
@@ -182,6 +185,7 @@ struct exynos5_i2c {
 	 * 2. Fast speed upto 1Mbps
 	 */
 	int			speed_mode;
+	int			current_mode;
 };
 
 static const struct of_device_id exynos5_i2c_match[] = {
@@ -222,10 +226,11 @@ static void exynos5_i2c_clr_pend_irq(struct exynos5_i2c *i2c)
  */
 static int exynos5_i2c_clock_info(struct exynos5_i2c *i2c)
 {
-	unsigned int op_clk = i2c->clock;
 	unsigned int clkin = clk_get_rate(i2c->clk);
-	unsigned int i, utemp0 = 0, utemp1 = 0;
+	unsigned int div, utemp0 = 0, utemp1 = 0;
 	unsigned int t_ftl_cycle;
+	unsigned int op_clk = (i2c->current_mode == HSI2C_HIGH_SPD) ?
+					i2c->hs_clock : i2c->fs_clock;
 
 	/* FPCLK / FI2C =
 	 * (CLK_DIV + 1) * (TSCLK_L + TSCLK_H + 2) + 8 + 2 * FLT_CYCLE
@@ -236,8 +241,8 @@ static int exynos5_i2c_clock_info(struct exynos5_i2c *i2c)
 	utemp0 = (clkin / op_clk) - 8 - 2 * t_ftl_cycle;
 
 	/* CLK_DIV max is 256 */
-	for (i = 0; i < 256; i++) {
-		utemp1 = utemp0 / (i + 1);
+	for (div = 0; div < 256; div++) {
+		utemp1 = utemp0 / (div + 1);
 
 		/* SCL_L and SCL_H each has max value of 255
 		 * Hence, For the clk_cycle to the have right value
@@ -245,7 +250,7 @@ static int exynos5_i2c_clock_info(struct exynos5_i2c *i2c)
 		 */
 		if ((utemp1 < 512) && (utemp1 > 4)) {
 			i2c->clk_cycle = utemp1 - 2;
-			i2c->clk_div = i;
+			i2c->clk_div = div;
 			return 0;
 		}
 	}
@@ -297,7 +302,7 @@ static void exynos5_i2c_set_timing(struct exynos5_i2c *i2c)
 		n_clkdiv, t_sr_release);
 	dev_dbg(i2c->dev, "tDATA_HD: %X\n", t_data_hd);
 
-	if (i2c->speed_mode == HSI2C_HIGH_SPD) {
+	if (i2c->current_mode == HSI2C_HIGH_SPD) {
 		writel(i2c_timing_s1, i2c->regs + HSI2C_TIMING_HS1);
 		writel(i2c_timing_s2, i2c->regs + HSI2C_TIMING_HS2);
 		writel(i2c_timing_s3, i2c->regs + HSI2C_TIMING_HS3);
@@ -309,25 +314,52 @@ static void exynos5_i2c_set_timing(struct exynos5_i2c *i2c)
 	writel(i2c_timing_sla, i2c->regs + HSI2C_TIMING_SLA);
 }
 
+static int exynos5_hsi2c_clock_setup(struct exynos5_i2c *i2c)
+{
+
+	if (exynos5_i2c_clock_info(i2c)) {
+		dev_err(i2c->dev, "HSI2C FS Clock set up failed\n");
+		return -EINVAL;
+	}
+	exynos5_i2c_set_timing(i2c);
+/*If controller supports High Speed configure the High speed timing value*/
+	if (i2c->speed_mode == HSI2C_HIGH_SPD) {
+		i2c->current_mode = HSI2C_HIGH_SPD;
+		if (exynos5_i2c_clock_info(i2c)) {
+			dev_err(i2c->dev, "HSI2C HS Clock set up failed\n");
+			return -EINVAL;
+		}
+	exynos5_i2c_set_timing(i2c);
+	}
+	return 0;
+}
+
 /* exynos5_i2c_init: configures the controller for I2C functionality
  * Programs I2C controller for Master mode operation
  *
  * Note: Currently, supports AUTO mode of operation.
  */
-static void exynos5_i2c_init(struct exynos5_i2c *i2c)
+static int exynos5_i2c_init(struct exynos5_i2c *i2c)
 {
+	int id = 0, ret;
 	u32 i2c_conf = readl(i2c->regs + HSI2C_CONF);
 
+	if (i2c->adap.dev.of_node)
+		id = of_alias_get_id(i2c->adap.dev.of_node, "hsi2c");
 	writel((HSI2C_FUNC_MODE_I2C | HSI2C_MASTER),
 					i2c->regs + HSI2C_CTL);
 	writel(HSI2C_TRAILING_COUNT, i2c->regs + HSI2C_TRAILIG_CTL);
+	ret = exynos5_hsi2c_clock_setup(i2c);
+	if (ret < 0)
+		return ret;
 
-	exynos5_i2c_set_timing(i2c);
 
-	if (i2c->speed_mode == HSI2C_HIGH_SPD)
+	if (i2c->speed_mode == HSI2C_HIGH_SPD) {
+		writel(HSI2C_MASTER_ID(MASTER_ID(id)), i2c->regs + HSI2C_ADDR);
 		i2c_conf |= HSI2C_HS_MODE;
-
+	}
 	writel(i2c_conf | HSI2C_AUTO_MODE, i2c->regs + HSI2C_CONF);
+	return ret;
 }
 
 static void exynos5_i2c_reset(struct exynos5_i2c *i2c)
@@ -372,7 +404,6 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 
 	int_status = readl(i2c->regs + HSI2C_INT_STATUS);
 	fifo_status = readl(i2c->regs + HSI2C_FIFO_STATUS);
-
 	if (int_status & HSI2C_INT_I2C) {
 		trans_status = readl(i2c->regs + HSI2C_TRANS_STATUS);
 		if (trans_status & HSI2C_NO_DEV_ACK) {
@@ -500,7 +531,6 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 
 	i2c_ctl = readl(i2c->regs + HSI2C_CTL);
 	i2c_ctl &= ~(HSI2C_TXCHON | HSI2C_RXCHON);
-
 	if (i2c->msg->flags & I2C_M_RD) {
 		i2c_ctl |= HSI2C_RXCHON;
 
@@ -731,14 +761,15 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 
 	/* Mode of operation High/Fast Speed mode */
 	if (of_get_property(np, "samsung,hs-mode", NULL)) {
-		i2c->speed_mode = 1;
-		if (of_property_read_u32(np, "samsung,hs-clock", &i2c->clock))
-			i2c->clock = HSI2C_HS_TX_CLOCK;
-	} else {
-		i2c->speed_mode = 0;
-		if (of_property_read_u32(np, "samsung,fs-clock", &i2c->clock))
-			i2c->clock = HSI2C_FS_TX_CLOCK;
+		i2c->speed_mode = HSI2C_HIGH_SPD;
+		if (of_property_read_u32(np, "samsung,hs-clock",
+						&i2c->hs_clock))
+			i2c->hs_clock = HSI2C_HS_TX_CLOCK;
 	}
+	if (of_property_read_u32(np, "samsung,fs-clock", &i2c->fs_clock))
+		i2c->fs_clock = HSI2C_FS_TX_CLOCK;
+	/*High Speed mode initially starts with Fast mode*/
+	i2c->current_mode = HSI2C_FAST_SPD;
 
 	strlcpy(i2c->adap.name, "exynos5-i2c", sizeof(i2c->adap.name));
 	i2c->adap.owner   = THIS_MODULE;
@@ -773,12 +804,6 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	/* Clear pending interrupts from u-boot or misc causes */
 	exynos5_i2c_clr_pend_irq(i2c);
 
-	ret = exynos5_i2c_clock_info(i2c);
-	if (ret)
-		goto err_iomap;
-
-	exynos5_i2c_init(i2c);
-
 	init_completion(&i2c->msg_complete);
 
 	i2c->irq = ret = irq_of_parse_and_map(np, 0);
@@ -811,6 +836,12 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	i2c->adap.nr = -1;
 	i2c->adap.dev.of_node = np;
 
+	ret = exynos5_i2c_init(i2c);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init HSI2C Controller\n");
+		goto err_pm;
+	}
+
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
-- 
1.7.9.5
