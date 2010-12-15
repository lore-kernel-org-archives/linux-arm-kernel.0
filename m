From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:38 +0100
Subject: [PATCH 08/16] ARM: at91: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020338.GA15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-at91/gpio.c              |    7 +++++++
 arch/arm/mach-at91/include/mach/gpio.h |    6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index ae4772e..efcfe8b 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -44,6 +44,7 @@ static int at91_gpiolib_direction_output(struct gpio_chip *chip,
 					 unsigned offset, int val);
 static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 					unsigned offset);
+static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset);
 
 #define AT91_GPIO_CHIP(name, base_gpio, nr_gpio)			\
 	{								\
@@ -53,6 +54,7 @@ static int at91_gpiolib_direction_input(struct gpio_chip *chip,
 			.direction_output = at91_gpiolib_direction_output, \
 			.get		  = at91_gpiolib_get,		\
 			.set		  = at91_gpiolib_set,		\
+			.to_irq		  = at91_gpiolib_to_irq,	\
 			.dbg_show	  = at91_gpiolib_dbg_show,	\
 			.base		  = base_gpio,			\
 			.ngpio		  = nr_gpio,			\
@@ -586,6 +588,11 @@ static void at91_gpiolib_set(struct gpio_chip *chip, unsigned offset, int val)
 	__raw_writel(mask, pio + (val ? PIO_SODR : PIO_CODR));
 }
 
+static int at91_gpiolib_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return chip->base + offset;
+}
+
 static void at91_gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	int i;
diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index bfdd8ab..1e557f4 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -219,11 +219,7 @@ extern void at91_gpio_resume(void);
 #define gpio_get_value	__gpio_get_value
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
-
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return gpio;
-}
+#define gpio_to_irq	__gpio_to_irq
 
 static inline int irq_to_gpio(unsigned irq)
 {
-- 
1.7.1
