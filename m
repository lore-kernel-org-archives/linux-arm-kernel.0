From: j-keerthy@ti.com (Keerthy)
Date: Thu, 20 Jul 2017 15:12:16 +0530
Subject: [PATCH v2 1/3] gpio: davinci: Use devm_gpiochip_add_data in place of
 gpiochip_add_data
In-Reply-To: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1500543738-9696-2-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the devm version of gpiochip_add_data and pass on the
return value. This avoids memory leak due to gpiochip_add_data
in case the driver is unbound.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Restoring the previous values of ctrl_num and bank_base in case of an error.

 drivers/gpio/gpio-davinci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 65cb359..27499ec 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -166,7 +166,7 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int davinci_gpio_probe(struct platform_device *pdev)
 {
 	static int ctrl_num, bank_base;
-	int gpio, bank;
+	int gpio, bank, ret = 0;
 	unsigned ngpio, nbank;
 	struct davinci_gpio_controller *chips;
 	struct davinci_gpio_platform_data *pdata;
@@ -232,10 +232,20 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
 		chips->regs[bank] = gpio_base + offset_array[bank];
 
-	gpiochip_add_data(&chips->chip, chips);
+	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
+	if (ret)
+		goto err;
+
 	platform_set_drvdata(pdev, chips);
 	davinci_gpio_irq_setup(pdev);
 	return 0;
+
+err:
+	/* Revert the static variable increments */
+	ctrl_num--;
+	bank_base -= ngpio;
+
+	return ret;
 }
 
 /*--------------------------------------------------------------------------*/
-- 
1.9.1
