From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Nov 2016 13:23:34 +0100
Subject: [PATCH 2/2] pinctrl: bcm2835: Return pins to inputs when freed
Message-ID: <1479126214-20529-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

When dynamically unloading overlays, it is important that freed pins are
restored to being inputs to prevent functions from being enabled in
multiple places at once.

Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I want to apply this to cater for my GPIOLIB_IRQCHIP
refactorings.
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 1d8fc104e26b..2df59d9964a2 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -844,6 +844,16 @@ static const struct pinctrl_ops bcm2835_pctl_ops = {
 	.dt_free_map = bcm2835_pctl_dt_free_map,
 };
 
+static int bcm2835_pmx_free(struct pinctrl_dev *pctldev,
+		unsigned offset)
+{
+	struct bcm2835_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
+
+	/* disable by setting to GPIO_IN */
+	bcm2835_pinctrl_fsel_set(pc, offset, BCM2835_FSEL_GPIO_IN);
+	return 0;
+}
+
 static int bcm2835_pmx_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	return BCM2835_FSEL_COUNT;
@@ -903,6 +913,7 @@ static int bcm2835_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 }
 
 static const struct pinmux_ops bcm2835_pmx_ops = {
+	.free = bcm2835_pmx_free,
 	.get_functions_count = bcm2835_pmx_get_functions_count,
 	.get_function_name = bcm2835_pmx_get_function_name,
 	.get_function_groups = bcm2835_pmx_get_function_groups,
-- 
2.7.4
