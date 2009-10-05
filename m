From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Oct 2009 18:03:27 -0400
Subject: [PATCH] Change ep93xx gpio_irq static inlines to macros
In-Reply-To: <49EBDE05.1050406@bluewatersys.com>
References: <49EBDE05.1050406@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7762@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Change the gpio_to_irq and irq_to_gpio static inline functions to macros
so that they can be used in variable initialisers.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

This patch seems to have been lost, originally posted 4/19/2009.
Updated so that the macro parameters are wrapped with ().


diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h b/arch/arm/mach-ep93xx/include/mach/gpio.h
index 0a1498a..c991b14 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h
@@ -114,17 +114,9 @@ extern void ep93xx_gpio_int_debounce(unsigned int irq, int enable);
  *          B0..B7  (7..15) to irq 72..79, and
  *          F0..F7 (16..24) to irq 80..87.
  */
-static inline int gpio_to_irq(unsigned gpio)
-{
-	if (gpio <= EP93XX_GPIO_LINE_MAX_IRQ)
-		return 64 + gpio;
-
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return irq - gpio_to_irq(0);
-}
+#define gpio_to_irq(gpio)	\
+	(((gpio) <= EP93XX_GPIO_LINE_MAX_IRQ) ? (64 + (gpio)) : -EINVAL)
+
+#define irq_to_gpio(irq)	((irq) - gpio_to_irq(0))
 
 #endif 
