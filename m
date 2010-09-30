From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 13:48:44 +0900
Subject: [PATCH 5/7] ARM: S5PC210: I2C0/1 devices support on Universal board
Message-ID: <20100930044844.GA16913@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Camera devices use the I2C0 and Gyro uese the I2C1 on universal board.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig               |    2 ++
 arch/arm/mach-s5pv310/mach-universal_c210.c |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 178eab9..c207426 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -41,6 +41,8 @@ config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_S5PV310
 	select S5P_DEV_ONENAND
+	select S3C_DEV_I2C1
+	select S5PV310_SETUP_I2C1
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board. S5PC210(MCP) is one of package option of S5PV310
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
index e169849..deffeb1 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/input.h>
+#include <linux/i2c.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 
@@ -116,6 +117,16 @@ static struct platform_device universal_gpio_keys = {
 	},
 };
 
+/* I2C0 */
+static struct i2c_board_info i2c0_devs[] __initdata = {
+	/* Camera, To be updated */
+};
+
+/* I2C1 */
+static struct i2c_board_info i2c1_devs[] __initdata = {
+	/* Gyro, To be updated */
+};
+
 static struct platform_device *universal_devices[] __initdata = {
 	&universal_gpio_keys,
 	&s5p_device_onenand,
@@ -134,6 +145,9 @@ static void __init universal_machine_init(void)
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
 
+	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
+	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
+
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
 }
-- 
1.5.3.3
