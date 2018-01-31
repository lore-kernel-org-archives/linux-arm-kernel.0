From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 30 Jan 2018 18:36:18 -0800
Subject: [PATCH v5 4/4] gpio: Support gpio nexus dt bindings
In-Reply-To: <20180131023618.14292-1-stephen.boyd@linaro.org>
References: <20180131023618.14292-1-stephen.boyd@linaro.org>
Message-ID: <20180131023618.14292-5-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms like 96boards have a standardized connector/expansion
slot that exposes signals like GPIOs to expansion boards in an
SoC agnostic way. We'd like the DT overlays for the expansion
boards to be written once without knowledge of the SoC on the
other side of the connector. This avoids the unscalable
combinatorial explosion of a different DT overlay for each
expansion board and SoC pair.

Now that we have nexus support in the OF core let's change the
function call here that parses the phandle lists of gpios to use
the nexus variant. This allows us to remap phandles and their
arguments through any number of nexus nodes and end up with the
actual gpio provider being used.

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 72a0695d2ac3..09217a87e7ff 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -75,8 +75,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 	struct gpio_desc *desc;
 	int ret;
 
-	ret = of_parse_phandle_with_args(np, propname, "#gpio-cells", index,
-					 &gpiospec);
+	ret = of_parse_phandle_with_args_map(np, propname, "gpio", index,
+					     &gpiospec);
 	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pOF[%d]'\n",
 			__func__, propname, np, index);
-- 
2.14.GIT
