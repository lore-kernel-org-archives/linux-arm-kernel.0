From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 11:57:43 +0100
Subject: [PATCH] gemini: fixup irq_data conversion compile breakage
Message-ID: <1302519463-15996-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq_data conversion changed gpio_ack_irq() to take irq_data but
didn't convert gpio_set_irq_type to pass the irq_data.

  CC      arch/arm/mach-gemini/gpio.o
arch/arm/mach-gemini/gpio.c: In function ?gpio_set_irq_type?:
arch/arm/mach-gemini/gpio.c:126: warning: passing argument 1 of ?gpio_ack_irq? makes pointer from integer without a cast
arch/arm/mach-gemini/gpio.c:60: note: expected ?struct irq_data *? but argument is of type ?unsigned int?

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-gemini/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index fdc7ef1..d4e74ee 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -120,7 +120,7 @@ static int gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	__raw_writel(reg_level, base + GPIO_INT_LEVEL);
 	__raw_writel(reg_both, base + GPIO_INT_BOTH_EDGE);
 
-	gpio_ack_irq(d->irq);
+	gpio_ack_irq(d);
 
 	return 0;
 }
-- 
1.7.4.2
