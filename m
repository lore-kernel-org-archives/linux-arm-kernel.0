From: eunki_kim@samsung.com (Eunki Kim)
Date: Thu, 27 Sep 2012 12:55:24 +0900
Subject: [PATCH 2/2] gpio: samsung: Fix input mode setting function for GPIO
 int
Message-ID: <000101cd9c63$ecb606a0$c62213e0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes GPIO pin to INTERRUPT mode or INPUT mode according
to bitmap_gpio_int. When the related bit of bitmap_gpio_int is set,
it makes GPIO pin to INTERRUPT mode instrad of INPUT mode in the
samsung_gpiolib_4bit_input function.

Signed-off-by: Eunki Kim <eunki_kim@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/gpio/gpio-samsung.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index ba126cc..19caef4 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -596,7 +596,10 @@ static int samsung_gpiolib_4bit_input(struct gpio_chip *chip,
 	unsigned long con;
 
 	con = __raw_readl(base + GPIOCON_OFF);
-	con &= ~(0xf << con_4bit_shift(offset));
+	if (ourchip->bitmap_gpio_int & BIT(offset))
+		con |= 0xf << con_4bit_shift(offset);
+	else
+		con &= ~(0xf << con_4bit_shift(offset));
 	__raw_writel(con, base + GPIOCON_OFF);
 
 	gpio_dbg("%s: %p: CON now %08lx\n", __func__, base, con);
@@ -1018,6 +1021,8 @@ static void __init samsung_gpiolib_add_4bit_chips(struct samsung_gpio_chip
*chip
 		if ((base != NULL) && (chip->base == NULL))
 			chip->base = base + ((i) * 0x20);
 
+		chip->bitmap_gpio_int = 0;
+
 		samsung_gpiolib_add(chip);
 	}
 }
-- 
1.7.1
