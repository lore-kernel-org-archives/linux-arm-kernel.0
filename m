From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Nov 2013 19:53:05 +0100
Subject: [PATCH] ARM: nomadik: get rid of explicit ethernet GPIO management
Message-ID: <1384455185-21331-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to set up the GPIO used for the SMC ethernet IRQ by
requesting the GPIO line explicitly. As we recently established
that specifying the GPIO controller as interrupt parent and
requesting one of its interrupts by reference should be enough,
we do away with this. Incidentally, the Nomadik GPIO chip driver
handles this just fine: the IRQ is set up and fired as expected.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts |  4 ----
 arch/arm/mach-nomadik/cpu-8815.c        | 32 --------------------------------
 2 files changed, 36 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 16c3888b7b15..f557feb997f4 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -67,10 +67,6 @@
 
 	/* Custom board node with GPIO pins to active etc */
 	usb-s8815 {
-		/* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
-		ethernet-gpio {
-			gpios = <&gpio3 8 0x1>;
-		};
 		/* This will bias the MMC/SD card detect line */
 		mmcsd-gpio {
 			gpios = <&gpio3 16 0x1>;
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index cce2c9dfb5d1..4a1065e41e9c 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -110,38 +110,6 @@ static void cpu8815_restart(enum reboot_mode mode, const char *cmd)
 }
 
 /*
- * The SMSC911x IRQ is connected to a GPIO pin, but the driver expects
- * to simply request an IRQ passed as a resource. So the GPIO pin needs
- * to be requested by this hog and set as input.
- */
-static int __init cpu8815_eth_init(void)
-{
-	struct device_node *eth;
-	int gpio, irq, err;
-
-	eth = of_find_node_by_path("/usb-s8815/ethernet-gpio");
-	if (!eth) {
-		pr_info("could not find any ethernet GPIO\n");
-		return 0;
-	}
-	gpio = of_get_gpio(eth, 0);
-	err = gpio_request(gpio, "eth_irq");
-	if (err) {
-		pr_info("failed to request ethernet GPIO\n");
-		return -ENODEV;
-	}
-	err = gpio_direction_input(gpio);
-	if (err) {
-		pr_info("failed to set ethernet GPIO as input\n");
-		return -ENODEV;
-	}
-	irq = gpio_to_irq(gpio);
-	pr_info("enabled USB-S8815 ethernet GPIO %d, IRQ %d\n", gpio, irq);
-	return 0;
-}
-device_initcall(cpu8815_eth_init);
-
-/*
  * This GPIO pin turns on a line that is used to detect card insertion
  * on this board.
  */
-- 
1.8.3.1
