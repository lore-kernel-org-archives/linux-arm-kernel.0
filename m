From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:56 +0100
Subject: [PATCH 15/16] ARM: sa1100: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020356.GH15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-sa1100/gpio.c              |    9 +++++++++
 arch/arm/mach-sa1100/include/mach/gpio.h |    3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/gpio.c b/arch/arm/mach-sa1100/gpio.c
index 0d3829a..07fda32 100644
--- a/arch/arm/mach-sa1100/gpio.c
+++ b/arch/arm/mach-sa1100/gpio.c
@@ -49,12 +49,21 @@ static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int
 	return 0;
 }
 
+static int sa1100_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset <= 10)
+		return IRQ_GPIO0 + offset;
+
+	return IRQ_GPIO11 + (offset - 11);
+}
+
 static struct gpio_chip sa1100_gpio_chip = {
 	.label			= "gpio",
 	.direction_input	= sa1100_direction_input,
 	.direction_output	= sa1100_direction_output,
 	.set			= sa1100_gpio_set,
 	.get			= sa1100_gpio_get,
+	.to_irq			= sa1100_gpio_to_irq,
 	.base			= 0,
 	.ngpio			= GPIO_MAX + 1,
 };
diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
index 7befc10..982b8f0 100644
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/gpio.h
@@ -48,9 +48,8 @@ static inline void gpio_set_value(unsigned gpio, int value)
 }
 
 #define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
 
-#define gpio_to_irq(gpio)	((gpio < 11) ? (IRQ_GPIO0 + gpio) : \
-					(IRQ_GPIO11 - 11 + gpio))
 #define irq_to_gpio(irq)	((irq < IRQ_GPIO11_27) ? (irq - IRQ_GPIO0) : \
 					(irq - IRQ_GPIO11 + 11))
 
-- 
1.7.1
