From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jan 2014 15:20:15 +0100
Subject: [PATCH v2] ARM: iop32x: fix power off handling for the EM7210 board
Message-ID: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board was missed when converting all the others to proper
abstracted GPIO handling. Fix it up the right way by requesting
and driving GPIO line 0 high through gpiolib to power off the
machine.

Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Request the power off and set the power off hook with a
  device_initcall() so we know the GPIO driver is available
  when requesting the line.
- Refer to POWER OFF rather than RESET everywhere.

ARM SoC folks, if you're happy with this fix, please apply it
directly to fixes in the ARM SoC tree.
---
 arch/arm/mach-iop32x/em7210.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 177cd073a83b..77e1ff057303 100644
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
@@ -176,11 +177,35 @@ static struct platform_device em7210_serial_device = {
 	.resource	= &em7210_uart_resource,
 };
 
+#define EM7210_HARDWARE_POWER 0
+
 void em7210_power_off(void)
 {
-	*IOP3XX_GPOE &= 0xfe;
-	*IOP3XX_GPOD |= 0x01;
+	int ret;
+
+	ret = gpio_direction_output(EM7210_HARDWARE_POWER, 1);
+	if (ret)
+		pr_crit("could not drive power off GPIO high\n");
+}
+
+static int __init em7210_request_gpios(void)
+{
+	int ret;
+
+	if (!machine_is_em7210())
+		return 0;
+
+	ret = gpio_request(EM7210_HARDWARE_POWER, "power");
+	if (ret) {
+		pr_err("could not request power off GPIO\n");
+		return 0;
+	}
+
+	pm_power_off = em7210_power_off;
+
+	return 0;
 }
+device_initcall(em7210_request_gpios);
 
 static void __init em7210_init_machine(void)
 {
@@ -194,9 +219,6 @@ static void __init em7210_init_machine(void)
 
 	i2c_register_board_info(0, em7210_i2c_devices,
 		ARRAY_SIZE(em7210_i2c_devices));
-
-
-	pm_power_off = em7210_power_off;
 }
 
 MACHINE_START(EM7210, "Lanner EM7210")
-- 
1.8.5.3
