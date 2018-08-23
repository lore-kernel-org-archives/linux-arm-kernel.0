From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Aug 2018 12:33:29 +0200
Subject: [PATCH 1/4] eeprom: at24: Allow passing gpiodesc from pdata
In-Reply-To: <20180823103332.32047-1-linus.walleij@linaro.org>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
Message-ID: <20180823103332.32047-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to pass an initialized GPIO descriptor
to the driver through platform data.

This is useful when we are dealing with EEPROMs on expansion
boards where the GPIO has to be looked up indirectly using a
connector abstraction (several systems using the same
connector) so the machine descriptor tables cannot be used
to associate the descriptor with the device and we then want
to pass this descriptor on to the EEPROM driver this way
instead.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes
- Requesting an ACK from the EEPROM maintainer (Bartosz) so
  we can apply this to the ARM SoC tree with the series depending
  on it.
---
 drivers/misc/eeprom/at24.c         | 6 +++++-
 include/linux/platform_data/at24.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f5cc517d1131..d577cdbe221e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -662,7 +662,11 @@ static int at24_probe(struct i2c_client *client)
 	at24->client[0].client = client;
 	at24->client[0].regmap = regmap;
 
-	at24->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
+	if (pdata.wp_gpiod)
+		at24->wp_gpio = pdata.wp_gpiod;
+	else
+		at24->wp_gpio =
+			devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_HIGH);
 	if (IS_ERR(at24->wp_gpio))
 		return PTR_ERR(at24->wp_gpio);
 
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 63507ff464ee..5606fb2ef76c 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/bitops.h>
+#include <linux/gpio/consumer.h>
 
 /**
  * struct at24_platform_data - data to set up at24 (generic eeprom) driver
@@ -55,6 +56,7 @@ struct at24_platform_data {
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
+	struct gpio_desc *wp_gpiod;
 };
 
 #endif /* _LINUX_AT24_H */
-- 
2.17.0
