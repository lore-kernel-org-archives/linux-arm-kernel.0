From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 14:30:00 +0200
Subject: [PATCH 1/7] ARM: ixp4xx: convert remaining users to use gpiolib
Message-ID: <1378816200-7940-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few call sites inside mach-ixp4xx were still using the custom
ixp4xx GPIO API with gpio_line_* accessors, convert all these
to use the standard gpiolib functions instead. Also attempt to
request and label all GPIOs before use.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ixp4xx/dsmg600-setup.c | 16 +++++++++-------
 arch/arm/mach-ixp4xx/ixdp425-setup.c |  8 +++++---
 arch/arm/mach-ixp4xx/nas100d-setup.c | 15 ++++++++-------
 arch/arm/mach-ixp4xx/nslu2-setup.c   | 10 +++++-----
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 63de1b3..9095097 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -26,6 +26,7 @@
 #include <linux/reboot.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 
@@ -161,11 +162,8 @@ static struct platform_device *dsmg600_devices[] __initdata = {
 
 static void dsmg600_power_off(void)
 {
-	/* enable the pwr cntl gpio */
-	gpio_line_config(DSMG600_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* poweroff */
-	gpio_line_set(DSMG600_PO_GPIO, IXP4XX_GPIO_HIGH);
+	/* enable the pwr cntl and drive it high */
+	gpio_direction_output(DSMG600_PO_GPIO, 1);
 }
 
 /* This is used to make sure the power-button pusher is serious.  The button
@@ -202,7 +200,7 @@ static void dsmg600_power_handler(unsigned long data)
 			ctrl_alt_del();
 
 			/* Change the state of the power LED to "blink" */
-			gpio_line_set(DSMG600_LED_PWR_GPIO, IXP4XX_GPIO_LOW);
+			gpio_set_value(DSMG600_LED_PWR_GPIO, 0);
 		} else {
 			power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
 		}
@@ -252,6 +250,7 @@ static void __init dsmg600_init(void)
 
 	pm_power_off = dsmg600_power_off;
 
+	gpio_request(DSMG600_RB_GPIO, "reset button");
 	if (request_irq(gpio_to_irq(DSMG600_RB_GPIO), &dsmg600_reset_handler,
 		IRQF_DISABLED | IRQF_TRIGGER_LOW,
 		"DSM-G600 reset button", NULL) < 0) {
@@ -266,7 +265,10 @@ static void __init dsmg600_init(void)
 	 */
 
 	/* Make sure that the power button GPIO is set up as an input */
-	gpio_line_config(DSMG600_PB_GPIO, IXP4XX_GPIO_IN);
+	gpio_request(DSMG600_PB_GPIO, "power button");
+	gpio_direction_input(DSMG600_PB_GPIO);
+	/* Request poweroff GPIO line */
+	gpio_request(DSMG600_PO_GPIO, "power off button");
 
 	/* Set the initial value for the power button IRQ handler */
 	power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 22d688b..e7b8bef 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <asm/types.h>
 #include <asm/setup.h>
 #include <asm/memory.h>
@@ -80,10 +81,10 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_NCE) {
-			gpio_line_set(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_LOW);
+			gpio_set_value(IXDP425_NAND_NCE_PIN, 0);
 			udelay(5);
 		} else
-			gpio_line_set(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_HIGH);
+			gpio_set_value(IXDP425_NAND_NCE_PIN, 1);
 
 		offset = (ctrl & NAND_CLE) ? IXDP425_NAND_CMD_BYTE : 0;
 		offset |= (ctrl & NAND_ALE) ? IXDP425_NAND_ADDR_BYTE : 0;
@@ -227,7 +228,8 @@ static void __init ixdp425_init(void)
 	ixdp425_flash_nand_resource.start = IXP4XX_EXP_BUS_BASE(3),
 	ixdp425_flash_nand_resource.end   = IXP4XX_EXP_BUS_BASE(3) + 0x10 - 1;
 
-	gpio_line_config(IXDP425_NAND_NCE_PIN, IXP4XX_GPIO_OUT);
+	gpio_request(IXDP425_NAND_NCE_PIN, "NAND NCE pin");
+	gpio_direction_output(IXDP425_NAND_NCE_PIN, 0);
 
 	/* Configure expansion bus for NAND Flash */
 	*IXP4XX_EXP_CS3 = IXP4XX_EXP_BUS_CS_EN |
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index ed667ce..04f723a 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -184,11 +184,8 @@ static void nas100d_power_off(void)
 {
 	/* This causes the box to drop the power and go dead. */
 
-	/* enable the pwr cntl gpio */
-	gpio_line_config(NAS100D_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* do the deed */
-	gpio_line_set(NAS100D_PO_GPIO, IXP4XX_GPIO_HIGH);
+	/* enable the pwr cntl gpio and assert power off */
+	gpio_direction_output(NAS100D_PO_GPIO, 1);
 }
 
 /* This is used to make sure the power-button pusher is serious.  The button
@@ -225,7 +222,7 @@ static void nas100d_power_handler(unsigned long data)
 			ctrl_alt_del();
 
 			/* Change the state of the power LED to "blink" */
-			gpio_line_set(NAS100D_LED_PWR_GPIO, IXP4XX_GPIO_LOW);
+			gpio_set_value(NAS100D_LED_PWR_GPIO, 0);
 		} else {
 			power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
 		}
@@ -283,8 +280,12 @@ static void __init nas100d_init(void)
 	 * have to poll it with a kernel timer.
 	 */
 
+	/* Request the power off GPIO */
+	gpio_request(NAS100D_PO_GPIO, "power off");
+
 	/* Make sure that the power button GPIO is set up as an input */
-	gpio_line_config(NAS100D_PB_GPIO, IXP4XX_GPIO_IN);
+	gpio_request(NAS100D_PB_GPIO, "power button");
+	gpio_direction_input(NAS100D_PB_GPIO);
 
 	/* Set the initial value for the power button IRQ handler */
 	power_button_countdown = PBUTTON_HOLDDOWN_COUNT;
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 7e55236..c8c13df 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -197,11 +197,8 @@ static void nslu2_power_off(void)
 {
 	/* This causes the box to drop the power and go dead. */
 
-	/* enable the pwr cntl gpio */
-	gpio_line_config(NSLU2_PO_GPIO, IXP4XX_GPIO_OUT);
-
-	/* do the deed */
-	gpio_line_set(NSLU2_PO_GPIO, IXP4XX_GPIO_HIGH);
+	/* enable the pwr cntl gpio and assert power off */
+	gpio_direction_output(NSLU2_PO_GPIO, 1);
 }
 
 static irqreturn_t nslu2_power_handler(int irq, void *dev_id)
@@ -273,6 +270,9 @@ static void __init nslu2_init(void)
 			gpio_to_irq(NSLU2_PB_GPIO));
 	}
 
+	/* Request the power off GPIO */
+	gpio_request(NSLU2_PO_GPIO, "power off");
+
 	/*
 	 * Map in a portion of the flash and read the MAC address.
 	 * Since it is stored in BE in the flash itself, we need to
-- 
1.8.3.1
