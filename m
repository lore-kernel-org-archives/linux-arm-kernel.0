From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  6 Jun 2011 14:20:46 +0800
Subject: [PATCH 1/2] gpio/mxs: save the unnecessary function mxs_gpio_to_irq
Message-ID: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq number can be easily calculated from the sum of
MXS_GPIO_IRQ_START and gpio number.  The patch directly defines
gpio_to_irq for it and removes mxs_gpio_to_irq to simplify the
the driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/gpio.h |    2 +-
 drivers/gpio/gpio-mxs.c               |    9 ---------
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index 828cccc..18017c5 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -28,8 +28,8 @@
 #define gpio_get_value		__gpio_get_value
 #define gpio_set_value		__gpio_set_value
 #define gpio_cansleep		__gpio_cansleep
-#define gpio_to_irq		__gpio_to_irq
 
 #define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
+#define gpio_to_irq(gpio)	(MXS_GPIO_IRQ_START + (gpio))
 
 #endif /* __MACH_MXS_GPIO_H__ */
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index a287614..d01f046 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -236,14 +236,6 @@ static void mxs_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		writel(1 << offset, pin_addr + MXS_CLR);
 }
 
-static int mxs_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct mxs_gpio_port *port =
-		container_of(chip, struct mxs_gpio_port, chip);
-
-	return port->virtual_irq_start + offset;
-}
-
 static int mxs_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	mxs_set_gpio_direction(chip, offset, 0);
@@ -327,7 +319,6 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 	port->chip.direction_output = mxs_gpio_direction_output;
 	port->chip.get = mxs_gpio_get;
 	port->chip.set = mxs_gpio_set;
-	port->chip.to_irq = mxs_gpio_to_irq;
 	port->chip.base = port->id * 32;
 	port->chip.ngpio = 32;
 
-- 
1.7.4.1
