From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 6 Aug 2012 10:52:26 +0200
Subject: [PATCH] ARM: ux500: resurrect I2C platform data
Message-ID: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Commit:
98582d9562b4bea6b0eb6e2bfafcd3fab3b60ccb
"ARM: ux500: Remove unused i2c platform_data initialisation code"

Deleted platform data intialization code that was used,
not unused as indicated in the commit. The boot log (without
devicetree) now looks like this:

nmk-i2c nmk-i2c.0: no platform data
nmk-i2c nmk-i2c.1: no platform data
nmk-i2c nmk-i2c.2: no platform data
nmk-i2c nmk-i2c.3: no platform data

And no I2C drivers register anymore.

Take this opportunity to bump the i2c bus speed to 400kHz.
Some recent discussion revealed inconsistency in the board file
for the MOP500 family. The board can very well do 400kHz on
the I2C busses, so make it do that.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 39 ++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 8674a89..dbb9946 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -327,12 +327,43 @@ static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	},
 };
 
+#define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, t_out, _sm)	\
+static struct nmk_i2c_controller u8500_i2c##id##_data = { \
+	/*				\
+	 * slave data setup time, which is	\
+	 * 250 ns,100ns,10ns which is 14,6,2	\
+	 * respectively for a 48 Mhz	\
+	 * i2c clock			\
+	 */				\
+	.slsu		= _slsu,	\
+	/* Tx FIFO threshold */		\
+	.tft		= _tft,		\
+	/* Rx FIFO threshold */		\
+	.rft		= _rft,		\
+	/* std. mode operation */	\
+	.clk_freq	= clk,		\
+	/* Slave response timeout(ms) */\
+	.timeout	= t_out,	\
+	.sm		= _sm,		\
+}
+
+/*
+ * The board uses 4 i2c controllers, initialize all of
+ * them with slave data setup time of 250 ns,
+ * Tx & Rx FIFO threshold values as 1 resp. 8 and fast
+ * mode of operation
+ */
+U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(2,	0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(3,	0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+
 static void __init mop500_i2c_init(struct device *parent)
 {
-	db8500_add_i2c0(parent, NULL);
-	db8500_add_i2c1(parent, NULL);
-	db8500_add_i2c2(parent, NULL);
-	db8500_add_i2c3(parent, NULL);
+	db8500_add_i2c0(parent, &u8500_i2c0_data);
+	db8500_add_i2c1(parent, &u8500_i2c1_data);
+	db8500_add_i2c2(parent, &u8500_i2c2_data);
+	db8500_add_i2c3(parent, &u8500_i2c3_data);
 }
 
 static struct gpio_keys_button mop500_gpio_keys[] = {
-- 
1.7.11.3
