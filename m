From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Wed, 22 Mar 2017 17:15:34 +0000
Subject: [PATCH v3 1/2] pinctrl: samsung: Register pinctrl before GPIO
Message-ID: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we request a GPIO hog, then gpiochip_add_data will attempt
to request some of its own GPIOs. The driver also uses
gpiochip_generic_request which means that for any GPIO request to
succeed the pinctrl needs to be registered. Currently however the
driver registers the GPIO and then the pinctrl meaning all GPIO hog
requests will fail, which then in turn causes the whole driver to fail
probe.

Fix this up by ensuring we register the pinctrl first. This
does require us to manually set the GPIO base for the
pinctrl. Fortunately the driver already assigns a fixed GPIO base, in
samsung_gpiolib_register, and uses the same calculation it does for
the pin_base. Meaning the two will always be the same and allowing us
to reuse the pinbase and avoid the issue.

Although currently there are no users of GPIO hogs in mainline
there are plenty of Samsung based boards that are widely used for
development purposes of other hardware. Indeed we hit this issue
whilst attaching some additional hardware to an Arndale system.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v2:
 - Squash in fix to set the GPIO base on the pin_bank.

 drivers/pinctrl/samsung/pinctrl-samsung.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index f9ddba7..5d53370 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -884,7 +884,7 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 		pin_bank->grange.id = bank;
 		pin_bank->grange.pin_base = drvdata->pin_base
 						+ pin_bank->pin_base;
-		pin_bank->grange.base = pin_bank->gpio_chip.base;
+		pin_bank->grange.base = pin_bank->grange.pin_base;
 		pin_bank->grange.npins = pin_bank->gpio_chip.ngpio;
 		pin_bank->grange.gc = &pin_bank->gpio_chip;
 		pinctrl_add_gpio_range(drvdata->pctl_dev, &pin_bank->grange);
@@ -893,6 +893,19 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 	return 0;
 }
 
+/* unregister the pinctrl interface with the pinctrl subsystem */
+static int samsung_pinctrl_unregister(struct platform_device *pdev,
+				      struct samsung_pinctrl_drv_data *drvdata)
+{
+	struct samsung_pin_bank *bank = drvdata->pin_banks;
+	int i;
+
+	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
+		pinctrl_remove_gpio_range(drvdata->pctl_dev, &bank->grange);
+
+	return 0;
+}
+
 static const struct gpio_chip samsung_gpiolib_chip = {
 	.request = gpiochip_generic_request,
 	.free = gpiochip_generic_free,
@@ -917,7 +930,7 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 		bank->gpio_chip = samsung_gpiolib_chip;
 
 		gc = &bank->gpio_chip;
-		gc->base = drvdata->pin_base + bank->pin_base;
+		gc->base = bank->grange.base;
 		gc->ngpio = bank->nr_pins;
 		gc->parent = &pdev->dev;
 		gc->of_node = bank->of_node;
@@ -939,19 +952,6 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 	return ret;
 }
 
-/* unregister the gpiolib interface with the gpiolib subsystem */
-static int samsung_gpiolib_unregister(struct platform_device *pdev,
-				      struct samsung_pinctrl_drv_data *drvdata)
-{
-	struct samsung_pin_bank *bank = drvdata->pin_banks;
-	int i;
-
-	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
-		gpiochip_remove(&bank->gpio_chip);
-
-	return 0;
-}
-
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
@@ -1062,13 +1062,13 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 			return PTR_ERR(drvdata->retention_ctrl);
 	}
 
-	ret = samsung_gpiolib_register(pdev, drvdata);
+	ret = samsung_pinctrl_register(pdev, drvdata);
 	if (ret)
 		return ret;
 
-	ret = samsung_pinctrl_register(pdev, drvdata);
+	ret = samsung_gpiolib_register(pdev, drvdata);
 	if (ret) {
-		samsung_gpiolib_unregister(pdev, drvdata);
+		samsung_pinctrl_unregister(pdev, drvdata);
 		return ret;
 	}
 
-- 
2.1.4
