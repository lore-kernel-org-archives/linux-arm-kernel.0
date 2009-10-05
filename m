From: thommycheck@gmx.de (Thomas Kunze)
Date: Mon,  5 Oct 2009 23:35:29 +0200
Subject: [PATCH 5/9] SA1100: make gpio_to_irq and reverse a macro
In-Reply-To: <1254778533-3529-5-git-send-email-thommycheck@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-4-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-5-git-send-email-thommycheck@gmx.de>
Message-ID: <1254778533-3529-6-git-send-email-thommycheck@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function can't be used for static initialisations so
convert them to macros.

Signed-off-by: Thomas Kunze <thommycheck@gmx.de>
---
 arch/arm/mach-sa1100/include/mach/gpio.h |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
index 582a0c9..7befc10 100644
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/gpio.h
@@ -49,20 +49,9 @@ static inline void gpio_set_value(unsigned gpio, int value)
 
 #define gpio_cansleep	__gpio_cansleep
 
-static inline unsigned gpio_to_irq(unsigned gpio)
-{
-	if (gpio < 11)
-		return IRQ_GPIO0 + gpio;
-	else
-		return IRQ_GPIO11 - 11 + gpio;
-}
-
-static inline unsigned irq_to_gpio(unsigned irq)
-{
-	if (irq < IRQ_GPIO11_27)
-		return irq - IRQ_GPIO0;
-	else
-		return irq - IRQ_GPIO11 + 11;
-}
+#define gpio_to_irq(gpio)	((gpio < 11) ? (IRQ_GPIO0 + gpio) : \
+					(IRQ_GPIO11 - 11 + gpio))
+#define irq_to_gpio(irq)	((irq < IRQ_GPIO11_27) ? (irq - IRQ_GPIO0) : \
+					(irq - IRQ_GPIO11 + 11))
 
 #endif
-- 
1.6.0.4
