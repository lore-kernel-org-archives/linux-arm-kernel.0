From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jul 2015 11:32:42 +0200
Subject: [PATCH 1/9] gpiolib: Fix possible use of wrong name
In-Reply-To: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1437125570-28623-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name is set optionally from DT. Therefore we need to reset the name
variable for every loop iteration. Otherwise we could use a wrong or
uninitialized name.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9a0ec48a4737..60aebe4d7c26 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -209,11 +209,11 @@ static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
 {
 	struct gpio_desc *desc = NULL;
 	struct device_node *np;
-	const char *name;
 	enum gpio_lookup_flags lflags;
 	enum gpiod_flags dflags;
 
 	for_each_child_of_node(chip->of_node, np) {
+		const char *name = NULL;
 		if (!of_property_read_bool(np, "gpio-hog"))
 			continue;
 
-- 
2.1.4
