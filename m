From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jul 2015 11:32:47 +0200
Subject: [PATCH 6/9] gpiolib-of: Reuse 'line-name' from DT as gpio descriptor
 name
In-Reply-To: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1437125570-28623-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT describes gpios with subnodes. These subnodes can contain a
property 'line-name'. This information can be useful in other areas
where we want to identify a GPIO by its name.

This patch stores the line-name in the gpio descriptor.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-of.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 64950591a764..cefc665a558c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -184,11 +184,6 @@ static struct gpio_desc *of_parse_gpio(struct device_node *np,
 		*dflags |= GPIOD_OUT_LOW;
 	else if (of_property_read_bool(np, "output-high"))
 		*dflags |= GPIOD_OUT_HIGH;
-	else {
-		pr_warn("GPIO line %d (%s): no hogging state specified, bailing out\n",
-			desc_to_gpio(gg_data.out_gpio), np->name);
-		return ERR_PTR(-EINVAL);
-	}
 
 	if (name && of_property_read_string(np, "line-name", name))
 		*name = np->name;
@@ -214,15 +209,31 @@ static void of_gpiochip_scan_gpios(struct gpio_chip *chip)
 
 	for_each_child_of_node(chip->of_node, np) {
 		const char *name = NULL;
-		if (!of_property_read_bool(np, "gpio-hog"))
-			continue;
+		struct gpio_desc *name_desc;
 
 		desc = of_parse_gpio(np, &name, &lflags, &dflags);
 		if (IS_ERR(desc))
 			continue;
 
-		if (gpiod_hog(desc, name, lflags, dflags))
-			continue;
+		if (name) {
+			name_desc = gpio_name_to_desc(name);
+			if (name_desc)
+				pr_err("GPIO name collision for '%s' detected at GPIO line %d (%s)\n",
+				       name, desc_to_gpio(desc), np->name);
+			else
+				desc->name = name;
+		}
+
+		if (of_property_read_bool(np, "gpio-hog")) {
+			if (!dflags) {
+				pr_warn("GPIO line %d (%s): no hogging state specified, bailing out\n",
+					desc_to_gpio(desc), np->name);
+				continue;
+			}
+
+			if (gpiod_hog(desc, name, lflags, dflags))
+				continue;
+		}
 	}
 }
 
-- 
2.1.4
