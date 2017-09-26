From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:15 +0200
Subject: [PATCH v2 05/10] pinctrl: axp209: add programmable gpio_status_offset
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <e9385e366da18057aaa1e1d5d751839cde4343fa.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for patches that will add support for a new PMIC that has a
different GPIO input status register, add a gpio_status_offset within
axp20x_pctl structure and use it.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 4be1aca..11f871e 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -89,6 +89,7 @@ struct axp20x_pctl {
 	unsigned int				ngroups;
 	struct axp20x_pinctrl_function		*functions;
 	unsigned int				nfunctions;
+	unsigned int				gpio_status_offset;
 };
 
 static const struct axp20x_desc_pin axp209_pins[] = {
@@ -127,7 +128,7 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	if (ret)
 		return ret;
 
-	return !!(val & BIT(offset + 4));
+	return !!(val & BIT(offset + pctl->gpio_status_offset));
 }
 
 static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -509,6 +510,7 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 	pctl->regmap = axp20x->regmap;
 
 	pctl->desc = &axp20x_pinctrl_data;
+	pctl->gpio_status_offset = 4;
 	pctl->dev = &pdev->dev;
 
 	platform_set_drvdata(pdev, pctl);
-- 
git-series 0.9.1
