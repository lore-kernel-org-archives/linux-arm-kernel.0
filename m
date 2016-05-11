From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 11 May 2016 13:40:00 -0400
Subject: [PATCH] gpio: lpc32xx: disable broken to_irq support
Message-ID: <1462988400-21738-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The "to_irq" functionality is broken inside this driver since commit
76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler").

The addition of the new lpc32xx irqchip driver in 4.7, fixed the
lpc32xx platform interrupt issue.

When switching to the new lpc32xx irqchip driver, a warning appear
in the lpc32xx gpio driver: warning: "NR_IRQS" redefined.

To remove this warning (temporary solution), this patch
disables the broken "to_irq" mapping functionality support.

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Note:
* For details on the lpc32xx irqchip patch, refer to:
  http://thread.gmane.org/gmane.linux.drivers.devicetree/165620

* The final solution is to replace the existing lpc32xx gpio driver.
  This work is currently in progress; refer to the following URL:
  http://thread.gmane.org/gmane.linux.drivers.devicetree/144696

 drivers/gpio/gpio-lpc32xx.c | 48 +--------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index d39014d..fc5f197 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -29,7 +29,6 @@
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <mach/irqs.h>
 
 #define LPC32XX_GPIO_P3_INP_STATE		_GPREG(0x000)
 #define LPC32XX_GPIO_P3_OUTP_SET		_GPREG(0x004)
@@ -371,61 +370,16 @@ static int lpc32xx_gpio_request(struct gpio_chip *chip, unsigned pin)
 
 static int lpc32xx_gpio_to_irq_p01(struct gpio_chip *chip, unsigned offset)
 {
-	return IRQ_LPC32XX_P0_P1_IRQ;
+	return -ENXIO;
 }
 
-static const char lpc32xx_gpio_to_irq_gpio_p3_table[] = {
-	IRQ_LPC32XX_GPIO_00,
-	IRQ_LPC32XX_GPIO_01,
-	IRQ_LPC32XX_GPIO_02,
-	IRQ_LPC32XX_GPIO_03,
-	IRQ_LPC32XX_GPIO_04,
-	IRQ_LPC32XX_GPIO_05,
-};
-
 static int lpc32xx_gpio_to_irq_gpio_p3(struct gpio_chip *chip, unsigned offset)
 {
-	if (offset < ARRAY_SIZE(lpc32xx_gpio_to_irq_gpio_p3_table))
-		return lpc32xx_gpio_to_irq_gpio_p3_table[offset];
 	return -ENXIO;
 }
 
-static const char lpc32xx_gpio_to_irq_gpi_p3_table[] = {
-	IRQ_LPC32XX_GPI_00,
-	IRQ_LPC32XX_GPI_01,
-	IRQ_LPC32XX_GPI_02,
-	IRQ_LPC32XX_GPI_03,
-	IRQ_LPC32XX_GPI_04,
-	IRQ_LPC32XX_GPI_05,
-	IRQ_LPC32XX_GPI_06,
-	IRQ_LPC32XX_GPI_07,
-	IRQ_LPC32XX_GPI_08,
-	IRQ_LPC32XX_GPI_09,
-	-ENXIO, /* 10 */
-	-ENXIO, /* 11 */
-	-ENXIO, /* 12 */
-	-ENXIO, /* 13 */
-	-ENXIO, /* 14 */
-	-ENXIO, /* 15 */
-	-ENXIO, /* 16 */
-	-ENXIO, /* 17 */
-	-ENXIO, /* 18 */
-	IRQ_LPC32XX_GPI_19,
-	-ENXIO, /* 20 */
-	-ENXIO, /* 21 */
-	-ENXIO, /* 22 */
-	-ENXIO, /* 23 */
-	-ENXIO, /* 24 */
-	-ENXIO, /* 25 */
-	-ENXIO, /* 26 */
-	-ENXIO, /* 27 */
-	IRQ_LPC32XX_GPI_28,
-};
-
 static int lpc32xx_gpio_to_irq_gpi_p3(struct gpio_chip *chip, unsigned offset)
 {
-	if (offset < ARRAY_SIZE(lpc32xx_gpio_to_irq_gpi_p3_table))
-		return lpc32xx_gpio_to_irq_gpi_p3_table[offset];
 	return -ENXIO;
 }
 
-- 
1.8.3.1
