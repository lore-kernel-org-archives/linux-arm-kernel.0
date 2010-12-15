From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:43 +0100
Subject: [PATCH 10/16] ARM: gemini: Switch over to gpiolib ->to_irq() and
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020343.GC15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-gemini/gpio.c              |    6 ++++++
 arch/arm/mach-gemini/include/mach/gpio.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index fe3bd5a..40259b7 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -197,12 +197,18 @@ static int gemini_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
+static int gemini_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	return GPIO_IRQ_BASE + offset;
+}
+
 static struct gpio_chip gemini_gpio_chip = {
 	.label			= "Gemini",
 	.direction_input	= gemini_gpio_direction_input,
 	.get			= gemini_gpio_get,
 	.direction_output	= gemini_gpio_direction_output,
 	.set			= gemini_gpio_set,
+	.to_irq			= gemini_gpio_to_irq,
 	.base			= 0,
 	.ngpio			= GPIO_PORT_NUM * 32,
 };
diff --git a/arch/arm/mach-gemini/include/mach/gpio.h b/arch/arm/mach-gemini/include/mach/gpio.h
index 3bc2c70..41f8f6a 100644
--- a/arch/arm/mach-gemini/include/mach/gpio.h
+++ b/arch/arm/mach-gemini/include/mach/gpio.h
@@ -18,8 +18,8 @@
 #define gpio_get_value	__gpio_get_value
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
 
-#define gpio_to_irq(x)	((x) + GPIO_IRQ_BASE)
 #define irq_to_gpio(x)	((x) - GPIO_IRQ_BASE)
 
 #endif /* __MACH_GPIO_H__ */
-- 
1.7.1
