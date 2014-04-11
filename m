From: alexanders83@web.de (Alexander Stein)
Date: Fri, 11 Apr 2014 20:33:13 +0200
Subject: [PATCH] pinctrl/at91: Fix mask creation in at91_gpio_dbg_show
In-Reply-To: <CAJjB1qLC6HBwz=bBef-EGH8wrfpqE3DdTGcfGrwb_r1qCdRPRA@mail.gmail.com>
References: <CAJjB1qLC6HBwz=bBef-EGH8wrfpqE3DdTGcfGrwb_r1qCdRPRA@mail.gmail.com>
Message-ID: <1397241193-2420-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pin_to_mask expects a bank pin number. So do not add the chip base.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
Mark, thanks for the clarification that pin_to_mask only expects tha bank
pin number. This wasn't obvious to me.
 drivers/pinctrl/pinctrl-at91.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 63176f2..2da0e6e 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1205,8 +1205,7 @@ static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	void __iomem *pio = at91_gpio->regbase;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		unsigned pin = chip->base + i;
-		unsigned mask = pin_to_mask(pin);
+		unsigned mask = pin_to_mask(i);
 		const char *gpio_label;
 		u32 pdsr;
 
-- 
1.9.2
