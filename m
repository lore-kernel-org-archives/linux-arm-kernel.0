From: broonie@kernel.org (Mark Brown)
Date: Tue,  1 Jul 2014 12:55:26 +0100
Subject: [PATCH] regulator: core: Still free GPIOs using gpio_free()
Message-ID: <1404215726-2480-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Even though we mostly use GPIO descriptors internally we still use
gpio_request_one() to request so we need to pair that with gpio_free() to
release the GPIO.

Reported-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/regulator/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c563d93125cd..80381409f856 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1710,7 +1710,12 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
+				/*
+				 * Since we requested with gpio_request_one()
+				 * we still need to free with gpio_free()
+				 * for now.
+				 */
+				gpio_free(desc_to_gpio(pin->gpiod));
 				list_del(&pin->list);
 				kfree(pin);
 			} else {
-- 
2.0.0
