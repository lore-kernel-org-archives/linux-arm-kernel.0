From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Apr 2014 14:41:36 +0800
Subject: [PATCH 2/7] gpiolib: Support purely name based gpiod lookup in device
 trees
In-Reply-To: <1397544101-18135-1-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
Message-ID: <1397544101-18135-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables gpio-names based gpiod lookup in device tree usage,
which ignores the index passed to gpiod_get_index. If this fails, fall
back to the original function-index ("con_id"-gpios) based lookup scheme,
for backward compatibility and any drivers needing more than one GPIO
for any function.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpio/gpiolib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 761013f..956f01e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2585,8 +2585,13 @@ static struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	else
 		snprintf(prop_name, 32, "gpios");
 
-	desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
-					&of_flags);
+	/* try gpio-names based lookup first */
+	desc = of_get_gpiod_flags_by_name(dev->of_node, con_id, &of_flags);
+
+	/* fallback to function based lookup */
+	if (IS_ERR(desc))
+		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
+				&of_flags);
 
 	if (IS_ERR(desc))
 		return desc;
-- 
1.9.1
