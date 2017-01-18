From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 17 Jan 2017 16:50:38 -0800
Subject: [PATCH v2 3/3] gpio: Support gpio nexus dt bindings
In-Reply-To: <20170118005038.9216-1-stephen.boyd@linaro.org>
References: <20170118005038.9216-1-stephen.boyd@linaro.org>
Message-ID: <20170118005038.9216-4-stephen.boyd@linaro.org>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 92b185f19232..17bca36d4ebb 100644
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
 		pr_debug("%s: can't parse '%s' property of node '%s[%d]'\n",
 			__func__, propname, np->full_name, index);
-- 
2.10.0.297.gf6727b0
