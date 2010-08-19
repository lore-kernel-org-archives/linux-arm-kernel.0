From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 19 Aug 2010 15:54:47 +0900
Subject: [PATCH] ARM: S5PC110: GONI: Add TSP driver
Message-ID: <20100819065447.GA29760@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Use the TSP on I2C2.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |   43 +++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 53754d7..48b455e 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -15,6 +15,7 @@
 #include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/i2c/qt602240_ts.h>
 #include <linux/mfd/max8998.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -410,6 +411,42 @@ static struct platform_device goni_device_gpiokeys = {
 	},
 };
 
+/* TSP */
+static struct qt602240_platform_data qt602240_platform_data = {
+	.x_line		= 17,
+	.y_line		= 11,
+	.x_size		= 800,
+	.y_size		= 480,
+	.blen		= 0x21,
+	.threshold	= 0x28,
+	.voltage	= 2800000,              /* 2.8V */
+	.orient		= QT602240_DIAGONAL,
+};
+
+static struct i2c_board_info i2c2_devs[] __initdata = {
+	{
+		I2C_BOARD_INFO("qt602240_ts", 0x4a),
+		.platform_data = &qt602240_platform_data,
+	},
+};
+
+static void __init goni_tsp_init(void)
+{
+	int gpio, irq;
+
+	gpio = S5PV210_GPJ1(3);                 /* XMSMADDR_11 */
+	gpio_request(gpio, "TSP_LDO_ON");
+	gpio_direction_output(gpio, 1);
+	gpio_export(gpio, 0);
+
+	gpio = S5PV210_GPJ0(5);                 /* XMSMADDR_5 */
+	gpio_request(gpio, "TSP_INT");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+	irq = gpio_to_irq(gpio);
+	i2c2_devs[0].irq = irq;
+}
+
 static void __init goni_pmic_init(void)
 {
 	/* AP_PMIC_IRQ: EINT7 */
@@ -476,6 +513,12 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
+	/* TSP: call before I2C 2 registeration */
+	goni_tsp_init();
+
+	/* I2C2 */
+	i2c_register_board_info(2, i2c2_devs, ARRAY_SIZE(i2c2_devs));
+
 	/* PMIC */
 	goni_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
-- 
1.5.3.3
