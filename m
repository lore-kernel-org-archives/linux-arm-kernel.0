From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Aug 2013 01:55:51 +0200
Subject: [PATCH 3/3] ARM: nomadik: retire ethernet IRQ request mechanism
Message-ID: <1376697351-18918-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was a bit picky and did actually define the ethernet GPIO line
as both a plain GPIO line in one place and as an interrupt line
in another place - as a GPIO line it would be requested and set
to input and then left like that.

Now that the GPIO OF core will request and set as input any GPIO
line used as interrupt, we can remove this mechanism and delete
the corresponding device tree node.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts |  4 ----
 arch/arm/mach-nomadik/cpu-8815.c        | 32 --------------------------------
 2 files changed, 36 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 16c3888..f557feb 100644
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
index 13e0df9..b5c7244 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -158,38 +158,6 @@ static struct fsmc_nand_platform_data cpu8815_nand_data = {
 };
 
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
  * TODO:
  * cannot be set from device tree, convert to a proper DT
  * binding.
-- 
1.8.1.4
