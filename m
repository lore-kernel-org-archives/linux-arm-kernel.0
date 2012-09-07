From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Sep 2012 14:18:11 +0200
Subject: [PATCH 2/7] gpio: 74x164: Use devm_kzalloc
In-Reply-To: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1347020296-18796-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Florian Fainelli <florian@openwrt.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-74x164.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 2975036..604b998 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -90,7 +90,7 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(&spi->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -125,7 +125,6 @@ static int __devinit gen_74x164_probe(struct spi_device *spi)
 exit_destroy:
 	dev_set_drvdata(&spi->dev, NULL);
 	mutex_destroy(&chip->lock);
-	kfree(chip);
 	return ret;
 }
 
@@ -141,10 +140,9 @@ static int __devexit gen_74x164_remove(struct spi_device *spi)
 	dev_set_drvdata(&spi->dev, NULL);
 
 	ret = gpiochip_remove(&chip->gpio_chip);
-	if (!ret) {
+	if (!ret)
 		mutex_destroy(&chip->lock);
-		kfree(chip);
-	} else
+	else
 		dev_err(&spi->dev, "Failed to remove the GPIO controller: %d\n",
 				ret);
 
-- 
1.7.9.5
