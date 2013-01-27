From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Jan 2013 20:02:10 +0100
Subject: [PATCH 1/3] pinctrl: sunxi: Add of_xlate function
In-Reply-To: <1359313332-12305-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359313332-12305-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359313332-12305-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the pin controller of sunxi chips is represented as a single bank
in the driver.
Since this is neither convenient nor represented that way in the
datasheets, define a custom of_xlate function with the layout <bank pin
flag>

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 353f6a8..122eeca 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -1261,6 +1261,24 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 	writel((value & DATA_PINS_MASK) << index, pctl->membase + reg);
 }
 
+static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
+				const struct of_phandle_args *gpiospec,
+				u32 *flags)
+{
+	int pin, base;
+
+	base = PINS_PER_BANK * gpiospec->args[0];
+	pin = base + gpiospec->args[1];
+
+	if (pin > (gc->base + gc->ngpio))
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[2];
+
+	return pin;
+}
+
 static struct gpio_chip sunxi_pinctrl_gpio_chip __devinitconst = {
 	.owner			= THIS_MODULE,
 	.request		= sunxi_pinctrl_gpio_request,
@@ -1269,6 +1287,8 @@ static struct gpio_chip sunxi_pinctrl_gpio_chip __devinitconst = {
 	.direction_output	= sunxi_pinctrl_gpio_direction_output,
 	.get			= sunxi_pinctrl_gpio_get,
 	.set			= sunxi_pinctrl_gpio_set,
+	.of_xlate		= sunxi_pinctrl_gpio_of_xlate,
+	.of_gpio_n_cells	= 3,
 	.can_sleep		= 0,
 };
 
-- 
1.7.10.4
