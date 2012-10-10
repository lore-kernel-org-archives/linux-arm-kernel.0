From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Oct 2012 14:38:18 +0200
Subject: [PATCH 3/5] pinctrl/nomadik: allow to support several ranges per GPIO
 bank
Message-ID: <1349872698-31245-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@stericsson.com>

With DB8500 the number of GPIO chips = number GPIO bank =
number of GPIO ranges.

With DB8540, a new GPIO range configuration is used, some GPIO
banks can have several GPIO ranges.

For example, DB8540 GPIO bank0 (GPIO0 to GPIO32) have 2 GPIO
ranges:
    - GPIO0 to GPIO17  : routed
    - GPIO18 to GPIO21 : hole
    - GPIO22 to GPIO28 : routed
    - GPIO29 to GPIO32 : hole

Previously, during nmk_pinctrl_probe(), all GPIO ranges were
parsed, as GPIO ranges are larger than the number of GPIO chips,
a warning occurs. This commit allows each bank to have several
GPIO ranges.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 334cd2f..e4d3778 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1837,11 +1837,11 @@ static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
 	 * need this to proceed.
 	 */
 	for (i = 0; i < npct->soc->gpio_num_ranges; i++) {
-		if (!nmk_gpio_chips[i]) {
+		if (!nmk_gpio_chips[npct->soc->gpio_ranges[i].id]) {
 			dev_warn(&pdev->dev, "GPIO chip %d not registered yet\n", i);
 			return -EPROBE_DEFER;
 		}
-		npct->soc->gpio_ranges[i].gc = &nmk_gpio_chips[i]->chip;
+		npct->soc->gpio_ranges[i].gc = &nmk_gpio_chips[npct->soc->gpio_ranges[i].id]->chip;
 	}
 
 	nmk_pinctrl_desc.pins = npct->soc->pins;
-- 
1.7.11.3
