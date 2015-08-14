From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:11:01 +0200
Subject: [PATCH v3 4/9] gpio-sysfs: Use gpio descriptor name instead of
 gpiochip names array
In-Reply-To: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439561466-14350-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name is now stored in the gpio descriptor as well, for example to
allow to store names from DT. This patch changes the sysfs gpio files
to use the gpio descriptor name.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-sysfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index b57ed8e55ab5..3e81f28e3aee 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -550,9 +550,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	struct gpiod_data	*data;
 	unsigned long		flags;
 	int			status;
-	const char		*ioname = NULL;
 	struct device		*dev;
-	int			offset;
 
 	/* can't export until sysfs is available ... */
 	if (!gpio_class.p) {
@@ -601,13 +599,9 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	else
 		data->direction_can_change = false;
 
-	offset = gpio_chip_hwgpio(desc);
-	if (chip->names && chip->names[offset])
-		ioname = chip->names[offset];
-
 	dev = device_create_with_groups(&gpio_class, chip->dev,
 					MKDEV(0, 0), data, gpio_groups,
-					ioname ? ioname : "gpio%u",
+					desc->name ? desc->name : "gpio%u",
 					desc_to_gpio(desc));
 	if (IS_ERR(dev)) {
 		status = PTR_ERR(dev);
-- 
2.4.6
