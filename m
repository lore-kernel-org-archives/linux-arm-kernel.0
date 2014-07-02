From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 02 Jul 2014 17:41:00 +0200
Subject: [PATCH 2/6] pinctrl: samsung: Handle GPIO request and free using
 pinctrl helpers
In-Reply-To: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404315664-3174-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds .request() and .free() operations to gpio_chip of
pinctrl-samsung driver, which call pinctrl request and free helpers to
request and free pinctrl pin along with GPIO pin.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 779c8bc..6e099d6 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -779,7 +779,8 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 		pin_bank = &drvdata->ctrl->pin_banks[bank];
 		pin_bank->grange.name = pin_bank->name;
 		pin_bank->grange.id = bank;
-		pin_bank->grange.pin_base = pin_bank->pin_base;
+		pin_bank->grange.pin_base = drvdata->ctrl->base
+						+ pin_bank->pin_base;
 		pin_bank->grange.base = pin_bank->gpio_chip.base;
 		pin_bank->grange.npins = pin_bank->gpio_chip.ngpio;
 		pin_bank->grange.gc = &pin_bank->gpio_chip;
@@ -789,7 +790,19 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 	return 0;
 }
 
+static int samsung_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void samsung_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+}
+
 static const struct gpio_chip samsung_gpiolib_chip = {
+	.request = samsung_gpio_request,
+	.free = samsung_gpio_free,
 	.set = samsung_gpio_set,
 	.get = samsung_gpio_get,
 	.direction_input = samsung_gpio_direction_input,
-- 
1.9.3
