From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2011 18:24:57 +0000
Subject: [PATCH] GPIO: sa1100: implement proper gpiolib gpio_to_irq conversion
Message-ID: <20111218182457.GV14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The existing gpio_to_irq() implementation on sa1100 only translates
validly for internal GPIOs.  Since this sub-arch enables GPIOLIB
support, this results in buggy translations for non-internal GPIOs.

Get rid of the private gpio_to_irq() implementation, replacing it
with the .to_irq method in the sa1100 gpio chip instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Grant, please apply to your gpio tree.  Thanks.

 arch/arm/mach-sa1100/include/mach/gpio.h |    3 ---
 drivers/gpio/gpio-sa1100.c               |    6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
index 7036318..a38fc4f 100644
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/gpio.h
@@ -51,7 +51,4 @@ static inline void gpio_set_value(unsigned gpio, int value)
 
 #define gpio_cansleep	__gpio_cansleep
 
-#define gpio_to_irq(gpio)	((gpio < 11) ? (IRQ_GPIO0 + gpio) : \
-					(IRQ_GPIO11 - 11 + gpio))
-
 #endif
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index b6c1f6d..7eecf69 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -47,12 +47,18 @@ static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int
 	return 0;
 }
 
+static int sa1100_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return offset < 11 ? (IRQ_GPIO0 + offset) : (IRQ_GPIO11 - 11 + offset);
+}
+
 static struct gpio_chip sa1100_gpio_chip = {
 	.label			= "gpio",
 	.direction_input	= sa1100_direction_input,
 	.direction_output	= sa1100_direction_output,
 	.set			= sa1100_gpio_set,
 	.get			= sa1100_gpio_get,
+	.to_irq			= sa1100_to_irq,
 	.base			= 0,
 	.ngpio			= GPIO_MAX + 1,
 };
