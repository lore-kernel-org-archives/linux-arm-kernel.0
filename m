From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jul 2018 21:54:04 +0200
Subject: [PATCH] i2c: exynos5: Describe the hardware variant for readability
Message-ID: <20180718195404.5095-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver supports multiple hardware variants of Exynos I2C controller
which differ in FIFO depth, handling of interrupts and bus recovery in
HSI2C_MASTER_ST_LOSE state.

The difference in variant was a single bit set for Exynos7 variants and
implicit lack of this bit for other variants.

Make each variant explicit which also fixes the GCC warning about
documentation:

    drivers/i2c/busses/i2c-exynos5.c:223: warning: Function parameter or member 'hw' not described in 'exynos_hsi2c_variant'

No change in functionality.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-exynos5.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index de82ad8ff534..c1ce2299a76e 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -176,7 +176,10 @@
 
 #define EXYNOS5_I2C_TIMEOUT (msecs_to_jiffies(100))
 
-#define HSI2C_EXYNOS7	BIT(0)
+enum i2c_type_exynos {
+	I2C_TYPE_EXYNOS5,
+	I2C_TYPE_EXYNOS7,
+};
 
 struct exynos5_i2c {
 	struct i2c_adapter	adap;
@@ -212,27 +215,30 @@ struct exynos5_i2c {
 /**
  * struct exynos_hsi2c_variant - platform specific HSI2C driver data
  * @fifo_depth: the fifo depth supported by the HSI2C module
+ * @hw: the hardware variant of Exynos I2C controller
  *
  * Specifies platform specific configuration of HSI2C module.
  * Note: A structure for driver specific platform data is used for future
  * expansion of its usage.
  */
 struct exynos_hsi2c_variant {
-	unsigned int	fifo_depth;
-	unsigned int	hw;
+	unsigned int		fifo_depth;
+	enum i2c_type_exynos	hw;
 };
 
 static const struct exynos_hsi2c_variant exynos5250_hsi2c_data = {
 	.fifo_depth	= 64,
+	.hw		= I2C_TYPE_EXYNOS5,
 };
 
 static const struct exynos_hsi2c_variant exynos5260_hsi2c_data = {
 	.fifo_depth	= 16,
+	.hw		= I2C_TYPE_EXYNOS5,
 };
 
 static const struct exynos_hsi2c_variant exynos7_hsi2c_data = {
 	.fifo_depth	= 16,
-	.hw		= HSI2C_EXYNOS7,
+	.hw		= I2C_TYPE_EXYNOS7,
 };
 
 static const struct of_device_id exynos5_i2c_match[] = {
@@ -300,7 +306,7 @@ static int exynos5_i2c_set_timing(struct exynos5_i2c *i2c, bool hs_timings)
 	 */
 	t_ftl_cycle = (readl(i2c->regs + HSI2C_CONF) >> 16) & 0x7;
 	temp = clkin / op_clk - 8 - t_ftl_cycle;
-	if (i2c->variant->hw != HSI2C_EXYNOS7)
+	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
 		temp -= t_ftl_cycle;
 	div = temp / 512;
 	clk_cycle = temp / (div + 1) - 2;
@@ -424,7 +430,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
 	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
 
 	/* handle interrupt related to the transfer status */
-	if (i2c->variant->hw == HSI2C_EXYNOS7) {
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS7) {
 		if (int_status & HSI2C_INT_TRANS_DONE) {
 			i2c->trans_done = 1;
 			i2c->state = 0;
@@ -571,7 +577,7 @@ static void exynos5_i2c_bus_check(struct exynos5_i2c *i2c)
 {
 	unsigned long timeout;
 
-	if (i2c->variant->hw != HSI2C_EXYNOS7)
+	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
 		return;
 
 	/*
@@ -612,7 +618,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
 	unsigned long flags;
 	unsigned short trig_lvl;
 
-	if (i2c->variant->hw == HSI2C_EXYNOS7)
+	if (i2c->variant->hw == I2C_TYPE_EXYNOS7)
 		int_en |= HSI2C_INT_I2C_TRANS;
 	else
 		int_en |= HSI2C_INT_I2C;
-- 
2.14.1
