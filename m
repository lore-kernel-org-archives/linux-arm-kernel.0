From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 10:35:17 +0100
Subject: [PATCH 06/12] gpio: davinci: restore a way to manually specify the
 GPIO base
In-Reply-To: <20181121093523.12503-1-brgl@bgdev.pl>
References: <20181121093523.12503-1-brgl@bgdev.pl>
Message-ID: <20181121093523.12503-7-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the network support in legacy boot
mode for da850-evm since we can no longer request the MDIO clock GPIO.

Other boards may be broken too, which I haven't tested.

The problem is in the fact that most board files still use the legacy
GPIO API where lines are requested by numbers rather than descriptors.

While this should be fixed eventually, in order to unbreak the board
for now - provide a way to manually specify the GPIO base in platform
data.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable at vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-davinci.c                | 2 +-
 include/linux/platform_data/gpio-davinci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 5c1564fcc24e..bdb29e51b417 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -258,7 +258,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.set = davinci_gpio_set;
 
 	chips->chip.ngpio = ngpio;
-	chips->chip.base = -1;
+	chips->chip.base = pdata->no_auto_base ? pdata->base : -1;
 
 #ifdef CONFIG_OF_GPIO
 	chips->chip.of_gpio_n_cells = 2;
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index f92a47e18034..a93841bfb9f7 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -17,6 +17,8 @@
 #define __DAVINCI_GPIO_PLATFORM_H
 
 struct davinci_gpio_platform_data {
+	bool	no_auto_base;
+	u32	base;
 	u32	ngpio;
 	u32	gpio_unbanked;
 };
-- 
2.19.1
