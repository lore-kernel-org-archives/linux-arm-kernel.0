From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:52 +0000
Subject: [PATCH 03/12] regulator: gpio-regulator: Fix logical error in for()
 loop
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cond-statement of this particular for() loop will always be
true as long as at least one voltage-shifting GPIO is present.
If it wasn't for the break below, we'd be stuck in a forever loop.
This patch inserts the correct cond-statement into the statement.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/gpio-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 3afa46a..5462c28 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -181,7 +181,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 	if (!config->gpios)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; config->nr_gpios; i++) {
+	for (i = 0; i < config->nr_gpios; i++) {
 		gpio = of_get_named_gpio(np, "gpios", i);
 		if (gpio < 0)
 			break;
-- 
1.7.9.5
