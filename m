From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:40:23 +0200
Subject: [PATCH 2/8] ARM: iop32x: request and issue reset using gpio
Message-ID: <1378741223-12921-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the IOP GPIO driver supports gpiolib we can use the standard
GPIO calls to issue a reset of the machine instead of using the
custom gpio_line_set/config calls. Also request the GPIO when
initializing the machine.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-iop32x/n2100.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 0691443..cd199c1 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
@@ -288,8 +289,14 @@ static void n2100_power_off(void)
 
 static void n2100_restart(enum reboot_mode mode, const char *cmd)
 {
-	gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
-	gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
+	int ret;
+
+	ret = gpio_direction_output(N2100_HARDWARE_RESET, 0);
+	if (ret) {
+		pr_crit("could not drive reset GPIO low\n");
+		return;
+	}
+	/* Wait for reset to happen */
 	while (1)
 		;
 }
@@ -311,6 +318,8 @@ static void power_button_poll(unsigned long dummy)
 
 static void __init n2100_init_machine(void)
 {
+	int ret;
+
 	platform_device_register(&iop3xx_i2c0_device);
 	platform_device_register(&n2100_flash_device);
 	platform_device_register(&n2100_serial_device);
@@ -326,6 +335,10 @@ static void __init n2100_init_machine(void)
 	power_button_poll_timer.function = power_button_poll;
 	power_button_poll_timer.expires = jiffies + (HZ / 10);
 	add_timer(&power_button_poll_timer);
+
+	ret = gpio_request(N2100_HARDWARE_RESET, "reset");
+	if (ret)
+		pr_err("could not request reset GPIO\n");
 }
 
 MACHINE_START(N2100, "Thecus N2100")
-- 
1.8.3.1
