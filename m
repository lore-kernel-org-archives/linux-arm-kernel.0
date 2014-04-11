From: alexanders83@web.de (Alexander Stein)
Date: Fri, 11 Apr 2014 17:35:37 +0200
Subject: [PATCH] pinctrl/at91: Fix pin_to_mask
Message-ID: <1397230537-8727-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need first to reduce the pin number to only a GPIO bank before we can
create the mask.
Otherwise only GPIO bank 0 has correct masks as the bits in the other
banks are shifted out of range.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 drivers/pinctrl/pinctrl-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 63176f2..6669e13 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -316,7 +316,7 @@ static inline int pin_to_bank(unsigned pin)
 
 static unsigned pin_to_mask(unsigned int pin)
 {
-	return 1 << pin;
+	return 1 << (pin % MAX_NB_GPIO_PER_BANK);
 }
 
 static void at91_mux_disable_interrupt(void __iomem *pio, unsigned mask)
-- 
1.9.2
