From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 10 Nov 2016 17:21:29 +0800
Subject: [PATCH] regulator: gpio: properly check return value of
 of_get_named_gpio
Message-ID: <20161110092129.2203-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function of_get_named_gpio() could return -ENOENT, -EPROBE_DEFER
-EINVAL and so on. Currently, for the optional property "enable-gpio",
we only check -EPROBE_DEFER, this is not enough since there may be
misconfigured "enable-gpio" in the DTB, of_get_named_gpio() will return
-EINVAL in this case, we should return immediately here. And for the
optional property "gpios", we didn't check the return value, the driver
will continue to the point where gpio_request_array() is called, it
doesn't make sense to continue if we got -EPROBE_DEFER or -EINVAL here.

This patch tries to address these two issues by properly checking the
return value of of_get_named_gpio.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/regulator/gpio-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 83e89e5..0fce06a 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -162,8 +162,8 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
 	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio == -EPROBE_DEFER)
-		return ERR_PTR(-EPROBE_DEFER);
+	if (config->enable_gpio < 0 && config->enable_gpio != -ENOENT)
+		return ERR_PTR(config->enable_gpio);
 
 	/* Fetch GPIOs. - optional property*/
 	ret = of_gpio_count(np);
@@ -190,8 +190,11 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 		for (i = 0; i < config->nr_gpios; i++) {
 			gpio = of_get_named_gpio(np, "gpios", i);
-			if (gpio < 0)
+			if (gpio < 0) {
+				if (gpio != -ENOENT)
+					return ERR_PTR(gpio);
 				break;
+			}
 			config->gpios[i].gpio = gpio;
 			if (proplen > 0) {
 				of_property_read_u32_index(np, "gpios-states",
-- 
2.10.2
