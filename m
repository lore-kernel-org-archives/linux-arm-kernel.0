From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:07 +0100
Subject: [PATCH 02/18] ARM: ux500: Remove unused i2c platform_data
 initialisation code
In-Reply-To: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337262323-27692-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that u5500 is obsolete, u8500 is the only user of the Nomadik
i2c driver. As such there is no requirement to differentiate between
initialisation values. By the time a new SoC is released, almost all
of the ux500 platform will be DT:ed, so we can make decisions based
on the compatible property instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   39 ++++--------------------------------
 drivers/i2c/busses/i2c-nomadik.c   |    3 +--
 2 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 26ff77c..4584c74 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -330,43 +330,12 @@ static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	},
 };
 
-#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, t_out, _sm)	\
-static struct nmk_i2c_controller u8500_i2c##id##_data = { \
-	/*				\
-	 * slave data setup time, which is	\
-	 * 250 ns,100ns,10ns which is 14,6,2	\
-	 * respectively for a 48 Mhz	\
-	 * i2c clock			\
-	 */				\
-	.slsu		= _slsu,	\
-	/* Tx FIFO threshold */		\
-	.tft		= _tft,		\
-	/* Rx FIFO threshold */		\
-	.rft		= _rft,		\
-	/* std. mode operation */	\
-	.clk_freq	= clk,		\
-	/* Slave response timeout(ms) */\
-	.timeout	= t_out,	\
-	.sm		= _sm,		\
-}
-
-/*
- * The board uses 4 i2c controllers, initialize all of
- * them with slave data setup time of 250 ns,
- * Tx & Rx FIFO threshold values as 8 and standard
- * mode of operation
- */
-U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(2,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(3,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-
 static void __init mop500_i2c_init(struct device *parent)
 {
-	db8500_add_i2c0(parent, &u8500_i2c0_data);
-	db8500_add_i2c1(parent, &u8500_i2c1_data);
-	db8500_add_i2c2(parent, &u8500_i2c2_data);
-	db8500_add_i2c3(parent, &u8500_i2c3_data);
+	db8500_add_i2c0(parent, NULL);
+	db8500_add_i2c1(parent, NULL);
+	db8500_add_i2c2(parent, NULL);
+	db8500_add_i2c3(parent, NULL);
 }
 
 static struct gpio_keys_button mop500_gpio_keys[] = {
diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index cd45563..1ffdf67 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1002,8 +1002,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
-	adap->timeout	= pdata->timeout ? msecs_to_jiffies(pdata->timeout) :
-		msecs_to_jiffies(20000);
+	adap->timeout	= msecs_to_jiffies(pdata->timeout);
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
 
-- 
1.7.9.5
