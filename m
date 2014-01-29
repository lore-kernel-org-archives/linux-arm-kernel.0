From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jan 2014 13:45:45 +0100
Subject: [PATCH] ARM: iop32x: fix reset handling for the EM7210 board
Message-ID: <1390999545-31428-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board was missed when converting all the others to proper
abstracted GPIO handling. Fix it up the right way by requesting
and driving GPIO line 0 high through gpiolib to reset the machine.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks, if you're happy with this fix, please apply it
directly to fixes in the ARM SoC tree.
---
 arch/arm/mach-iop32x/em7210.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 177cd073a83b..e0c4187f3799 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -176,14 +177,21 @@ static struct platform_device em7210_serial_device = {
 	.resource	= &em7210_uart_resource,
 };
 
+#define EM7210_HARDWARE_RESET 0
+
 void em7210_power_off(void)
 {
-	*IOP3XX_GPOE &= 0xfe;
-	*IOP3XX_GPOD |= 0x01;
+	int ret;
+
+	ret = gpio_direction_output(EM7210_HARDWARE_RESET, 1);
+	if (ret)
+		pr_crit("could not drive reset GPIO high\n");
 }
 
 static void __init em7210_init_machine(void)
 {
+	int ret;
+
 	register_iop32x_gpio();
 	platform_device_register(&em7210_serial_device);
 	platform_device_register(&iop3xx_i2c0_device);
@@ -194,7 +202,9 @@ static void __init em7210_init_machine(void)
 
 	i2c_register_board_info(0, em7210_i2c_devices,
 		ARRAY_SIZE(em7210_i2c_devices));
-
+	ret = gpio_request(EM7210_HARDWARE_RESET, "reset");
+	if (ret)
+		pr_err("could not request reset GPIO\n");
 
 	pm_power_off = em7210_power_off;
 }
-- 
1.8.5.3
