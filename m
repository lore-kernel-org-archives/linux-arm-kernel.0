From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 29 Dec 2010 13:01:31 +0200
Subject: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
Message-ID: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
updating reg and l values. However, at the end of the function we
perform a write:

	__raw_writel(l, reg);

So on OMAP2+ we end up writing 0 to the bank->base which is not
correct (typically this points to GPIO_REVISION register).

Fix this by returning immediately after call to
set_24xx_gpio_triggering().

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..4dcb66f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -867,7 +867,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	case METHOD_GPIO_24XX:
 	case METHOD_GPIO_44XX:
 		set_24xx_gpio_triggering(bank, gpio, trigger);
-		break;
+		return 0;
 #endif
 	default:
 		goto bad;
-- 
1.7.3.2
